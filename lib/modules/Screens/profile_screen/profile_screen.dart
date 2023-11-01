// ignore_for_file: sort_child_properties_last, unnecessary_import, prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'package:shoping/modules/Screens/change_passwordscreen.dart';
import 'package:shoping/modules/Screens/darktheme/app_text_style.dart';
import 'package:shoping/modules/Screens/darktheme/dark_theme_provider.dart';

import '../../../layout/cubit/layout_cubit.dart';
import '../../../layout/cubit/layout_state.dart';

import '../../../style/Style.dart';
import '../update_user_data_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);
    return BlocConsumer<LayoutCubit, LayoutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        final cubit = BlocProvider.of<LayoutCubit>(context);

        if (cubit.userModel == null) cubit.getUserData();
        return Scaffold(
          appBar: AppBar(
            backgroundColor: thirdColor,
            elevation: 0,
            title: Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: Text(
                "VODAI",
                style: TextStyle(
                    fontSize: 38.0,
                    fontWeight: FontWeight.w900,
                    color: mainColor),
              ),
            ),
            titleSpacing: -50,
          ),
          body: cubit.userModel != null
              ? Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  width: double.infinity,
                  child: Column(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(cubit.userModel!.image!),
                        radius: 45,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        cubit.userModel!.name!,
                        style: const TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 20),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        cubit.userModel!.email!,
                        style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                            color: Colors.grey),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Material(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(22.0)),
                        elevation: 2,
                        // color: const Color(0xffF7F7F7),
                        clipBehavior: Clip.antiAlias,
                        child: MaterialButton(
                          height: 50,
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ChangePasswordScreen()));
                          },
                          child: Row(
                            children: [
                              Icon(Icons.change_circle,
                                  color:
                                      Theme.of(context).colorScheme.secondary),
                              SizedBox(
                                width: 15,
                              ),
                              Text(
                                "Change Password",
                                style: AppTextStyle.instance.mainTextStyle(
                                    10, FontWeight.w500, context),
                              ),
                            ],
                          ),

                          // color: const Color(0xffF7F7F7),
                          minWidth: double.infinity,
                          textColor: Colors.black,
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Column(
                        children: [
                          Align(
                            alignment: AlignmentDirectional
                                .centerStart, //keep eye on this
                            child: Material(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(22.0)),
                              elevation: 2,
                              // color: const Color(0xffF7F7F7),
                              clipBehavior: Clip.antiAlias,
                              child: MaterialButton(
                                height: 50,
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              UpdateUserDataScreen()));
                                },
                                child: Row(
                                  children: [
                                    Icon(Icons.person_pin,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Text(
                                      "Update Data",
                                      style: AppTextStyle.instance
                                          .mainTextStyle(
                                              10, FontWeight.w500, context),
                                    ),
                                  ],
                                ),

                                // color: const Color(0xffF7F7F7),
                                minWidth: double.infinity,
                                textColor: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Material(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(22.0)),
                        elevation: 2,
                        // color: const Color(0xffF7F7F7),
                        clipBehavior: Clip.antiAlias,
                        child: SwitchListTile(
                            title: Text(
                              "Dark Mode",
                              style: AppTextStyle.instance
                                  .mainTextStyle(10, FontWeight.w500, context),
                            ),
                            secondary: Icon(
                                themeState.darkTheme
                                    ? Icons.dark_mode_outlined
                                    : Icons.light_mode_outlined,
                                color: Theme.of(context).colorScheme.secondary),
                            value: themeState.darkTheme,
                            onChanged: (value) {
                              themeState.setDarkTheme = value;
                            }),
                      ),
                      const SizedBox(
                        height: 15,
                      ),

                      MaterialButton(
                        child: Text(
                          'Log Out',
                          style: TextStyle(color: Colors.red),
                        ),
                        onPressed: () => LayoutCubit().logOut(context),
                        // text: 'Log Out',
                        // onTap: () => AccountServices().logOut(context),
                      ),

                      // MaterialButton(
                      //   color: Colors.red,
                      //   child: Text('Log Out'),
                      //   onPressed: () {
                      //     Navigator.pushAndRemoveUntil(context,
                      //         MaterialPageRoute(builder: (context) {
                      //       return LoginScreen();
                      //     }), (route) => false);
                      //   },
                      //   // text: 'Log Out',
                      //   // onTap: () => AccountServices().logOut(context),
                      // ),
                    ],
                  ),
                )
              : const Center(
                  child: CircularProgressIndicator(),
                ),
        );
      },
    );
  }
}
