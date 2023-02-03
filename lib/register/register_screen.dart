import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:p4_chat/firebase_errors.dart';
import 'package:p4_chat/register/register_biew_model.dart';
import 'package:p4_chat/register/register_navigator.dart';
import 'package:provider/provider.dart';
import 'package:p4_chat/utils.dart' as Utils;
class RegisterScreen extends StatefulWidget {
  static const String routeName = 'register';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> implements RegisterNavigator {
  String Name = '';

  String Email = '';

  String Password = '';

  String Username = '';

  var formKey = GlobalKey<FormState>();

  RegisterViewModel viewModel = RegisterViewModel();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.navigator = this;
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context)=> viewModel,
      child: Stack(
        children: [
          Container(
            color: Colors.white,
          ),
          Image.asset(
            'assets/images/Back.png',
            width: double.infinity,
            fit: BoxFit.fill,
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              centerTitle: true,
              title: Text(
                'Creat Account',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.w500),
              ),
            ),
            body: Container(
              margin: EdgeInsets.only(top: 10, left: 15, right: 15),
              padding: EdgeInsets.only(top: 10),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Name',
                      ),
                      onChanged: (text) {
                        Name = text;
                      },
                      validator: (text) {
                        if (text == null || text.trim().isEmpty) {
                          return 'Please enter your name';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Username',
                      ),
                      onChanged: (text) {
                        Username = text;
                      },
                      validator: (text) {
                        if (text == null || text.trim().isEmpty) {
                          return 'Please enter your username';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Email',
                      ),
                      onChanged: (text) {
                        Email = text;
                      },
                      validator: (text) {
                        if (text == null || text.trim().isEmpty) {
                          return 'Please enter your Email';
                        }
                        final bool emailValid = RegExp(
                                r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                            .hasMatch(text);

                        if (!emailValid) {
                          return 'Please enter valid Email';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Passwrod',
                      ),
                      onChanged: (text) {
                        Password = text;
                      },
                      validator: (text) {
                        if (text == null || text.trim().isEmpty) {
                          return 'Please enter your password';
                        }
                        if (text.length < 6) {
                          return 'password must exceed 6 charchters';
                        }
                        return null;
                      },
                    ),

                    InkWell(
                      onTap: (){
                    validateForm();
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 30,vertical: 15),
                        margin: EdgeInsets.only(top:15),
                        decoration: BoxDecoration(color: Color(0xff3598DB),
                          borderRadius: BorderRadius.circular(8)
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Register',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w400,color: Colors.white),),
                            Icon(Icons.arrow_forward,size: 30,color: Colors.white,)
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void validateForm()async {
    if (formKey.currentState?.validate() == true) {
      //register
viewModel.registerFirebaseAuth(Email, Password);

    }
  }

  @override
  void hideLoading() {
   Utils.hideLoading(context);
  }

  @override
  void showLoading() {
    // TODO: implement showLoading
    Utils.showLoading(context, 'Loading ...');
  }

  @override
  void showMessage(String message) {
    // TODO: implement showMessage
    Utils.showMessage(context, message, 'ok', (context){
      Navigator.pop(context);
    });
  }
}
