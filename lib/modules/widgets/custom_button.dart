import 'package:flutter/material.dart';
import 'package:shoping/modules/widgets/loader.dart';
import 'package:shoping/style/Style.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final void Function() onPress;
  final bool loading;
  CustomButton(
      {Key? key,
      required this.text,
      required this.onPress,
      this.loading = false})
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
        onPressed: loading ? null : onPress,
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
