import 'package:bookia/core/Utils/colors.dart';
import 'package:bookia/core/Utils/text_styles.dart';
import 'package:flutter/material.dart';

enum Dialogs { error, success, warring }

showMyDialog(
  BuildContext context,
  String message, {
  Dialogs type = Dialogs.error,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message, style: TextStyles.styleSize16()),
      backgroundColor: type == Dialogs.error
          ? Colors.red
          : type == Dialogs.success
          ? AppColor.primaryColor
          : AppColor.cardColor,
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.all(20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      elevation: 0,
    ),
  );
}

showLoadingDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return Center(child: CircularProgressIndicator());
    },
  );
}
