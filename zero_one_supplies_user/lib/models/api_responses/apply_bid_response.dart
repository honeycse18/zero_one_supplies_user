import 'package:ecomik/utils/helpers/api_helper.dart';

class ApplyBidResponse {
  String id;
  String bidAmount;

  ApplyBidResponse({this.id = '', this.bidAmount = ''});

  factory ApplyBidResponse.fromJson(Map<String, dynamic> json) {
    return ApplyBidResponse(
      id: APIHelper.getSafeStringValue(json['_id']),
      bidAmount: APIHelper.getSafeStringValue(json['bid_amount']),
    );
  }

  Map<String, dynamic> toJson() => {
        '_id': id,
        'bid_amount': bidAmount,
      };
  static ApplyBidResponse getAPIResponseObjectSafeValue(
          Object? unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? ApplyBidResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : ApplyBidResponse();
}
