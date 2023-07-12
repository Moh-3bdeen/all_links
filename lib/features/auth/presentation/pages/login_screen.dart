import 'package:all_links/core/constants/router_list.dart';
import 'package:all_links/features/auth/presentation/controller/login_provider.dart';
import 'package:all_links/core/constants/constant.dart';
import 'package:all_links/core/constants/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../../core/constants/app_text_field.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          backgroundColor: kBackgroundColor,
          body: SafeArea(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                kSizeBoxH8,
                SizedBox(
                  height: MediaQuery.of(context).size.height / 3,
                  child: Center(
                    child: SvgPicture.asset(
                      "assets/icons/login.svg",
                    ),
                  ),
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
                  text: "Login",
                  showProgress: provider.isShowProgress,
                  onPressed: (){
                    provider.login(context);
                  },
                ),
                kSizeBoxH16,
                AppButton(
                  text: "Register",
                  showProgress: false,
                  textColor: Colors.black,
                  backgroundColor: Colors.white,
                  onPressed: () {
                    !provider.isShowProgress
                        ? Navigator.pushNamed(context, RouterList.signupScreen)
                        : null;
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
