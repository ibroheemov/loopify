import 'package:betterloop/services/purchase_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final isProUserProvider = FutureProvider<bool>((ref) async {
  await PurchaseService().updateCustomerInfo();
  return PurchaseService().isProUser();
});
