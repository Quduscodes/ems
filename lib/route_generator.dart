import 'add_staffSpace.dart';
import 'exports.dart';

class RouteGenerator {
  static const String loginStaff = "/loginStaff";
  static const String loginAdmin = "/loginAdmin";
  static const String signUpAdmin = "/signUpAdmin";
  static const String signStaff = "/signStaff";
  static const String onboarding = "/onboarding";
  static const String staffHome = "/staffHome";
  static const String adminHome = "/adminHome";
  static const String adminLogin = "/adminLogin";
  static const String adminSignup = "/adminSignup";
  static const String staffSignup = "/staffSignup";
  static const String staffLogin = "/staffLogin";
  static const String configureSpaceStaff = "/configureSpaceStaff";
  static const String splash = "/";

  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => const Splash());
      case onboarding:
        return MaterialPageRoute(builder: (_) => const Onboarding());
      case staffHome:
        return MaterialPageRoute(builder: (_) => const StaffHomePage());
      case adminHome:
        return MaterialPageRoute(builder: (_) => const AdminHomePage());
      case staffLogin:
        return MaterialPageRoute(builder: (_) => const StaffLogin());
      case adminLogin:
        return MaterialPageRoute(builder: (_) => const AdminLogin());
      case staffSignup:
        return MaterialPageRoute(builder: (_) => const StaffSignUp());
      case adminSignup:
        return MaterialPageRoute(builder: (_) => const AdminSignUp());
        case configureSpaceStaff:
        return MaterialPageRoute(builder: (_) => const ConfigureSpaceStaff());
    }
  }
}
