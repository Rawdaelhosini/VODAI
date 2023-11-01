import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoping/layout/cubit/layout_cubit.dart';
import 'package:shoping/models/categories_model.dart';

import '../../../style/Style.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<CategoriesModel> categoriesData =
        BlocProvider.of<LayoutCubit>(context).categories;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: thirdColor,
        elevation: 0,
        title: const Padding(
          padding: EdgeInsets.only(top: 10, bottom: 10),
          child: Text(
            "VODAI",
            style: TextStyle(
                fontSize: 38.0, fontWeight: FontWeight.w900, color: mainColor),
          ),
        ),
        titleSpacing: -50,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        child: GridView.builder(
            //ده عشان اشوف كام حاجه تتعرض جمب بعض في الشاشه
            itemCount: categoriesData.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, mainAxisSpacing: 20, crossAxisSpacing: 15),
            itemBuilder: (context, index) {
              return Container(
                child: Column(
                  children: [
                    Expanded(
                      child: Image.network(
                        categoriesData[index].url!,
                        fit: BoxFit.fill,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(categoriesData[index].title!)
                  ],
                ),
              );
            }),
      ),
    );
  }
}
