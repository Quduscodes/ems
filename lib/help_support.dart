import 'package:ems/exports.dart';
import 'package:timeago/timeago.dart' as timeago;

final chatIdProvider = StateProvider<String?>((ref) => null);

class HelpAndSupport extends StatefulWidget {
  const HelpAndSupport({Key? key}) : super(key: key);

  @override
  State<HelpAndSupport> createState() => _HelpAndSupportState();
}

class _HelpAndSupportState extends State<HelpAndSupport> {
  final CollectionReference _fireStore =
      FirebaseFirestore.instance.collection('adminChat');

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          // For Android.
          // Use [light] for white status bar and [dark] for black status bar.
          statusBarIconBrightness: Brightness.dark,
          // For iOS.
          // Use [dark] for white status bar and [light] for black status bar.
          statusBarBrightness: Brightness.light,
          statusBarColor: Colors.transparent,
        ),
        child:
            Scaffold(body: Consumer(builder: (context, WidgetRef ref, child) {
          return SafeArea(
              child: Container(
                  child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 10.h),
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
                        size: 20.sp,
                      ),
                    ),
                    Text(
                      'Help and Support',
                      style: CustomTheme.largeText(context),
                    ),
                    SizedBox(width: 4.8.w),
                  ],
                ),
              ),
              Expanded(
                child:
                    ListView(physics: const BouncingScrollPhysics(), children: [
                  StreamBuilder<QuerySnapshot>(
                      stream: _fireStore.snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return const Center(
                            child: CircularProgressIndicator(
                              color: Colors.black,
                            ),
                          );
                        }
                        if (snapshot.hasError) {
                          return const Text("Something went wrong");
                        }
                        QuerySnapshot messages = snapshot.data!;
                        List doc = messages.docs;
                        return messages.size > 0
                            ? ListView.builder(
                                itemCount: messages.size,
                                shrinkWrap: true,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10.w, vertical: 5.h),
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  final conversation = doc[index]['mainChat'];
                                  final recentChat =
                                      conversation[conversation.length - 1];
                                  return ConversationList(
                                    onTap: () {
                                      ref.watch(chatIdProvider.notifier).state =
                                          messages.docs[index].id;
                                      Navigator.pushNamed(context,
                                          RouteGenerator.adminLiveChat);
                                    },
                                    name: doc[index]['name'],
                                    messageText: recentChat['msg'],
                                    imageUrl: "",
                                    time: timeago.format(
                                        DateTime.parse(recentChat['time'])),
                                    isMessageRead: true,
                                  );
                                })
                            : const Center(
                                child: Text(
                                'You have no conversations',
                                style: TextStyle(color: Colors.black),
                              ));
                      })
                ]),
              ),
            ],
          )));
        })));
  }
}

class ConversationList extends StatelessWidget {
  final String? name;
  final String? messageText;
  final String? imageUrl;
  final String? time;
  final bool? isMessageRead;
  final onTap;
  const ConversationList(
      {Key? key,
      @required this.name,
      this.onTap,
      @required this.messageText,
      @required this.imageUrl,
      @required this.time,
      @required this.isMessageRead})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.only(top: 10, bottom: 10),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Row(
                children: <Widget>[
                  const CircleAvatar(
                    maxRadius: 30,
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: Container(
                      color: Colors.transparent,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            name!,
                            style: TextStyle(
                                fontSize: 16.sp, fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            height: 1.h,
                          ),
                          Text(
                            messageText!,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 12.sp,
                                color: Colors.grey.shade600,
                                fontWeight: isMessageRead!
                                    ? FontWeight.bold
                                    : FontWeight.normal),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Text(
              time!,
              style: TextStyle(
                  fontSize: 12,
                  fontWeight:
                      isMessageRead! ? FontWeight.bold : FontWeight.normal),
            ),
          ],
        ),
      ),
    );
  }
}
