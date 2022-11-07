import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iec_app/app/modules/category/domain/services/get_category_products.dart';

final categoryProductsCategory = Provider((ref) => CategoryProductsService());

final getCategoryProductRepository = FutureProvider.autoDispose
    .family<List<dynamic>, String>((ref, categoryName) async {
  final repository = ref.watch(categoryProductsCategory);
  return repository.getAllCategoryProducts(categoryName: categoryName);
});
