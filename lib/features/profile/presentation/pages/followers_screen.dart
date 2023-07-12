import 'package:all_links/features/profile/presentation/controller/followers_provider.dart';
import 'package:all_links/core/constants/constant.dart';
import 'package:all_links/features/profile/presentation/widgets/follower.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FollowersScreen extends StatelessWidget {
  const FollowersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<FollowersProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          backgroundColor: kBackgroundColor,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                // padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    decoration: const BoxDecoration(
                      color: Colors.white70,
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                    ),
                    child: TextField(
                      controller: provider.searchController,
                      decoration: InputDecoration(
                        hintText: "search user...",
                        prefixIcon: const Icon(Icons.search),
                        suffixIcon: IconButton(
                          icon: const Icon(
                            Icons.close,
                            color: Colors.grey,
                          ),
                          onPressed: () {},
                        ),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                        ),
                      ),
                    ),
                  ),
                  kSizeBoxH8,
                  Expanded(
                    child: ListView.builder(
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return Followers(name: "Mohammed Abdeen", email: "abdeenmohammed2002@gmail.com", clickUser: (){}, followUser: (){});
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
