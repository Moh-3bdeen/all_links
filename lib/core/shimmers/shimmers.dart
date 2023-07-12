import 'package:all_links/core/constants/constant.dart';
import 'package:all_links/core/shimmers/shimmer_components.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class AllShimmerLoaded {
  static Shimmer accountLink() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[400]!,
      highlightColor: Colors.grey[100]!,
      child: const AccountLinkShimmer(),
    );
  }

//////////////////////////////////

  static Shimmer profileScreen() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[400]!,
      highlightColor: Colors.grey[100]!,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          // padding: const EdgeInsets.all(16),
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                CircleAvatar(
                  radius: 60,
                ),
                kSizeBoxW8,
                Expanded(
                  child: Row(
                    children: [
                      Expanded(child: TextAndNumber()),
                      kSizeBoxW8,
                      Expanded(child: TextAndNumber()),
                      kSizeBoxW8,
                      Expanded(child: TextAndNumber()),
                    ],
                  ),
                ),
              ],
            ),
            kSizeBoxH16,
            const TextShimmer(),
            const TextShimmer(),
            const TextShimmer(),
            kSizeBoxH8,
            const Row(
              children: [
                Expanded(child: AccountLinkShimmer()),
                kSizeBoxW8,
                Expanded(child: AccountLinkShimmer()),
              ],
            ),
            kDivider,
            Expanded(
              child: ListView.builder(
                itemCount: 7,
                itemBuilder: (context, index) {
                  return const AccountLinkShimmer();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

//////////////////////////////////
}
