import 'dart:developer';

import 'package:all_links/core/alert_dialog/all_dialogs.dart';
import 'package:all_links/features/home/presentation/controller/location_provider.dart';
import 'package:all_links/features/home/presentation/pages/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/constant.dart';
import '../../../../core/constants/router_list.dart';
import '../../../active_sharing/presentation/pages/active_sharing_screen.dart';
import '../../../profile/presentation/pages/profile_screen.dart';

class PageViewApp extends StatefulWidget {
  const PageViewApp({super.key});

  @override
  State<PageViewApp> createState() => _PageViewAppState();
}

class _PageViewAppState extends State<PageViewApp> {
  PageController pageController = PageController();
  int currentIndex = 0;
  String selectedPageName = 'Profile';


  selectNewPage(int index) {
    currentIndex = index;
    selectedPageName = index == 0 ? "Profile" : index == 1 ? "Home" : "Active Sharing";
    pageController.jumpToPage(currentIndex);
    setState(() {});
  }


  @override
  void initState() {
    // Provider.of<LocationProvider>(context, listen: false).getLocation(context);
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: kBackgroundColor,
        title: Text(selectedPageName, style: const TextStyle(color: Colors.black),),
        actions: [
          IconButton(
            onPressed: () {
              // Navigator.pushNamed(context, RouterList.profileScreen);
            },
            icon: const Icon(
              Icons.search,
              color: Colors.black,
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, RouterList.scannerQRCodeScreen);
            },
            icon: const Icon(
              Icons.qr_code_scanner,
              color: Colors.black,
            ),
          ),
          IconButton(
            onPressed: () {
              AllDialogs.logoutDialog(context);
            },
            icon: const Icon(
              Icons.logout,
              color: Colors.black,
            ),
          ),
          kSizeBoxW16,
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: BottomNavigationBar(
            showSelectedLabels: true,
            showUnselectedLabels: false,
            elevation: 5,
            backgroundColor: kMainColorLight,
            selectedItemColor: Colors.white,
            selectedIconTheme: const IconThemeData(size: 28),
            unselectedItemColor: Colors.grey,
            currentIndex: currentIndex,
            onTap: (int index){
              selectNewPage(index);
            },
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(icon: Icon(Icons.emergency_share), label: 'Active Sharing'),
            ],
          ),
        ),
      ),
      body: PageView(
          physics: const NeverScrollableScrollPhysics(),
          // allowImplicitScrolling: false,
          controller: pageController,
          onPageChanged: (value) {
            selectNewPage(value);
          },
          children: const [
            ProfileScreen(),
            HomeScreen(),
            ActiveSharingScreen(),
          ]
      ),
    );
  }
}
