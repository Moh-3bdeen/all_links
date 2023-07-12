import 'package:all_links/core/constants/constant.dart';
import 'package:all_links/features/links/data/models/link_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/app_text_field.dart';
import '../controller/link_provider.dart';
import '../../../../core/constants/app_button.dart';

class AddOrEditLink extends StatelessWidget {
  const AddOrEditLink({super.key});

  @override
  Widget build(BuildContext context) {
    dynamic args = ModalRoute.of(context)!.settings.arguments;
    String type = "Add Link";
    if(args != null){
      type = "Update Link";
      Provider.of<LinkProvider>(context, listen: false).titleController.text = args.title!;
      Provider.of<LinkProvider>(context, listen: false).linkController.text = args.link!;
    }

    return Consumer<LinkProvider>(builder: (context, provider, child){
      return Scaffold(
        backgroundColor: kBackgroundColor,
        appBar: AppBar(
          backgroundColor: kBackgroundColor,
          title: Text(
            type,
            style: const TextStyle(color: Colors.black),
          ),
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              provider.titleController.clear();
              provider.linkController.clear();
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
                SizedBox(
                  height: MediaQuery.of(context).size.height / 3,
                  child: Center(
                    child: SvgPicture.asset(
                      "assets/icons/add_link.svg",
                    ),
                  ),
                ),
                kSizeBoxH16,
                AppTextField(
                  text: "Title",
                  hintText: "Instagram",
                  keyboardType: TextInputType.text,
                  obscureText: false,
                  controller: provider.titleController,
                  prefixIcon: const Icon(Icons.title),
                ),
                kSizeBoxH16,
                AppTextField(
                  text: "Link",
                  hintText: "https://www.instagram.com/mo._3bdeen/",
                  keyboardType: TextInputType.url,
                  obscureText: false,
                  maxLine: 2,
                  controller: provider.linkController,
                  prefixIcon:const Icon(Icons.link),
                ),
                kSizeBoxH32,
                kSizeBoxH32,
                AppButton(
                  text: type,
                  showProgress: provider.isShowProgress,
                  onPressed: (){
                    if(type == "Add Link") {
                      provider.addLink(context);
                    }else{
                      provider.updateLink(context, args);
                    }
                  },
                ),
              ],
            )
        ),
      );
    },);
  }
}
