import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
static const String routeName = 'register';

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: Colors.white,
        ),
        Image.asset('assets/images/Back.png',
        width: double.infinity,
        fit: BoxFit.fill,),
      ],
    );
  }
}
