import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iec_app/app/shared/utils/theme/app_color.dart';
import 'package:iec_app/app/shared/views/widgets/custom_text_widget.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton(
      {Key? key,
      required this.title,
      required this.onPressed,
      this.width,
      required this.isLoading})
      : super(key: key);

  final VoidCallback onPressed;
  final String title;
  final double? width;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height / 15.5,
      width: width ?? size.width / 2,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(AppColor.primaryColor),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(133.0),
            ))),
        child: isLoading
            ? const CupertinoActivityIndicator(
                color: AppColor.whiteColor,
              )
            : TextWidget(
                text: title,
                color: AppColor.whiteColor,
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
      ),
    );
  }
}
