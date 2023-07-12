import 'package:flutter/material.dart';
import '../../../../core/constants/constant.dart';

class ProfileImage extends StatelessWidget {
  final double radius;

  const ProfileImage({super.key, required this.radius});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CircleAvatar(
          radius: radius,
          backgroundColor: kMainColorLight,
          child: const Icon(Icons.person, size: 40,),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: InkWell(
            onTap: () async {
              // ImagePicker imagePicker = ImagePicker();
              // XFile? file = await imagePicker.pickImage(source: ImageSource.gallery, imageQuality: 50);
            },
            child: const CircleAvatar(
              backgroundColor: kMainColorDark,
              child: Center(
                child: Icon(
                  Icons.change_circle_outlined,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
