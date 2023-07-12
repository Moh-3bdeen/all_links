import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/constant.dart';
import '../../../../core/shimmers/shimmers.dart';
import '../../../links/data/models/link_model.dart';
import '../../../links/presentation/widgets/account_link.dart';
import '../controller/user_profile_provider.dart';
import '../widgets/profile_image.dart';
import '../widgets/user_details.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  var args;
  late Map<String, dynamic> user;

  getUserData() {
    if (Provider.of<UserProfileProvider>(context, listen: false).userId == null) {
      args = ModalRoute.of(context)!.settings.arguments;
      if (args != null) {
        user = args;
      }
      Provider.of<UserProfileProvider>(context, listen: false).userId = args["id"];
      Provider.of<UserProfileProvider>(context, listen: false).userName = args["name"];
      Provider.of<UserProfileProvider>(context, listen: false).userEmail = args["email"];
      Provider.of<UserProfileProvider>(context, listen: false).userToken = args["token"];

      Provider.of<UserProfileProvider>(context, listen: false).getUserLinks(context, args["token"]);
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    getUserData();
    return Consumer<UserProfileProvider>(builder: (context, provider, child) {
      return provider.isGettingData
          ? Scaffold(body: SafeArea(child: AllShimmerLoaded.profileScreen()))
          : Scaffold(
              backgroundColor: kBackgroundColor,
              appBar: AppBar(
                backgroundColor: kBackgroundColor,
                title: const Text(
                  "User Profile",
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
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      kSizeBoxH8,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const ProfileImage(radius: 55, enableUpdate: false),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    UserDetails(
                                      num: provider.allLinks.length,
                                      type: "Links",
                                    ),
                                    const UserDetails(num: 120, type: "Followers"),
                                    const UserDetails(num: 590, type: "Following"),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      kSizeBoxH16,
                      Text(
                        provider.userName ?? "",
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      // kSizeBoxH8,
                      Text(
                        provider.userEmail ?? "",
                        style: const TextStyle(color: Colors.black),
                      ),
                      // kSizeBoxH8,
                      Text(
                        provider.userId.toString(),
                        style: const TextStyle(color: Colors.black),
                      ),
                      kSizeBoxH16,
                      Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {

                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 16),
                                decoration: const BoxDecoration(
                                  color: kMainColorLight,
                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                ),
                                child: const Center(
                                  child: Text(
                                    "Follow",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          kSizeBoxW8,
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                              decoration: const BoxDecoration(
                                color: kMainColorLight,
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                              ),
                              child: const Center(
                                child: Text(
                                  "Copy account Link",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      kSizeBoxH8,
                      kDivider,
                      kSizeBoxH16,
                      Expanded(
                        child: provider.allLinks.isNotEmpty
                            ? ListView.builder(
                                itemCount: provider.allLinks.length,
                                itemBuilder: (context, index) {
                                  Link link = provider.allLinks[index];
                                  return Column(
                                    children: [
                                      AccountLink(
                                        // appName: link.title ?? "",
                                        link: link,
                                        isSlidable: false,
                                        background: index % 2 == 0
                                            ? const Color(0xFFFEE2E7)
                                            : const Color(0xFFE7E5F1),
                                      ),
                                      kSizeBoxH8,
                                    ],
                                  );
                                },
                              )
                            : const Center(
                                child: Text(
                                  "This user not added any link before",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                      ),
                    ],
                  ),
                ),
              ),
            );
    });
  }
}
