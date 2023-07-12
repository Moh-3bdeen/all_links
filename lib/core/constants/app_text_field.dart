import 'package:all_links/core/constants/constant.dart';
import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  final String text;
  final String hintText;
  final TextInputType keyboardType;
  final TextEditingController controller;
  final Widget prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final int? maxLine;
  final String? Function(String?)? validator;
  final Function? onClickSuffix;

  const AppTextField({
    Key? key,
    required this.text,
    required this.hintText,
    required this.keyboardType,
    required this.obscureText,
    required this.controller,
    required this.prefixIcon,
    this.suffixIcon, this.maxLine, this.validator, this.onClickSuffix,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(text, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
        kSizeBoxH8,
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.white,
            border: Border.all(color: Colors.black),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 0.5,
                blurRadius: 10,
                offset: const Offset(0, 4), // changes position of shadow
              ),
            ],
          ),
          child: TextFormField(
            validator: validator,
            controller: controller,
            keyboardType: keyboardType,
            obscureText: obscureText,
            minLines: 1,
            maxLines: maxLine ?? 1,
            decoration: InputDecoration(
              hintText: hintText,
              hintMaxLines: 1,
              prefixIcon: prefixIcon,
              prefixIconColor: kMainColorLight,
              suffixIcon: suffixIcon != null
                  ? IconButton(
                      onPressed: () {
                        onClickSuffix!();
                      },
                      icon: suffixIcon!,
                    )
                  : kSizeBoxEmpty,
              suffixIconColor: Colors.grey,
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Colors.transparent,
                ),
                borderRadius: BorderRadius.circular(15),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
