import 'package:flutter/material.dart';
import 'package:iec_app/app/shared/utils/theme/app_color.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({Key? key, required this.startPadding}) : super(key: key);

  final bool startPadding;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: startPadding
            ? const EdgeInsets.only(left: 50, right: 20)
            : const EdgeInsets.only(left: 20, right: 50),
        child: const Divider(
          color: AppColor.dividerColor,
          thickness: 1,
        ),
      ),
    );
  }
}
