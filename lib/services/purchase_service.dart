import 'package:purchases_flutter/purchases_flutter.dart';

class PurchaseService {
  static final PurchaseService _instance = PurchaseService._internal();
  factory PurchaseService() => _instance;
  PurchaseService._internal();

  Offerings? _offerings;
  CustomerInfo? _customerInfo;

  Future<void> fetchOfferings() async {
    _offerings = await Purchases.getOfferings();
  }

  Offering? get currentOffering => _offerings?.current;

  Future<void> purchasePackage(Package package) async {
    try {
      final result = await Purchases.purchasePackage(package);
      _customerInfo = result.customerInfo;
    } catch (e) {
      // Handle purchase error
      rethrow;
    }
  }

  Future<void> restorePurchases() async {
    _customerInfo = await Purchases.restorePurchases();
  }

  bool isProUser() {
    final entitlements = _customerInfo?.entitlements.active;
    return entitlements?.containsKey('pro') ?? false;
  }

  Future<void> updateCustomerInfo() async {
    _customerInfo = await Purchases.getCustomerInfo();
  }
}
