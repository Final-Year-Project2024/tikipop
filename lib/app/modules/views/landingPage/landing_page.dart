// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tikipap/app/data/constants/assets.dart';
import 'package:tikipap/app/modules/views/profile/profile_view.dart';
import 'package:tikipap/app/modules/views/upload/uploadpost.dart';

import '../home/home_view.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  int selectedIndex = 0;
  List<dynamic> pages = [
    HomeView(),
    Container(),
    ProfileView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: pages[selectedIndex],
        bottomNavigationBar: ConvexAppBar(
          backgroundColor: Colors.white,
          activeColor: Colors.blue,
          initialActiveIndex: selectedIndex,
          elevation: 0,
          style: TabStyle.fixedCircle,
          color: Colors.blue,
          items: [
            TabItem(icon: SvgPicture.asset(CustomAssets.kHome), title: ''),
            const TabItem(icon: Icons.add, title: ''),
            TabItem(icon: SvgPicture.asset(CustomAssets.kUserIcon), title: ''),
          ],
          onTap: (int i) {
            if (i != 1) {
              setState(() {
                selectedIndex = i;
              });
            } else {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => UploadPage()));
            }
          },
        ));
  }
}
