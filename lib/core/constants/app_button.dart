import 'package:flutter/material.dart';
import 'constant.dart';

class AppButton extends StatelessWidget {
  final String text;
  final bool showProgress;
  final Color? textColor;
  final Color? backgroundColor;
  final Function() onPressed;

  const AppButton(
      {Key? key,
      required this.text,
      required this.showProgress,
      this.textColor,
      this.backgroundColor,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        !showProgress ? onPressed() : null;
      },
      child: Container(
        height: 60.0,
        decoration: backgroundColor == null
            ? const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    kMainColorLight,
                    kMainColorDark,
                  ],
                ),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              )
            : BoxDecoration(
                color: backgroundColor,
                borderRadius: const BorderRadius.all(Radius.circular(10)),
              ),
        child: Center(
          child: showProgress
              ? const CircularProgressIndicator(color: Colors.white)
              : Text(
                  text,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: textColor ?? Colors.white,
                    fontSize: 16,
                  ),
                ),
        ),
      ),
    );
  }
}
