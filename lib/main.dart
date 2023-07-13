import 'package:all_links/features/home/presentation/controller/location_provider.dart';
import 'package:all_links/features/links/presentation/controller/link_provider.dart';
import 'package:all_links/features/home/presentation/controller/home_provider.dart';
import 'package:all_links/features/profile/presentation/controller/user_profile_provider.dart';
import 'package:all_links/infrastacture/shared_preferences.dart';
import 'package:all_links/features/home/presentation/pages/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/constants/app_routes.dart';
import 'features/active_sharing/presentation/controller/active_sharing_provider.dart';
import 'features/auth/presentation/controller/login_provider.dart';
import 'features/profile/presentation/controller/followers_provider.dart';
import 'features/profile/presentation/controller/profile_provider.dart';
import 'features/home/presentation/controller/scanner_qr_provider.dart';
import 'features/auth/presentation/controller/signup_provider.dart';
import 'features/profile/presentation/controller/user_data_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefController.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginProvider()),
        ChangeNotifierProvider(create: (_) => SignupProvider()),
        ChangeNotifierProvider(create: (_) => HomeProvider()),
        ChangeNotifierProvider(create: (_) => ScannerQRProvider()),
        // ChangeNotifierProvider(create: (_) => ProfileProvider()),
        ChangeNotifierProvider(create: (_) => LinkProvider()),
        ChangeNotifierProvider(create: (_) => UserDataProvider()),
        ChangeNotifierProvider(create: (_) => FollowersProvider()),
        ChangeNotifierProvider(create: (_) => LocationProvider()),
        ChangeNotifierProvider(create: (_) => UserProfileProvider()),
        ChangeNotifierProvider(create: (_) => ActiveSharingProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,

        onGenerateRoute: Routes.getRouteGenerate,
        onGenerateInitialRoutes: (initialRoute) {
          return [
            MaterialPageRoute(
              builder: (context) => const SplashScreen(),
            ),
          ];
        },
        routes: Routes.getAll(),
      ),
    );
  }
}
