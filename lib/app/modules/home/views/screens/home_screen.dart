import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iec_app/app/modules/category/views/screens/category_products.dart';
import 'package:iec_app/app/modules/location/domain/providers/location_provider.dart';
import 'package:iec_app/app/modules/product/data/models/get_all_product_model.dart';
import 'package:iec_app/app/modules/product/domain/providers/produts_provider.dart';
import 'package:iec_app/app/modules/product/views/screens/product_detail_screen.dart';
import 'package:iec_app/app/shared/managers/location_manager.dart';
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
        categoryName: 'women\'s clothing',
        categoryImageName:
            'https://fakestoreapi.com/img/51Y5NI-I5jL._AC_UX679_.jpg'),
    ProductCategories(
        categoryName: 'men\'s clothing',
        categoryImageName:
            'https://fakestoreapi.com/img/71YXzeOuslL._AC_UY879_.jpg'),
    ProductCategories(
        categoryName: 'jewelery',
        categoryImageName:
            'https://fakestoreapi.com/img/71YAIFU48IL._AC_UL640_QL65_ML3_.jpg'),
    ProductCategories(
        categoryName: 'electronics',
        categoryImageName:
            'https://fakestoreapi.com/img/81QpkIctqPL._AC_SX679_.jpg')
  ];

  // @override
  // void initState() {
  //   LocationManager.setLocationName(context);
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final allProducts = ref.watch(getAllProductsRepository);
    final location = ref.watch(locationRepository(context));
    return Scaffold(
        backgroundColor: AppColor.scaffoldBackgroundColor,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: AppColor.scaffoldBackgroundColor,
          elevation: 0.0,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 5),
              child: SvgPicture.asset(
                'assets/svgs/notificationIcon.svg',
              ),
            ),
          ],
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/svgs/locationIcon.svg',
                height: 15,
              ),
              location.when(
                  data: (userLocation) {
                    return Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: TextWidget(
                            fontWeight: FontWeight.w400,
                            color: AppColor.blackColor,
                            fontSize: 14,
                            textAlign: TextAlign.center,
                            text: userLocation),
                      ),
                    );
                  },
                  error: (error, stack) {
                    return const Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: TextWidget(
                          fontWeight: FontWeight.w400,
                          color: AppColor.blackColor,
                          fontSize: 14,
                          text: 'No Location'),
                    );
                    ;
                  },
                  loading: () => const SizedBox.shrink())
            ],
          ),
          leading: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/svgs/drawerIcon.svg',
              ),
            ],
          ),
        ),
        body: ListView(
          padding: const EdgeInsets.only(left: 20),
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 20),
              child: TextWidget(
                  fontWeight: FontWeight.w500,
                  color: AppColor.blackColor,
                  fontSize: 32,
                  text: 'Explore'),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 25.5, bottom: 25.5),
              child: TextWidget(
                  fontWeight: FontWeight.w400,
                  color: AppColor.brightTextColor,
                  fontSize: 20,
                  text: 'best Outfits for you'),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: SearchTextField(
                size: size,
                onChanged: (val) {},
                prefixIconName: 'search',
                suffixIconName: 'searchButtonIcon',
                hintText: 'Search items...',
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 35, bottom: 40),
              child: SizedBox(
                height: size.height / 9,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 17),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (_) => CategoryProductsScreen(
                                  categoryName:
                                      categories[index].categoryName)));
                        },
                        child: Container(
                          width: size.width / 4.6,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                  color: AppColor.categoryCardBorderColor)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 8, left: 5, right: 5),
                                  child: CachedNetworkImage(
                                    progressIndicatorBuilder:
                                        (context, url, progress) => Center(
                                      child: CircularProgressIndicator(
                                        value: progress.progress,
                                        color: AppColor.primaryColor,
                                      ),
                                    ),
                                    imageUrl:
                                        categories[index].categoryImageName,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 5, bottom: 5, left: 5, right: 5),
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
                      ),
                    );
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20, bottom: 17),
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
                            child: ProductsCard(
                                index: index,
                                price: products[index]["price"].toString(),
                                imageUrl: products[index]["image"],
                                title: products[index]["title"],
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (_) => ProductDetailScreen(
                                          productId:
                                              products[index]["id"].toString(),
                                          productName: products[index]["title"],
                                          productDescription: products[index]
                                              ["description"],
                                          productImageUrl: products[index]
                                              ["image"],
                                          productPrice: products[index]["price"]
                                              .toString())));
                                  print(products[index]["image"]);
                                }));
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

class ProductsCard extends StatelessWidget {
  const ProductsCard(
      {Key? key,
      required this.onTap,
      required this.index,
      required this.title,
      required this.imageUrl,
      required this.price})
      : super(key: key);

  final VoidCallback onTap;
  final int index;
  final String imageUrl;
  final String title;
  final String price;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size.width / 2.49,
        decoration: BoxDecoration(
            color: AppColor.whiteColor,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: AppColor.categoryCardBorderColor)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                  imageUrl: imageUrl,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 5, bottom: 5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: Padding(
                        padding:
                            const EdgeInsets.only(left: 11, right: 11, top: 5),
                        child: TextWidget(
                            textAlign: TextAlign.start,
                            fontWeight: FontWeight.w400,
                            color: AppColor.blackColor,
                            fontSize: 12,
                            text: title),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: TextWidget(
                          textAlign: TextAlign.center,
                          fontWeight: FontWeight.w500,
                          color: AppColor.blackColor,
                          fontSize: 14,
                          text: '＄$price'.toString()),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
