import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iec_app/app/modules/home/views/screens/home_screen.dart';
import 'package:iec_app/app/modules/product/domain/providers/produts_provider.dart';
import 'package:iec_app/app/modules/product/views/screens/product_detail_screen.dart';
import 'package:iec_app/app/shared/utils/theme/app_color.dart';
import 'package:iec_app/app/shared/views/widgets/custom_text_widget.dart';

class AllProductsScreen extends ConsumerStatefulWidget {
  const AllProductsScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<AllProductsScreen> createState() => _AllProductsScreenState();
}

class _AllProductsScreenState extends ConsumerState<AllProductsScreen> {
  @override
  Widget build(BuildContext context) {
    final allProducts = ref.watch(getAllProductsRepository);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColor.scaffoldBackgroundColor,
          iconTheme: const IconThemeData(color: AppColor.blackColor),
          centerTitle: true,
          elevation: 0.0,
          title: const TextWidget(
              fontWeight: FontWeight.w500,
              color: AppColor.blackColor,
              fontSize: 20,
              text: 'All Products'),
        ),
        body: allProducts.when(
            data: (products) {
              return GridView.builder(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 200,
                      childAspectRatio: 2.7 / 3,
                      crossAxisSpacing: 0,
                      mainAxisSpacing: 10),
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: ProductsCard(
                          index: index,
                          price: products[index]["price"].toString(),
                          imageUrl: products[index]["image"],
                          title: products[index]["title"],
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (_) => ProductDetailScreen(
                                    productId: products[index]["id"].toString(),
                                    productName: products[index]["title"],
                                    productDescription: products[index]
                                        ["description"],
                                    productImageUrl: products[index]["image"],
                                    productPrice:
                                        products[index]["price"].toString())));
                          }),
                    );
                  });
            },
            error: (error, stack) {
              return const SizedBox.shrink();
            },
            loading: () => const CupertinoActivityIndicator()));
  }
}
