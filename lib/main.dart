import 'package:app_money/screens/app.dart';
import 'package:app_money/services/register.dart';
import 'package:flutter/material.dart';
import 'package:app_money/services/auth.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(
          create: (context) => Auth()),
      ChangeNotifierProvider(
          create: (context) => Register()),
    ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AppScreen(),
    );
  }

}
