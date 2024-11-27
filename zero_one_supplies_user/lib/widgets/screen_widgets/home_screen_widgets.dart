import 'package:ecomik/utils/constants/app_constants_import.dart';
import 'package:flutter/material.dart';

/// Product category grid item widget from home screen
class ProductCategoryGridSingleItemWidget extends StatelessWidget {
  final String title;
  final int itemNumber;
  final ImageProvider<Object> categoryImageProvider;
  const ProductCategoryGridSingleItemWidget({
    super.key,
    required this.title,
    required this.itemNumber,
    required this.categoryImageProvider,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
                image: DecorationImage(image: categoryImageProvider))),
        AppGaps.hGap16,
        Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        AppGaps.hGap8,
        Center(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
            decoration: const BoxDecoration(
                color: AppColors.shadeColor2,
                borderRadius: BorderRadius.all(Radius.circular(6))),
            child: Text(
              '$itemNumber ${itemNumber > 1 ? 'items' : 'item'}',
              textAlign: TextAlign.center,
              style:
                  const TextStyle(color: AppColors.bodyTextColor, fontSize: 12),
            ),
          ),
        )
      ],
    );
  }
}
