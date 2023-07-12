import 'package:all_links/core/constants/router_list.dart';
import 'package:all_links/features/active_sharing/presentation/pages/active_sharing_screen.dart';
import 'package:all_links/features/home/presentation/pages/page_view.dart';
import 'package:flutter/material.dart';

import '../../features/auth/presentation/pages/login_screen.dart';
import '../../features/auth/presentation/pages/signup_screen.dart';
import '../../features/profile/presentation/pages/edit_user_data.dart';
import '../../features/home/presentation/pages/home_screen.dart';
import '../../features/home/presentation/pages/scanner_qrcode_screen.dart';
import '../../features/home/presentation/pages/splash_screen.dart';
import '../../features/links/presentation/pages/add_edit_link.dart';
import '../../features/profile/presentation/pages/followers_screen.dart';
import '../../features/profile/presentation/pages/profile_screen.dart';
import '../../features/profile/presentation/pages/user_profile_screen.dart';

class Routes {
  static Map<String, WidgetBuilder> getAll() => _routes;

  static final Map<String, WidgetBuilder> _routes = {
    RouterList.splashScreen: (context) => const SplashScreen(),
    RouterList.loginScreen: (context) => const LoginScreen(),
    RouterList.signupScreen: (context) => const SignupScreen(),
    RouterList.homeScreen: (context) => const HomeScreen(),
    RouterList.scannerQRCodeScreen: (context) => const ScannerQRCodeScreen(),
    RouterList.profileScreen: (context) => const ProfileScreen(),
    RouterList.addOrEditLink: (context) => const AddOrEditLink(),
    RouterList.editUserData: (context) => const EditUserDataScreen(),
    RouterList.followersScreen: (context) => const FollowersScreen(),
    RouterList.activeSharingScreen: (context) => const ActiveSharingScreen(),
    RouterList.pageViewApp: (context) => const PageViewApp(),
    RouterList.userProfileScreen: (context) => const UserProfileScreen(),
  };

  static Route getRouteGenerate(RouteSettings settings) {
    // var routingData = settings.name!.getRoutingData;

    switch (settings.name) {
      case RouterList.splashScreen:
        return _buildRouteFade(
          settings,
          const SplashScreen(),
        );

      case RouterList.loginScreen:
        return _buildRouteFade(
          settings,
          const LoginScreen(),
        );

      case RouterList.signupScreen:
        return _buildRoute(
          settings,
          (_) => const SignupScreen(),
        );

      case RouterList.homeScreen:
        return _buildRoute(
          settings,
          (_) => const HomeScreen(),
        );
      case RouterList.scannerQRCodeScreen:
        return _buildRoute(
          settings,
          (_) => const ScannerQRCodeScreen(),
        );
      case RouterList.profileScreen:
        return _buildRoute(
          settings,
          (_) => const ProfileScreen(),
        );
      case RouterList.addOrEditLink:
        return _buildRoute(
          settings,
          (_) => const AddOrEditLink(),
        );

      case RouterList.editUserData:
        return _buildRoute(
          settings,
          (_) => const EditUserDataScreen(),
        );

      case RouterList.followersScreen:
        return _buildRoute(
          settings,
          (_) => const FollowersScreen(),
        );

      case RouterList.activeSharingScreen:
        return _buildRoute(
          settings,
          (_) => const ActiveSharingScreen(),
        );

      case RouterList.pageViewApp:
        return _buildRoute(
          settings,
          (_) => const PageViewApp(),
        );

      case RouterList.userProfileScreen:
        return _buildRoute(
          settings,
          (_) => const UserProfileScreen(),
        );

      default:
        return _errorRoute();
    }
  }

  static WidgetBuilder? getRouteByName(String name) {
    if (_routes.containsKey(name) == false) {
      return _routes[RouterList.homeScreen];
    }
    return _routes[name];
  }

  static Route _errorRoute([String message = 'Page not found!!']) {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: Center(
          child: Text(message),
        ),
      );
    });
  }

  static PageRouteBuilder _buildRouteFade(
    RouteSettings settings,
    Widget builder,
  ) {
    return _FadedTransitionRoute(
      settings: settings,
      widget: builder,
    );
  }

  static MaterialPageRoute _buildRoute(
      RouteSettings settings, WidgetBuilder builder,
      {bool fullscreenDialog = false}) {
    return MaterialPageRoute(
      settings: settings,
      builder: builder,
      fullscreenDialog: fullscreenDialog,
    );
  }
}

class _FadedTransitionRoute extends PageRouteBuilder {
  final Widget? widget;
  @override
  final RouteSettings settings;

  _FadedTransitionRoute({this.widget, required this.settings})
      : super(
          settings: settings,
          pageBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secondaryAnimation) {
            return widget!;
          },
          transitionDuration: const Duration(milliseconds: 100),
          transitionsBuilder: (BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child) {
            return FadeTransition(
              opacity: CurvedAnimation(
                parent: animation,
                curve: Curves.easeOut,
              ),
              child: child,
            );
          },
        );
}
