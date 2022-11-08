import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iec_app/app/modules/cart/domain/services/cart_service.dart';

final cartProvider = Provider((ref) => CartService());

final userCart = FutureProvider.autoDispose
    .family<Map<String, dynamic>, String>((ref, userId) async {
  final repository = ref.watch(cartProvider);
  return repository.getCart(userId: userId);
});
