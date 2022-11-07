import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iec_app/app/shared/utils/theme/app_color.dart';
import 'package:iec_app/app/shared/views/widgets/custom_text_widget.dart';
import 'package:iec_app/app/shared/views/widgets/text_field/search_textfield.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  List<ProductCategories> categories = [
    ProductCategories(
        categoryName: 'women\'s clothing', categoryImageName: 'dress'),
    ProductCategories(
        categoryName: 'men\'s clothing', categoryImageName: 'dress'),
    ProductCategories(categoryName: 'jewelery', categoryImageName: 'dress'),
    ProductCategories(categoryName: 'electronics', categoryImageName: 'dress')
  ];
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: AppColor.scaffoldBackgroundColor,
        appBar: AppBar(
          backgroundColor: AppColor.scaffoldBackgroundColor,
          elevation: 0.0,
        ),
        body: ListView(
          padding: const EdgeInsets.only(left: 20),
          children: [
            SearchTextField(
              size: size,
              onChanged: (val) {},
              prefixIconName: 'search',
              suffixIconName: 'searchButtonIcon',
              hintText: 'Search items...',
            ),
            SizedBox(
              height: size.height / 9,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 17),
                    child: Container(
                      width: size.width / 4.6,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                              color: AppColor.categoryCardBorderColor)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            'assets/svgs/${categories[index].categoryImageName}.svg',
                            height: 45,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5, bottom: 2),
                            child: TextWidget(
                                textAlign: TextAlign.center,
                                fontWeight: FontWeight.w500,
                                color: AppColor.darkTextColor,
                                fontSize: 12,
                                text: categories[index].categoryName),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  TextWidget(
                      fontWeight: FontWeight.w500,
                      color: AppColor.blackColor,
                      fontSize: 20,
                      text: 'All Products'),
                  TextWidget(
                      fontWeight: FontWeight.w400,
                      color: AppColor.brightTextColor,
                      fontSize: 14,
                      text: 'See All')
                ],
              ),
            ),
            SizedBox(
              height: size.height / 4.4,
              // height: 190,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 17),
                    child: Container(
                      width: size.width / 2.49,
                      decoration: BoxDecoration(
                          color: AppColor.whiteColor,
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                              color: AppColor.categoryCardBorderColor)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            // height: size.height / 5.3,
                            height: 133,
                            width: size.width / 2.79,

                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: AppColor.productBackgroundColor,
                                border: Border.all(
                                    color: AppColor.productBackgroundColor)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  'assets/svgs/${categories[index].categoryImageName}.svg',
                                  height: size.height / 8,
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5, bottom: 2),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                TextWidget(
                                    textAlign: TextAlign.center,
                                    fontWeight: FontWeight.w400,
                                    color: AppColor.blackColor,
                                    fontSize: 12,
                                    text: categories[index].categoryName),
                                TextWidget(
                                    textAlign: TextAlign.center,
                                    fontWeight: FontWeight.w500,
                                    color: AppColor.blackColor,
                                    fontSize: 12,
                                    text: '233')
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ));
  }
}

class ProductCategories {
  ProductCategories(
      {required this.categoryName, required this.categoryImageName});
  final String categoryName;
  final String categoryImageName;
}
