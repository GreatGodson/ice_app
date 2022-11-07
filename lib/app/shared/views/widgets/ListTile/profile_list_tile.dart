import 'package:flutter/material.dart';
import 'package:iec_app/app/shared/utils/theme/app_color.dart';
import 'package:iec_app/app/shared/views/widgets/custom_text_widget.dart';

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
