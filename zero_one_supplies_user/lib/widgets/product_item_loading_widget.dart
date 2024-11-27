import 'package:ecomik/utils/constants/app_gaps.dart';
import 'package:ecomik/widgets/loading_List_item_widget.dart';
import 'package:flutter/material.dart';

class ProductItemLoadingWidget extends StatelessWidget {
  const ProductItemLoadingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 288,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: 6,
        separatorBuilder: (context, index) => AppGaps.wGap16,
        itemBuilder: (context, index) {
          return const SizedBox(
            // height: 275,
            width: 175,
            child: ProductLoadingListItemWidget(),
          );
        },
      ),
    );
  }
}
