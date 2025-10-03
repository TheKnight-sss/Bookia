import 'package:bookia/core/Utils/text_styles.dart';
import 'package:flutter/material.dart';

ShowErrorDialog(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(message,
                    style: TextStyles.styleSize16(),),
                    backgroundColor: Colors.red,
                    behavior: SnackBarBehavior.floating,
                    margin: EdgeInsets.all(20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    elevation: 0,
                  ),
                );
}
  