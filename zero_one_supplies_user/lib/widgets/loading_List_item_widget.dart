import 'package:ecomik/widgets/core_widgets.dart';
import 'package:flutter/material.dart';

import '../../utils/constants/app_gaps.dart';

class AuctionLoadingListItemWidget extends StatelessWidget {
  const AuctionLoadingListItemWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return LoadingPlaceholderWidget(
      child: Container(
        padding: const EdgeInsets.all(8),
        child: const Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              // height: 159,
              child: SizedBox(
                height: 159,
                child: LoadingBoxWidget(),
              ),
            ),
            AppGaps.hGap8,
            LoadingTextWidget(),
            AppGaps.hGap8,
            Row(
              children: [
                SizedBox(width: 53, child: LoadingTextWidget()),
                AppGaps.wGap16,
                SizedBox(width: 65, child: LoadingTextWidget()),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ProductLoadingListItemWidget extends StatelessWidget {
  const ProductLoadingListItemWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return LoadingPlaceholderWidget(
      child: Container(
        padding: const EdgeInsets.all(8),
        child: const Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              // height: 159,
              child: SizedBox(
                height: 159,
                child: LoadingBoxWidget(),
              ),
            ),
            AppGaps.hGap8,
            LoadingTextWidget(),
            AppGaps.hGap8,
            Row(
              children: [
                SizedBox(width: 62, child: LoadingTextWidget()),
                AppGaps.wGap16,
                SizedBox(width: 34, child: LoadingTextWidget()),
                AppGaps.wGap23,
                SizedBox(height: 24, width: 24, child: LoadingBoxWidget())
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class PopularCategoryLoadingWidget extends StatelessWidget {
  const PopularCategoryLoadingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return LoadingPlaceholderWidget(
      child: Container(
        padding: const EdgeInsets.all(8),
        child: const Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              // height: 159,
              child: SizedBox(
                height: 40,
                width: 40,
                child: LoadingBoxWidget(),
              ),
            ),
            AppGaps.hGap8,
            LoadingTextWidget(),
          ],
        ),
      ),
    );
  }
}

class TopBrandLoadingWidget extends StatelessWidget {
  const TopBrandLoadingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return LoadingPlaceholderWidget(
      child: Container(
        padding: const EdgeInsets.all(8),
        child: const Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              // height: 159,
              child: SizedBox(
                height: 60,
                width: 60,
                child: LoadingBoxWidget(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TopSellerLoadingWidget extends StatelessWidget {
  const TopSellerLoadingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return LoadingPlaceholderWidget(
      child: Container(
        padding: const EdgeInsets.all(8),
        child: const Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              // height: 159,
              child: SizedBox(
                height: 139,
                width: 159,
                child: LoadingBoxWidget(),
              ),
            ),
            AppGaps.hGap8,
            SizedBox(width: 62, child: LoadingTextWidget()),
            AppGaps.hGap8,
            SizedBox(width: 50, child: LoadingTextWidget()),
          ],
        ),
      ),
    );
  }
}
