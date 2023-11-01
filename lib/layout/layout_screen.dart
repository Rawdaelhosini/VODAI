// ignore_for_file: unused_local_variable, unnecessary_import
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoping/layout/cubit/layout_cubit.dart';
import 'package:shoping/layout/cubit/layout_state.dart';
import 'package:shoping/style/Style.dart';

class LayoutScreen extends StatelessWidget {
  const LayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<LayoutCubit>(context);
    return BlocConsumer<LayoutCubit, LayoutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          // appBar: AppBar(
          //   backgroundColor: thirdColor,
          //   elevation: 0,
          //   title: Padding(
          //     padding: const EdgeInsets.only(
          //       top: 20,
          //     ),
          //     child: Row(
          //       mainAxisAlignment: MainAxisAlignment.start,
          //       children: [
          //         Image.asset(
          //           "assets/logo1.png",
          //           width: 250,
          //           height: 250,
          //           color: mainColor,
          //         ),
          //       ],
          //     ),
          //   ),
          //   titleSpacing: -50,
          // ),
          bottomNavigationBar: BottomNavigationBar(
              currentIndex: cubit.bottomNavIndex,
              selectedItemColor: mainColor,
              unselectedItemColor: Colors.grey,
              type: BottomNavigationBarType.fixed,
              onTap: (index) {
                cubit.changeBottomNavIndex(index: index);
              },
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.category), label: 'Categories'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.favorite), label: 'Favourite'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.shopping_cart), label: 'Cart'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.person), label: 'Profile'),
              ]),
          body: cubit.layoutScreens[cubit.bottomNavIndex],
        );
      },
    );
  }
}
