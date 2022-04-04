import 'package:ems/exports.dart';

class RouteSelector extends StatelessWidget {
  const RouteSelector({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark,
        statusBarColor: Colors.transparent,
      ),
    );
    return ProviderScope(
      child: ScreenUtilInit(
        designSize: const Size(375, 854),
        builder: () {
          return MaterialApp(
            title: "EMS",
            color: Colors.white,
            theme: CustomTheme.getTheme(),
            //initialRoute: RouteGenerator.splash,

            /// changed the route to test out my screens
            onGenerateRoute: RouteGenerator.generateRoute,
            debugShowCheckedModeBanner: false,
            home: const RoutePath(),
          );
        },
      ),
    );
  }
}
