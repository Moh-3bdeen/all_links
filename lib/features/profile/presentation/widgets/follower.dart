import 'package:all_links/core/constants/constant.dart';
import 'package:flutter/material.dart';

class Followers extends StatelessWidget {
  final String name;
  final String email;
  final Function clickUser;
  final Function followUser;

  const Followers({super.key, required this.name, required this.email, required this.clickUser, required this.followUser});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(name),
      subtitle: Text(email),
      trailing: Container(
        height: 40,
        width: 80,
        // padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: kMainColorLight,
          borderRadius: BorderRadius.circular(8)
        ),
        child: const Center(
          child: Text("Follow", style: TextStyle(color: Colors.white),),
        ),
      ),
    );
  }
}
