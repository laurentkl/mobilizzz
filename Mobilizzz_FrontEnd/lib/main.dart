import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mobilizzz/pages/home_page.dart';
import 'package:mobilizzz/pages/signup_page.dart';
import 'package:mobilizzz/providers/team_provider.dart';
import 'package:provider/provider.dart';
import 'package:mobilizzz/pages/login_page.dart';
import 'package:mobilizzz/providers/auth_provider.dart';
import 'package:mobilizzz/providers/record_provider.dart';
import 'package:mobilizzz/providers/user_provider.dart';
import 'package:mobilizzz/widgets/bottom_nav.dart';

import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

// GoRouter configuration
final _router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => AuthWrapper(),
    ),
    GoRoute(
      path: '/signup',
      builder: (context, state) => SignUpPage(),
    ),
    GoRoute(
      path: '/bottomnav',
      builder: (context, state) => const BottomNav(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => LoginPage(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => const HomePage(),
    ),
  ],
  redirect: (context, state) {
    // final authProvider = Provider.of<AuthProvider>(context, listen: false);

    // // Check if the user is authenticated
    // if (authProvider.user != null) {
    //   // User is authenticated, redirect to '/bottomnav'
    //   return "/bottomnav";
    // } else {
    //   // User is not authenticated, redirect to '/'
    //   return "/";
    // }
  },
);

void main() async {
  try {
    runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider<UserProvider>(
          create: (context) => UserProvider(),
        ),
        ChangeNotifierProvider<TeamProvider>(
          create: (context) => TeamProvider(),
        ),
        ChangeNotifierProvider<RecordProvider>(
          create: (context) => RecordProvider(),
        ),
        ChangeNotifierProvider<AuthProvider>(
          create: (context) => AuthProvider(),
        ),
      ],
      child: const MyApp(),
    ));
  } catch (error) {
    print('Error initializing providers: $error');
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
      debugShowCheckedModeBanner: false,
      title: 'Mobilizzz',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        snackBarTheme: const SnackBarThemeData(
          backgroundColor: Colors.blueGrey, // Couleur de fond de SnackBar
          contentTextStyle:
              TextStyle(color: Colors.white), // Couleur du texte de SnackBar
        ),
        useMaterial3: true,
      ),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({Key? key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, _) {
        final user = authProvider.user;

        // Check if user is null and show LoginPage if true, otherwise show the main app content
        if (user == null) {
          return LoginPage();
        } else {
          return const BottomNav();
        }
      },
    );
  }
}
