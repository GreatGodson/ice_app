import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iec_app/app/modules/authentication/views/screens/signup_screen.dart';
import 'package:iec_app/app/modules/home/views/screens/home_screen.dart';
import 'package:iec_app/app/modules/profile/data/user.dart';
import 'package:iec_app/app/shared/helpers/preferences/preferences.dart';
import 'package:iec_app/app/shared/utils/theme/app_color.dart';
import 'package:iec_app/app/shared/views/widgets/buttons/primary_button.dart';
import 'package:iec_app/app/shared/views/widgets/custom_text_widget.dart';
import 'package:iec_app/app/shared/views/widgets/text_field/text_field.dart';

class UpdateProfileScreen extends ConsumerStatefulWidget {
  const UpdateProfileScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<UpdateProfileScreen> createState() =>
      _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends ConsumerState<UpdateProfileScreen> {
  String name = '';
  String mail = '';
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColor.scaffoldBackgroundColor,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: AppColor.blackColor),
        elevation: 0.0,
        backgroundColor: AppColor.scaffoldBackgroundColor,
        title: const TextWidget(
            fontWeight: FontWeight.w500,
            color: AppColor.blackColor,
            fontSize: 18,
            text: 'Edit profile'),
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 0.0,
        child: Padding(
          padding: const EdgeInsets.only(left: 50, right: 50),
          child: PrimaryButton(
              title: 'Save',
              onPressed: () async {
                ref.read(isLoadingProvider.state).state = true;
                await Preferences.setString(
                    key: 'name', value: name.isNotEmpty ? name : cachedName);
                await Preferences.setString(
                    key: 'mail', value: mail.isNotEmpty ? mail : cachedMail);

                cachedName = Preferences.getString('name') ?? '';
                cachedMail = Preferences.getString('mail') ?? '';

                ref.read(userNameProvider.state).state = cachedName;
                ref.read(userMailProvider.state).state = cachedMail;

                ref.read(isLoadingProvider.state).state = false;
                Navigator.pop(context);
                Navigator.pop(context);
              },
              isLoading: ref.watch(isLoadingProvider.state).state),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomTextField(
              size: size,
              onChanged: (val) {
                name = val.trim();
              },
              initialValue: cachedName,
            ),
            CustomTextField(
              size: size,
              onChanged: (val) {
                mail = val.trim();
              },
              initialValue: cachedMail,
            )
          ],
        ),
      ),
    );
  }
}
