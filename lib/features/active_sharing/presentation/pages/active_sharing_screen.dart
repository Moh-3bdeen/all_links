import 'package:all_links/core/constants/constant.dart';
import 'package:all_links/core/shimmers/shimmers.dart';
import 'package:all_links/features/active_sharing/presentation/controller/active_sharing_provider.dart';
import 'package:all_links/features/active_sharing/presentation/widgets/user_active.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ActiveSharingScreen extends StatefulWidget {
  const ActiveSharingScreen({super.key});

  @override
  State<ActiveSharingScreen> createState() => _ActiveSharingScreenState();
}

class _ActiveSharingScreenState extends State<ActiveSharingScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  Duration duration = const Duration(seconds: 5);

  @override
  void initState() {
    super.initState();
    int? userId = Provider.of<ActiveSharingProvider>(context, listen: false).userId;
    Provider.of<ActiveSharingProvider>(context, listen: false).setActiveSharing(context, "sender");
    Provider.of<ActiveSharingProvider>(context, listen: false).nearestSender(context, userId ?? 0);

    controller = AnimationController(vsync: this, duration: duration);

    controller.repeat();
    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    int? userId = Provider.of<ActiveSharingProvider>(context, listen: false).userId;
    Provider.of<ActiveSharingProvider>(context, listen: false).removeActiveSharing(context, userId ?? 0);
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ActiveSharingProvider>(builder: (context, provider, child) {

      return Scaffold(
        backgroundColor: kBackgroundColor,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      kSizeBoxH16,
                      const Text(
                        "Active Sharing",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      kSizeBoxH16,
                      // kSizeBoxH16,
                      Icon(Icons.emergency_share, size: controller.value * 220),
                    ],
                  ),
                ),
                Expanded(
                  child:
                      !provider.isGettingData && provider.allNearestUser.isEmpty
                          ? const Center(child: Text("No any users nearest you!"))
                          : ListView.builder(
                              itemCount: provider.isGettingData
                                  ? 10
                                  : provider.allNearestUser.length,
                              itemBuilder: (context, index) {
                                return provider.isGettingData
                                    ? AllShimmerLoaded.accountLink()
                                    : UserActive(name: provider.allNearestUser[index]["user"]["name"] ?? "");
                              },
                            ),
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
