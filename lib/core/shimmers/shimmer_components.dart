import 'package:flutter/material.dart';

class AccountLinkShimmer extends StatelessWidget {
  const AccountLinkShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      width: double.infinity,
      height: 60,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: Colors.white,
      ),
    );
  }
}

//////////////

class TextAndNumber extends StatelessWidget {
  const TextAndNumber({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 5),
          width: 40,
          height: 15,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: Colors.white,
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 5),
          width: double.infinity,
          height: 10,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}

//////////////

class TextShimmer extends StatelessWidget {
  const TextShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 5),
          width: MediaQuery.of(context).size.width / 1.7,
          height: 15,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}

//////////////

