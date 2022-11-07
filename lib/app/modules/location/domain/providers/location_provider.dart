import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iec_app/app/shared/managers/location_manager.dart';

final locationProvider = Provider((ref) => LocationManager());

final locationRepository = FutureProvider.autoDispose
    .family<dynamic, BuildContext>((ref, context) async {
  final repository = ref.watch(locationProvider);
  return repository.setLocationName(context);
});
