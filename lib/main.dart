import 'package:flutter/material.dart';
import 'package:p4_chat/register/register_screen.dart';

void main(){
  runApp( MyApp());
}
class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: RegisterScreen.routeName,
      routes: {
        RegisterScreen.routeName:(context)=>RegisterScreen()
      },
    );
  }
}
