import 'package:flutter/material.dart';
import 'package:shoping/modules/widgets/loader.dart';
import 'package:shoping/style/Style.dart';

import '../../../layout/cubit/layout_cubit.dart';
import '../../../models/product_model.dart';

class CustomButton extends StatelessWidget {
  final String text;

  final bool loading;

  CustomButton({Key? key, required this.text, this.loading = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(35),
          color: mainColor,
          boxShadow: CustomTheme.buttonShadow),
      child: MaterialButton(
        onPressed: () {},
        child: loading
            ? const loader()
            : Text(
                text,
                style: Theme.of(context).textTheme.titleSmall,
              ),
      ),
    );
  }
}
