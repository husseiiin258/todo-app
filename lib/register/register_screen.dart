import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo/components/custom_text_form.dart';
import 'package:todo/dialoug_utils.dart';
import 'package:todo/home/home_layout.dart';
import 'package:todo/login/login_screen.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = 'register';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  var nameController = TextEditingController();

  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  var confirmPasswordController = TextEditingController();

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
                      label: "User Name",
                      controller: nameController,
                      myValidator: (text) {
                        if (text == null || text.trim().isEmpty) {
                          return 'please enter user name';
                        }
                        return null;
                      },
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
                    CustomeTextForm(
                      label: "Confirm Password ",
                      isPassword: true,
                      controller: confirmPasswordController,
                      keyboardType: TextInputType.number,
                      myValidator: (text) {
                        if (text == null || text.trim().isEmpty) {
                          return 'please enter confirmation password';
                        }
                        if (text != passwordController.text) {
                          return "password doesn't match";
                        }
                        return null;
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                          onPressed: () {
                            register();
                          },
                          child: Text(
                            "Register",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(color: Colors.white),
                          )),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have account?",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.pushReplacementNamed(
                                  context, LoginScreen.routeName);
                            },
                            child: Text(
                              "Login",
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

  void register() async {
    if (formKey.currentState?.validate() == true) {
      DialogUtils.showLoading(context, "Loading..");

      try {
        final credential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        DialogUtils.hideDialog(context);

        DialogUtils.showMessage(context, 'Register Succuessfully',
            title: "Done", posActionName: 'OK', posAction: () {
          Navigator.of(context).pushNamed(HomeLayout.routeName);
        });
      } on FirebaseAuthException catch (e) {
        DialogUtils.hideDialog(context);

        if (e.code == 'weak-password') {
          print('The password provided is too weak.');
          DialogUtils.showMessage(context, "The password provided is too weak",
              title: 'somthing went wrong');
        } else if (e.code == 'email-already-in-use') {
          print('The account already exists for that email.');

          DialogUtils.showMessage(
              context, "The account already exists for that email.",
              title: 'somthing went wrong');
        }
      } catch (e) {
        DialogUtils.showMessage(context, e.toString());
        print(e);
      }
    }
  }
}
