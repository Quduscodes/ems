import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ems/color_constant.dart';
import 'package:ems/custom_theme.dart';
import 'package:ems/string_const.dart';
import 'package:ems/user_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

class LiveChatScreen extends StatefulWidget {
  const LiveChatScreen({Key? key}) : super(key: key);

  @override
  _LiveChatScreenState createState() => _LiveChatScreenState();
}

class _LiveChatScreenState extends State<LiveChatScreen> {
  final CollectionReference _fireStore =
      FirebaseFirestore.instance.collection('adminChat');
  ScrollController controller = ScrollController();
  TextEditingController messageController = TextEditingController();
  final format = DateFormat.jm();

  final UserData? user =
      Hive.box<UserData>(StringConst.userDataBox).get(StringConst.userDataKey);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: swatch9,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: EdgeInsets.only(
                left: 4.8.w,
                right: 4.8.w,
                top: 2.4.w,
                bottom: 3.w,
              ),
              margin: EdgeInsets.only(bottom: 2.4.w),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(width: 0.1.w, color: greyColorShade5),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Material(
                    type: MaterialType.transparency,
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.arrow_back,
                          color: whiteColor,
                          size: 20.sp,
                        ),
                      ),
                    ),
                  ),
                  Text('Live Chat',
                      style: CustomTheme.normalText(context)
                          .copyWith(color: whiteColor)),
                  SizedBox(width: 4.8.w),
                ],
              ),
            ),
            user!.userId != null
                ? StreamBuilder<DocumentSnapshot>(
                    stream: _fireStore.doc(user!.userId).snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(
                          child: CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(primaryColor),
                          ),
                        );
                      }
                      if (snapshot.hasError) {
                        return Text("Something went wrong",
                            style: CustomTheme.normalText(context)
                                .copyWith(color: whiteColor));
                      }
                      if (!snapshot.data!.exists) {
                        return Text(
                          "Start Chat",
                          style: CustomTheme.normalText(context)
                              .copyWith(color: whiteColor),
                        );
                      }
                      List messages = snapshot.data!['mainChat'];
                      List<MessageBubble> messageBubbles = [];
                      for (var message in messages) {
                        final String msg = message['msg'];
                        final String messageSender = message['from'];
                        final String time = message['time'];

                        final messageBubble = MessageBubble(
                          messageText: msg,
                          messageSender: messageSender,
                          from: messageSender,
                          time: format.format(
                            DateTime.tryParse(time)!,
                          ),
                        );
                        messageBubbles.add(messageBubble);
                      }
                      return messageBubbles.isEmpty
                          ? const Text('start chat')
                          : Expanded(
                              child: ListView(
                                  reverse: true,
                                  controller: controller,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0, vertical: 20.0),
                                  children: <Widget>[
                                    messageBubbles.length == 1
                                        ? Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 7.w),
                                            child: Text(
                                              "An admin will be with you shortly, response time is usually between 10 - 30 mins",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 11.sp,
                                                  color: greyColorShade5),
                                            ),
                                          )
                                        : const SizedBox(),
                                    Column(
                                      children: messageBubbles,
                                    ),
                                  ]),
                            );
                    })
                : const CircularProgressIndicator(
                    valueColor:
                        const AlwaysStoppedAnimation<Color>(primaryColor),
                  ),
            Container(
              // padding: EdgeInsets.only(bottom: .),
              margin: EdgeInsets.only(left: 5.w, right: 5.w, bottom: 2.4.w),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(width: 0.15.w, color: blackTextColor),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      textCapitalization: TextCapitalization.sentences,
                      autofocus: true,
                      controller: messageController,
                      style: CustomTheme.smallText(context)
                          .copyWith(color: whiteColor),
                      decoration: InputDecoration(
                        hintText: "Write a message",
                        hintStyle: CustomTheme.smallText(context)
                            .copyWith(color: whiteColor),
                        isDense: true,
                        isCollapsed: true,
                        border: const OutlineInputBorder(
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(right: 2.4.w)),
                  FloatingActionButton(
                    onPressed: () {
                      sendInitialChat(messageController.text);
                      messageController.clear();
                      controller.animateTo(
                        controller.position.minScrollExtent,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.fastOutSlowIn,
                      );
                    },
                    focusElevation: 0.0,
                    hoverElevation: 0.0,
                    highlightElevation: 0.0,
                    child: Icon(
                      Icons.send,
                      color: primaryColor,
                      size: 20.sp,
                    ),
                    backgroundColor: whiteColor,
                    elevation: 0,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class MessageBubble extends StatelessWidget {
  final String? messageText;
  final String? messageSender;
  final String? from;
  final String? time;
  const MessageBubble(
      {Key? key, this.from, this.messageText, this.messageSender, this.time})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: from == 'me'
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  constraints: BoxConstraints(minWidth: 10.w, maxWidth: 300.w),
                  child: Material(
                      borderRadius: from == 'me'
                          ? BorderRadius.only(
                              topLeft: Radius.circular(25.sp),
                              topRight: Radius.circular(25.sp),
                              bottomLeft: Radius.circular(25.sp),
                            )
                          : BorderRadius.only(
                              topLeft: Radius.circular(25.sp),
                              topRight: Radius.circular(25.sp),
                              bottomRight: Radius.circular(25.sp),
                            ),
                      // borderRadius: BorderRadius.circular(30.0),
                      color: from == 'me' ? primaryColor : greyColorShade5,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 20.0),
                        child: Text(
                          messageText!,
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 15.sp,
                              color:
                                  from == 'me' ? whiteColor : blackTextColor),
                        ),
                      )),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 0.5.h),
                  child: Text(
                    time!,
                    style: TextStyle(
                        color: greyTextColorShade2,
                        fontWeight: FontWeight.w500,
                        fontSize: 8.sp),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

sendInitialChat(String msg) async {
  final _fireStore = FirebaseFirestore.instance;

  final UserData? user =
      Hive.box<UserData>(StringConst.userDataBox).get(StringConst.userDataKey);
  String userID = user!.userId!;
  String username = '${user.firstName} ${user.lastName}';

  var docRefUser = _fireStore.collection('adminChat').doc(userID);

  docRefUser.get().then((value) {
    if (value.exists) {
      FirebaseFirestore.instance.runTransaction((transaction) async {
        transaction.update(docRefUser, {
          "mainChat": FieldValue.arrayUnion([
            {
              "from": "me",
              "msg": msg,
              "to": "Admin",
              "time": DateTime.now().toString(),
            }
          ])
        });
      });
    } else {
      docRefUser.set({
        "createdAt": DateTime.now(),
        "email": user.email,
        "name": username,
        "mainChat": FieldValue.arrayUnion([
          {
            "from": "me",
            "msg": msg,
            "to": "Admin",
            "time": DateTime.now().toString(),
          }
        ])
      });
    }
  });
}
