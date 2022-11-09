import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iec_app/app/modules/home/views/screens/home_screen.dart';
import 'package:iec_app/app/modules/profile/data/user.dart';

import 'package:iec_app/app/shared/utils/theme/app_color.dart';
import 'package:iec_app/app/shared/views/widgets/cards/profile_card.dart';
import 'package:iec_app/app/shared/views/widgets/cards/profile_details_card.dart';
import 'package:iec_app/app/shared/views/widgets/custom_text_widget.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.scaffoldBackgroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                height: 220,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/background.png'),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              const CircleAvatar(
                radius: 67.5,
                backgroundColor: AppColor.whiteColor,
                child: Icon(
                  Icons.person_add,
                  color: AppColor.primaryColor,
                  size: 30,
                ),
              )
            ],
          ),
          TextWidget(
              fontWeight: FontWeight.w500,
              color: AppColor.blackColor,
              fontSize: 24,
              text: ref.watch(userNameProvider.state).state),
          TextWidget(
            fontWeight: FontWeight.w400,
            color: AppColor.brightTextColor,
            fontSize: 16,
            text: ref.watch(userMailProvider.state).state,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [
              ProfileCard(
                  title: 'Progress order',
                  imageName: 'profileBag',
                  iconColor: AppColor.brightPinkColor,
                  score: '10+'),
              ProfileCard(
                  title: 'Promocodes',
                  imageName: 'profilePromo',
                  iconColor: AppColor.brightBlueTheme,
                  score: '5'),
              ProfileCard(
                  title: 'Reviews',
                  imageName: 'star',
                  iconColor: AppColor.brightYellowTheme,
                  score: '4.5K'),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 21.26),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: const [
                TextWidget(
                    fontWeight: FontWeight.w500,
                    color: AppColor.mainBlackColor,
                    fontSize: 18,
                    text: 'Personal Information'),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 21.26, right: 21.26),
            child: ProfileDetailsCard(),
          )
        ],
      ),
    );
  }
}
