import 'package:ecomik/models/api_responses/store_wise_carts_response.dart';
import 'package:ecomik/models/enums.dart';
import 'package:ecomik/utils/app_singleton.dart';

mixin CartCalculations {
  StoreWiseCarts _cartsData = StoreWiseCarts.empty();
  // CartsData cartsData = CartsData.empty();
  StoreWiseCarts get cartsData => _cartsData;
  set cartsData(StoreWiseCarts value) {
    _cartsData = value;
    onAfterCartsDataSet(value);
  }

  double get netPriceAmountForView {
/*     var userCartProducts = cartsData.cart.products;
    double netPrice = userCartProducts.fold<double>(
        0,
        (previousValue, product) =>
            previousValue + (product.price * product.quantity));
    return netPrice; */
    return cartsData.netAmount;
  }

  double get subTotalAmount {
    final subTotal = netPriceAmountForView - discountAmountForView;
    return subTotal;
  }

  double get discountAmountForView;

  double get vatAmountForView {
    final vatAmount = AppSingleton.instance.settings.companyVat.value;
    final CompanyVatType vatType = CompanyVatType.toEnumValue(
        AppSingleton.instance.settings.companyVat.type);
    if (vatType == CompanyVatType.percent) {
      final vatPercentageValue = vatAmount / 100;
      return netPriceAmountForView * vatPercentageValue;
    }
    return vatAmount;
  }

  double get deliveryChargeAmountForView;

  bool get showDeliveryChargeSectionForView => deliveryChargeAmountForView > 0;

  int get totalAmountForView {
    final double total =
        subTotalAmount + vatAmountForView + deliveryChargeAmountForView;
    return total.ceil();
  }

  void onAfterCartsDataSet(StoreWiseCarts cartsData);
}
