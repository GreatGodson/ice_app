import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:iec_app/app/modules/cart/domain/providers/cart_provider.dart';
import 'package:iec_app/app/modules/profile/data/user.dart';
import 'package:iec_app/app/shared/utils/theme/app_color.dart';
import 'package:iec_app/app/shared/views/widgets/buttons/primary_button.dart';
import 'package:iec_app/app/shared/views/widgets/custom_text_widget.dart';

final subTotalProvider = StateProvider((ref) => '');
final quantityProvider = StateProvider((ref) => 1);

class CartScreen extends ConsumerStatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends ConsumerState<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final cart = ref.watch(userCart('5'));
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: BottomAppBar(
            color: AppColor.scaffoldBackgroundColor,
            elevation: 0.0,
            child: Padding(
              padding: const EdgeInsets.only(left: 50, right: 50),
              child: PrimaryButton(
                isLoading: false,
                title: 'Checkout',
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    backgroundColor: AppColor.primaryColor,
                    content: TextWidget(
                        fontWeight: FontWeight.w400,
                        color: AppColor.whiteColor,
                        fontSize: 16,
                        text: 'No checkout feature'),
                  ));
                },
              ),
            ),
          ),
        ),
        backgroundColor: AppColor.scaffoldBackgroundColor,
        appBar: AppBar(
          backgroundColor: AppColor.scaffoldBackgroundColor,
          iconTheme: const IconThemeData(color: AppColor.blackColor),
          centerTitle: true,
          elevation: 0.0,
          title: const TextWidget(
              fontWeight: FontWeight.w500,
              color: AppColor.blackColor,
              fontSize: 20,
              text: 'My Cart'),
        ),
        body: cart.when(
            data: (cartData) {
              return Padding(
                padding: const EdgeInsets.only(left: 21, right: 21),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: cachedCart.length,
                        itemBuilder: (context, index) {
                          final userCart = json.decode(cachedCart[index]);
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            ref.read(subTotalProvider.state).state =
                                '＄${userCart['data']['productPrice']}';
                          });
                          return Padding(
                            padding: const EdgeInsets.only(top: 13),
                            child: Container(
                                width: double.infinity,
                                height: size.height / 9,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: AppColor.whiteColor,
                                ),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.only(left: 14, right: 5),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        width: 84,
                                        height: 73,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            border: Border.all(
                                                color: AppColor
                                                    .productBackgroundColor)),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Expanded(
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 6, bottom: 6),
                                                child: CachedNetworkImage(
                                                  progressIndicatorBuilder:
                                                      (context, url,
                                                              progress) =>
                                                          Center(
                                                    child:
                                                        CircularProgressIndicator(
                                                      value: progress.progress,
                                                      color:
                                                          AppColor.primaryColor,
                                                    ),
                                                  ),
                                                  imageUrl: userCart['data']
                                                      ['productImage'],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 15),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              TextWidget(
                                                  fontWeight: FontWeight.w400,
                                                  color:
                                                      AppColor.brightTextColor,
                                                  fontSize: 14,
                                                  text: userCart['data']
                                                      ['productName']),
                                              TextWidget(
                                                  fontWeight: FontWeight.w500,
                                                  color: AppColor.blackColor,
                                                  fontSize: 16,
                                                  text:
                                                      '＄${userCart['data']['productPrice']}'),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          IconButton(
                                              onPressed: () {
                                                ref
                                                    .read(
                                                        quantityProvider.state)
                                                    .state = ref
                                                        .read(quantityProvider
                                                            .state)
                                                        .state +
                                                    1;
                                              },
                                              icon: Container(
                                                height: 21.48,
                                                width: 26,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                    color:
                                                        AppColor.cartIconColor),
                                                child: const Icon(
                                                  Icons.add,
                                                  color: AppColor.primaryColor,
                                                  size: 16,
                                                ),
                                              )),
                                          TextWidget(
                                              fontWeight: FontWeight.w400,
                                              color: AppColor.blackColor,
                                              fontSize: 14,
                                              text: ref
                                                  .watch(quantityProvider.state)
                                                  .state
                                                  .toString()),
                                          IconButton(
                                              onPressed: () {
                                                if (ref
                                                        .read(quantityProvider
                                                            .state)
                                                        .state ==
                                                    1) {
                                                  ref
                                                          .read(quantityProvider
                                                              .state)
                                                          .state <=
                                                      1;
                                                } else {
                                                  ref
                                                      .read(quantityProvider
                                                          .state)
                                                      .state = ref
                                                          .read(quantityProvider
                                                              .state)
                                                          .state -
                                                      1;
                                                }
                                              },
                                              icon: Container(
                                                height: 21.48,
                                                width: 26,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                    color:
                                                        AppColor.cartIconColor),
                                                child: const Icon(
                                                  Icons.remove,
                                                  color: AppColor.primaryColor,
                                                  size: 16,
                                                ),
                                              )),
                                        ],
                                      ),
                                    ],
                                  ),
                                )),
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const TextWidget(
                              fontWeight: FontWeight.w400,
                              color: AppColor.blackColor,
                              fontSize: 14,
                              text: 'Subtotal :'),
                          TextWidget(
                              fontWeight: FontWeight.w500,
                              color: AppColor.subTotalColor,
                              fontSize: 18,
                              text: ref.watch(subTotalProvider.state).state),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
            error: (error, stack) {
              print(stack);
              print(error);
              return const SizedBox.shrink();
            },
            loading: () => const CupertinoActivityIndicator()));
  }
}
