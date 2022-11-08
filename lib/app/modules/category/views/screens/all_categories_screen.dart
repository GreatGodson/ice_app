import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:iec_app/app/modules/category/views/screens/category_products.dart';
import 'package:iec_app/app/modules/home/views/screens/home_screen.dart';
import 'package:iec_app/app/shared/utils/theme/app_color.dart';
import 'package:iec_app/app/shared/views/widgets/custom_text_widget.dart';

class AllCategoryScreen extends StatefulWidget {
  const AllCategoryScreen({Key? key}) : super(key: key);

  @override
  State<AllCategoryScreen> createState() => _AllCategoryScreenState();
}

class _AllCategoryScreenState extends State<AllCategoryScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColor.scaffoldBackgroundColor,
        iconTheme: const IconThemeData(color: AppColor.blackColor),
        centerTitle: true,
        elevation: 0.0,
        title: const TextWidget(
            fontWeight: FontWeight.w500,
            color: AppColor.blackColor,
            fontSize: 20,
            text: 'All Categories'),
      ),
      body: GridView.builder(
          padding: const EdgeInsets.only(left: 10, right: 10),
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              childAspectRatio: 2.7 / 3,
              crossAxisSpacing: 0,
              mainAxisSpacing: 10),
          itemCount: categories.length,
          itemBuilder: (context, index) {
            return Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Padding(
                  padding: const EdgeInsets.only(right: 17),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => CategoryProductsScreen(
                              categoryName: categories[index].categoryName)));
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
                                imageUrl: categories[index].categoryImageName,
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
                ));
          }),
    );
  }
}
