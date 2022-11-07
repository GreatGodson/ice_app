import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iec_app/app/shared/utils/theme/app_color.dart';
import 'package:iec_app/app/shared/views/widgets/custom_text_widget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
              )
            ],
          ),
          const TextWidget(
              fontWeight: FontWeight.w500,
              color: AppColor.blackColor,
              fontSize: 24,
              text: 'Godson Okezie'),
          const TextWidget(
              fontWeight: FontWeight.w400,
              color: AppColor.brightTextColor,
              fontSize: 16,
              text: 'greatgodsonokezie@yahoo.com'),
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
          Padding(
            padding: const EdgeInsets.only(left: 21.26, right: 21.26),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                      color: AppColor.categoryCardBorderColor, width: 2),
                  color: AppColor.whiteColor),
              child: Column(
                children: const [
                  ProfileDetailListTile(
                    title: 'Name :',
                    value: 'Godson Okezie',
                  ),
                  ProfileDetailListTile(
                    title: 'Email :',
                    value: 'greatgodsonokezie@yahoo.com',
                  ),
                  ProfileDetailListTile(
                    title: 'Location :',
                    value: 'Lagos',
                  ),
                  ProfileDetailListTile(
                    title: 'Zip Code :',
                    value: '100001',
                  ),
                  ProfileDetailListTile(
                    title: 'Phone Number :',
                    value: '+2349038818841',
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class ProfileDetailListTile extends StatelessWidget {
  const ProfileDetailListTile(
      {Key? key, required this.title, required this.value})
      : super(key: key);

  final String title;

  final String value;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: TextWidget(
          fontWeight: FontWeight.w400,
          color: AppColor.brightTextColor,
          fontSize: 14,
          text: title),
      trailing: TextWidget(
          fontWeight: FontWeight.w500,
          color: AppColor.blackColor,
          fontSize: 14,
          text: value),
    );
  }
}

class ProfileCard extends StatelessWidget {
  const ProfileCard(
      {Key? key,
      required this.title,
      required this.imageName,
      required this.iconColor,
      required this.score})
      : super(key: key);

  final String imageName;
  final String score;
  final String title;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 117,
      width: 107,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: AppColor.whiteColor),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          CircleAvatar(
            radius: 22.5,
            backgroundColor: iconColor,
            child: SvgPicture.asset('assets/svgs/$imageName.svg'),
          ),
          TextWidget(
              fontWeight: FontWeight.w500,
              color: AppColor.brightTextColor,
              fontSize: 12,
              text: title),
          TextWidget(
              fontWeight: FontWeight.w500,
              color: AppColor.blackColor,
              fontSize: 14,
              text: score),
        ],
      ),
    );
  }
}
