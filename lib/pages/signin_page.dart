import 'package:flutter/material.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => SignInPageState();
}

class SignInPageState extends State<SignInPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: const Text('Connexion'),
        toolbarHeight: 60,
      ),
      body:Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 15),
          child: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                      'Welcome',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,),
                      ),
                ],
              ))
      ),
    );
  }
}
