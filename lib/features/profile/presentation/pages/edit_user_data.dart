import 'package:all_links/features/profile/presentation/controller/user_data_provider.dart';
import 'package:all_links/core/constants/constant.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/app_button.dart';
import '../../../../core/constants/app_text_field.dart';
import '../widgets/profile_image.dart';

class EditUserDataScreen extends StatelessWidget {
  const EditUserDataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<UserDataProvider>(builder: (context, provider, child){
      return Scaffold(
        backgroundColor: kBackgroundColor,
        appBar: AppBar(
          backgroundColor: kBackgroundColor,
          title: const Text(
            "Edit My Data",
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          ),
        ),
        body: SafeArea(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            children: [
              kSizeBoxH8,
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ProfileImage(radius: 70, enableUpdate: true),
                ],
              ),
              kSizeBoxH32,
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
                text: "Mobile",
                hintText: "+970599597469",
                keyboardType: TextInputType.phone,
                obscureText: false,
                controller: provider.mobileController,
                prefixIcon: const Icon(Icons.phone_android),
              ),
              kSizeBoxH32,
              kSizeBoxH32,
              AppButton(
                text: "Save Data",
                showProgress: provider.isShowProgress,
                onPressed: (){},
              ),
            ],
          ),
        ),
      );
    },);
  }
}
