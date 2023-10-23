import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo/components/custom_text_form.dart';
import 'package:todo/dialoug_utils.dart';
import 'package:todo/home/home_layout.dart';
import 'package:todo/register/register_screen.dart';

class LoginScreen extends StatelessWidget {
  static const String routeName = 'login';

  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/images/login_screen.png',
            width: double.infinity,
            fit: BoxFit.fill,
          ),
          Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.34,
                    ),
                    CustomeTextForm(
                      label: "Email Address",
                      controller: emailController,
                      myValidator: (text) {
                        if (text == null || text.trim().isEmpty) {
                          return 'please enter email address';
                        }
                        bool emailValid = RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(text);
                        if (!emailValid) {
                          return 'please enter valid email';
                        }
                        return null;
                      },
                    ),
                    CustomeTextForm(
                      label: "Password",
                      isPassword: true,
                      controller: passwordController,
                      keyboardType: TextInputType.number,
                      myValidator: (text) {
                        if (text == null || text.trim().isEmpty) {
                          return 'please enter password';
                        }
                        if (text.length < 6) {
                          return 'password must beat least 6 chars';
                        }
                        return null;
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                          onPressed: () {
                            login(context);
                          },
                          child: Text(
                            "Login",
                            style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.white),
                          )),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Dont have account?",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.pushReplacementNamed(
                                  context, RegisterScreen.routeName);
                            },
                            child: Text(
                              "SignUp",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue),
                            ))
                      ],
                    )
                  ],
                ),
              ))
        ],
      ),
    );
  }

  void login(BuildContext context) async {
    if (formKey.currentState?.validate() == true)
      DialogUtils.showLoading(context, 'Loading..');
      try {
        final credential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: emailController.text, password: passwordController.text);
        DialogUtils.hideDialog(context);
        DialogUtils.showMessage(context, 'Logged Succuessfully',
            title: "Done",
            posActionName: 'OK',
            posAction: (){
              Navigator.of(context).pushNamed(HomeLayout.routeName);
            }

        );


      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          DialogUtils.hideDialog(context);
          DialogUtils.showMessage(context, 'No user found for that email.');

        } else if (e.code == 'wrong-password') {
          DialogUtils.hideDialog(context);
          DialogUtils.showMessage(context, 'No user found for that email.');

        }
      }
  }
}
