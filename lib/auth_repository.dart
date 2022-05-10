import 'package:ems/admin_bottom.dart';
import 'package:ems/exports.dart';

final authLoader = StateProvider<bool>((ref) => false);
final _auth = FirebaseAuth.instance;

final authenticationProvider = ChangeNotifierProvider<Authentication>((ref) {
  return Authentication(ref);
});

class Authentication extends ChangeNotifier {
  final Ref ref;
  Authentication(this.ref);

  void storeUserData(UserData data) {
    final box = Hive.box<UserData>(StringConst.userDataBox);
    box.put(StringConst.userDataKey, data);
  }

  void registerUser(BuildContext context, String email, String password,
      String firstName, String lastName) async {
    dropKeyboard(context);
    if (email.isNotEmpty ||
        password.isNotEmpty ||
        firstName.isNotEmpty ||
        lastName.isNotEmpty) {
      ref.watch(authLoader.notifier).state = true;
      User? user;
      await _auth
          .createUserWithEmailAndPassword(
              email: email.trim(), password: password.trim())
          .then((auth) {
        user = auth.user!;
      }).catchError((error) {
        ref.watch(authLoader.notifier).state = false;
        ScaffoldMessenger.of(context).showSnackBar(showSnackBar(context,
            text: 'An error occurred, check your internet connection',
            error: true));
      });
      if (user != null) {
        saveUserInfoToFirestore(user!, firstName, lastName).then((value) {
          storeUserData(UserData(
            firstName: firstName,
            lastName: lastName,
            email: email,
            userId: user!.uid,
          ));
          Navigator.pop(context);
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => const StaffHomePage(),
              ),
              (Route<dynamic> route) => false);
        });
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(showSnackBar(context,
          text: 'Please ensure that you have filled all fields correctly',
          error: true));
    }
  }

  Future saveUserInfoToFirestore(
      User fUser, String firstName, String lastName) async {
    FirebaseFirestore.instance.collection("users").doc(fUser.uid).set({
      "uid": fUser.uid,
      "email": fUser.email,
      "firstName": firstName.trim(),
      "lastName": lastName.trim(),
      "space": {},
      "createdAt": DateTime.now()
    }).then((value) => ref.watch(authLoader.notifier).state = false);
  }

  Future loginAdmin(
      BuildContext context, String adminId, String password) async {
    dropKeyboard(context);
    ref.watch(authLoader.notifier).state = true;

    if (adminId.isNotEmpty || password.isNotEmpty) {
      FirebaseFirestore.instance
          .collection('admin')
          .doc(adminId)
          .get()
          .then((snapshot) {
        if (snapshot.exists) {
          if (snapshot.data()!['email'] != adminId.trim()) {
            ref.watch(authLoader.notifier).state = false;
            ScaffoldMessenger.of(context).showSnackBar(
              showSnackBar(context,
                  text: 'ID or Password incorrect', error: true),
            );
          } else if (snapshot.data()!['password'] != password.trim()) {
            ref.watch(authLoader.notifier).state = false;
            ScaffoldMessenger.of(context).showSnackBar(showSnackBar(context,
                text: 'ID or Password incorrect', error: true));
          } else {
            storeUserData(UserData(
              firstName: snapshot.data()!['firstName'],
              lastName: snapshot.data()!['lastName'],
              email: snapshot.data()!['email'],
              userId: snapshot.data()!['email'],
            ));
            ref.watch(authLoader.notifier).state = false;
            setLoginState(AuthState.LoggedIn);
            ScaffoldMessenger.of(context).showSnackBar(showSnackBar(context,
                text: 'Welcome ' + snapshot.data()!['lastName'], error: false));
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (context) => const BottomAppBarScreenAdmin(),
                ),
                (Route<dynamic> route) => false);
          }
        } else {
          ref.watch(authLoader.notifier).state = false;
          ScaffoldMessenger.of(context).showSnackBar(showSnackBar(context,
              text: 'User not found, try signing up instead', error: true));
        }
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(showSnackBar(context,
          text: 'Please ensure that you have filled all fields correctly',
          error: true));
    }
  }

  loginUser(BuildContext context, String email, String password) async {
    dropKeyboard(context);
    if (email.isNotEmpty || password.isNotEmpty) {
      User? user;
      ref.watch(authLoader.notifier).state = true;
      await _auth
          .signInWithEmailAndPassword(
              email: email.trim(), password: password.trim())
          .then((authUser) {
        user = authUser.user;
      }).catchError((error) {
        ref.watch(authLoader.notifier).state = false;
        ScaffoldMessenger.of(context).showSnackBar(
            showSnackBar(context, text: 'An error occurred', error: true));
      });

      Future readData(User fUser) async {
        FirebaseFirestore.instance
            .collection("users")
            .doc(fUser.uid)
            .get()
            .then((snapshot) async {
          storeUserData(UserData(
            firstName: snapshot.data()!['firstName'],
            lastName: snapshot.data()!['lastName'],
            email: snapshot.data()!['email'],
            userId: fUser.uid,
          ));
        });
      }

      if (user != null) {
        readData(user!).then((value) {
          ref.watch(authLoader.notifier).state = false;
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => const StaffHomePage(),
              ),
              (Route<dynamic> route) => false);
        });
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(showSnackBar(context,
          text: 'Please ensure that you have filled all fields correctly',
          error: true));
    }
  }

  Future signUpAdmin(BuildContext context, String email, String password,
      String firstName, String lastName) async {
    dropKeyboard(context);
    if (email.isNotEmpty ||
        password.isNotEmpty ||
        firstName.isNotEmpty ||
        lastName.isNotEmpty) {
      ref.watch(authLoader.notifier).state = true;
      final _fireStore = FirebaseFirestore.instance;
      var docRefAdmin = _fireStore.collection('admin').doc(email);
      docRefAdmin.get().then((value) {
        if (value.exists) {
          ref.watch(authLoader.notifier).state = false;
          Navigator.pushNamed(context, RouteGenerator.adminLogin);
        } else {
          ref.watch(authLoader.notifier).state = false;
          docRefAdmin.set({
            "createdAt": DateTime.now(),
            "email": email,
            "firstName": firstName,
            "lastName": lastName,
            "password": password,
            "space": [],
          }).then((value) {
            storeUserData(UserData(
              firstName: firstName,
              lastName: lastName,
              email: email,
              userId: email,
            ));
            ref.watch(authLoader.notifier).state = false;
            ScaffoldMessenger.of(context).showSnackBar(showSnackBar(context,
                text: 'Welcome ' + lastName, error: false));
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (context) => const BottomAppBarScreenAdmin(),
                ),
                (Route<dynamic> route) => false);
          });
        }
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(showSnackBar(context,
          text: 'Please ensure that you have filled all fields correctly',
          error: true));
    }
  }
}
