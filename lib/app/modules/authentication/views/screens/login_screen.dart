import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iec_app/app/modules/authentication/domain/services/auth_service.dart';
import 'package:iec_app/app/modules/authentication/views/screens/signup_screen.dart';
import 'package:iec_app/app/modules/profile/data/user.dart';
import 'package:iec_app/app/modules/wrapper/views/bottom_nav_bar.dart';
import 'package:iec_app/app/shared/helpers/device/device_info.dart';
import 'package:iec_app/app/shared/utils/theme/app_color.dart';
import 'package:iec_app/app/shared/views/widgets/buttons/primary_button.dart';
import 'package:iec_app/app/shared/views/widgets/custom_divider.dart';
import 'package:iec_app/app/shared/views/widgets/buttons/facebook_google_button.dart';
import 'package:iec_app/app/shared/views/widgets/custom_text_widget.dart';
import 'package:iec_app/app/shared/views/widgets/text_field/text_field.dart';

final obscureTextProvider = StateProvider((ref) => true);

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  void loginUser() async {
    if (email.isNotEmpty && password.isNotEmpty) {
      final deviceToken = await DeviceHelper.initPlatformState();
      if (devToken != null && deviceToken != devToken) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: AppColor.primaryColor,
            content: TextWidget(
                fontWeight: FontWeight.w400,
                color: AppColor.whiteColor,
                fontSize: 16,
                text: 'Unable to login multiple accounts on this device')));
      } else {
        if (email != cachedMail || password != cachedPassword) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              backgroundColor: AppColor.redColor,
              content: TextWidget(
                  fontWeight: FontWeight.w400,
                  color: AppColor.whiteColor,
                  fontSize: 16,
                  text: 'Invalid login credentials, try again')));
        } else {
          try {
            ref.read(isLoadingProvider.state).state = true;
            await AuthService.loginUser(userName: '', password: '');
            Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const BottomNavBarWidget()));
            ref.read(isLoadingProvider.state).state = false;
          } catch (e) {
            ref.read(isLoadingProvider.state).state = false;
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                backgroundColor: AppColor.redColor,
                content: TextWidget(
                    fontWeight: FontWeight.w400,
                    color: AppColor.whiteColor,
                    fontSize: 16,
                    text: 'Oops! something went wrong, Try again')));
          }
        }
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: AppColor.primaryColor,
          content: TextWidget(
              fontWeight: FontWeight.w400,
              color: AppColor.whiteColor,
              fontSize: 16,
              text: 'Kindly fill all fields to login')));
    }
  }

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
                            email = val.trim();
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
                        obscureText: ref.watch(obscureTextProvider),
                        prefixIconName: 'password',
                        hintText: 'Password',
                        suffixIcon: ref.watch(obscureTextProvider.state).state
                            ? IconButton(
                                color: AppColor.primaryColor,
                                onPressed: () {
                                  ref.read(obscureTextProvider.state).state =
                                      !ref
                                          .read(obscureTextProvider.state)
                                          .state;
                                },
                                icon: const Padding(
                                  padding: EdgeInsets.only(top: 10, left: 5),
                                  child: Icon(
                                    Icons.visibility_off,
                                    size: 18,
                                  ),
                                ))
                            : IconButton(
                                color: AppColor.primaryColor,
                                onPressed: () {
                                  ref.read(obscureTextProvider.state).state =
                                      !ref
                                          .read(obscureTextProvider.state)
                                          .state;
                                },
                                icon: const Padding(
                                  padding: EdgeInsets.only(top: 10, left: 5),
                                  child: Icon(
                                    Icons.visibility,
                                    size: 18,
                                  ),
                                )),
                        size: size,
                        onChanged: (val) {
                          _formKey.currentState!.validate();
                          password = val.trim();
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
                isLoading: ref.watch(isLoadingProvider.state).state,
                title: 'Log in',
                onPressed: () {
                  loginUser();
                },
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
                      text: 'Don???t have an account?',
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
