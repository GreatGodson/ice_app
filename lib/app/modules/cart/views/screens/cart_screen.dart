import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:iec_app/app/shared/utils/theme/app_color.dart';
import 'package:iec_app/app/shared/views/widgets/buttons/primary_button.dart';
import 'package:iec_app/app/shared/views/widgets/custom_text_widget.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        color: AppColor.scaffoldBackgroundColor,
        elevation: 0.0,
        child: Padding(
          padding: const EdgeInsets.only(left: 50, right: 50),
          child: PrimaryButton(
            title: 'Checkout',
            onPressed: () {},
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
      body: Padding(
        padding: const EdgeInsets.only(left: 21, right: 21),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: 4,
                itemBuilder: (context, index) {
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
                          padding: const EdgeInsets.only(left: 14, right: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                // width: size.width / 4.6,
                                width: 84,
                                height: 73,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    border: Border.all(
                                        color:
                                            AppColor.productBackgroundColor)),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      'assets/svgs/dress.svg',
                                      // height: 45,
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  TextWidget(
                                      fontWeight: FontWeight.w400,
                                      color: AppColor.brightTextColor,
                                      fontSize: 14,
                                      text: 'Henly shirts'),
                                  TextWidget(
                                      fontWeight: FontWeight.w500,
                                      color: AppColor.blackColor,
                                      fontSize: 16,
                                      text: '500'),
                                ],
                              ),
                              Row(
                                children: [
                                  IconButton(
                                      onPressed: () {},
                                      icon: Container(
                                        height: 21.48,
                                        width: 26,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            color: AppColor.cartIconColor),
                                        child: const Icon(
                                          Icons.add,
                                          color: AppColor.primaryColor,
                                          size: 16,
                                        ),
                                      )),
                                  const TextWidget(
                                      fontWeight: FontWeight.w400,
                                      color: AppColor.blackColor,
                                      fontSize: 14,
                                      text: '1'),
                                  IconButton(
                                      onPressed: () {},
                                      icon: Container(
                                        height: 21.48,
                                        width: 26,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            color: AppColor.cartIconColor),
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
                children: const [
                  TextWidget(
                      fontWeight: FontWeight.w400,
                      color: AppColor.blackColor,
                      fontSize: 14,
                      text: 'Subtotal :'),
                  TextWidget(
                      fontWeight: FontWeight.w500,
                      color: AppColor.subTotalColor,
                      fontSize: 18,
                      text: '400'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
