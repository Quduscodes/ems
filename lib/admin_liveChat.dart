import 'package:ems/exports.dart';
import 'package:intl/intl.dart';

import 'help_support.dart';

class AdminLiveChatScreen extends StatefulWidget {
  const AdminLiveChatScreen({Key? key}) : super(key: key);

  @override
  _AdminLiveChatScreenState createState() => _AdminLiveChatScreenState();
}

class _AdminLiveChatScreenState extends State<AdminLiveChatScreen> {
  final CollectionReference _fireStore =
      FirebaseFirestore.instance.collection('adminChat');

  ScrollController controller = ScrollController();
  TextEditingController messageController = TextEditingController();
  final format = DateFormat.jm();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: Consumer(builder: (context, WidgetRef ref, child) {
        return SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.only(
                  left: 24.w,
                  right: 24.w,
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
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.arrow_back,
                        color: blackTextColor,
                        size: 16.sp,
                      ),
                    ),
                    Text(
                      'Live Chat',
                      style: TextStyle(
                        color: blackTextColor,
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(width: 4.8.w),
                  ],
                ),
              ),
              ref.watch(chatIdProvider) != null
                  ? StreamBuilder<DocumentSnapshot>(
                      stream:
                          _fireStore.doc(ref.watch(chatIdProvider)).snapshots(),
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
                          return const Text("Something went wrong");
                        }
                        if (!snapshot.data!.exists) {
                          return const Text("Start Chat");
                        }
                        List messages = snapshot.data!['mainChat'];
                        List<MessageBubble> messageBubbles = [];
                        for (var message in messages) {
                          final String msg = message['msg'];
                          final String messageSender =
                              message['from'] == "me" ? "" : "me";
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
                                      Column(
                                        children: messageBubbles,
                                      ),
                                    ]),
                              );
                      })
                  : const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
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
                        style: TextStyle(
                          color: blackTextColor,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                        ),
                        decoration: const InputDecoration(
                          isDense: true,
                          isCollapsed: true,
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(right: 2.4.w)),
                    FloatingActionButton(
                      onPressed: () {
                        sendInitialChat(
                            messageController.text, ref.watch(chatIdProvider)!);
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
        );
      }),
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

sendInitialChat(String msg, String id) async {
  final _fireStore = FirebaseFirestore.instance;

  var docRefUser = _fireStore.collection('adminChat').doc(id);

  final UserData? user =
      Hive.box<UserData>(StringConst.userDataBox).get(StringConst.userDataKey);

  docRefUser.get().then((value) {
    if (value.exists) {
      FirebaseFirestore.instance.runTransaction((transaction) async {
        transaction.update(docRefUser, {
          "mainChat": FieldValue.arrayUnion([
            {
              "from": "Admin",
              "msg": msg,
              "to": "User",
              "time": DateTime.now().toString(),
            }
          ])
        });
      });
    } else {
      docRefUser.set({
        "createdAt": DateTime.now(),
        "email": user!.email,
        "name": "${user.firstName} ${user.lastName}",
        "mainChat": FieldValue.arrayUnion([
          {
            "from": "Admin",
            "msg": msg,
            "to": "User",
            "time": DateTime.now().toString(),
          }
        ])
      });
    }
  });
}
