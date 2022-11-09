import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iec_app/app/shared/utils/styles/text_styles.dart';
import 'package:iec_app/app/shared/utils/theme/app_color.dart';

class ValidatorTextForm extends StatelessWidget {
  const ValidatorTextForm({
    Key? key,
    required this.size,
    required this.onChanged,
    this.autofocus,
    this.borderColor,
    this.initialValue,
    this.hintText,
    this.textInputType,
    required this.validator,
    required this.prefixIconName,
  }) : super(key: key);
  final Size size;
  final Function(String) onChanged;
  final bool? autofocus;
  final Color? borderColor;
  final String? initialValue;
  final String? hintText;
  final TextInputType? textInputType;
  final String? Function(String?)? validator;
  final String prefixIconName;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: 1,
      validator: validator,
      keyboardType: textInputType ?? TextInputType.text,
      autofocus: autofocus ?? false,
      style: textFormTextStyle,
      onChanged: onChanged,
      initialValue: initialValue ?? '',
      cursorColor: AppColor.blackColor,
      decoration: InputDecoration(
          hintText: hintText ?? '',
          hintStyle: hintTextFieldTextStyle,
          fillColor: AppColor.whiteColor,
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: AppColor.primaryColor),
          ),
          prefixStyle: textFormTextStyle,
          prefixIcon: Padding(
            padding:
                const EdgeInsets.only(left: 8, right: 9, top: 6, bottom: 6),
            child: Container(
              width: 48,
              height: 45,
              decoration: const BoxDecoration(
                  color: AppColor.brightPrimaryColor,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'assets/svgs/$prefixIconName.svg',
                  ),
                ],
              ),
            ),
          )),
    );
  }
}

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    required this.size,
    required this.onChanged,
    this.autofocus,
    this.borderColor,
    this.initialValue,
    this.hintText,
    this.textInputType,
  }) : super(key: key);

  final Size size;
  final Function(String) onChanged;
  final bool? autofocus;
  final Color? borderColor;
  final String? initialValue;
  final String? hintText;
  final TextInputType? textInputType;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: 1,
      keyboardType: textInputType ?? TextInputType.text,
      autofocus: autofocus ?? false,
      style: textFormTextStyle,
      onChanged: onChanged,
      initialValue: initialValue ?? '',
      cursorColor: AppColor.blackColor,
      decoration: InputDecoration(
        hintText: hintText ?? '',
        hintStyle: hintTextFieldTextStyle,
        fillColor: AppColor.whiteColor,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppColor.primaryColor),
        ),
        prefixStyle: textFormTextStyle,
      ),
    );
  }
}
