// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecomik/controller/bid_timer_widget_controller.dart';
import 'package:ecomik/models/enums.dart';
import 'package:ecomik/utils/constants/app_constants.dart';

import 'package:ecomik/utils/constants/app_constants_import.dart';
import 'package:ecomik/utils/constants/app_language_translations.dart';
import 'package:ecomik/utils/constants/app_text_styles.dart';
import 'package:ecomik/utils/extensions/string.dart';
import 'package:ecomik/utils/helpers/helpers.dart';
import 'package:ecomik/widgets/screen_widgets/cart_screen_widgets.dart';
import 'package:ecomik/widgets/screen_widgets/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:shimmer/shimmer.dart';

/// Custom padded body widget for scaffold
class CustomScaffoldBodyWidget extends StatelessWidget {
  final Widget child;
  const CustomScaffoldBodyWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.symmetric(horizontal: AppGaps.screenPaddingValue),
      child: child,
    );
  }
}

/// Custom TextButton widget which is very tight to child text
class TightTextButtonWidget extends StatelessWidget {
  final void Function()? onTap;
  final Widget child;
  const TightTextButtonWidget({
    super.key,
    this.onTap,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: onTap,
        style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            visualDensity: const VisualDensity(
                horizontal: VisualDensity.minimumDensity,
                vertical: VisualDensity.minimumDensity)),
        child: child);
  }
}

/// Custom padded bottom bar widget for scaffold
class CustomScaffoldBottomBarWidget extends StatelessWidget {
  final Widget child;
  final Color? backgroundColor;
  final BorderRadius? borderRadius;
  const CustomScaffoldBottomBarWidget(
      {super.key,
      required this.child,
      this.backgroundColor,
      this.borderRadius});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppGaps.bottomNavBarPadding,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: borderRadius,
      ),
      child: child,
    );
  }
}

/// Custom TextButton stretches the width of the screen with small elevation
/// shadow
class CustomTextButtonWidget extends StatelessWidget {
  final String buttonText;
  final void Function()? onTap;
  const CustomTextButtonWidget({
    super.key,
    this.onTap,
    required this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          // color: AppColors.primaryColor.withOpacity(0.5),
          gradient: onTap == null
              ? LinearGradient(colors: [
                  AppColors.primaryColor.withOpacity(0.5),
                  AppColors.primaryColor.withOpacity(0.5)
                ])
              : LinearGradient(colors: [
                  AppColors.primaryColor,
                  AppColors.primaryColor.withOpacity(0.4),
                ])),
      child: TextButton(
          onPressed: onTap,
          style: TextButton.styleFrom(
              foregroundColor: Colors.white,
              elevation: onTap == null ? 0 : 10,
              shadowColor: AppColors.primaryColor.withOpacity(0.25),
              // backgroundColor: onTap == null
              //     ? AppColors.primaryColor.withOpacity(0.15)
              //     : AppColors.primaryColor.withOpacity(0.0),
              minimumSize: const Size(30, 62),
              shape: const RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.all(AppComponents.defaultBorderRadius))),
          child: Text(buttonText,
              style:
                  onTap == null ? const TextStyle(color: Colors.white) : null)),
    );
  }
}

//multiple image input
class MultiImageUploadSectionWidget extends StatelessWidget {
  final String label;
  final bool isRequired;
  final List<String> imageURLs;
  final void Function()? onImageUploadTap;
  final void Function(int)? onImageTap;
  final void Function(int)? onImageEditTap;
  final void Function(int)? onImageDeleteTap;
  const MultiImageUploadSectionWidget({
    super.key,
    required this.label,
    this.isRequired = false,
    required this.imageURLs,
    this.onImageUploadTap,
    this.onImageEditTap,
    this.onImageDeleteTap,
    this.onImageTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              label,
              style: AppTextStyles.labelTextStyle.copyWith(color: Colors.black),
            ),
            if (isRequired)
              Text(
                ' *',
                style: AppTextStyles.bodySemiboldTextStyle
                    .copyWith(color: AppColors.alertColor),
              )
          ],
        ),
        AppGaps.hGap16,
        MultiImageUploadWidget(
          imageURLs: imageURLs,
          onImageTap: onImageTap,
          onImageUploadTap: onImageUploadTap,
          onImageEditTap: onImageEditTap,
          onImageDeleteTap: onImageDeleteTap,
        ),
      ],
    );
  }
}

class MultiImageUploadWidget extends StatelessWidget {
  final List<String> imageURLs;
  final void Function()? onImageUploadTap;
  final void Function(int)? onImageTap;
  final void Function(int)? onImageEditTap;
  final void Function(int)? onImageDeleteTap;
  const MultiImageUploadWidget(
      {super.key,
      required this.imageURLs,
      this.onImageUploadTap,
      this.onImageEditTap,
      this.onImageDeleteTap,
      this.onImageTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 102,
      decoration: BoxDecoration(
          color: AppColors.uploadContainerColor,
          borderRadius: const BorderRadius.all(Radius.circular(18))),
      child: Builder(
          builder: (context) => imageURLs.isEmpty
              ? SelectImageButton(onTap: onImageUploadTap)
              : ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    if (index == imageURLs.length) {
                      return SizedBox(
                          width: 102,
                          child: SelectImageButton(onTap: onImageUploadTap));
                    }
                    final imageURL = imageURLs[index];
                    return SizedBox(
                      width: 102,
                      child: SelectedNetworkImagesWidget(
                        imageURL: imageURL,
                        onTap: onImageTap != null
                            ? () => onImageTap!(index)
                            : null,
                        onEditButtonTap: onImageEditTap != null
                            ? () => onImageEditTap!(index)
                            : null,
                        showDeleteButton: true,
                        onDeleteButtonTap: onImageDeleteTap != null
                            ? () => onImageDeleteTap!(index)
                            : null,
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => AppGaps.wGap12,
                  itemCount: imageURLs.length + 1)),
    );
  }
}

class SelectImageButton extends StatelessWidget {
  final void Function()? onTap;
  const SelectImageButton({
    super.key,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return RawButtonWidget(
        borderRadiusValue: Constants.uploadImageButtonBorderRadiusValue,
        onTap: onTap,
        child: Container(
          width: 102,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
              border: Border.all(color: AppColors.greyColor),
              borderRadius: const BorderRadius.all(Radius.circular(
                  Constants.uploadImageButtonBorderRadiusValue))),
          child: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text('+Upload',
                      style: AppTextStyles.bodySemiboldTextStyle),
                ]),
          ),
        ));
  }
}

class SelectedNetworkImagesWidget extends StatelessWidget {
  final String imageURL;
  final void Function()? onTap;
  final void Function()? onEditButtonTap;
  final bool showDeleteButton;
  final void Function()? onDeleteButtonTap;

  const SelectedNetworkImagesWidget({
    super.key,
    required this.imageURL,
    this.onTap,
    this.onEditButtonTap,
    this.onDeleteButtonTap,
    this.showDeleteButton = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // width: 140,
      child: RawButtonWidget(
        borderRadiusValue: Constants.defaultBorderRadiusValue,
        onTap: onTap,
        child: Stack(
          alignment: Alignment.topRight,
          children: [
            Positioned.fill(
              child: CachedNetworkImageWidget(
                imageURL: imageURL,
                imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                      borderRadius: AppComponents.defaultBorder,
                      image: DecorationImage(
                          image: imageProvider, fit: BoxFit.cover)),
                ),
              ),
            ),
            Positioned(
              top: 5,
              right: 5,
              child: Builder(
                builder: (context) {
                  if (showDeleteButton) {
                    return Row(
                      children: [
                        TightIconsButtonWidget(
                            icon: const LocalAssetSVGIcon(AppAssetImages.upload,
                                color: Colors.black),
                            onTap: onEditButtonTap),
                        AppGaps.wGap8,
                      ],
                    );
                  }
                  return TightIconsButtonWidget(
                      icon: const LocalAssetSVGIcon(AppAssetImages.upload,
                          color: Colors.black),
                      onTap: onEditButtonTap);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

/// This icon button does not have any padding, margin around it
class TightIconsButtonWidget extends StatelessWidget {
  final Widget icon;
  final Function()? onTap;
  const TightIconsButtonWidget({super.key, required this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    return IconButton(
        padding: EdgeInsets.zero,
        visualDensity: const VisualDensity(
            horizontal: VisualDensity.minimumDensity,
            vertical: VisualDensity.minimumDensity),
        onPressed: onTap,
        icon: icon);
  }
}

class SelectedLocalImageWidget extends StatelessWidget {
  final String label;
  final bool isRequired;
  final List<String> imageURLs;
  final List<dynamic> imagesBytes;
  final void Function()? onTap;
  final void Function(int)? onImageDeleteTap;
  final void Function()? onImageUploadTap;

  const SelectedLocalImageWidget({
    super.key,
    required this.label,
    required this.imageURLs,
    this.isRequired = false,
    required this.imagesBytes,
    this.onTap,
    this.onImageDeleteTap,
    this.onImageUploadTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              label,
              style: AppTextStyles.labelTextStyle,
            ),
            if (isRequired)
              Text(
                ' *',
                style: AppTextStyles.bodySemiboldTextStyle
                    .copyWith(color: AppColors.alertColor),
              )
          ],
        ),
        AppGaps.hGap16,
        SizedBox(
          height: 140,
          child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: ((context, index) {
                // index += 1;
                if (index == imagesBytes.length) {
                  return SizedBox(
                      width: 180,
                      child: SelectImageButton(onTap: onImageUploadTap));
                }
                dynamic singleLocalImage = imagesBytes[index];
                return SizedBox(
                  width: 140,
                  height: 140,
                  child: RawButtonWidget(
                    borderRadiusValue: Constants.defaultBorderRadiusValue,
                    onTap: onTap,
                    child: Stack(
                      alignment: Alignment.topRight,
                      children: [
                        Positioned.fill(
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: AppComponents.defaultBorder,
                                image: DecorationImage(
                                    image: (singleLocalImage is String)
                                        ? CachedNetworkImageProvider(
                                            singleLocalImage)
                                        : Image.memory(singleLocalImage).image,
                                    fit: BoxFit.cover)),
                          ),
                        ),
                        Positioned(
                          top: 5,
                          right: 5,
                          child: Row(
                            children: [
                              // const TightIconButtonWidget(
                              //     icon: LocalAssetSVGIcon(
                              //         AppAssetImages.emailFillSvgIcon,
                              //         color: Colors.white),
                              //     onTap: null),
                              // AppGaps.wGap10,
                              TightIconsButtonWidget(
                                  icon: const LocalAssetSVGIcon(
                                      AppAssetImages.deleteSVGLogoLine,
                                      color: AppColors.alertColor),
                                  onTap: onImageDeleteTap != null
                                      ? () => onImageDeleteTap!(index)
                                      : null),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              }),
              separatorBuilder: (context, index) => AppGaps.wGap10,
              itemCount: imagesBytes.length + 1),
        ),
      ],
    );
  }
}

class EnrollPaymentButtonLoadingWidget extends StatelessWidget {
  const EnrollPaymentButtonLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return LoadingPlaceholderWidget(
      child: StretchedTextButtonWidget(buttonText: 'Loading'),
    );
  }
}

/// Custom TextButton stretches the width of the screen
class StretchedTextButtonWidget extends StatelessWidget {
  final String buttonText;
  final Color backgroundColor;
  final Color color;
  final Color fontColor;
  final bool isSmallSizedButton;
  final void Function()? onTap;
  const StretchedTextButtonWidget({
    Key? key,
    this.onTap,
    required this.buttonText,
    this.backgroundColor = AppColors.primaryColor,
    this.color = AppColors.primaryBorderColor,
    this.fontColor = Colors.white,
    this.isSmallSizedButton = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ButtonWidget(
              borderRadiusValue: 15,
              onTap: onTap,
              color: color,
              fixedSize: isSmallSizedButton ? null : const Size(211, 55),
              backgroundColor: onTap != null
                  ? backgroundColor
                  : backgroundColor.withOpacity(0.5),
              child: Text(
                buttonText,
                style: AppTextStyles.bodyLargeSemiboldTextStyle.copyWith(
                    color: onTap != null
                        ? fontColor
                        : AppColors.primaryColor.withOpacity(0.5)),
              )),
        ),
      ],
    );
  }
}

class ButtonWidget extends StatelessWidget {
  final void Function()? onTap;
  final Color color;
  final Color backgroundColor;
  final Widget child;
  final Size? fixedSize;
  final double borderRadiusValue;

  const ButtonWidget({
    Key? key,
    this.onTap,
    this.color = Colors.white,
    this.backgroundColor = AppColors.primaryColor,
    required this.child,
    this.fixedSize,
    this.borderRadiusValue = Constants.borderRadiusValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: onTap,
        style: TextButton.styleFrom(
          foregroundColor: color,
          disabledForegroundColor: Colors.white,
          disabledBackgroundColor: AppColors.lightGreyColor,
          backgroundColor: backgroundColor,
          minimumSize: const Size(30, 44),
          fixedSize: fixedSize,
          shape: RoundedRectangleBorder(
              borderRadius:
                  // BorderRadius.all(Radius.circular(Constants.borderRadiusValue)),
                  Constants.borderRadius(borderRadiusValue)),
        ),
        child: child);
  }
}

class DottedHorizontalLine extends StatelessWidget {
  final Color? dashColor;
  final double dashLength;
  final double dashGapLength;
  const DottedHorizontalLine({
    Key? key,
    this.dashColor,
    this.dashLength = 1,
    this.dashGapLength = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DottedLine(
      lineThickness: 1,
      dashColor: dashColor ?? AppColors.primaryColor.withOpacity(0.5),
      dashLength: dashLength,
      dashGapLength: dashGapLength,
      dashRadius: 50,
    );
  }
}

///Svg picture Insert

class SvgPictureAssetWidget extends StatelessWidget {
  final String assetName;
  final double? height;
  final double? width;
  final Color? color;
  final String? package;
  final BoxFit fit;
  const SvgPictureAssetWidget(this.assetName,
      {super.key,
      this.height,
      this.width,
      this.color,
      this.package,
      this.fit = BoxFit.contain});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(assetName,
        height: height,
        width: width,
        fit: fit,
        colorFilter:
            color == null ? null : ColorFilter.mode(color!, BlendMode.srcIn));
  }
}

class ScaffoldBodyWidget extends StatelessWidget {
  final Widget child;
  final bool hasNoAppbar;
  const ScaffoldBodyWidget(
      {Key? key, required this.child, this.hasNoAppbar = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return hasNoAppbar
        ? Padding(
            padding: AppComponents.screenHorizontalPadding,
            child: SafeArea(top: true, child: child),
          )
        : Padding(
            padding: AppComponents.screenHorizontalPadding,
            child: child,
          );
  }
}

/// Custom TextButton stretches the width of the screen with small elevation
/// shadow
class CustomStretchedTextButtonWidget extends StatelessWidget {
  final String buttonText;
  final bool isLoading;
  final void Function()? onTap;
  const CustomStretchedTextButtonWidget({
    super.key,
    this.onTap,
    required this.buttonText,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return LoadingStretchedTextButtonWidget(buttonText: buttonText);
    }
    return Row(
      children: [
        Expanded(
          child: DecoratedBox(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                // color: AppColors.primaryColor.withOpacity(0.5),
                gradient: onTap == null
                    ? LinearGradient(colors: [
                        AppColors.primaryColor.withOpacity(0.5),
                        AppColors.primaryColor.withOpacity(0.5)
                      ])
                    : LinearGradient(colors: [
                        AppColors.primaryColor,
                        AppColors.primaryColor.withOpacity(0.1),
                      ])),
            child: TextButton(
                onPressed: onTap,
                style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                    elevation: onTap == null ? 0 : 10,
                    shadowColor: AppColors.primaryColor.withOpacity(0.25),
                    // backgroundColor: onTap == null
                    //     ? AppColors.primaryColor.withOpacity(0.15)
                    //     : AppColors.primaryColor.withOpacity(0.0),
                    minimumSize: const Size(30, 62),
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                            AppComponents.defaultBorderRadius))),
                child: Text(buttonText,
                    textAlign: TextAlign.center,
                    style: onTap == null
                        ? const TextStyle(color: Colors.white)
                        : null)),
          ),
        ),
      ],
    );
  }
}

/// Custom TextButton stretches the width of the screen with small elevation
/// shadow
class LoadingStretchedTextButtonWidget extends StatelessWidget {
  final String buttonText;
  const LoadingStretchedTextButtonWidget({
    super.key,
    required this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    return LoadingPlaceholderWidget(
      child: Row(
        children: [
          Expanded(
            child: DecoratedBox(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  // color: AppColors.primaryColor.withOpacity(0.5),
                  gradient: LinearGradient(colors: [
                    AppColors.primaryColor.withOpacity(0.5),
                    AppColors.primaryColor.withOpacity(0.5)
                  ])),
              child: TextButton(
                  onPressed: null,
                  style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shadowColor: AppColors.primaryColor.withOpacity(0.25),
                      // backgroundColor: onTap == null
                      //     ? AppColors.primaryColor.withOpacity(0.15)
                      //     : AppColors.primaryColor.withOpacity(0.0),
                      minimumSize: const Size(30, 62),
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                              AppComponents.defaultBorderRadius))),
                  child: Text(buttonText,
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.white))),
            ),
          ),
        ],
      ),
    );
  }
}

/// Custom TextButton stretches the width of the screen with small elevation
/// shadow with custom child widget
class CustomStretchedButtonWidget extends StatelessWidget {
  final Widget child;
  final void Function()? onTap;
  final bool isLoading;
  const CustomStretchedButtonWidget({
    super.key,
    this.onTap,
    required this.child,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return LoadingPlaceholderWidget(
          child: StretchedButtonWidget(onTap: onTap, child: child));
    }
    return StretchedButtonWidget(onTap: onTap, child: child);
  }
}

/// Custom TextButton stretches the width of the screen with small elevation
/// shadow with custom child widget
class CustomStretchedDeleteButtonWidget extends StatelessWidget {
  final Widget child;
  final void Function()? onTap;
  final bool isLoading;
  const CustomStretchedDeleteButtonWidget({
    super.key,
    this.onTap,
    required this.child,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return LoadingPlaceholderWidget(
          child: StretchedDeleteButtonWidget(onTap: onTap, child: child));
    }
    return StretchedDeleteButtonWidget(onTap: onTap, child: child);
  }
}

class StretchedButtonWidget extends StatelessWidget {
  const StretchedButtonWidget({
    super.key,
    required this.onTap,
    required this.child,
  });

  final void Function()? onTap;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextButton(
              onPressed: onTap,
              style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  elevation: 10,
                  shadowColor: AppColors.primaryColor.withOpacity(0.25),
                  backgroundColor: onTap == null
                      ? AppColors.bodyTextColor
                      : AppColors.primaryColor,
                  minimumSize: const Size(30, 62),
                  shape: const RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.all(AppComponents.defaultBorderRadius))),
              child: child),
        ),
      ],
    );
  }
}

class StretchedDeleteButtonWidget extends StatelessWidget {
  const StretchedDeleteButtonWidget({
    super.key,
    required this.onTap,
    required this.child,
  });

  final void Function()? onTap;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextButton(
              onPressed: onTap,
              style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  elevation: 10,
                  shadowColor: AppColors.primaryColor.withOpacity(0.25),
                  backgroundColor: onTap == null
                      ? AppColors.alertBackgroundColor
                      : AppColors.alertColor,
                  minimumSize: const Size(30, 62),
                  shape: const RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.all(AppComponents.defaultBorderRadius))),
              child: child),
        ),
      ],
    );
  }
}

/// Custom TextButton stretches the width of the screen with small elevation
/// shadow with custom child widget
class CustomStretchedOnlyTextButtonWidget extends StatelessWidget {
  final String buttonText;
  final void Function()? onTap;
  const CustomStretchedOnlyTextButtonWidget({
    super.key,
    this.onTap,
    required this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextButton(
              onPressed: onTap,
              style: TextButton.styleFrom(
                  minimumSize: const Size(30, 32),
                  visualDensity: const VisualDensity(),
                  shape: const RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.all(AppComponents.defaultBorderRadius))),
              child: Text(
                buttonText,
                textAlign: TextAlign.center,
              )),
        ),
      ],
    );
  }
}

/// Custom TextButton stretches the width of the screen with small elevation
/// shadow with custom child widget
class CustomButtonWidget extends StatelessWidget {
  final Widget child;
  final void Function()? onTap;
  const CustomButtonWidget({
    super.key,
    this.onTap,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: onTap,
        style: TextButton.styleFrom(
            foregroundColor: Colors.white,
            elevation: 10,
            shadowColor: AppColors.primaryColor.withOpacity(0.25),
            backgroundColor: onTap == null
                ? AppColors.bodyTextColor
                : AppColors.primaryColor,
            minimumSize: const Size(30, 62),
            shape: const RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.all(AppComponents.defaultBorderRadius))),
        child: child);
  }
}

/// Custom TextButton stretches the width of the screen with small elevation
/// shadow with custom child widget
class CustomDialogButtonWidget extends StatelessWidget {
  final Widget child;
  final void Function()? onTap;
  const CustomDialogButtonWidget({
    super.key,
    this.onTap,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: onTap,
        style: TextButton.styleFrom(
            foregroundColor: Colors.white,
            elevation: 10,
            shadowColor: AppColors.primaryColor.withOpacity(0.25),
            backgroundColor: onTap == null
                ? AppColors.bodyTextColor
                : AppColors.primaryColor,
            minimumSize: const Size(128, 33),
            shape: const StadiumBorder()),
        child: child);
  }
}

/// Custom TextButton stretches the width of the screen with small elevation
/// shadow with custom child widget
class CustomStretchedOutlinedButtonWidget extends StatelessWidget {
  final Widget child;
  final void Function()? onTap;
  const CustomStretchedOutlinedButtonWidget({
    super.key,
    this.onTap,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
              onPressed: onTap,
              style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.primaryColor,
                  elevation: 1000,
                  minimumSize: const Size(30, 62),
                  shape: const RoundedRectangleBorder(
                    // side: BorderSide(color: AppColors.primaryColor),
                    borderRadius:
                        BorderRadius.all(AppComponents.defaultBorderRadius),
                  )),
              child: child),
        ),
      ],
    );
  }
}

/// Custom toggle button of tab widget
class CustomTabToggleButtonWidget extends StatelessWidget {
  final bool isSelected;
  final String text;
  final void Function()? onTap;
  const CustomTabToggleButtonWidget(
      {super.key, required this.isSelected, required this.text, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      animationDuration: Duration.zero,
      color: isSelected ? AppColors.primaryColor : Colors.transparent,
      elevation: isSelected ? 10 : 0,
      shadowColor: isSelected ? AppColors.primaryColor.withOpacity(0.25) : null,
      borderRadius: const BorderRadius.all(Radius.circular(18)),
      child: InkWell(
        borderRadius: const BorderRadius.all(Radius.circular(18)),
        onTap: onTap,
        child: Container(
          alignment: Alignment.center,
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .labelLarge
                ?.copyWith(color: isSelected ? Colors.white : null),
          ),
        ),
      ),
    );
  }
}

/// Minus, counter, plus buttons row for product cart counter.
class PlusMinusCounterRow extends StatelessWidget {
  final void Function()? onRemoveTap;
  final String counterText;
  final void Function()? onAddTap;
  const PlusMinusCounterRow({
    super.key,
    required this.onRemoveTap,
    required this.counterText,
    required this.onAddTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 86,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomIconButtonWidget(
              backgroundColor: AppColors.shadeColor1,
              borderRadiusRadiusValue: const Radius.circular(6),
              fixedSize: const Size(24, 24),
              onTap: onRemoveTap,
              child: SvgPicture.asset(
                AppAssetImages.minusSVGLogoSolid,
                color: AppColors.bodyTextColor,
                height: 12,
                width: 12,
              )),
          AppGaps.wGap10,
          Expanded(
            child: Center(
              child: Text(
                counterText,
                textAlign: TextAlign.center,
                style:
                    const TextStyle(fontSize: 12, color: AppColors.darkColor),
              ),
            ),
          ),
          AppGaps.wGap10,
          CustomIconButtonWidget(
              backgroundColor: AppColors.primaryColor,
              borderRadiusRadiusValue: const Radius.circular(6),
              fixedSize: const Size(24, 24),
              onTap: onAddTap,
              child: SvgPicture.asset(
                AppAssetImages.plusSVGLogoSolid,
                color: Colors.white,
                height: 12,
                width: 12,
              )),
        ],
      ),
    );
  }
}

/// Custom TextFormField configured with Theme.
class CustomTextFormField extends StatelessWidget {
  final String? labelText;
  final String? hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool isPasswordTextField;
  final bool hasShadow;
  final bool isReadOnly;
  final BoxConstraints prefixIconConstraints;
  final TextInputType? textInputType;
  final BoxConstraints suffixIconConstraints;
  final TextEditingController? controller;
  final int? minLines;
  final int maxLines;
  final void Function()? onTap;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  const CustomTextFormField({
    super.key,
    this.labelText,
    this.prefixIcon,
    this.suffixIcon,
    this.hintText,
    this.isPasswordTextField = false,
    this.hasShadow = false,
    this.prefixIconConstraints =
        const BoxConstraints(maxHeight: 48, maxWidth: 48),
    this.suffixIconConstraints =
        const BoxConstraints(maxHeight: 48, maxWidth: 48),
    this.isReadOnly = false,
    this.textInputType,
    this.controller,
    this.minLines,
    this.maxLines = 1,
    this.onTap,
    this.validator,
    this.onChanged,
  });

  /// TextField widget
  Widget textFormFieldWidget() {
    return SizedBox(
      // height: (maxLines > 1 || (minLines ?? 1) > 1) ? null : 62,
      child: TextFormField(
        controller: controller,
        onTap: onTap,
        readOnly: isReadOnly,
        onChanged: onChanged,
        obscureText: isPasswordTextField,
        keyboardType: textInputType,
        validator: validator,
        minLines: minLines,
        maxLines: maxLines,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
          hintText: hintText,
          prefix: AppGaps.wGap10,
          prefixIconConstraints: prefixIconConstraints,
          prefixIcon: prefixIcon != null
              ? Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: prefixIcon,
                )
              : null,
          contentPadding: const EdgeInsets.symmetric(vertical: 20),
          suffixIconConstraints: suffixIconConstraints,
          suffix: AppGaps.wGap10,
          suffixIcon: suffixIcon != null
              ? Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: suffixIcon,
                )
              : null,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // If label text is not null, then show label as a separate Text widget
    // wrapped inside column widget.
    // Else, just return the TextFormField widget.
    if (labelText != null) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Label text
          Text(labelText!,
              style:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
          AppGaps.hGap8,
          // Text field
          hasShadow
              ? PhysicalModel(
                  color: Colors.transparent,
                  elevation: 10,
                  shadowColor: Colors.black.withOpacity(0.25),
                  child: textFormFieldWidget(),
                )
              : textFormFieldWidget(),
        ],
      );
    } else {
      // Text field
      return hasShadow
          ? PhysicalModel(
              color: Colors.transparent,
              elevation: 10,
              shadowColor: Colors.black.withOpacity(0.25),
              child: textFormFieldWidget())
          : textFormFieldWidget();
    }
  }
}

class DropdownButtonFormFieldWidget<T> extends StatelessWidget {
  final T? value;
  final String hintText;
  final Widget? prefixIcon;
  final bool isLoading;
  final String? labelText;
  final List<T>? items;
  final String Function(T)? getItemText;
  final BoxConstraints prefixIconConstraints;
  final Widget Function(T)? getItemChild;
  final void Function(T?)? onChanged;
  final String? Function(T?)? validator;
  final TextEditingController? controller;
  final bool isDense;
  const DropdownButtonFormFieldWidget(
      {super.key,
      this.value,
      required this.hintText,
      this.prefixIcon,
      this.items,
      this.getItemText,
      required this.onChanged,
      this.prefixIconConstraints =
          const BoxConstraints(maxHeight: 48, maxWidth: 48),
      this.labelText,
      this.validator,
      this.controller,
      this.isLoading = false,
      this.getItemChild,
      this.isDense = true});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (labelText != null)
          Text(
            labelText!,
            style: AppTextStyles.labelTextStyle,
          ),
        if (labelText != null) AppGaps.hGap8,
        Builder(builder: (context) {
          if (isLoading) {
            return const DropdownButtonFormFieldLoadingWidget();
          }
          return DropdownButtonFormField<T>(
            isExpanded: true,
            isDense: isDense,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: validator,
            value: value,
            borderRadius: AppComponents.defaultBorder,
            hint: Text(hintText),
            disabledHint: Text(hintText,
                style: AppTextStyles.labelTextStyle
                    .copyWith(color: AppColors.bodyTextColor.withOpacity(0.5))),
            icon: LocalAssetSVGIcon(AppAssetImages.dropdownArrow,
                color: isDisabled()
                    ? AppColors.bodyTextColor.withOpacity(0.5)
                    : AppColors.bodyTextColor),
            // iconEnabledColor: AppColors.bodyTextColor,
            // iconDisabledColor: AppColors.lineShapeColor,
            decoration: InputDecoration(
                prefixIconConstraints: prefixIconConstraints,
                prefixIcon: prefixIcon != null
                    ? Padding(
                        padding: const EdgeInsets.only(left: 20, right: 10),
                        child: prefixIcon,
                      )
                    : null,
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 18, horizontal: 20)),
            items: items
                ?.map((e) =>
                    DropdownMenuItem(value: e, child: _getItemChildWidget(e)))
                .toList(),
            onChanged: onChanged,
          );
        }),
      ],
    );
  }

  Widget _getItemChildWidget(T element) {
    if (getItemChild != null) {
      return getItemChild!(element);
    }
    if (getItemText != null) {
      return Text(getItemText!(element));
    }
    return AppGaps.emptyGap;
  }

  bool isDisabled() =>
      onChanged == null || (items == null || (items?.isEmpty ?? true));
}

class DropdownButtonFormFieldLoadingWidget extends StatelessWidget {
  const DropdownButtonFormFieldLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return LoadingPlaceholderWidget(
      child: Container(
        height: 60,
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
            borderRadius: AppComponents.defaultBorder,
            border: Border.all(width: 2)),
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 18),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(width: 120, child: LoadingTextWidget()),
              Spacer(),
              LocalAssetSVGIcon(AppAssetImages.dropdownArrow,
                  color: Colors.white)
            ],
          ),
        ),
      ),
    );
  }
}

class LocalAssetSVGIcon extends StatelessWidget {
  final String iconLocalAssetLocation;
  final Color color;
  final double height;
  final double? width;
  const LocalAssetSVGIcon(this.iconLocalAssetLocation,
      {super.key, required, required this.color, this.height = 24, this.width});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(iconLocalAssetLocation,
        height: height,
        width: width ?? height,
        colorFilter: ColorFilter.mode(color, BlendMode.srcIn));
  }
}

class LoadingTextWidget extends StatelessWidget {
  final bool isSmall;
  const LoadingTextWidget({
    super.key,
    this.isSmall = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: isSmall ? 15 : 20,
      child: Container(
        decoration: const BoxDecoration(
            color: Colors.white, borderRadius: AppComponents.smallBorderRadius),
      ),
    );
  }
}

class LoadingBoxWidget extends StatelessWidget {
  final double? height;
  final double? width;
  const LoadingBoxWidget({
    super.key,
    this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: Container(
        decoration: const BoxDecoration(
            color: Colors.white, borderRadius: AppComponents.smallBorderRadius),
      ),
    );
  }
}

/// Radio widget without additional padding
class CustomRadioWidget extends StatelessWidget {
  final Object value;
  final Object? groupValue;
  final void Function(Object?) onChanged;
  const CustomRadioWidget(
      {super.key,
      required this.value,
      required this.groupValue,
      required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 20,
      width: 20,
      child: Radio<Object>(
        value: value,
        groupValue: groupValue,
        onChanged: onChanged,
      ),
    );
  }
}

/// Custom IconButton widget various attributes
class CustomIconButtonWidget extends StatelessWidget {
  final void Function()? onTap;
  final Border? border;
  final Widget child;
  final Color backgroundColor;
  final Size fixedSize;
  final Radius borderRadiusRadiusValue;
  final bool isCircleShape;
  final bool hasShadow;
  final bool isLoading;
  const CustomIconButtonWidget(
      {super.key,
      this.onTap,
      required this.child,
      this.backgroundColor = Colors.white,
      this.fixedSize = const Size(40, 40),
      this.borderRadiusRadiusValue = const Radius.circular(14),
      this.border,
      this.isCircleShape = false,
      this.hasShadow = false,
      this.isLoading = false});

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return LoadingPlaceholderWidget(
        child: IconButtonWidget(
            fixedSize: fixedSize,
            isCircleShape: isCircleShape,
            borderRadiusRadiusValue: borderRadiusRadiusValue,
            border: border,
            backgroundColor: backgroundColor,
            hasShadow: hasShadow,
            onTap: onTap,
            child: child),
      );
    }
    return IconButtonWidget(
        fixedSize: fixedSize,
        isCircleShape: isCircleShape,
        borderRadiusRadiusValue: borderRadiusRadiusValue,
        border: border,
        backgroundColor: backgroundColor,
        hasShadow: hasShadow,
        onTap: onTap,
        child: child);
  }
}

class IconButtonWidget extends StatelessWidget {
  const IconButtonWidget({
    super.key,
    required this.fixedSize,
    required this.isCircleShape,
    required this.borderRadiusRadiusValue,
    required this.border,
    required this.backgroundColor,
    required this.hasShadow,
    required this.onTap,
    required this.child,
  });

  final Size fixedSize;
  final bool isCircleShape;
  final Radius borderRadiusRadiusValue;
  final Border? border;
  final Color backgroundColor;
  final bool hasShadow;
  final void Function()? onTap;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: fixedSize.height,
      width: fixedSize.width,
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(
          shape: isCircleShape ? BoxShape.circle : BoxShape.rectangle,
          borderRadius:
              isCircleShape ? null : BorderRadius.all(borderRadiusRadiusValue),
          border: border),
      child: Material(
        color: backgroundColor,
        shape: isCircleShape ? const CircleBorder() : null,
        shadowColor: hasShadow ? Colors.black.withOpacity(0.4) : null,
        elevation: hasShadow ? 8 : 0,
        borderRadius:
            isCircleShape ? null : BorderRadius.all(borderRadiusRadiusValue),
        child: InkWell(
          onTap: onTap,
          customBorder: isCircleShape ? const CircleBorder() : null,
          borderRadius: BorderRadius.all(borderRadiusRadiusValue),
          child: Center(child: child),
        ),
      ),
    );
  }
}

/// Custom large text button widget
class CustomLargeTextButtonWidget extends StatelessWidget {
  final bool isSmallScreen;
  final void Function()? onTap;
  final String text;
  final Color backgroundColor;
  final Color textColor;
  const CustomLargeTextButtonWidget({
    super.key,
    this.onTap,
    required this.text,
    this.backgroundColor = AppColors.primaryColor,
    this.textColor = Colors.white,
    this.isSmallScreen = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: onTap,
        style: TextButton.styleFrom(
            foregroundColor: textColor,
            fixedSize:
                isSmallScreen ? const Size(140, 55) : const Size(175, 65),
            visualDensity: const VisualDensity(
                horizontal: VisualDensity.minimumDensity,
                vertical: VisualDensity.minimumDensity),
            backgroundColor: backgroundColor,
            shape: const RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.all(AppComponents.defaultBorderRadius))),
        child: Text(text));
  }
}

/// Raw list tile does not have a background color
class CustomRawListTileWidget extends StatelessWidget {
  final Widget child;
  final void Function()? onTap;
  final Radius? borderRadiusRadiusValue;
  const CustomRawListTileWidget({
    super.key,
    required this.child,
    this.onTap,
    this.borderRadiusRadiusValue,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: borderRadiusRadiusValue != null
          ? BorderRadius.all(borderRadiusRadiusValue!)
          : null,
      child: InkWell(
        onTap: onTap,
        borderRadius: borderRadiusRadiusValue != null
            ? BorderRadius.all(borderRadiusRadiusValue!)
            : null,
        child: child,
      ),
    );
  }
}

/// Custom list tile widget of white background color
class CustomListTileWidget extends StatelessWidget {
  final bool hasShadow;
  final double elevation;
  final void Function()? onTap;
  final void Function()? onLongPress;
  final Widget child;
  final EdgeInsets paddingValue;
  final BorderRadius borderRadius;
  const CustomListTileWidget(
      {super.key,
      required this.child,
      this.onTap,
      this.paddingValue = const EdgeInsets.all(AppGaps.screenPaddingValue),
      this.onLongPress,
      this.borderRadius =
          const BorderRadius.all(AppComponents.defaultBorderRadius),
      this.hasShadow = false,
      this.elevation = 10});

  @override
  Widget build(BuildContext context) {
    return PhysicalModel(
      color: Colors.transparent,
      elevation: hasShadow ? elevation : 0,
      shadowColor: Colors.black.withOpacity(0.05),
      borderRadius: borderRadius,
      child: Material(
        color: Colors.white,
        borderRadius: borderRadius,
        child: InkWell(
          borderRadius: borderRadius,
          onTap: onTap,
          onLongPress: onLongPress,
          child: Container(
            alignment: Alignment.topLeft,
            padding: paddingValue,
            decoration: BoxDecoration(borderRadius: borderRadius),
            child: child,
          ),
        ),
      ),
    );
  }
}

/// Horizontal dashed line.
class CustomHorizontalDashedLineWidget extends StatelessWidget {
  const CustomHorizontalDashedLineWidget({
    super.key,
    this.height = 1,
    this.color = Colors.black,
  });
  final double height;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final boxWidth = constraints.constrainWidth();
        const dashWidth = 4.0;
        final dashHeight = height;
        final dashCount = (boxWidth / (2 * dashWidth)).floor();
        return Flex(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          direction: Axis.horizontal,
          children: List.generate(dashCount, (_) {
            return SizedBox(
              width: dashWidth,
              height: dashHeight,
              child: DecoratedBox(
                decoration: BoxDecoration(color: color),
              ),
            );
          }),
        );
      },
    );
  }
}

/// Vertical dashed line
class CustomVerticalDashedLineWidget extends StatelessWidget {
  const CustomVerticalDashedLineWidget({
    super.key,
    this.width = 1,
    this.color = Colors.black,
  });
  final double width;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final boxHeight = constraints.constrainWidth();
        const dashHeight = 4.0;
        final dashWidth = width;
        final dashCount = (boxHeight / (2 * dashHeight)).floor();
        return Flex(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          direction: Axis.vertical,
          children: List.generate(dashCount, (_) {
            return SizedBox(
              width: dashWidth,
              height: dashHeight,
              child: DecoratedBox(
                decoration: BoxDecoration(color: color),
              ),
            );
          }),
        );
      },
    );
  }
}

///Empty screen Widget
/* class EmptyScreenWidget extends StatelessWidget {
  final String image;
  final String title;
  final String shortTitle;
  const EmptyScreenWidget({
    Key? key,
    required this.image,
    required this.title,
    required this.shortTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 231,
          //  width: 254,
          child: Image.asset(image),
        ),
        AppGaps.hGap32,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: AppTextStyles.titleBoldTextStyle,
              ),
              AppGaps.hGap10,
              Text(shortTitle,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.bodyLargeTextStyle
                      .copyWith(color: AppColors.bodyTextColor)),
            ],
          ),
        ),
      ],
    );
  }
} */

/// Credit card widget with 3 shadows towards bottom
class PaymentCardWidget extends StatelessWidget {
  final Widget child;
  const PaymentCardWidget({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 232,
      alignment: Alignment.topCenter,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.topCenter,
        children: [
          Positioned.fill(child: Container(alignment: Alignment.topCenter)),
          Container(
            height: 208,
            alignment: Alignment.topCenter,
            margin: const EdgeInsets.only(left: 32, right: 32, top: 24),
            decoration: BoxDecoration(
              color: AppColors.primaryColor.withOpacity(0.1),
              borderRadius: const BorderRadius.all(Radius.circular(20)),
            ),
          ),
          Container(
            height: 208,
            alignment: Alignment.topCenter,
            margin: const EdgeInsets.only(left: 16, right: 16, top: 12),
            decoration: BoxDecoration(
              color: AppColors.primaryColor.withOpacity(0.3),
              borderRadius: const BorderRadius.all(Radius.circular(20)),
            ),
          ),
          Container(
            height: 208,
            decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                image: DecorationImage(
                    image: Image.asset(AppAssetImages.paymentCardAbstractShape,
                            cacheHeight: 163,
                            cacheWidth: 163,
                            height: 163,
                            width: 163)
                        .image,
                    alignment: Alignment.topRight)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
              child: child,
            ),
          ),
        ],
      ),
    );
  }
}

/// Slogan and subtitle text
class HighlightAndDetailTextWidget extends StatelessWidget {
  final String slogan;
  final String subtitle;
  final bool isSpaceShorter;
  const HighlightAndDetailTextWidget({
    super.key,
    required this.slogan,
    required this.subtitle,
    this.isSpaceShorter = false,
  });

  @override
  Widget build(BuildContext context) {
    return CustomScaffoldBodyWidget(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            slogan,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.displaySmall,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          isSpaceShorter ? AppGaps.hGap8 : AppGaps.hGap16,
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: AppColors.bodyTextColor),
            maxLines: 5,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

/// Wishlist screen grid item button widget
class WishlistItemButtonWidget extends StatelessWidget {
  final bool isWishListed;
  final void Function()? onTap;
  const WishlistItemButtonWidget({
    super.key,
    required this.isWishListed,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onTap,
      padding: EdgeInsets.zero,
      visualDensity: const VisualDensity(
          horizontal: VisualDensity.minimumDensity,
          vertical: VisualDensity.minimumDensity),
      icon: SvgPicture.asset(
        isWishListed
            ? AppAssetImages.heartSelectedSVGLogoLine
            : AppAssetImages.heartUnselectedSVGLogoLine,
      ),
    );
  }
}

/// Custom TextButton widget which is very tight to child text
class CustomTightTextButtonWidget extends StatelessWidget {
  final void Function()? onTap;
  final Widget child;
  const CustomTightTextButtonWidget({
    super.key,
    this.onTap,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: onTap,
        style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            visualDensity: const VisualDensity(
                horizontal: VisualDensity.minimumDensity,
                vertical: VisualDensity.minimumDensity)),
        child: child);
  }
}

class TightIconButtonWidget extends StatelessWidget {
  final String? tooltip;
  final void Function()? onTap;
  final BoxConstraints? constraints;
  final Widget child;
  final bool isLoading;
  const TightIconButtonWidget(
      {super.key,
      this.onTap,
      required this.child,
      this.tooltip,
      this.constraints,
      this.isLoading = false});

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return LoadingPlaceholderWidget(
        child: IconButton(
          onPressed: null,
          constraints: constraints,
          tooltip: tooltip,
          padding: EdgeInsets.zero,
          visualDensity: const VisualDensity(
              horizontal: VisualDensity.minimumDensity,
              vertical: VisualDensity.minimumDensity),
          icon: child,
        ),
      );
    }
    return IconButton(
      onPressed: onTap,
      constraints: constraints,
      tooltip: tooltip,
      padding: EdgeInsets.zero,
      visualDensity: const VisualDensity(
          horizontal: VisualDensity.minimumDensity,
          vertical: VisualDensity.minimumDensity),
      icon: child,
    );
  }
}

/// Custom grid item widget
class CustomGridSingleItemWidget extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;
  final Color backgroundColor;
  final Color? borderColor;
  final BorderRadius borderRadius;
  final void Function()? onTap;
  const CustomGridSingleItemWidget({
    super.key,
    this.onTap,
    this.backgroundColor = Colors.white,
    this.borderRadius = const BorderRadius.all(Radius.circular(20)),
    this.padding = const EdgeInsets.all(7.5),
    required this.child,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: borderRadius,
      child: InkWell(
        borderRadius: borderRadius,
        onTap: onTap,
        child: Container(
          padding: padding,
          decoration: BoxDecoration(
              borderRadius: borderRadius,
              border:
                  borderColor != null ? Border.all(color: borderColor!) : null),
          child: Center(
            child: child,
          ),
        ),
      ),
    );
  }
}

class AlertDialogWidget extends StatelessWidget {
  final List<Widget>? actionWidgets;
  final Widget? contentWidget;
  final Widget? titleWidget;
  final Color? backgroundColor;
  const AlertDialogWidget({
    super.key,
    this.actionWidgets,
    this.contentWidget,
    this.titleWidget,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: backgroundColor,
      titlePadding: AppComponents.dialogTitlePadding,
      contentPadding: AppComponents.dialogContentPadding,
      shape: const RoundedRectangleBorder(
          borderRadius: AppComponents.dialogBorderRadius),
      title: titleWidget,
      content: contentWidget,
      actions: actionWidgets,
      actionsAlignment: MainAxisAlignment.center,
      actionsPadding: AppComponents.dialogActionPadding,
      buttonPadding: EdgeInsets.zero,
    );
  }
}

class CustomStretchedOutlinedTextButtonWidget extends StatelessWidget {
  final String buttonText;
  final void Function()? onTap;
  final double minHeight;
  final double borderRadiusValue;
  const CustomStretchedOutlinedTextButtonWidget({
    super.key,
    this.onTap,
    required this.buttonText,
    this.minHeight = 62,
    this.borderRadiusValue = Constants.buttonBorderRadiusValue,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextButton(
              onPressed: onTap,
              style: OutlinedButton.styleFrom(
                // elevation: 1000,
                // shadowColor: Colors.white,
                // foregroundColor: AppColors.primaryColor,
                minimumSize: Size(30, minHeight),
                shape: RoundedRectangleBorder(
                    // side: BorderSide(color: Colors.black12),
                    side: const BorderSide(color: AppColors.primaryColor),
                    borderRadius:
                        AppComponents.borderRadius(borderRadiusValue)),
              ),
              child: Text(buttonText, textAlign: TextAlign.center)),
        ),
      ],
    );
  }
}

/// This class contains functions that return a widget
class CoreWidgets {
  /// Custom app bar widget
  static AppBar appBarWidget(
      {required BuildContext screenContext,
      Widget? titleWidget,
      List<Widget>? actions,
      bool hasBackButton = true}) {
    return AppBar(
      automaticallyImplyLeading: false,
      titleSpacing: 0,
      leading: hasBackButton
          ? Center(
              child: CustomIconButtonWidget(
                  onTap: () {
                    Get.back();
                  },
                  hasShadow: true,
                  child: SvgPicture.asset(
                    AppAssetImages.arrowLeftSVGLogoLine,
                    color: AppColors.darkColor,
                    height: 18,
                    width: 18,
                  )),
            )
          : null,
      title: titleWidget,
      actions: actions,
    );
  }

  static PagedChildBuilderDelegate<ItemType>
      pagedChildBuilderDelegate<ItemType>({
    required Widget Function(BuildContext, ItemType, int) itemBuilder,
    Widget Function(BuildContext)? errorIndicatorBuilder,
    Widget Function(BuildContext)? noItemFoundIndicatorBuilder,
    Widget Function(BuildContext)? firstPageLoadingIndicatorBuilder,
    Widget Function(BuildContext)? newPageLoadingIndicatorBuilder,
  }) {
    final firstPageProgressIndicatorBuilder =
        firstPageLoadingIndicatorBuilder ??
            (context) => const Center(child: CircularProgressIndicator());
    final newPageProgressIndicatorBuilder = newPageLoadingIndicatorBuilder ??
        (context) => const Center(child: CircularProgressIndicator());
    final pageErrorIndicatorBuilder =
        errorIndicatorBuilder ?? (context) => const ErrorPaginationWidget();
    final noItemsFoundIndicatorBuilder = noItemFoundIndicatorBuilder ??
        (context) => const ErrorPaginationWidget();
    return PagedChildBuilderDelegate<ItemType>(
        itemBuilder: itemBuilder,
        firstPageErrorIndicatorBuilder: pageErrorIndicatorBuilder,
        newPageErrorIndicatorBuilder: pageErrorIndicatorBuilder,
        noItemsFoundIndicatorBuilder: noItemsFoundIndicatorBuilder,
        firstPageProgressIndicatorBuilder: firstPageProgressIndicatorBuilder,
        newPageProgressIndicatorBuilder: newPageProgressIndicatorBuilder,
        animateTransitions: true,
        transitionDuration: const Duration(milliseconds: 200));
  }
}

class ErrorPaginationWidget extends StatelessWidget {
  final String errorMessage;
  const ErrorPaginationWidget({
    super.key,
    this.errorMessage = 'Error occurred while loading',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 150,
        width: 150,
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const ErrorLoadedIconWidget(isLargeIcon: true),
            AppGaps.hGap5,
            Text(
              errorMessage,
              textAlign: TextAlign.center,
              style: AppTextStyles.bodyMediumTextStyle,
            ),
          ],
        ));
  }
}

class ErrorLoadedIconWidget extends StatelessWidget {
  final bool isLargeIcon;
  const ErrorLoadedIconWidget({
    super.key,
    this.isLargeIcon = false,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Icon(Icons.error_outline,
            size: isLargeIcon ? 40 : null, color: AppColors.alertColor));
  }
}

class CachedNetworkImageWidget extends StatelessWidget {
  final String imageURL;
  final BoxFit boxFit;
  final int? cacheHeight;
  final int? cacheWidth;
  final String loadingAssetImageLocation;
  final Widget Function(BuildContext, ImageProvider<Object>)? imageBuilder;
  const CachedNetworkImageWidget({
    super.key,
    required this.imageURL,
    this.boxFit = BoxFit.cover,
    this.loadingAssetImageLocation = AppAssetImages.imagePlaceholderIconImage,
    this.cacheHeight,
    this.cacheWidth,
    this.imageBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return imageURL.isEmpty
        ? Image.asset(loadingAssetImageLocation, fit: BoxFit.contain)
        : CachedNetworkImage(
            imageUrl: imageURL,
            placeholder: (context, url) => LoadingImagePlaceholderWidget(
                loadingAssetImageLocation: loadingAssetImageLocation),
            errorWidget: (context, url, error) => const ErrorLoadedIconWidget(),
            imageBuilder: imageBuilder,
            memCacheHeight: cacheHeight,
            memCacheWidth: cacheWidth,
            fit: boxFit,
            cacheManager: CacheManager(Config('zero_one_supplies_cache',
                stalePeriod: const Duration(days: 2))),
          );
  }
}

class LoadingImagePlaceholderWidget extends StatelessWidget {
  final double? height;
  final double? width;
  final String loadingAssetImageLocation;
  const LoadingImagePlaceholderWidget({
    super.key,
    this.height,
    this.width,
    this.loadingAssetImageLocation = AppAssetImages.imagePlaceholderIconImage,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: LoadingPlaceholderWidget(
          child: Image.asset(loadingAssetImageLocation)),
    );
  }
}

class LoadingPlaceholderWidget extends StatelessWidget {
  final Widget child;
  final Color baseColor;
  final Color highlightColor;
  const LoadingPlaceholderWidget({
    super.key,
    required this.child,
    this.baseColor = AppColors.shimmerBaseColor,
    this.highlightColor = AppColors.shimmerHighlightColor,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: baseColor, highlightColor: highlightColor, child: child);
  }
}

class BidCountdownTimerWidget extends StatelessWidget {
  final DateTime bidEndDateTime;
  final Widget Function(BidCountdownTimerWidgetController) builder;
  const BidCountdownTimerWidget(
      {super.key, required this.bidEndDateTime, required this.builder});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BidCountdownTimerWidgetController>(
      init: BidCountdownTimerWidgetController(),
      global: false,
      builder: (controller) {
        controller.bidEndDateTime = bidEndDateTime;
        return builder(controller);
      },
    );
  }
}

class SliverListItemWidget extends StatelessWidget {
  final Widget itemWidget;
  final Widget dividerWidget;
  final int currentIndex;
  final int listLength;
  const SliverListItemWidget({
    super.key,
    required this.itemWidget,
    required this.dividerWidget,
    required this.currentIndex,
    required this.listLength,
  });

  @override
  Widget build(BuildContext context) {
    final bool showDivider = Helper.showDividerWidget(
        listCurrentIndex: currentIndex, listLength: listLength);
    return showDivider
        ? Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [itemWidget, if (showDivider) dividerWidget],
          )
        : itemWidget;
  }
}

class CartAmountsAndButtonWidget extends StatelessWidget {
  final double subtotalAmount;
  final double discountAmount;
  final double vatAmount;
  final double totalAmount;
  final double totalAmountInUSD;
  final double deliveryChargeAmount;
  final String buttonText;
  final bool showDeliveryCharge;
  final bool isLoading;
  final bool showTotalInUSD;
  final void Function()? onButtonTap;
  final List<Widget> additionalCartAmountWidgets;
  const CartAmountsAndButtonWidget({
    super.key,
    required this.subtotalAmount,
    required this.discountAmount,
    required this.vatAmount,
    required this.totalAmount,
    this.deliveryChargeAmount = 0,
    required this.buttonText,
    this.showDeliveryCharge = false,
    this.onButtonTap,
    this.additionalCartAmountWidgets = const [],
    this.isLoading = false,
    this.showTotalInUSD = false,
    this.totalAmountInUSD = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
      decoration: BoxDecoration(
          color: Color.lerp(Colors.white.withOpacity(0.5),
              Colors.white.withOpacity(0.4), 0.5),
          border: Border.all(color: Colors.white),
          borderRadius: AppComponents.defaultBorder),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppGaps.hGap6,
          CartAmountWidget(name: 'Sub total', amount: subtotalAmount),
          AppGaps.hGap8,
          CartAmountWidget(name: 'Discount', amount: discountAmount),
          AppGaps.hGap8,
          if (showDeliveryCharge)
            CartAmountWidget(
                name: 'Delivery charge', amount: deliveryChargeAmount),
          if (showDeliveryCharge) AppGaps.hGap8,
          CartAmountWidget(name: 'Vat', amount: vatAmount),
          AppGaps.hGap8,
          ...additionalCartAmountWidgets,
          AppGaps.hGap16,
          Row(
            children: [
              Text(AppLanguageTranslation.totalTransKey.toCurrentLanguage,
                  style: AppTextStyles.headLine6BoldTextStyle),
              Expanded(
                  child: Align(
                alignment: Alignment.centerRight,
                child: Text(Helper.getCurrencyFormattedAmountText(totalAmount),
                    style: AppTextStyles.headLine6BoldTextStyle),
              ))
            ],
          ),
          AppGaps.hGap16,
          if (showTotalInUSD)
            Row(
              children: [
                const Text('Total in USD',
                    style: AppTextStyles.headLine6BoldTextStyle),
                Expanded(
                    child: Align(
                  alignment: Alignment.centerRight,
                  child: Text('${totalAmountInUSD.toStringAsFixed(2)} USD',
                      style: AppTextStyles.headLine6BoldTextStyle),
                ))
              ],
            ),
          if (showTotalInUSD) AppGaps.hGap16,
          CustomStretchedTextButtonWidget(
            isLoading: isLoading,
            buttonText: buttonText,
            onTap: onButtonTap,
          ),
        ],
      ),
    );
  }
}

class CheckboxWidget extends StatelessWidget {
  final bool value;
  final void Function(bool?)? onChanged;
  const CheckboxWidget({super.key, this.value = false, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 24,
      width: 24,
      child: Checkbox(value: value, onChanged: onChanged),
    );
  }
}

class CheckboxTextWidget extends StatelessWidget {
  final bool value;
  final void Function(bool?)? onChanged;
  final String text;
  final TextStyle textStyle;
  final void Function()? onTextTap;
  const CheckboxTextWidget(
      {super.key,
      this.value = false,
      this.onChanged,
      this.text = '',
      this.textStyle = AppTextStyles.bodyTextStyle,
      this.onTextTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        CheckboxWidget(value: value, onChanged: onChanged),
        AppGaps.wGap5,
        GestureDetector(onTap: onTextTap, child: Text(text, style: textStyle)),
      ],
    );
  }
}

class RadioTextWidget extends StatelessWidget {
  final Object value;
  final Object groupValue;
  final void Function(Object?) onChanged;
  final String text;
  final TextStyle textStyle;
  final void Function()? onTextTap;
  const RadioTextWidget(
      {super.key,
      required this.value,
      required this.onChanged,
      this.text = '',
      this.textStyle = AppTextStyles.bodyTextStyle,
      this.onTextTap,
      required this.groupValue});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        CustomRadioWidget(
            value: value, groupValue: groupValue, onChanged: onChanged),
        AppGaps.wGap5,
        GestureDetector(onTap: onTextTap, child: Text(text, style: textStyle)),
      ],
    );
  }
}

class NotificationDotWidget extends StatelessWidget {
  final bool isRead;
  const NotificationDotWidget({super.key, this.isRead = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 10,
      width: 10,
      decoration: BoxDecoration(
          color: isRead
              ? AppColors.darkColor.withOpacity(0.2)
              : AppColors.primaryColor,
          shape: BoxShape.circle),
    );
  }
}

class SelectedNetworkImageWidget extends StatelessWidget {
  final String imageURL;
  final void Function()? onTap;
  final void Function()? onEditButtonTap;

  const SelectedNetworkImageWidget({
    super.key,
    required this.imageURL,
    this.onTap,
    this.onEditButtonTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // width: 140,
      child: RawButtonWidget(
        borderRadiusValue: Constants.imageBorderRadiusValue,
        onTap: onTap,
        child: Stack(
          alignment: Alignment.topRight,
          children: [
            Positioned.fill(
              child: CachedNetworkImageWidget(
                imageURL: imageURL,
                imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                      borderRadius: AppComponents.defaultBorder,
                      image: DecorationImage(
                          image: imageProvider, fit: BoxFit.cover)),
                ),
              ),
            ),
            /* Positioned(
              top: 5,
              right: 5,
              child: CustomTightIconButtonWidget(
                  icon: const LocalAssetSVGIcon(AppAssetImages.editSVGLogoSolid,
                      color: Colors.white),
                  onTap: onEditButtonTap),
            ) */
          ],
        ),
      ),
    );
  }
}

/// This icon button does not have any padding, margin around it
class CustomTightIconButtonWidget extends StatelessWidget {
  final Widget icon;
  final Function()? onTap;
  const CustomTightIconButtonWidget(
      {super.key, required this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    return IconButton(
        padding: EdgeInsets.zero,
        visualDensity: const VisualDensity(
            horizontal: VisualDensity.minimumDensity,
            vertical: VisualDensity.minimumDensity),
        onPressed: onTap,
        icon: icon);
  }
}

/// Raw button widget
class RawButtonWidget extends StatelessWidget {
  final Widget child;
  final void Function()? onTap;
  final double? borderRadiusValue;
  final Color backgroundColor;
  const RawButtonWidget({
    super.key,
    required this.child,
    this.onTap,
    this.borderRadiusValue,
    this.backgroundColor = Colors.transparent,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: backgroundColor,
      borderRadius: borderRadiusValue != null
          ? BorderRadius.all(Radius.circular(borderRadiusValue!))
          : null,
      child: InkWell(
        onTap: onTap,
        borderRadius: borderRadiusValue != null
            ? BorderRadius.all(Radius.circular(borderRadiusValue!))
            : null,
        child: child,
      ),
    );
  }
}

class NoImageAvatarWidget extends StatelessWidget {
  final String firstName;
  final String lastName;
  const NoImageAvatarWidget({
    super.key,
    required this.firstName,
    required this.lastName,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 40,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
          color: AppColors.primaryColor, shape: BoxShape.circle),
      child: Text(
        Helper.avatar2LetterUsername(firstName, lastName),
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}

class FilterItemWidget extends StatelessWidget {
  final void Function()? onTap;
  final Object value;
  final String text;
  final Object groupValue;
  final void Function(Object?) onChanged;
  const FilterItemWidget(
      {super.key,
      this.onTap,
      required this.value,
      required this.text,
      required this.groupValue,
      required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return CustomListTileWidget(
        borderRadius: AppComponents.borderRadius(8),
        paddingValue: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        onTap: onTap,
        child: RadioTextWidget(
            value: value,
            text: text,
            onChanged: onChanged,
            groupValue: groupValue));
  }
}

class ProductColorWidget extends StatelessWidget {
  final bool isSelected;
  final String name;
  final String colorHexCode;
  final void Function()? onTap;
  const ProductColorWidget({
    super.key,
    this.isSelected = false,
    this.name = '',
    this.colorHexCode = '',
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
              border: Border.all(
                  color:
                      isSelected ? AppColors.primaryColor : Colors.transparent,
                  width: 2),
              borderRadius: const BorderRadius.all(Radius.circular(12))),
          child: CustomIconButtonWidget(
              onTap: onTap,
              fixedSize: const Size(32, 32),
              borderRadiusRadiusValue: const Radius.circular(10),
              backgroundColor: Helper.getColorFromHexCode(colorHexCode),
              child: const SizedBox()),
        ),
        GestureDetector(
          onTap: onTap,
          child: Text(name,
              style: AppTextStyles.bodyTextStyle, textAlign: TextAlign.center),
        )
      ],
    );
  }
}

class EmptyScreenWidget extends StatelessWidget {
  final String localImageAssetURL;
  final bool isSVGImage;
  final String title;
  final String shortTitle;
  final double height;

  const EmptyScreenWidget({
    super.key,
    required this.localImageAssetURL,
    required this.title,
    this.shortTitle = '',
    this.height = 231,
    this.isSVGImage = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: height,
          //  width: 254,
          child: isSVGImage
              ? SvgPicture.asset(localImageAssetURL, height: 231)
              : Image.asset(localImageAssetURL),
        ),
        AppGaps.hGap32,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: AppTextStyles.titleBoldTextStyle,
              ),
              AppGaps.hGap8,
              Text(shortTitle,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.bodyLargeTextStyle),
            ],
          ),
        ),
      ],
    );
  }
}

class ProductConditionWidget extends StatelessWidget {
  final ProductConditionStatus productCondition;
  const ProductConditionWidget({super.key, required this.productCondition});

  @override
  Widget build(BuildContext context) {
    switch (productCondition) {
      case ProductConditionStatus.newStatus:
        return Container(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
            decoration: const BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.all(Radius.circular(50))),
            child: Text(productCondition.stringValueForView,
                style: AppTextStyles.bodySemiboldTextStyle
                    .copyWith(color: Colors.white)));
      case ProductConditionStatus.usedStatus:
        return Container(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
            decoration: const BoxDecoration(
                color: AppColors.secondaryColor,
                borderRadius: BorderRadius.all(Radius.circular(50))),
            child: Text(productCondition.stringValueForView,
                style: AppTextStyles.bodySemiboldTextStyle
                    .copyWith(color: Colors.white)));
      default:
        return AppGaps.emptyGap;
    }
  }
}

class VerifiedSellerTickWidget extends StatelessWidget {
  final bool isVerified;
  const VerifiedSellerTickWidget({super.key, required this.isVerified});

  @override
  Widget build(BuildContext context) {
    if (isVerified) {
      return Image.asset(AppAssetImages.tickFilled, height: 16, width: 16);
    }
    return AppGaps.emptyGap;
  }
}

class SellerStatusBadgeWidget extends StatelessWidget {
  final SellerStatus status;
  const SellerStatusBadgeWidget({
    super.key,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    switch (status) {
      case SellerStatus.best:
        return SvgPicture.asset(AppAssetImages.medalSVGLogo,
            height: 24, width: 24);
      case SellerStatus.top:
        return SvgPicture.asset(AppAssetImages.oneBadgeSVGLogo,
            height: 24, width: 24);
      case SellerStatus.newSeller:
        return SvgPicture.asset(AppAssetImages.newTextSVGLogo,
            height: 24, width: 24);
      case SellerStatus.unknown:
        return AppGaps.emptyGap;
      default:
        return AppGaps.emptyGap;
    }
  }
}

class StoreShortInfoWidget extends StatelessWidget {
  final String imageURL;
  final String storeName;
  final bool isVerified;
  final SellerStatus status;
  final String categoryName;
  final double averageRating;
  final Widget rightIconWidget;
  final bool showBadge;
  const StoreShortInfoWidget(
      {super.key,
      required this.imageURL,
      required this.storeName,
      required this.isVerified,
      required this.status,
      this.showBadge = true,
      required this.categoryName,
      required this.averageRating,
      required this.rightIconWidget});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        height: 118,
        padding: const EdgeInsets.all(8),
        child: Row(children: [
          SizedBox(
            height: 80,
            width: 80,
            child: CachedNetworkImageWidget(
                imageURL: imageURL,
                imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                        image: DecorationImage(
                          image: imageProvider,
                        ),
                      ),
                    )),
          ),
          AppGaps.wGap10,
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      storeName,
                      style: AppTextStyles.bodyLargeSemiboldTextStyle,
                    ),
                    isVerified ? AppGaps.wGap4 : AppGaps.wGap8,
                    if (isVerified)
                      Expanded(
                          child:
                              VerifiedSellerTickWidget(isVerified: isVerified)),
                    isVerified ? AppGaps.wGap4 : AppGaps.wGap8,
                    /*  if (showBadge)
                      Expanded(child: SellerStatusBadgeWidget(status: status)) */
                  ],
                ),
                AppGaps.hGap10,
                Text(
                  categoryName,
                  style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                      color: AppColors.bodyTextColor),
                ),
                AppGaps.hGap10,
                Row(
                  children: [
                    SvgPicture.asset(
                      AppAssetImages.starSVGLogoSolid,
                      color: AppColors.secondaryColor,
                    ),
                    AppGaps.wGap3,
                    Text(
                      '(${averageRating.toStringAsFixed(1)})',
                      style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: AppColors.bodyTextColor),
                    )
                  ],
                ),
                AppGaps.wGap4,
              ],
            ),
          ),
          const Spacer(),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              if (Helper.isUserLoggedIn()) rightIconWidget,
            ],
          )
        ]),
      ),
    );
  }
}

/// Custom padded body widget for scaffold
class BottomModalBodyWidget extends StatelessWidget {
  final Widget child;
  const BottomModalBodyWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
          Constants.screenPaddingValue,
          Constants.bottomSheetTopPaddingValue,
          Constants.screenPaddingValue,
          0),
      child: child,
    );
  }
}
