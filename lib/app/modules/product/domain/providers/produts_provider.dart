import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iec_app/app/modules/product/data/models/get_all_product_model.dart';
import 'package:iec_app/app/modules/product/domain/services/get_all_products.dart';

final productsProvider = Provider((ref) => ProductsService());

final getAllProductsRepository =
    FutureProvider.autoDispose<List<dynamic>>((ref) async {
  final repository = ref.watch(productsProvider);
  return repository.getAllProducts();
});
