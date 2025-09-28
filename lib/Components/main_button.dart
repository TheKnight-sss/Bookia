import 'package:flutter/material.dart';
import 'package:taskati/core/utils/AppColor.dart';
import 'package:taskati/core/utils/text_styles.dart';

class MainButton extends StatelessWidget {
  const MainButton({super.key, required this.text, required this.onPressed, this.width, this.height});

  final String text;
  final double? height;
  final double? width;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 55,
      width: width ?? double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColor.primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyles.bodyStyle(
            fontSize: 16,
            color: Colors.white,
            fontweight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
