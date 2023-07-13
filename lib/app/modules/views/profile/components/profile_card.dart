import 'package:flutter/material.dart';
import 'package:tikipap/app/data/constants/assets.dart';

import 'account_info_chips.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 50),
          padding:
              const EdgeInsets.only(left: 10, right: 10, top: 60, bottom: 20),
          decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10)),
          child: const Column(
            children: [
              Text(
                "Anabel May",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AccountInfoChips(
                    info: '35.5k Followers',
                  ),
                  SizedBox(width: 10),
                  AccountInfoChips(
                    info: '400 Followings',
                  ),
                ],
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
        CircleAvatar(
          radius: 50,
          backgroundImage: AssetImage(CustomAssets.kUser1),
        ),
      ],
    );
  }
}
