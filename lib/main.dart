import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mobilizzz/pages/login_page.dart';
import 'package:mobilizzz/pages/team_page.dart';
import 'package:mobilizzz/providers/auth_provider.dart';
import 'package:mobilizzz/providers/record_provider.dart';
import 'package:mobilizzz/providers/user_provider.dart';
import 'package:mobilizzz/widgets/bottom_nav.dart';

void main() async {
  try {
    runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider<UserProvider>(
          create: (context) => UserProvider(),
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
    final userProvider = Provider.of<UserProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mobilizzz',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const AuthWrapper(),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, _) {
        final user = authProvider.user;

        // Check if user is null and show LoginPage if true, otherwise show the main app content
        return user == null ? LoginPage() : const BottomNav();
      },
    );
  }
}
