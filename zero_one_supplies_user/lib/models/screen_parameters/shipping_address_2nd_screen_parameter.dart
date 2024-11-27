import 'package:ecomik/models/api_responses/coupon_applied_response.dart';
import 'package:ecomik/models/api_responses/distance_calculation_result_response.dart';
import 'package:ecomik/models/api_responses/order_create_response.dart';
import 'package:ecomik/models/api_responses/pickup_stations_with_cost_response.dart';
import 'package:ecomik/models/api_responses/saved_addresses_with_cost_response.dart';
import 'package:ecomik/models/api_responses/store_wise_carts_response.dart';

class ShippingAddress2ndScreenParameter {
  final StoreWiseCarts cartsData;
  final CouponAppliedData couponData;
  final String orderID;
  final OrderCreate orderDetails;
  final double total;
  final DistanceCalculationResult distanceCalculationResult;
  final PickupStationsWithCost? selectedPickupStation;
  final SavedAddressWithCost? selectedSavedAddress;
  final bool isPickUpPointTabSelected;

  ShippingAddress2ndScreenParameter(
      {required this.couponData,
      required this.cartsData,
      this.orderID = '',
      this.total = 0,
      required this.distanceCalculationResult,
      this.selectedPickupStation,
      this.selectedSavedAddress,
      this.isPickUpPointTabSelected = false,
      required this.orderDetails});

  factory ShippingAddress2ndScreenParameter.empty() =>
      ShippingAddress2ndScreenParameter(
          cartsData: StoreWiseCarts.empty(),
          couponData: CouponAppliedData.empty(),
          distanceCalculationResult: DistanceCalculationResult.empty(),
          orderDetails: OrderCreate.empty());
}
