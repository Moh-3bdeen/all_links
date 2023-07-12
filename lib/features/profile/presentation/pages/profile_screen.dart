import 'package:all_links/features/links/presentation/controller/link_provider.dart';
import 'package:all_links/features/links/presentation/widgets/account_link.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/router_list.dart';
import '../../../../core/constants/constant.dart';
import '../../../../core/shimmers/shimmers.dart';
import '../../../../infrastacture/shared_preferences.dart';
import '../../../links/data/models/link_model.dart';
import '../widgets/profile_image.dart';
import '../widgets/user_details.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Provider.of<LinkProvider>(context, listen: false).getMyLinks(context);
    return Consumer<LinkProvider>(
      builder: (context, linkProvider, child) {
        linkProvider.getMyLinks(context);
        return linkProvider.isGettingData
            ? AllShimmerLoaded.profileScreen()
            : Scaffold(
                backgroundColor: kBackgroundColor,
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
                                          num: linkProvider.allMyLinks.length,
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
                          SharedPrefController.getData(key: Keys.name.name) ?? "",
                          style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                          ),
                        ),
                        // kSizeBoxH8,
                        Text(
                          SharedPrefController.getData(key: Keys.email.name) ?? "",
                          style: const TextStyle(color: Colors.black),
                        ),
                        // kSizeBoxH8,
                        Text(
                          SharedPrefController.getData(key: Keys.id.name).toString(),
                          style: const TextStyle(color: Colors.black),
                        ),
                        kSizeBoxH16,
                        Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(context, RouterList.editUserData);
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                                  decoration: const BoxDecoration(
                                    color: kMainColorLight,
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                  ),
                                  child: const Center(
                                    child: Text(
                                      "Edit your data",
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
                          child: linkProvider.allMyLinks.isNotEmpty
                              ? ListView.builder(
                                  itemCount: linkProvider.allMyLinks.length,
                                  itemBuilder: (context, index) {
                                    Link link = linkProvider.allMyLinks[index];
                                    return Column(
                                      children: [
                                        AccountLink(
                                          // appName: link.title ?? "",
                                          link: link,
                                          isSlidable: true,
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
                                    "You did not added any link before",
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                        ),
                      ],
                    ),
                  ),
                ),
                floatingActionButton: FloatingActionButton(
                  onPressed: () {
                    Navigator.pushNamed(context, RouterList.addOrEditLink);
                  },
                  backgroundColor: kMainColorLight,
                  child: const Icon(Icons.add),
                ),
              );
      },
    );
  }
}

