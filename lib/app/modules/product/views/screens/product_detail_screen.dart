import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iec_app/app/modules/cart/views/screens/cart_screen.dart';
import 'package:iec_app/app/shared/utils/theme/app_color.dart';
import 'package:iec_app/app/shared/views/widgets/buttons/primary_button.dart';
import 'package:iec_app/app/shared/views/widgets/custom_text_widget.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({Key? key}) : super(key: key);

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColor.productBackgroundColor,
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: SvgPicture.asset(
              'assets/svgs/likeProduct.svg',
            ),
          ),
        ],
        elevation: 0.0,
        iconTheme: const IconThemeData(color: AppColor.blackColor),
        backgroundColor: AppColor.productBackgroundColor,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SvgPicture.asset(
            'assets/svgs/google.svg',
            height: 100,
          ),
          Container(
            height: size.height / 2.34,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: AppColor.whiteColor,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(45), topRight: Radius.circular(45)),
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 20, right: 20, top: 30, bottom: 32.15),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Expanded(
                        child: TextWidget(
                            fontWeight: FontWeight.w500,
                            color: AppColor.darkTextColor,
                            fontSize: 20,
                            text: 'My product for sale'),
                      ),
                      TextWidget(
                          fontWeight: FontWeight.w500,
                          color: AppColor.blackColor,
                          fontSize: 18,
                          text: '300'),
                    ],
                  ),
                  const Padding(
                      padding: EdgeInsets.only(top: 17),
                      child: TextWidget(
                          fontWeight: FontWeight.w400,
                          color: AppColor.brightTextColor,
                          fontSize: 14,
                          text:
                              '3fnfoifninfinfonfnifbfbfibffbfubffubfufbfufbfufboifn;pfnfifnfionfinfifnfiofnifnfifnfinnnfinfnioflfnfnfiofnnfifnfifnifnnfofnffnofnfonifofnffonfnfnifnof')),
                  const Spacer(),
                  PrimaryButton(
                      title: 'Add to Cart',
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const CartScreen()));
                      })
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
