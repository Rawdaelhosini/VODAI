import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoping/layout/layout_screen.dart';
import 'package:shoping/modules/Screens/authinticationScreen/cubit/auth_state.dart';
import 'package:shoping/modules/Screens/authinticationScreen/register_screen.dart';

import 'package:shoping/style/Style.dart';

import '../../widgets/login widget/alert_dialog.dart';
import 'cubit/auth_cubit.dart';

class LoginScreen extends StatefulWidget {
  static String id = 'LoginScreen';

  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/auth_background.png"),
              fit: BoxFit.fill),
        ),
        child: BlocConsumer<AuthCubit, AuthStates>(
          listener: (context, state) {
            if (state is LoginLoadingState) {
              showAlertDialog(
                  context: context,
                  backgroundColor: Colors.white,
                  content: AnimatedContainer(
                    duration: const Duration(seconds: 1),
                    curve: Curves.easeIn,
                    child: const Row(
                      children: [
                        CupertinoActivityIndicator(color: mainColor),
                        SizedBox(
                          width: 12.5,
                        ),
                        Text(
                          "wait",
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ));
            } else if (state is FailedToLoginState) {
              showAlertDialog(
                  context: context,
                  backgroundColor: Colors.red,
                  content: Text(
                    state.message,
                    textDirection: TextDirection.rtl,
                  ));
            } else if (state is LoginSuccessState) {
              Navigator.pop(context); // عشان يخرج من alertDialog
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => LayoutScreen()));
            }
          },
          builder: (context, state) {
            return Column(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    alignment: Alignment.bottomCenter,
                    padding: const EdgeInsets.only(bottom: 50),
                    child: const Text(
                      'Login to continue process',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 19,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Expanded(
                    flex: 2,
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 35),
                      decoration: const BoxDecoration(
                          color: thirdColor,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(35),
                              topRight: Radius.circular(35))),
                      child: Form(
                        key: formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Login",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 19),
                            ),
                            TextFormField(
                              controller: emailController,
                              decoration:
                                  const InputDecoration(hintText: "Email"),
                              validator: (input) {
                                if (emailController.text.isNotEmpty) {
                                  return null;
                                } else {
                                  return 'Email must not be empty';
                                }
                              },
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            TextFormField(
                              obscureText: true,
                              controller: passwordController,
                              decoration:
                                  const InputDecoration(hintText: "password"),
                              validator: (input) {
                                if (passwordController.text.isNotEmpty) {
                                  return null;
                                } else {
                                  return 'password must not be empty';
                                }
                              },
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            MaterialButton(
                              onPressed: () {
                                if (formKey.currentState!.validate() == true) {
                                  BlocProvider.of<AuthCubit>(context).login(
                                    email: emailController.text,
                                    password: passwordController.text,
                                  );
                                }
                              },
                              // ignore: sort_child_properties_last
                              child: Text(
                                state is LoginLoadingState
                                    ? "Loading...."
                                    : "Login",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.5),
                              ),
                              padding:
                                  const EdgeInsets.symmetric(vertical: 12.5),
                              color: mainColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4)),
                              textColor: Colors.white,
                              minWidth: double.infinity,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text('Don\'t have an account? ',
                                    style: TextStyle(color: Colors.black)),
                                SizedBox(
                                  width: 4,
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                RegisterScreen()));
                                  },
                                  child: const Text('Create one',
                                      style: TextStyle(
                                          color: mainColor,
                                          fontWeight: FontWeight.bold)),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ))
              ],
            );
          },
        ),
      ),
    );
  }
}
