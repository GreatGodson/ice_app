import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iec_app/app/shared/utils/theme/app_color.dart';

class FacebookGoogleButton extends StatelessWidget {
  const FacebookGoogleButton({Key? key, required this.imageName})
      : super(key: key);

  final String imageName;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 35.44,
      backgroundColor: AppColor.whiteColor,
      child: SvgPicture.asset('assets/svgs/$imageName.svg'),
    );
  }
}
