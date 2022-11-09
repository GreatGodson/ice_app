import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iec_app/app/modules/authentication/domain/services/auth_service.dart';
import 'package:iec_app/app/modules/profile/data/user.dart';
import 'package:iec_app/app/modules/wrapper/views/bottom_nav_bar.dart';
import 'package:iec_app/app/shared/helpers/device/device_info.dart';
import 'package:iec_app/app/shared/helpers/preferences/preferences.dart';
import 'package:iec_app/app/shared/utils/theme/app_color.dart';
import 'package:iec_app/app/shared/views/widgets/buttons/primary_button.dart';
import 'package:iec_app/app/shared/views/widgets/custom_divider.dart';
import 'package:iec_app/app/shared/views/widgets/buttons/facebook_google_button.dart';
import 'package:iec_app/app/shared/views/widgets/custom_text_widget.dart';
import 'package:iec_app/app/shared/views/widgets/text_field/text_field.dart';

final isLoadingProvider = StateProvider((ref) => false);

class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final agreeProvider = StateProvider((ref) => false);
  String email = '';
  String password = '';
  String firstName = ' ';
  void addAccount() async {
    if (firstName.isNotEmpty && email.isNotEmpty && password.isNotEmpty) {
      if (ref.read(agreeProvider.state).state == false) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: AppColor.primaryColor,
            content: TextWidget(
                fontWeight: FontWeight.w400,
                color: AppColor.whiteColor,
                fontSize: 16,
                text: 'Kindly accept our terms of service to proceed')));
      } else {
        try {
          ref.read(isLoadingProvider.state).state = true;

          final deviceToken = await DeviceHelper.initPlatformState();

          await Preferences.setString(key: 'name', value: firstName);
          await Preferences.setString(key: 'mail', value: email);
          await Preferences.setString(key: 'password', value: password);
          await Preferences.setString(key: 'token', value: deviceToken);

          cachedName = Preferences.getString('name') ?? '';
          cachedMail = Preferences.getString('mail') ?? '';
          cachedPassword = Preferences.getString('password') ?? '';
          devToken = Preferences.getString('token');

          // Preferences.getString('password');

          await AuthService.addNewUser(
              email: email,
              firstName: firstName,
              lastName: firstName,
              userName: 'bh',
              password: password,
              address: 'ggg',
              phoneNumber: 'jgj');
          Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const BottomNavBarWidget()));
          ref.read(isLoadingProvider.state).state = false;
        } catch (e) {
          print(e);
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
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: AppColor.primaryColor,
          content: TextWidget(
              fontWeight: FontWeight.w400,
              color: AppColor.whiteColor,
              fontSize: 16,
              text: 'Kindly fill all fields to signup')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final oldCheckboxTheme = theme.checkboxTheme;
    final newCheckBoxTheme = oldCheckboxTheme.copyWith(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
    );
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColor.scaffoldBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 60),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset('assets/svgs/logo.svg'),
                const TextWidget(
                    fontWeight: FontWeight.w500,
                    color: AppColor.blackColor,
                    fontSize: 22,
                    text: 'Sign Up'),
                Padding(
                  padding: const EdgeInsets.only(top: 25, bottom: 20),
                  child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: ValidatorTextForm(
                              prefixIconName: 'person',
                              hintText: 'Name',
                              size: size,
                              onChanged: (val) {
                                _formKey.currentState!.validate();
                                firstName = val.trim();
                              },
                              validator: (val) {
                                var vv = RegExp('[^a-zA-Z]');
                                bool inValid =
                                    vv.hasMatch(val!.trim()) ? true : false;
                                if (val.isEmpty) {
                                  return 'Required';
                                } else if (inValid) {
                                  return 'Invalid name';
                                }
                                return null;
                              },
                            ),
                          ),
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
                            prefixIconName: 'password',
                            hintText: 'Password',
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
                          Theme(
                            data:
                                theme.copyWith(checkboxTheme: newCheckBoxTheme),
                            child: CheckboxListTile(
                                controlAffinity:
                                    ListTileControlAffinity.leading,
                                value: ref.watch(agreeProvider),
                                activeColor: AppColor.primaryColor,
                                onChanged: (val) {
                                  val == null
                                      ? ref.read(agreeProvider.state).state =
                                          false
                                      : ref.read(agreeProvider.state).state =
                                          val;
                                },
                                title: RichText(
                                  text: const TextSpan(
                                    children: [
                                      TextSpan(
                                          text: 'I accept all the',
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontFamily: 'Gordita',
                                              fontWeight: FontWeight.w500,
                                              fontSize: 12)),
                                      TextSpan(
                                          text: ' Terms & Conditions',
                                          style: TextStyle(
                                              color: AppColor.blackColor,
                                              fontFamily: 'Gordita',
                                              fontWeight: FontWeight.w500,
                                              fontSize: 12))
                                    ],
                                  ),
                                )),
                          ),
                        ],
                      )),
                ),
                PrimaryButton(
                  isLoading: ref.watch(isLoadingProvider.state).state,
                  title: 'Sign up',
                  onPressed: () {
                    addAccount();
                    // Navigator.of(context).push(MaterialPageRoute(
                    //     builder: (_) => const BottomNavBarWidget()));
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 31, bottom: 33),
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
                Row(
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const TextWidget(
                      text: 'Already have an account?',
                      color: AppColor.darkTextColor,
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const TextWidget(
                        text: 'Log in',
                        color: AppColor.blackColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
