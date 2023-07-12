import 'package:flutter/material.dart';
import '../../../../core/constants/constant.dart';
import '../../../../core/constants/router_list.dart';

class UserDetails extends StatelessWidget {
  final int num;
  final String type;

  const UserDetails({
    super.key,
    required this.num,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, RouterList.followersScreen);
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "$num",
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          kSizeBoxH8,
          Text(
            type,
            style: const TextStyle(color: Colors.black),
          ),
        ],
      ),
    );
  }
}
