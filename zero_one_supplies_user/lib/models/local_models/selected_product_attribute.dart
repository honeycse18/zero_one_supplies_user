import 'package:ecomik/models/api_responses/product_details_response.dart';

class SelectedProductAttribute {
  final String key;
  final ProductAttributeOption option;

  SelectedProductAttribute({
    required this.key,
    required this.option,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SelectedProductAttribute &&
          other.runtimeType == runtimeType &&
          other.key == key;

  @override
  int get hashCode => key.hashCode;
}
