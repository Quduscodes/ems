import 'package:ems/staff_appliances.dart';
import 'package:ems/staff_locations.dart';

import 'add_locations.dart';
import 'admin_bottom.dart';
import 'admin_liveChat.dart';
import 'chat_window.dart';
import 'exports.dart';
import 'extras.dart';
import 'help_support.dart';

class RouteGenerator {
  static const String loginStaff = "/loginStaff";
  static const String loginAdmin = "/loginAdmin";
  static const String appliances = "/appliances";
  static const String staffAppliances = "/staffAppliances";
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
  static const String editAdminSpace = "/editAdminSpace";
  static const String addAdminSpace = "/addAdminSpace";
  static const String editSpaceStaff = "/editSpaceStaff";
  static const String staffLifeChat = "/staffLifeChat";
  static const String adminLiveChat = "/adminLiveChat";
  static const String helpAndSupport = "/helpAndSupport";
  static const String locations = "/locations";
  static const String extras = "/extras";
  static const String splash = "/";
  static const String bottomAppBarScreenAdmin = "bottomAppBarScreenAdmin";
  static const String staffLocationsView = "staffLocationsView";

  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => const Splash());
      case staffLocationsView:
        return MaterialPageRoute(builder: (_) => const StaffLocationsView());
      case staffLifeChat:
        return MaterialPageRoute(builder: (_) => const LiveChatScreen());
      case staffAppliances:
        return MaterialPageRoute(builder: (_) => const StaffAppliancesView());
      case bottomAppBarScreenAdmin:
        return MaterialPageRoute(
            builder: (_) => const BottomAppBarScreenAdmin());
      case extras:
        return MaterialPageRoute(builder: (_) => const Extras());
      case locations:
        return MaterialPageRoute(builder: (_) => const LocationsView());
      case helpAndSupport:
        return MaterialPageRoute(builder: (_) => const HelpAndSupport());
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
      case editAdminSpace:
        return MaterialPageRoute(builder: (_) => const EditAdminSpace());
      case appliances:
        return MaterialPageRoute(builder: (_) => const AppliancesView());
      case addAdminSpace:
        return MaterialPageRoute(builder: (_) => const AddAdminSpace());
      case editSpaceStaff:
        return MaterialPageRoute(builder: (_) => const EditSpaceStaff());
      case adminLiveChat:
        return MaterialPageRoute(builder: (_) => const AdminLiveChatScreen());
    }
  }
}
