import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iec_app/app/modules/profile/data/user.dart';
import 'package:iec_app/app/modules/profile/views/screens/edit_profile_screen.dart';
import 'package:iec_app/app/shared/utils/theme/app_color.dart';
import 'package:iec_app/app/shared/views/widgets/custom_text_widget.dart';

class CustomDrawer extends StatelessWidget {
  CustomDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(bottomRight: Radius.circular(50))),
      child: Column(
        children: [
          DrawerHeader(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const CircleAvatar(
                  backgroundColor: AppColor.whiteColor,
                  radius: 40,
                  child: Icon(
                    Icons.person,
                    color: AppColor.primaryColor,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 12),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextWidget(
                            text: cachedName,
                            color: AppColor.blackColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 20),
                        TextWidget(
                            text: cachedMail,
                            color: AppColor.blackColor,
                            fontWeight: FontWeight.w400,
                            fontSize: 14),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          DrawerListTile(
            title: 'Edit profile',
            icon: 'person',
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => const UpdateProfileScreen()));
            },
          ),
        ],
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    Key? key,
    required this.title,
    required this.icon,
    required this.onTap,
  }) : super(key: key);

  final String title;
  final String icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: SvgPicture.asset(
        'assets/svgs/$icon.svg',
        height: 20,
      ),
      title: TextWidget(
          text: title,
          color: AppColor.blackColor,
          fontWeight: FontWeight.w400,
          fontSize: 14),
      onTap: onTap,
    );
  }
}
