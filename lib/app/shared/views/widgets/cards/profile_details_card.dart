import 'package:flutter/material.dart';

import 'package:iec_app/app/shared/utils/theme/app_color.dart';
import 'package:iec_app/app/shared/views/widgets/ListTile/profile_list_tile.dart';

class ProfileDetailsCard extends StatelessWidget {
  const ProfileDetailsCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColor.categoryCardBorderColor, width: 2),
          color: AppColor.whiteColor),
      child: Column(
        children: const [
          ProfileDetailListTile(
            title: 'Name :',
            value: 'Godson Okezie',
          ),
          ProfileDetailListTile(
            title: 'Email :',
            value: 'greatgodsonokezie@yahoo.com',
          ),
          ProfileDetailListTile(
            title: 'Location :',
            value: 'Lagos',
          ),
          ProfileDetailListTile(
            title: 'Zip Code :',
            value: '100001',
          ),
          ProfileDetailListTile(
            title: 'Phone Number :',
            value: '+2349038818841',
          ),
        ],
      ),
    );
  }
}
