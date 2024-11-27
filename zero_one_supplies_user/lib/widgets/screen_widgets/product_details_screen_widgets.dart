import 'package:ecomik/models/api_responses/product_details_response.dart';
import 'package:ecomik/utils/constants/app_constants_import.dart';
import 'package:ecomik/utils/constants/app_language_translations.dart';
import 'package:ecomik/utils/constants/app_text_styles.dart';
import 'package:ecomik/utils/extensions/double.dart';
import 'package:ecomik/utils/extensions/string.dart';
import 'package:ecomik/utils/helpers/helpers.dart';
import 'package:ecomik/widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProductAttributeWidget extends StatelessWidget {
  final ProductAttribute productAttribute;
  final ProductAttributeOption? selectedOption;
  final void Function(ProductAttribute, ProductAttributeOption?)?
      onOptionSelected;
  final void Function()? onDeleteTap;
  final bool isLoading;
  const ProductAttributeWidget({
    super.key,
    required this.productAttribute,
    this.onOptionSelected,
    this.onDeleteTap,
    this.isLoading = false,
    this.selectedOption,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          // Attribute name
          productAttribute.key,
          style: AppTextStyles.productDetailsSubLabel,
        ),
        AppGaps.hGap10,
        Row(
          children: [
            Expanded(
              child: DropdownButtonFormFieldWidget<ProductAttributeOption>(
                  hintText:
                      '${AppLanguageTranslation.selectTransKey.toCurrentLanguage} ${productAttribute.key}',
                  items: productAttribute.options,
                  value: selectedOption,
                  isLoading: isLoading,
                  getItemChild: (item) => Row(
                        children: [
                          Expanded(
                              child: Text(item.label,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis)),
                          if (item.price > 0)
                            Text('+ ${item.price.toCurrencyAmountText}',
                                maxLines: 1, overflow: TextOverflow.ellipsis),
                          if (item.isValueHexColorCode) AppGaps.wGap10,
                          if (item.isValueHexColorCode)
                            Row(mainAxisSize: MainAxisSize.min, children: [
                              Container(
                                width: 50,
                                height: 30,
                                decoration: BoxDecoration(
                                    color:
                                        Helper.getColorFromHexCode(item.value),
                                    borderRadius:
                                        AppComponents.borderRadius(8)),
                              )
                            ]),
                        ],
                      ),
                  onChanged: (value) {
                    if (onOptionSelected != null) {
                      onOptionSelected!(productAttribute, value);
                    }
                  }),
            ),
            if (!isLoading) AppGaps.wGap8,
            if (!isLoading)
              TightIconButtonWidget(
                  onTap: onDeleteTap,
                  child: SvgPicture.asset(AppAssetImages.deleteSVGLogoLine,
                      color: AppColors.alertColor))
          ],
        ),
      ],
    );
  }
}
