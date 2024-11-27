import 'package:ecomik/utils/constants/app_gaps.dart';
import 'package:ecomik/widgets/loading_List_item_widget.dart';
import 'package:flutter/material.dart';

class AuctionLoadingListWidget extends StatelessWidget {
  const AuctionLoadingListWidget({
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
            child: AuctionLoadingListItemWidget(),
          );
        },
      ),
    );
  }
}

class AuctionLoadingGridWidget extends StatelessWidget {
  const AuctionLoadingGridWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      primary: false,
      slivers: <Widget>[
        SliverPadding(
          padding: const EdgeInsets.all(20),
          sliver: SliverGrid.count(
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            crossAxisCount: 2,
            children: const <Widget>[
              SizedBox(
                // height: 275,
                width: 195,
                child: AuctionLoadingListItemWidget(),
              )
            ],
          ),
        ),
      ],
    );
  }
}
