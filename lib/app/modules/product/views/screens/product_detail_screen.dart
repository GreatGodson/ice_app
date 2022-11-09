import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iec_app/app/modules/authentication/views/screens/signup_screen.dart';
import 'package:iec_app/app/modules/cart/domain/services/cart_service.dart';
import 'package:iec_app/app/modules/cart/views/screens/cart_screen.dart';
import 'package:iec_app/app/modules/profile/data/user.dart';
import 'package:iec_app/app/shared/helpers/preferences/preferences.dart';
import 'package:iec_app/app/shared/utils/theme/app_color.dart';
import 'package:iec_app/app/shared/views/widgets/buttons/primary_button.dart';
import 'package:iec_app/app/shared/views/widgets/custom_text_widget.dart';

class ProductDetailScreen extends ConsumerStatefulWidget {
  const ProductDetailScreen(
      {Key? key,
      required this.productId,
      required this.productName,
      required this.productDescription,
      required this.productImageUrl,
      required this.productPrice})
      : super(key: key);

  final String productName;
  final String productImageUrl;
  final String productDescription;
  final String productPrice;
  final String productId;

  @override
  ConsumerState<ProductDetailScreen> createState() =>
      _ProductDetailScreenState();
}

class _ProductDetailScreenState extends ConsumerState<ProductDetailScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
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
        backgroundColor: AppColor.whiteColor,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
              child: CachedNetworkImage(
                progressIndicatorBuilder: (context, url, progress) => Center(
                  child: CircularProgressIndicator(
                    value: progress.progress,
                    color: AppColor.primaryColor,
                  ),
                ),
                imageUrl: widget.productImageUrl,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 25),
            child: Container(
              height: size.height / 2.34,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: AppColor.whiteColor,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(45),
                    topRight: Radius.circular(45),
                  ),
                  border: Border.all(
                      color: AppColor.productBackgroundColor, width: 2)),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 20, right: 20, top: 30, bottom: 32.15),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: TextWidget(
                              fontWeight: FontWeight.w500,
                              color: AppColor.darkTextColor,
                              fontSize: 20,
                              text: widget.productName),
                        ),
                        TextWidget(
                            fontWeight: FontWeight.w500,
                            color: AppColor.blackColor,
                            fontSize: 18,
                            text: '＄${widget.productPrice}'),
                      ],
                    ),
                    Expanded(
                      child: ListView(
                        children: [
                          Padding(
                              padding: const EdgeInsets.only(top: 17),
                              child: TextWidget(
                                  fontWeight: FontWeight.w400,
                                  color: AppColor.brightTextColor,
                                  fontSize: 14,
                                  text: widget.productDescription)),
                        ],
                      ),
                    ),
                    // const Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: PrimaryButton(
                          isLoading: ref.watch(isLoadingProvider.state).state,
                          title: 'Add to Cart',
                          onPressed: () async {
                            ref.read(isLoadingProvider.state).state = true;
                            Map<String, dynamic> cartData = {
                              'data': {
                                'productName': widget.productName,
                                'productPrice': widget.productPrice,
                                'productImage': widget.productImageUrl,
                                'productQuantity': 1,
                              }
                            };

                            String carted = json.encode(cartData);
                            final newCart = [carted];

                            await Preferences.setStringList(
                                key: 'cachedCartList', value: newCart);

                            cachedCart =
                                Preferences.getStringList('cachedCartList') ??
                                    [];

                            await CartService.addToCart();
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const CartScreen()));
                            ref.read(isLoadingProvider.state).state = false;
                          }),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
