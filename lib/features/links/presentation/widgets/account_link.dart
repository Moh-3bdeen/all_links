import 'package:all_links/core/constants/constant.dart';
import 'package:all_links/core/constants/router_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../data/models/link_model.dart';
import '../controller/link_provider.dart';

class AccountLink extends StatelessWidget {
  final Link link;
  final Color background;

  const AccountLink(
      {super.key,
      required this.link,
      required this.background});

  void _launchUrl(BuildContext context, String rul) async {
    if (await canLaunch(rul)) {
      await launch(rul);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Could not launch: $rul!'),
      ),);

      throw 'Could not launch $rul';
    }
  }


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        _launchUrl(context, link.link ?? "");
      },
      child: Slidable(
        key: const ValueKey(0),
        startActionPane: ActionPane(
          motion: const ScrollMotion(),
          // dismissible: DismissiblePane(onDismissed: () {}),
          children: [
            SlidableAction(
              onPressed: (context){
                Provider.of<LinkProvider>(context, listen: false).deleteLink(context, link);
              },
              backgroundColor: const Color(0xFFFE4A49),
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Delete',
            ),
          ],
        ),
        endActionPane:  ActionPane(
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: (context){
                Navigator.pushNamed(context, RouterList.addOrEditLink, arguments: link);
              },
              backgroundColor: const Color(0xFF21B7CA),
              foregroundColor: Colors.white,
              icon: Icons.update,
              label: 'Update',
            ),
          ],
        ),

        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: background,
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                link.title ?? "",
                style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
              ),
              kSizeBoxH8,
              Text(link.link ?? ""),
            ],
          ),
        ),
      ),


    );
  }
}
