import 'package:flutter_proyecto_equipo3/pages/About%20us.dart';
import 'package:flutter_proyecto_equipo3/pages/home_page.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: '/about', 
      builder: (context, state) => const AboutScreen(),
    ),
  ],
);
