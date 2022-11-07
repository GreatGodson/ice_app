import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iec_app/app/modules/product/data/models/get_all_product_model.dart';
import 'package:iec_app/app/modules/product/domain/providers/produts_provider.dart';
import 'package:iec_app/app/modules/product/views/screens/product_detail_screen.dart';
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
    final allProducts = ref.watch(getAllProductsRepository);
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
            allProducts.when(
                data: (products) {
                  return SizedBox(
                    height: size.height / 4,
                    // height: 190,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        // List<GetAllProductsResponse> dataVal = products;
                        return Padding(
                          padding: const EdgeInsets.only(right: 17),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (_) => const ProductDetailScreen()));
                            },
                            child: Container(
                              width: size.width / 2.49,
                              decoration: BoxDecoration(
                                  color: AppColor.whiteColor,
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(
                                      color: AppColor.categoryCardBorderColor)),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 10, left: 10, right: 10),
                                      child: CachedNetworkImage(
                                        progressIndicatorBuilder:
                                            (context, url, progress) => Center(
                                          child: CircularProgressIndicator(
                                            value: progress.progress,
                                            color: AppColor.primaryColor,
                                          ),
                                        ),
                                        imageUrl: products[index]["image"],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 5, bottom: 5),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Expanded(
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 11, right: 11, top: 5),
                                              child: TextWidget(
                                                  textAlign: TextAlign.start,
                                                  fontWeight: FontWeight.w400,
                                                  color: AppColor.blackColor,
                                                  fontSize: 12,
                                                  text: products[index]
                                                      ["title"]),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 4),
                                            child: TextWidget(
                                                textAlign: TextAlign.center,
                                                fontWeight: FontWeight.w500,
                                                color: AppColor.blackColor,
                                                fontSize: 14,
                                                text:
                                                    '＄${products[index]["price"]}'
                                                        .toString()),
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
                error: (error, stack) {
                  print(error);
                  print(stack);
                  return Text(error.toString());
                },
                loading: () => const CupertinoActivityIndicator()),
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
