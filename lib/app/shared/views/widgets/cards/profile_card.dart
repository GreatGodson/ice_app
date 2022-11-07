import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iec_app/app/shared/utils/theme/app_color.dart';
import 'package:iec_app/app/shared/views/widgets/custom_text_widget.dart';

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
