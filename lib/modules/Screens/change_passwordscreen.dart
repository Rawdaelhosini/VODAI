// ignore_for_file: sort_child_properties_last, unused_import

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoping/layout/cubit/layout_cubit.dart';
import 'package:shoping/layout/cubit/layout_state.dart';
import 'package:shoping/shared/constants/constant.dart';
import 'package:shoping/style/Style.dart';

class ChangePasswordScreen extends StatelessWidget {
  final currentPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();

  ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<LayoutCubit>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Change Password",
          style: TextStyle(fontSize: 25),
        ),
        backgroundColor: thirdColor,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              controller: currentPasswordController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "CurrentPassword",
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            TextFormField(
              controller: newPasswordController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "NewPassword",
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            BlocConsumer<LayoutCubit, LayoutStates>(builder: (context, state) {
              return MaterialButton(
                onPressed: () {
                  if (currentPasswordController.text == currentPassword) {
                    if (newPasswordController.text.length >= 8) {
                      cubit.changePassword(
                          userCurrentPassword: currentPassword!,
                          newPassword: newPasswordController.text.trim());
                    } else {
                      showSnackBarItem(context,
                          "Password must be least 8 Characters", false);
                    }
                  } else {
                    showSnackBarItem(
                        context,
                        "Please, Verify current password, try again later",
                        false);
                  }
                },
                child: Text(state is ChangePasswordLoadingState
                    ? "Loading..."
                    : "Update "),
                color: mainColor,
                minWidth: double.infinity,
                textColor: Colors.white,
              );
            }, listener: (context, state) {
              if (state is ChangePasswordSuccessState) {
                showSnackBarItem(
                    context, "Password Updated Successfully", true);
                Navigator.pop(context);
              }
              if (state is ChangePasswordWithFailureState) {
                showSnackBarItem(context, state.error, false);
              }
            })
          ],
        ),
      ),
    );
  }

  void showSnackBarItem(
      BuildContext context, String message, bool forSuccessOrFailure) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: forSuccessOrFailure ? Colors.green : Colors.red,
    ));
  }
}
