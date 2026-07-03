import 'package:go_router/go_router.dart';

import '../../features/home/presentation/pages/main_page.dart';
import '../../features/splash/presentation/pages/splash_page.dart';

class AppRouter {

  static final GoRouter router = GoRouter(

    initialLocation: "/splash",

    routes: [

      GoRoute(
        path: "/splash",
        builder: (_, __) => const SplashPage(),
      ),

      GoRoute(
        path: "/",
        builder: (_, __) => const MainPage(),
      ),

    ],

  );

}