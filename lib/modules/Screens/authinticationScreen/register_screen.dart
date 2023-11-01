import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoping/layout/layout_screen.dart';
import 'package:shoping/modules/Screens/authinticationScreen/cubit/auth_state.dart';

import 'package:shoping/style/Style.dart';
import 'package:shoping/modules/Screens/authinticationScreen/cubit/auth_cubit.dart';

import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({super.key});
  static String id = 'RegisterScreen';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final nameController = TextEditingController();

  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  final phoneController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthStates>(
      listener: (context, state) {
        if (state is RegisterSuccessState) {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => LayoutScreen()));
        } else if (state is FailedToRegisterState) {
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    content: Text(
                      state.message,
                      style: const TextStyle(color: Colors.white),
                    ),
                    backgroundColor: Colors.red,
                  ));
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Sign Up',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                  ),
                  const SizedBox(
                    height: 35,
                  ),
                  _textFieldItem(
                      controller: nameController, hintText: "User Name"),
                  const SizedBox(
                    height: 20,
                  ),
                  _textFieldItem(
                      controller: emailController, hintText: "Email"),
                  const SizedBox(
                    height: 20,
                  ),
                  _textFieldItem(
                      controller: phoneController, hintText: "Phone"),
                  const SizedBox(
                    height: 20,
                  ),
                  _textFieldItem(
                      isSecure: true,
                      controller: passwordController,
                      hintText: "Password"),
                  const SizedBox(
                    height: 20,
                  ),
                  MaterialButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        BlocProvider.of<AuthCubit>(context).register(
                            email: emailController.text,
                            name: nameController.text,
                            phone: phoneController.text,
                            password: passwordController.text);
                      }
                    },
                    // ignore: sort_child_properties_last
                    child: Text(
                      state is RegisterLoadingState
                          ? "Loading...."
                          : "Register",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16.5),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12.5),
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
                      const Text('Already have an account? ',
                          style: TextStyle(color: Colors.black)),
                      const SizedBox(
                        width: 4,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginScreen()));
                        },
                        child: const Text('login in',
                            style: TextStyle(
                                color: mainColor, fontWeight: FontWeight.bold)),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

Widget _textFieldItem(
    {required TextEditingController controller,
    required String hintText,
    bool? isSecure}) {
  return TextFormField(
    controller: controller,
    validator: (input) {
      if (controller.text.isEmpty) {
        return "$hintText must not be empty";
      } else {
        return null;
      }
    },
    obscureText: isSecure ?? false,
    decoration:
        InputDecoration(border: const OutlineInputBorder(), hintText: hintText),
  );
}
