import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iec_app/app/shared/utils/theme/app_color.dart';
import 'package:iec_app/app/shared/views/widgets/custom_text_widget.dart';

class FacebookGoogleButton extends StatelessWidget {
  const FacebookGoogleButton({Key? key, required this.imageName})
      : super(key: key);

  final String imageName;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: AppColor.primaryColor,
            content: TextWidget(
                fontWeight: FontWeight.w500,
                color: AppColor.whiteColor,
                fontSize: 16,
                text: 'Social logins are currently unavailable')));
      },
      child: CircleAvatar(
        radius: 35.44,
        backgroundColor: AppColor.whiteColor,
        child: SvgPicture.asset('assets/svgs/$imageName.svg'),
      ),
    );
  }
}
