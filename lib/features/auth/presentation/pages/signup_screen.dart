import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/app_text_field.dart';
import '../../../../core/constants/constant.dart';
import '../../../../core/constants/app_button.dart';
import '../controller/signup_provider.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<SignupProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          backgroundColor: kBackgroundColor,
          body: SafeArea(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                kSizeBoxH8,
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back_ios),
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 3,
                  child: Center(
                    child: SvgPicture.asset(
                      "assets/icons/create_account.svg",
                    ),
                  ),
                ),
                kSizeBoxH16,
                AppTextField(
                  text: "Name",
                  hintText: "Mohammed",
                  keyboardType: TextInputType.name,
                  obscureText: false,
                  controller: provider.nameController,
                  prefixIcon: const Icon(Icons.person),
                ),
                kSizeBoxH16,
                AppTextField(
                  text: "Email",
                  hintText: "example@gmail.com",
                  keyboardType: TextInputType.emailAddress,
                  obscureText: false,
                  controller: provider.emailController,
                  prefixIcon: const Icon(Icons.email),
                ),
                kSizeBoxH16,
                AppTextField(
                  text: "Password",
                  hintText: "******",
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: !provider.isVisiblePassword,
                  controller: provider.passwordController,
                  prefixIcon: const Icon(Icons.lock),
                  suffixIcon: provider.isVisiblePassword
                      ? const Icon(Icons.visibility)
                      : const Icon(Icons.visibility_off),
                  onClickSuffix: () {
                    provider.changeVisiblePassword();
                  },
                ),
                kSizeBoxH32,
                kSizeBoxH32,
                AppButton(
                  text: "Register",
                  showProgress: provider.isShowProgress,
                  onPressed: (){
                    provider.signup(context);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
