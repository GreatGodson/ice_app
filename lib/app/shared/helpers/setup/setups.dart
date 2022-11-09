import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iec_app/app/modules/home/views/screens/home_screen.dart';
import 'package:iec_app/app/modules/profile/data/user.dart';
import 'package:iec_app/app/shared/helpers/device/device_info.dart';
import 'package:iec_app/app/shared/helpers/preferences/preferences.dart';

class Setups {
  static init() {
    cachedName = Preferences.getString('name') ?? '';
    cachedMail = Preferences.getString('mail') ?? '';
    cachedPassword = Preferences.getString('password') ?? '';
    devToken = Preferences.getString('token');
    cachedCart = Preferences.getStringList('cachedCartList') ?? [];
  }

  static localSignUp({required WidgetRef ref, required String firstName, required String email, required String password}) async {

    final deviceToken = await DeviceHelper.initPlatformState();

    await Preferences.setString(key: 'name', value: firstName);
    await Preferences.setString(key: 'mail', value: email);
    await Preferences.setString(key: 'password', value: password);
    await Preferences.setString(key: 'token', value: deviceToken);

    cachedName = Preferences.getString('name') ?? '';
    cachedMail = Preferences.getString('mail') ?? '';
    cachedPassword = Preferences.getString('password') ?? '';
    devToken = Preferences.getString('token');

    ref.read(userNameProvider.state).state = cachedName;
    ref.read(userMailProvider.state).state = cachedMail;
  }
}
