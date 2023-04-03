import 'package:rubik_cube_solver/src/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rubik_cube_solver/src/results.dart';
import 'package:rubik_cube_solver/src/second_view.dart';
import 'first_view.dart';
import 'second_image.dart';

class MyAppTest extends StatelessWidget {
  const MyAppTest({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.blueAccent,
      ),
      routerConfig: GoRouter(
        routes: [
          GoRoute(
            path: '/',
            name: HomeScreen.routeName,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: HomeScreen(),
            ),
          ),
          GoRoute(
            path: '/firstView',
            name: FirstView.routeName,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: FirstView(),
            ),
          ),
          GoRoute(
            path: '/secondImage',
            name: SecondImage.routeName,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: SecondImage(),
            ),
          ),
          GoRoute(
            path: '/secondView',
            name: SecondView.routeName,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: SecondView(),
            ),
          ),
          GoRoute(
            path: '/results/:sol',
            name: 'results',
            builder: (context, state) => Results(
              sol: state.params['sol'],
            ),
          ),
        ],
      ),
    );
  }
}
