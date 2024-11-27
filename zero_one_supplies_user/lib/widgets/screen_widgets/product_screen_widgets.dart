import 'dart:math' as math;

import 'package:ecomik/models/enums.dart';
import 'package:ecomik/utils/constants/app_constants_import.dart';
import 'package:ecomik/utils/constants/app_text_styles.dart';
import 'package:ecomik/utils/helpers/helpers.dart';
import 'package:ecomik/widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Product grid item widget
class ProductGridSingleItemWidget extends StatelessWidget {
  final bool isWishListed;
  final bool discount;
  final double discountValue;
  final bool isAddedToCart;
  final void Function()? onWishlistTap;
  final void Function()? onAddTap;
  final String title;
  final String discountType;
  final String category;
  final double originalPrice;
  final double currentPrice;
  final String productImageURL;
  final String storeName;
  final bool isVerified;
  final ProductConditionStatus productCondition;
  const ProductGridSingleItemWidget(
      {super.key,
      required this.title,
      this.category = '',
      this.productImageURL = '',
      this.discountValue = 0,
      this.onWishlistTap,
      this.discount = false,
      this.onAddTap,
      this.isWishListed = false,
      this.isAddedToCart = false,
      this.originalPrice = 0,
      this.discountType = '',
      this.currentPrice = 0,
      required this.storeName,
      required this.isVerified,
      required this.productCondition});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(
            height: 159,
            child: Stack(
              children: [
                Positioned.fill(
                    child: CachedNetworkImageWidget(
                  imageURL: productImageURL,
                  imageBuilder: (context, imageProvider) => Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: AppComponents.imageBorderRadius,
                        image: DecorationImage(
                            image: imageProvider, fit: BoxFit.cover)),
                  ),
                  /* imageBuilder: (context, imageProvider)=>(
                          
                        ), */
                )),
                if (showDiscount)
                  Positioned(
                      top: 2,
                      left: 5,
                      child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 6, vertical: 1),
                          decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: AppComponents.borderRadius(4)),
                          child: Text(getDiscountText(),
                              style: AppTextStyles.bodySemiboldTextStyle
                                  .copyWith(color: Colors.white)))),
                if (Helper.isUserLoggedIn())
                  Positioned(
                      top: 10,
                      right: 10,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          SizedBox(
                            height: 15,
                            width: 15,
                            // color: Colors.white.withOpacity(0.9),
                            child: WishlistItemButtonWidget(
                                isWishListed: isWishListed,
                                onTap: onWishlistTap),
                          ),
                          if (productCondition !=
                              ProductConditionStatus.unknown)
                            AppGaps.hGap10,
                          ProductConditionWidget(
                              productCondition: productCondition),
                        ],
                      ))
              ],
            )

            // WishlistItemButtonWidget(
            //     isWishListed: isWishlisted, onTap: onWishlistTap)

            ),
        AppGaps.hGap8,
        Text(
          title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.start,
          style: AppTextStyles.bodyLargeSemiboldTextStyle,
        ),
        AppGaps.hGap2,
        if (category.isNotEmpty)
          Text(
            category,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.start,
            style: AppTextStyles.bodySmallTextStyle
                .copyWith(color: AppColors.shadeColor3),
          ),
        AppGaps.hGap2,
        Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              storeName,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.start,
              style: AppTextStyles.bodySmallTextStyle
                  .copyWith(color: AppColors.shadeColor3),
            ),
            AppGaps.wGap5,
            VerifiedSellerTickWidget(isVerified: isVerified),
          ],
        ),
        AppGaps.hGap2,
        Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                Helper.getCurrencyFormattedAmountText(currentPrice),
                textAlign: TextAlign.start,
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              ),
            ),
            AppGaps.wGap8,
            if (Helper.isUserLoggedIn())
              CustomIconButtonWidget(
                  backgroundColor: isAddedToCart
                      ? AppColors.primaryColor
                      : AppColors.darkColor,
                  borderRadiusRadiusValue: const Radius.circular(6),
                  fixedSize: const Size(24, 24),
                  onTap: onAddTap,
                  child: SvgPicture.asset(
                    AppAssetImages.plusSVGLogoSolid,
                    color: Colors.white,
                    height: 12,
                    width: 12,
                  ))
          ],
        ),
        if (discount)
          Text(
            Helper.getCurrencyFormattedAmountText(originalPrice),
            style: const TextStyle(
                fontSize: 12,
                decoration: TextDecoration.lineThrough,
                color: Colors.red),
          )
      ],
    );
  }

  bool get showDiscount {
    var discountTypeEnum = DiscountType.toEnumValue(discountType);
    if (discountTypeEnum == DiscountType.unknown) {
      return false;
    }
    return discount;
  }

  String getDiscountText() {
    var discountTypeEnum = DiscountType.toEnumValue(discountType);
    switch (discountTypeEnum) {
      case DiscountType.flat:
        return Helper.getCurrencyFormattedAmountText(discountValue);
      case DiscountType.percent:
        return '$discountValue %';
      default:
        return '';
    }
  }

  String getDiscountAmountText() {
    var discountTypeEnum = DiscountType.toEnumValue(discountType);
    switch (discountTypeEnum) {
      case DiscountType.flat:
        return Helper.getCurrencyFormattedAmountText(discountValue);
      case DiscountType.percent:
        return Helper.getCurrencyFormattedAmountText(originalPrice);
      default:
        return '';
    }
  }
}

/// Drawer single menu widget
class DrawerRadioMenuWidget extends StatelessWidget {
  final void Function()? onTap;
  final void Function(int?) onRadioChange;
  final String text;
  final int radioValue;
  final int radioGroupValue;
  const DrawerRadioMenuWidget({
    super.key,
    this.onTap,
    required this.onRadioChange,
    required this.text,
    required this.radioValue,
    required this.radioGroupValue,
  });

  @override
  Widget build(BuildContext context) {
    return CustomRawListTileWidget(
      borderRadiusRadiusValue: AppComponents.defaultBorderRadius,
      onTap: onTap,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: const TextStyle(color: Colors.white),
          ),
          AppGaps.wGap15,
          Radio<int>(
              fillColor:
                  MaterialStateColor.resolveWith((states) => Colors.white),
              value: radioValue,
              groupValue: radioGroupValue,
              onChanged: onRadioChange)
        ],
      ),
    );
  }
}

/// For custom range slider
class CustomRoundRangeSliderThumbShape extends RoundRangeSliderThumbShape {
  /// Create a slider thumb that draws a circle.
  const CustomRoundRangeSliderThumbShape({
    this.enabledThumbRadius = 10.0,
  });

  /// The preferred radius of the round thumb shape when the slider is enabled.
  ///
  /// If it is not provided, then the material default of 10 is used.
  // ignore: annotate_overrides, overridden_fields
  final double enabledThumbRadius;

  /// The preferred radius of the round thumb shape when the slider is disabled.
  ///
  /// If no disabledRadius is provided, then it is equal to the
  /// [enabledThumbRadius].
  double get _disabledThumbRadius => enabledThumbRadius;

  /// The resting elevation adds shadow to the unpressed thumb.
  ///
  /// The default is 1.

  /// The pressed elevation adds shadow to the pressed thumb.
  ///
  /// The default is 6.

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size.fromRadius(
        isEnabled == true ? enabledThumbRadius : _disabledThumbRadius);
  }

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    bool isDiscrete = false,
    bool isEnabled = false,
    bool? isOnTop,
    required SliderThemeData sliderTheme,
    TextDirection? textDirection,
    Thumb? thumb,
    bool? isPressed,
    TextPainter? labelPainter,
    RenderBox? parentBox,
    double? value,
    double? textScaleFactor,
    Size? sizeWithOverflow,
  }) {
    assert(sliderTheme.showValueIndicator != null);
    assert(sliderTheme.overlappingShapeStrokeColor != null);
    final Canvas canvas = context.canvas;
    final Tween<double> radiusTween = Tween<double>(
      begin: _disabledThumbRadius,
      end: enabledThumbRadius,
    );
    final ColorTween colorTween = ColorTween(
      begin: sliderTheme.disabledThumbColor,
      end: sliderTheme.thumbColor,
    );
    final double radius = radiusTween.evaluate(enableAnimation);
    final Tween<double> elevationTween = Tween<double>(
      begin: elevation,
      end: pressedElevation,
    );

    // Add a stroke of 1dp around the circle if this thumb would overlap
    // the other thumb.
    if (isOnTop ?? false) {
      final Paint strokePaint = Paint()
        // ..color = sliderTheme.overlappingShapeStrokeColor!
        ..color = Colors.white
        ..strokeWidth = 9.0
        ..style = PaintingStyle.stroke;
      canvas.drawCircle(center, radius, strokePaint);
    }

    final Color color = colorTween.evaluate(enableAnimation)!;

    final double evaluatedElevation =
        isPressed! ? elevationTween.evaluate(activationAnimation) : elevation;
    final Path shadowPath = Path()
      ..addArc(
          Rect.fromCenter(
              center: center, width: 2 * radius, height: 2 * radius),
          0,
          math.pi * 2);
    canvas.drawShadow(shadowPath, Colors.black, evaluatedElevation, true);

    canvas.drawCircle(
      center,
      radius,
      Paint()
        ..color = color
        // ..style = PaintingStyle.stroke,
        ..style = PaintingStyle.fill,
    );
    canvas.drawCircle(
      center,
      radius,
      Paint()
        ..color = Colors.white
        ..strokeWidth = 8
        ..style = PaintingStyle.stroke,
      // ..style = PaintingStyle.fill,
    );
    // canvas.drawPaint(_indicatorShape)
    /* super.paint(context, center,
        activationAnimation: activationAnimation,
        enableAnimation: enableAnimation,
        sliderTheme: sliderTheme); */
    /* _indicatorShape.paint(context, center,
        activationAnimation: activationAnimation,
        // enableAnimation: enableAnimation,
        enableAnimation: AlwaysStoppedAnimation(1),
        isDiscrete: isDiscrete,
        labelPainter: labelPainter!,
        parentBox: parentBox!,
        sliderTheme: sliderTheme,
        textDirection: textDirection!,
        value: value!,
        textScaleFactor: textScaleFactor!,
        sizeWithOverflow: sizeWithOverflow!); */
  }
}

/// For custom range slider
class _PaddleSliderValueIndicatorPathPainter {
  const _PaddleSliderValueIndicatorPathPainter();

  // These constants define the shape of the default value indicator.
  // The value indicator changes shape based on the size of
  // the label: The top lobe spreads horizontally, and the
  // top arc on the neck moves down to keep it merging smoothly
  // with the top lobe as it expands.

  // Radius of the top lobe of the value indicator.
  static const double _topLobeRadius = 16.0;
  static const double _minLabelWidth = 16.0;
  // Radius of the bottom lobe of the value indicator.
  static const double _bottomLobeRadius = 10.0;
  static const double _labelPadding = 8.0;
  static const double _distanceBetweenTopBottomCenters = 40.0;
  static const double _middleNeckWidth = 3.0;
  static const double _bottomNeckRadius = 4.5;
  // The base of the triangle between the top lobe center and the centers of
  // the two top neck arcs.
  static const double _neckTriangleBase = _topNeckRadius + _middleNeckWidth / 2;
  static const double _rightBottomNeckCenterX =
      _middleNeckWidth / 2 + _bottomNeckRadius;
  static const double _rightBottomNeckAngleStart = math.pi;
  static const Offset _topLobeCenter =
      Offset(0.0, -_distanceBetweenTopBottomCenters);
  static const double _topNeckRadius = 13.0;
  // The length of the hypotenuse of the triangle formed by the center
  // of the left top lobe arc and the center of the top left neck arc.
  // Used to calculate the position of the center of the arc.
  static const double _neckTriangleHypotenuse = _topLobeRadius + _topNeckRadius;
  // Some convenience values to help readability.
  static const double _twoSeventyDegrees = 3.0 * math.pi / 2.0;
  static const double _ninetyDegrees = math.pi / 2.0;
  static const double _thirtyDegrees = math.pi / 6.0;
  static const double _preferredHeight =
      _distanceBetweenTopBottomCenters + _topLobeRadius + _bottomLobeRadius;
  // Set to true if you want a rectangle to be drawn around the label bubble.
  // This helps with building tests that check that the label draws in the right
  // place (because it prints the rect in the failed test output). It should not
  // be checked in while set to "true".
  static const bool _debuggingLabelLocation = false;

  Size getPreferredSize(
    TextPainter labelPainter,
    double textScaleFactor,
  ) {
    assert(textScaleFactor >= 0);
    final double width =
        math.max(_minLabelWidth * textScaleFactor, labelPainter.width) +
            _labelPadding * 2 * textScaleFactor;
    return Size(width, _preferredHeight * textScaleFactor);
  }

  // Adds an arc to the path that has the attributes passed in. This is
  // a convenience to make adding arcs have less boilerplate.
  static void _addArc(Path path, Offset center, double radius,
      double startAngle, double endAngle) {
    assert(center.isFinite);
    final Rect arcRect = Rect.fromCircle(center: center, radius: radius);
    path.arcTo(arcRect, startAngle, endAngle - startAngle, false);
  }

  double getHorizontalShift({
    required Offset center,
    required TextPainter labelPainter,
    required double scale,
    required double textScaleFactor,
    required Size sizeWithOverflow,
  }) {
    assert(!sizeWithOverflow.isEmpty);
    final double inverseTextScale =
        textScaleFactor != 0 ? 1.0 / textScaleFactor : 0.0;
    final double labelHalfWidth = labelPainter.width / 2.0;
    final double halfWidthNeeded = math.max(
      0.0,
      inverseTextScale * labelHalfWidth - (_topLobeRadius - _labelPadding),
    );
    final double shift = _getIdealOffset(halfWidthNeeded,
        textScaleFactor * scale, center, sizeWithOverflow.width);
    return shift * textScaleFactor;
  }

  // Determines the "best" offset to keep the bubble within the slider. The
  // calling code will bound that with the available movement in the paddle shape.
  double _getIdealOffset(
    double halfWidthNeeded,
    double scale,
    Offset center,
    double widthWithOverflow,
  ) {
    const double edgeMargin = 8.0;
    final Rect topLobeRect = Rect.fromLTWH(
      -_topLobeRadius - halfWidthNeeded,
      -_topLobeRadius - _distanceBetweenTopBottomCenters,
      2.0 * (_topLobeRadius + halfWidthNeeded),
      2.0 * _topLobeRadius,
    );
    // We can just multiply by scale instead of a transform, since we're scaling
    // around (0, 0).
    final Offset topLeft = (topLobeRect.topLeft * scale) + center;
    final Offset bottomRight = (topLobeRect.bottomRight * scale) + center;
    double shift = 0.0;

    if (topLeft.dx < edgeMargin) {
      shift = edgeMargin - topLeft.dx;
    }

    final double endGlobal = widthWithOverflow;
    if (bottomRight.dx > endGlobal - edgeMargin) {
      shift = endGlobal - edgeMargin - bottomRight.dx;
    }

    shift = scale == 0.0 ? 0.0 : shift / scale;
    if (shift < 0.0) {
      // Shifting to the left.
      shift = math.max(shift, -halfWidthNeeded);
    } else {
      // Shifting to the right.
      shift = math.min(shift, halfWidthNeeded);
    }
    return shift;
  }

  void paint(
    Canvas canvas,
    Offset center,
    Paint paint,
    double scale,
    TextPainter labelPainter,
    double textScaleFactor,
    Size sizeWithOverflow,
    Color? strokePaintColor,
  ) {
    if (scale == 0.0) {
      // Zero scale essentially means "do not draw anything", so it's safe to just return. Otherwise,
      // our math below will attempt to divide by zero and send needless NaNs to the engine.
      return;
    }
    assert(!sizeWithOverflow.isEmpty);

    // The entire value indicator should scale with the size of the label,
    // to keep it large enough to encompass the label text.
    final double overallScale = scale * textScaleFactor;
    final double inverseTextScale =
        textScaleFactor != 0 ? 1.0 / textScaleFactor : 0.0;
    final double labelHalfWidth = labelPainter.width / 2.0;

    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.scale(overallScale, overallScale);

    final double bottomNeckTriangleHypotenuse =
        _bottomNeckRadius + _bottomLobeRadius / overallScale;
    final double rightBottomNeckCenterY = -math.sqrt(
        math.pow(bottomNeckTriangleHypotenuse, 2) -
            math.pow(_rightBottomNeckCenterX, 2));
    final double rightBottomNeckAngleEnd =
        math.pi + math.atan(rightBottomNeckCenterY / _rightBottomNeckCenterX);
    final Path path = Path()
      ..moveTo(_middleNeckWidth / 2, rightBottomNeckCenterY);
    _addArc(
      path,
      Offset(_rightBottomNeckCenterX, rightBottomNeckCenterY),
      _bottomNeckRadius,
      _rightBottomNeckAngleStart,
      rightBottomNeckAngleEnd,
    );
    _addArc(
      path,
      Offset.zero,
      _bottomLobeRadius / overallScale,
      rightBottomNeckAngleEnd - math.pi,
      2 * math.pi - rightBottomNeckAngleEnd,
    );
    _addArc(
      path,
      Offset(-_rightBottomNeckCenterX, rightBottomNeckCenterY),
      _bottomNeckRadius,
      math.pi - rightBottomNeckAngleEnd,
      0,
    );

    // This is the needed extra width for the label.  It is only positive when
    // the label exceeds the minimum size contained by the round top lobe.
    final double halfWidthNeeded = math.max(
      0.0,
      inverseTextScale * labelHalfWidth - (_topLobeRadius - _labelPadding),
    );

    final double shift = _getIdealOffset(
        halfWidthNeeded, overallScale, center, sizeWithOverflow.width);
    final double leftWidthNeeded = halfWidthNeeded - shift;
    final double rightWidthNeeded = halfWidthNeeded + shift;

    // The parameter that describes how far along the transition from round to
    // stretched we are.
    final double leftAmount =
        math.max(0.0, math.min(1.0, leftWidthNeeded / _neckTriangleBase));
    final double rightAmount =
        math.max(0.0, math.min(1.0, rightWidthNeeded / _neckTriangleBase));
    // The angle between the top neck arc's center and the top lobe's center
    // and vertical. The base amount is chosen so that the neck is smooth,
    // even when the lobe is shifted due to its size.
    final double leftTheta = (1.0 - leftAmount) * _thirtyDegrees;
    final double rightTheta = (1.0 - rightAmount) * _thirtyDegrees;
    // The center of the top left neck arc.
    final Offset leftTopNeckCenter = Offset(
      -_neckTriangleBase,
      _topLobeCenter.dy + math.cos(leftTheta) * _neckTriangleHypotenuse,
    );
    final Offset neckRightCenter = Offset(
      _neckTriangleBase,
      _topLobeCenter.dy + math.cos(rightTheta) * _neckTriangleHypotenuse,
    );
    final double leftNeckArcAngle = _ninetyDegrees - leftTheta;
    final double rightNeckArcAngle = math.pi + _ninetyDegrees - rightTheta;
    // The distance between the end of the bottom neck arc and the beginning of
    // the top neck arc. We use this to shrink/expand it based on the scale
    // factor of the value indicator.
    final double neckStretchBaseline = math.max(
        0.0,
        rightBottomNeckCenterY -
            math.max(leftTopNeckCenter.dy, neckRightCenter.dy));
    final double t = math.pow(inverseTextScale, 3.0) as double;
    final double stretch =
        (neckStretchBaseline * t).clamp(0.0, 10.0 * neckStretchBaseline);
    final Offset neckStretch = Offset(0.0, neckStretchBaseline - stretch);

    assert(!_debuggingLabelLocation ||
        () {
          final Offset leftCenter =
              _topLobeCenter - Offset(leftWidthNeeded, 0.0) + neckStretch;
          final Offset rightCenter =
              _topLobeCenter + Offset(rightWidthNeeded, 0.0) + neckStretch;
          final Rect valueRect = Rect.fromLTRB(
            leftCenter.dx - _topLobeRadius,
            leftCenter.dy - _topLobeRadius,
            rightCenter.dx + _topLobeRadius,
            rightCenter.dy + _topLobeRadius,
          );
          final Paint outlinePaint = Paint()
            ..color = const Color(0xffff0000)
            ..style = PaintingStyle.stroke
            ..strokeWidth = 1.0;
          canvas.drawRect(valueRect, outlinePaint);
          return true;
        }());

    _addArc(
      path,
      leftTopNeckCenter + neckStretch,
      _topNeckRadius,
      0.0,
      -leftNeckArcAngle,
    );
    _addArc(
      path,
      _topLobeCenter - Offset(leftWidthNeeded, 0.0) + neckStretch,
      _topLobeRadius,
      _ninetyDegrees + leftTheta,
      _twoSeventyDegrees,
    );
    _addArc(
      path,
      _topLobeCenter + Offset(rightWidthNeeded, 0.0) + neckStretch,
      _topLobeRadius,
      _twoSeventyDegrees,
      _twoSeventyDegrees + math.pi - rightTheta,
    );
    _addArc(
      path,
      neckRightCenter + neckStretch,
      _topNeckRadius,
      rightNeckArcAngle,
      math.pi,
    );

    if (strokePaintColor != null) {
      final Paint strokePaint = Paint()
        ..color = strokePaintColor
        ..strokeWidth = 1.0
        ..style = PaintingStyle.stroke;
      canvas.drawPath(path, strokePaint);
    }

    canvas.drawPath(path, paint);

    // Draw the label.
    canvas.save();
    canvas.translate(shift, -_distanceBetweenTopBottomCenters + neckStretch.dy);
    canvas.scale(inverseTextScale, inverseTextScale);
    labelPainter.paint(canvas,
        Offset.zero - Offset(labelHalfWidth, labelPainter.height / 2.0));
    canvas.restore();
    canvas.restore();
  }
}

/// For custom range slider
class CustomPaddleRangeSliderValueIndicatorShape
    extends RangeSliderValueIndicatorShape {
  /// Create a slider value indicator in the shape of an upside-down pear.
  const CustomPaddleRangeSliderValueIndicatorShape();

  static const _PaddleSliderValueIndicatorPathPainter _pathPainter =
      _PaddleSliderValueIndicatorPathPainter();

  @override
  Size getPreferredSize(
    bool isEnabled,
    bool isDiscrete, {
    required TextPainter labelPainter,
    required double textScaleFactor,
  }) {
    assert(textScaleFactor >= 0);
    return _pathPainter.getPreferredSize(labelPainter, textScaleFactor);
  }

  @override
  double getHorizontalShift({
    RenderBox? parentBox,
    Offset? center,
    TextPainter? labelPainter,
    Animation<double>? activationAnimation,
    double? textScaleFactor,
    Size? sizeWithOverflow,
  }) {
    return _pathPainter.getHorizontalShift(
      center: center!,
      labelPainter: labelPainter!,
      scale: activationAnimation!.value,
      textScaleFactor: textScaleFactor!,
      sizeWithOverflow: sizeWithOverflow!,
    );
  }

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    bool? isDiscrete,
    bool isOnTop = false,
    required TextPainter labelPainter,
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    TextDirection? textDirection,
    Thumb? thumb,
    double? value,
    double? textScaleFactor,
    Size? sizeWithOverflow,
  }) {
    assert(!sizeWithOverflow!.isEmpty);
    final ColorTween enableColor = ColorTween(
      begin: sliderTheme.disabledThumbColor,
      end: sliderTheme.valueIndicatorColor,
    );
    // Add a stroke of 1dp around the top paddle.
    _pathPainter.paint(
      context.canvas,
      center,
      Paint()..color = enableColor.evaluate(enableAnimation)!,
      activationAnimation.value,
      // AlwaysStoppedAnimation(1).value.toDouble(),
      labelPainter,
      textScaleFactor!,
      sizeWithOverflow!,
      isOnTop ? sliderTheme.overlappingShapeStrokeColor : null,
      // null,
    );
  }
}
