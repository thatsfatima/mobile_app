import 'package:app_money/screens/home_screen.dart';
import 'package:app_money/services/register.dart';
import 'package:flutter/material.dart';
import 'package:app_money/screens/login_screen.dart';
import 'package:app_money/services/auth.dart';
import 'package:app_money/pages/home_page.dart';
import 'package:app_money/pages/signin_page.dart';
import 'package:app_money/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AppScreen extends StatefulWidget {
  @override
  _AppScreenState createState() => _AppScreenState();
}

class _AppScreenState extends State<AppScreen> {
  final storage = new FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    readToken();
  }

  void readToken() async {
    String? token = await storage.read(key: 'token');
    Provider.of<Auth>(context, listen: false).tryToken(token: token);
    print(token);
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<Auth>(context);
    final register = Provider.of<Register>(context);
    bool isLoggedIn = false;

    if(auth.authenticated) {
      isLoggedIn = true;
    } else if(register.signedUp) {
      isLoggedIn = true;
    }

    print(isLoggedIn);

    return MaterialApp(
      home: isLoggedIn ? const HomeScreen() : const LoginScreen(),
      routes: {
        '/home': (context) => const HomeScreen(),
        '/signIn': (context) => const SignInPage(),
      },
    );
  }

}
