import 'package:flutter/material.dart';
import 'package:mobilizzz/models/user_model.dart';
import 'package:mobilizzz/providers/user_provider.dart';
import 'package:mobilizzz/utlis/utils.dart';
import 'package:mobilizzz/widgets/bottom_nav.dart';
import 'package:provider/provider.dart';

void main() async {
  try {

    runApp(
      ChangeNotifierProvider<UserProvider>(
        create: (context) => UserProvider(),
        child: const MyApp(),
      ),
    );
  } catch (error) {
    // Handle potential errors (e.g., file not found, parse error)
    print('Error loading mock user: $error');
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
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    userProvider.getDataFromAPI();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mobilizzz',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const BottomNav(),
    );
  }
}
