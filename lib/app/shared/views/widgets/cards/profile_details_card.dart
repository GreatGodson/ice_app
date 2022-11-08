import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iec_app/app/modules/location/domain/providers/location_provider.dart';
import 'package:iec_app/app/modules/profile/data/user.dart';

import 'package:iec_app/app/shared/utils/theme/app_color.dart';
import 'package:iec_app/app/shared/views/widgets/ListTile/profile_list_tile.dart';

class ProfileDetailsCard extends ConsumerWidget {
  const ProfileDetailsCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final location = ref.watch(locationRepository(context));
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColor.categoryCardBorderColor, width: 2),
          color: AppColor.whiteColor),
      child: Column(
        children: [
          ProfileDetailListTile(
            title: 'Name :',
            value: name,
          ),
          ProfileDetailListTile(
            title: 'Email :',
            value: mail,
          ),
          location.when(
              data: (locationData) {
                return ProfileDetailListTile(
                  title: 'Location :',
                  value: locationData,
                );
              },
              error: (error, stack) {
                return const SizedBox.shrink();
              },
              loading: () => const SizedBox.shrink()),
          const ProfileDetailListTile(
            title: 'Zip Code :',
            value: '',
          ),
          const ProfileDetailListTile(
            title: 'Phone Number :',
            value: '',
          ),
        ],
      ),
    );
  }
}
