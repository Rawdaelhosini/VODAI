// ignore_for_file: sort_child_properties_last, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoping/layout/cubit/layout_cubit.dart';
import 'package:shoping/layout/cubit/layout_state.dart';

import '../../style/Style.dart';

class UpdateUserDataScreen extends StatelessWidget {
  final NameController = TextEditingController();
  final PhoneController = TextEditingController();
  final EmailController = TextEditingController();
  UpdateUserDataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<LayoutCubit>(context);
    NameController.text = cubit.userModel!.name!; //عشان يحطلي البايانات
    PhoneController.text = cubit.userModel!.phone!;
    EmailController.text = cubit.userModel!.email!;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Change Data",
          style: TextStyle(fontSize: 25),
        ),
        backgroundColor: thirdColor,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            TextFormField(
              controller: NameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "User Name",
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            TextFormField(
              controller: PhoneController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Phone",
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            TextFormField(
              controller: EmailController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Email",
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            BlocConsumer<LayoutCubit, LayoutStates>(builder: (context, state) {
              return MaterialButton(
                onPressed: () {
                  if (NameController.text.isNotEmpty &&
                      PhoneController.text.isNotEmpty &&
                      EmailController.text.isNotEmpty) {
                    cubit.updateUserData(
                        name: NameController.text,
                        phone: PhoneController.text,
                        email: EmailController.text);
                  } else {
                    showSnackBarItem(
                        context, "Please, Enter all Data!!", false);
                  }
                },
                child: Text(state is UpdateUserDataLoadingState
                    ? "Loading..."
                    : "Update "),
                minWidth: double.infinity,
                color: mainColor,
                textColor: Colors.white,
              );
            }, listener: (context, state) {
              if (state is UpdateUserDataSuccessState) {
                showSnackBarItem(context, "Data Updated Successfully", true);
                Navigator.pop(context);
              }
              if (state is UpdateUserDataWithFailureState) {
                showSnackBarItem(context, state.error, false);
              }
            })
          ],
        ),
      ),
    );
  }
}

void showSnackBarItem(
    BuildContext context, String message, bool forSuccessOrFailure) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(message),
    backgroundColor: forSuccessOrFailure ? Colors.green : Colors.red,
  ));
}
