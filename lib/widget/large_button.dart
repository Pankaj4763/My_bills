import 'package:flutter/material.dart';
import 'package:my_bills/component/colors.dart';

class AppLargeButton extends StatelessWidget {
  final Color? backGroundClor;
  final String text;
  final Color? textColor;
  final Function()? onTap;
  final bool? isBorder;
  const AppLargeButton({
    super.key,
    this.backGroundClor: AppColor.mainColor,
    this.textColor,
    this.onTap,
    this.isBorder: false,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(left: 30, right: 30),
        height: 60,
        width: MediaQuery.of(context).size.width - 60,
        decoration: BoxDecoration(
            color: backGroundClor,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              width: 2,
              color: AppColor.mainColor,
            )),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30,
              color: textColor,
            ),
          ),
        ),
      ),
    );
  }
}
