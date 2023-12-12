import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:open_weather_app/view/screens/screens.dart';

class AppRouter {
  final goRouter = GoRouter(
      initialLocation: '/',
      routes: [
        GoRoute(
          name: 'SplashScreen',
          path: '/',
          pageBuilder: (context, s) {
            return const MaterialPage(child: SplashScreen());
          },
        ),
        GoRoute(
          path: '/home',
          pageBuilder: (context, s) {
            ;
            return MaterialPage(child: HomeScreen());
          },
          routes: <RouteBase>[
            GoRoute(
              name: 'SearchScreen',
              path: 'search',
              pageBuilder: (context, s) {
                return const MaterialPage(
                  child: SearchScreen(),
                );
              },
            ),
            GoRoute(
              name: 'settings',
              path: 'setting',
              pageBuilder: (context, s) {
                return const MaterialPage(
                  child: SettingsScreen(),
                );
              },
            ),
            GoRoute(
              name: 'favoriteScreen',
              path: 'favorite',
              pageBuilder: (context, s) {
                return const MaterialPage(
                  child: FavoriteWeatherScreen(),
                );
              },
            ),
          ],
        ),
      ],
      errorPageBuilder: (context, s) =>
          const MaterialPage(child: ErrorScreen()));
}
