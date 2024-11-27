import 'dart:developer';

import 'package:ecomik/models/api_responses/saved_addresses_with_cost_response.dart';
import 'package:ecomik/utils/api_repo.dart';
import 'package:ecomik/utils/helpers/api_helper.dart';

mixin SavedAddressesGetter {
/*   Future<void> getSavedAddresses() async {
    SavedAddressResponse? response = await APIRepo.getSavedAddress();
    if (response == null) {
      APIHelper.onError(response?.msg);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    }
    log((response.toJson().toString()));
    onSuccessGetSavedAddresses(response);
  }

  void onSuccessGetSavedAddresses(SavedAddressResponse response); */
  Future<void> getSavedAddresses() async {
    final SavedAddressesWithCostResponse? response =
        await APIRepo.getSavedAddressesWithCost();
    if (response == null) {
      APIHelper.onError(response?.msg);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    }
    log((response.toJson().toString()));
    onSuccessGetSavedAddresses(response);
  }

  void onSuccessGetSavedAddresses(SavedAddressesWithCostResponse response);
}
