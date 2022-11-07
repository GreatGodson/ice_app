import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iec_app/app/modules/authentication/views/screens/signup_screen.dart';
import 'package:iec_app/app/shared/utils/theme/app_color.dart';
import 'package:iec_app/app/shared/views/widgets/buttons/primary_button.dart';
import 'package:iec_app/app/shared/views/widgets/custom_divider.dart';
import 'package:iec_app/app/shared/views/widgets/buttons/facebook_google_button.dart';
import 'package:iec_app/app/shared/views/widgets/custom_text_widget.dart';
import 'package:iec_app/app/shared/views/widgets/text_field/text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColor.scaffoldBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              SvgPicture.asset('assets/svgs/logo.svg'),
              const Padding(
                padding: EdgeInsets.only(top: 38),
                child: TextWidget(
                    fontWeight: FontWeight.w500,
                    color: AppColor.blackColor,
                    fontSize: 22,
                    text: 'Log in'),
              ),
              const Spacer(),
              Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: ValidatorTextForm(
                          prefixIconName: 'email',
                          hintText: 'Email',
                          size: size,
                          onChanged: (val) {
                            _formKey.currentState!.validate();
                          },
                          validator: (val) {
                            var vv = RegExp(
                                r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
                            bool inValid =
                                vv.hasMatch(val!.trim()) ? true : false;
                            if (val.isEmpty) {
                              return 'Required';
                            } else if (!inValid) {
                              return 'Enter a valid email address';
                            }
                            return null;
                          },
                        ),
                      ),
                      ValidatorTextForm(
                        prefixIconName: 'password',
                        hintText: 'Password',
                        size: size,
                        onChanged: (val) {
                          _formKey.currentState!.validate();
                        },
                        validator: (val) {
                          if (val!.isEmpty) {
                            return 'Required';
                          } else if (val.length < 6) {
                            return 'Password must be greater than 6 characters';
                          }
                          return null;
                        },
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 18, bottom: 17),
                        child: TextWidget(
                            fontWeight: FontWeight.w400,
                            color: AppColor.darkTextColor,
                            fontSize: 12,
                            text: 'Forgot password?'),
                      ),
                    ],
                  )),
              PrimaryButton(
                title: 'Log in',
                onPressed: () {},
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    CustomDivider(
                      startPadding: true,
                    ),
                    TextWidget(
                      text: 'Or',
                      color: AppColor.darkTextColor,
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                    ),
                    CustomDivider(
                      startPadding: false,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const [
                    FacebookGoogleButton(
                      imageName: 'facebook',
                    ),
                    FacebookGoogleButton(
                      imageName: 'google',
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const TextWidget(
                      text: 'Don’t have an account?',
                      color: AppColor.darkTextColor,
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) => const SignUpScreen()));
                      },
                      child: const TextWidget(
                        text: 'Sign Up',
                        color: AppColor.blackColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
