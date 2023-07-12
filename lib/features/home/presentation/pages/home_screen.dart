import 'package:all_links/core/constants/constant.dart';
import 'package:all_links/core/shimmers/shimmers.dart';
import 'package:all_links/features/home/presentation/controller/home_provider.dart';
import 'package:all_links/features/links/data/models/link_model.dart';
import 'package:all_links/features/links/presentation/controller/link_provider.dart';
import 'package:all_links/features/links/presentation/widgets/account_link.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(builder: (context, provider, child) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            kSizeBoxH16,
            Text(
              "Hello, ${provider.userName ?? ""}!",
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
            kSizeBoxH16,
            GestureDetector(
              onTap: () {},
              onLongPress: () {
                provider.changeActiveValue();
              },
              child: SizedBox(
                width: double.infinity,
                height: MediaQuery.of(context).size.height / 2.8,
                child: Center(
                  child: QrImageView(
                    data: provider.userEmail ?? "",
                    version: QrVersions.auto,
                    size: MediaQuery.of(context).size.height / 2.8,
                    backgroundColor:
                        provider.isActive ? kMainColorDark : Colors.white,
                    foregroundColor:
                        provider.isActive ? Colors.white : Colors.black,
                    errorStateBuilder: (cxt, err) {
                      return const SizedBox(
                        child: Center(
                          child: Text(
                            'Something went wrong...',
                            textAlign: TextAlign.center,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            kSizeBoxH16,
            kDivider,
            kSizeBoxH16,
            Expanded(
              child: Consumer<LinkProvider>(builder: (context, provider, child) {
                if (provider.allMyLinks.isEmpty) {
                  provider.getMyLinks(context);
                }
                return ListView.builder(
                  itemCount: provider.isGettingData
                      ? 5
                      : provider.allMyLinks.length > 3
                          ? 3
                          : provider.allMyLinks.length,
                  itemBuilder: (context, index) {
                    return provider.isGettingData
                        ? AllShimmerLoaded.accountLink()
                        : Container(
                            margin: const EdgeInsets.symmetric(vertical: 5),
                            child: AccountLink(
                              // appName: provider.allMyLinks[index].title ?? "",
                              link: provider.allMyLinks[index],
                              background: const Color(0xFFFEE2E7),
                            ),
                          );
                  },
                );
              }),
            ),
          ],
        ),
      );
    });
  }
}
