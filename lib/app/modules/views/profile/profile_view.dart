import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tikipap/app/models/post_model.dart';
import 'package:tikipap/app/modules/views/home/post_detail_page.dart';

import '../home/components/post_card.dart';
import 'components/profile_card.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  int selectedPostType = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text("Profile",
            style: TextStyle(fontSize: 18, color: Colors.black)),
        actions: [
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                onPressed: () {
                  GoogleSignIn().signOut();
                  FirebaseAuth.instance.signOut();
                },
                icon: Icon(Icons.logout_outlined),
                color: Colors.grey,
              ))
        ],
      ),
      body: AnimationLimiter(
        child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            children: AnimationConfiguration.toStaggeredList(
                duration: const Duration(milliseconds: 375),
                childAnimationBuilder: (widget) => SlideAnimation(
                      horizontalOffset: MediaQuery.of(context).size.width / 2,
                      child: FadeInAnimation(child: widget),
                    ),
                children: [
                  const SizedBox(height: 10),
                  const ProfileCard(),
                  const SizedBox(height: 20),
                  const SizedBox(height: 20),
                  ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return PostCard(
                            onTap: () {
                              Get.to(() =>
                                  PostDetailPage(post: dummyPosts[index]));
                            },
                            post: dummyPosts[index]);
                      },
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 10),
                      itemCount: dummyPosts.length)
                ])),
      ),
    );
  }
}
