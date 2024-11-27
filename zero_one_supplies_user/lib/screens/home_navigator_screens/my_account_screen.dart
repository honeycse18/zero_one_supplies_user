import 'package:ecomik/controller/home_navigator_screen_controller/my_account_screen_controller.dart';
import 'package:ecomik/utils/constants/app_constants_import.dart';
import 'package:ecomik/utils/constants/app_language_translations.dart';
import 'package:ecomik/utils/constants/app_page_names.dart';
import 'package:ecomik/utils/extensions/string.dart';
import 'package:ecomik/utils/helpers/helpers.dart';
import 'package:ecomik/utils/helpers/language_helper.dart';
import 'package:ecomik/widgets/core_widgets.dart';
import 'package:ecomik/widgets/screen_widgets/my_account_screen_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class MyAccountScreen extends StatelessWidget {
  const MyAccountScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MyAccountScreenController>(
        init: MyAccountScreenController(),
        builder: (controller) => DecoratedBox(
              decoration: BoxDecoration(
                  color: Colors.white,
                  image: DecorationImage(
                      image:
                          Image.asset(AppAssetImages.backgroundFullPng).image,
                      fit: BoxFit.fill)),
              child: Scaffold(
                // / <-------- Appbar --------> /
                appBar: CoreWidgets.appBarWidget(
                    screenContext: context,
                    hasBackButton: false,
                    titleWidget: Text(LanguageHelper.currentLanguageText(
                        LanguageHelper.myAccountTransKey))),
                // / <-------- Content --------> /
                body: CustomScaffoldBodyWidget(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Top extra spaces
                        AppGaps.hGap15,
                        /* <---- Profile picture, name, phone number, email address
                         ----> */
                        Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // / <---- Profile picture ----> /
                              if (Helper.isUserLoggedIn())
                                Stack(
                                  clipBehavior: Clip.none,
                                  children: [
                                    // / <---- Circular profile picture widget ----> /
                                    CachedNetworkImageWidget(
                                      imageURL: controller.userDetails.image,
                                      imageBuilder: (context, imageProvider) =>
                                          CircleAvatar(
                                        backgroundImage: imageProvider,
                                        radius: 64,
                                      ),
                                    ),
                                    // CircleAvatar(
                                    //   backgroundImage: Image.asset(
                                    //     AppAssetImages.myAccountProfilePicture,
                                    //   ).image,
                                    //   radius: 64,
                                    // ),
                                    // / <---- Small edit circle icon button ----> /
                                    Positioned(
                                        bottom: 7,
                                        right: -3,
                                        child: IconButton(
                                          onPressed: () async {
                                            // Tapping on it goes to edit my account screen
                                            await Get.toNamed(AppPageNames
                                                .editMyAccountScreen);
                                            controller.getUser();
                                            controller.update();
                                          },
                                          padding: EdgeInsets.zero,
                                          constraints: const BoxConstraints(
                                              minHeight: 34, minWidth: 34),
                                          icon: Container(
                                            height: 34,
                                            width: 34,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: AppColors.primaryColor,
                                                border: Border.all(
                                                    color: Colors.white)),
                                            child: SvgPicture.asset(
                                              AppAssetImages.editSVGLogoSolid,
                                              height: 14,
                                              width: 14,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ))
                                  ],
                                ),
                              if (Helper.isUserLoggedIn()) AppGaps.hGap18,
                              // / <---- Profile name ----> /
                              if (Helper.isUserLoggedIn())
                                Text(
                                  '${controller.userDetails.firstName} ${controller.userDetails.lastName}',
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelLarge
                                      ?.copyWith(),
                                ),
                              if (Helper.isUserLoggedIn()) AppGaps.hGap8,
                              if (Helper.isUserLoggedIn())

                                // / <---- Profile phone number ----> /
                                Text(controller.userDetails.phone,
                                    style: const TextStyle(
                                        color: AppColors.bodyTextColor)),
                              if (Helper.isUserLoggedIn()) AppGaps.hGap5,
                              // / <---- Profile email address ----> /
                              if (Helper.isUserLoggedIn())
                                Text('mail to: ${controller.userDetails.email}',
                                    style: const TextStyle(
                                        color: AppColors.bodyTextColor)),
                              if (Helper.isUserLoggedIn()) AppGaps.hGap32,
                              // / <---- Horizontal dashed line ----> /
                              if (Helper.isUserLoggedIn())
                                CustomHorizontalDashedLineWidget(
                                    color:
                                        AppColors.darkColor.withOpacity(0.1)),
                              if (Helper.isUserLoggedIn()) AppGaps.hGap32,
                              if (Helper.isUserLoggedIn())
                                RawButtonWidget(
                                  child: Text("BTN"),
                                  onTap: () {
                                    Get.toNamed(AppPageNames
                                        .deliveryRequestDetailsScreen);
                                  },
                                ),
                              if (Helper.isUserLoggedIn()) AppGaps.hGap32,
                              // / <---- 'Save address' list tile button ----> /
                              if (Helper.isUserLoggedIn())
                                CustomListTileMyAccountWidget(
                                    text: AppLanguageTranslation
                                        .deliveryRequestTransKey
                                        .toCurrentLanguage,
                                    icon: SvgPicture.asset(
                                      AppAssetImages.actionBids,
                                      color: AppColors.primaryColor,
                                      height: 24,
                                      width: 24,
                                    ),
                                    onTap: () {
                                      Get.toNamed(
                                          AppPageNames.deliveryRequestScreen);
                                    }),

                              if (Helper.isUserLoggedIn()) AppGaps.hGap32,
                              // / <---- 'Save address' list tile button ----> /
                              if (Helper.isUserLoggedIn())
                                CustomListTileMyAccountWidget(
                                    text: LanguageHelper.currentLanguageText(
                                        LanguageHelper.myAuctionBidTransKey),
                                    icon: SvgPicture.asset(
                                      AppAssetImages.actionBids,
                                      color: AppColors.primaryColor,
                                      height: 24,
                                      width: 24,
                                    ),
                                    onTap: () {
                                      Get.toNamed(AppPageNames.bidAuction);
                                    }),
                              if (Helper.isUserLoggedIn()) AppGaps.hGap24,
                              /* <---- 'Save address' list tile button ----> */
                              if (Helper.isUserLoggedIn())
                                CustomListTileMyAccountWidget(
                                    text: LanguageHelper.currentLanguageText(
                                        LanguageHelper.myOrderTransKey),
                                    icon: SvgPicture.asset(
                                      AppAssetImages.orders,
                                      color: AppColors.primaryColor,
                                      height: 24,
                                      width: 24,
                                    ),
                                    onTap: () {
                                      Get.toNamed(AppPageNames.myOrdersScreen);
                                    }),
                              if (Helper.isUserLoggedIn()) AppGaps.hGap24,
                              /* <---- 'Save address' list tile button ----> */
                              if (Helper.isUserLoggedIn())
                                CustomListTileMyAccountWidget(
                                    text: AppLanguageTranslation
                                        .sendOffersTransKey.toCurrentLanguage,
                                    icon: SvgPicture.asset(
                                      AppAssetImages.sendOffer,
                                      color: AppColors.primaryColor,
                                      height: 24,
                                      width: 24,
                                    ),
                                    onTap: () {
                                      Get.toNamed(
                                          AppPageNames.sendOfferListScreen);
                                    }),
                              if (Helper.isUserLoggedIn()) AppGaps.hGap24,
                              // / <---- 'My wallet' list tile button ----> /
                              /* CustomListTileMyAccountWidget(
                                  text: 'My wallet',
                                  icon: SvgPicture.asset(
                                    AppAssetImages.walletSVGLogoDualTone,
                                    color: AppColors.primaryColor,
                                    height: 24,
                                    width: 24,
                                  ),
                                  onTap: () {
                                    Get.toNamed(AppPageNames.myWalletScreen);
                                  }),
                              AppGaps.hGap32, */
                              /* <---- 'Save address' list tile button ----> */
                              if (Helper.isUserLoggedIn())
                                CustomListTileMyAccountWidget(
                                    text: LanguageHelper.currentLanguageText(
                                        LanguageHelper.savedAddressTransKey),
                                    icon: SvgPicture.asset(
                                      AppAssetImages.locationSVGLogoDualTone,
                                      color: AppColors.primaryColor,
                                      height: 24,
                                      width: 24,
                                    ),
                                    onTap: () {
                                      Get.toNamed(
                                          AppPageNames.savedAddressScreen);
                                    }),
                              if (Helper.isUserLoggedIn()) AppGaps.hGap24,
                              /* <---- 'Save address' list tile button ----> */
                              if (Helper.isUserLoggedIn())
                                CustomListTileMyAccountWidget(
                                    text: LanguageHelper.currentLanguageText(
                                        LanguageHelper.wishlistTransKey),
                                    icon: SvgPicture.asset(
                                      AppAssetImages.wishlist,
                                      color: AppColors.primaryColor,
                                      height: 24,
                                      width: 24,
                                    ),
                                    onTap: () {
                                      Get.toNamed(AppPageNames.wishlistScreen);
                                    }),
                              if (Helper.isUserLoggedIn()) AppGaps.hGap24,
                              /* <---- 'Settings' list tile button ----> */
                              CustomListTileMyAccountWidget(
                                  text: LanguageHelper.currentLanguageText(
                                      LanguageHelper.settingsTransKey),
                                  icon: SvgPicture.asset(
                                    AppAssetImages.settingSVGLogoDualTone,
                                    color: AppColors.primaryColor,
                                    height: 24,
                                    width: 24,
                                  ),
                                  onTap: () async {
                                    await Get.toNamed(
                                        AppPageNames.settingsScreen);
                                    controller.update();
                                  }),
                              // AppGaps.hGap24,
                              // /* <---- 'Settings' list tile button ----> */
                              // CustomListTileMyAccountWidget(
                              //     text: 'Support Ticket',
                              //     icon: SvgPicture.asset(
                              //       AppAssetImages.supportTicket,
                              //       color: AppColors.primaryColor,
                              //       height: 24,
                              //       width: 24,
                              //     ),
                              //     onTap: () {
                              //       Get.toNamed(AppPageNames.supportScreen);
                              //     }),
                              if (Helper.isUserLoggedIn()) AppGaps.hGap24,
                              // / <---- 'Terms & conditions' list tile button ----> /
                              if (Helper.isUserLoggedIn())
                                CustomListTileMyAccountWidget(
                                    text: LanguageHelper.currentLanguageText(
                                        LanguageHelper.contactUsTransKey),
                                    icon: SvgPicture.asset(
                                      AppAssetImages.map,
                                      color: AppColors.primaryColor,
                                      height: 24,
                                      width: 24,
                                    ),
                                    onTap: () {
                                      Get.toNamed(AppPageNames.contactUsScreen);
                                    }),

                              AppGaps.hGap24,
                              // / <---- 'Settings' list tile button ----> /
                              CustomListTileMyAccountWidget(
                                  text: LanguageHelper.currentLanguageText(
                                      LanguageHelper.aboutUsTransKey),
                                  icon: SvgPicture.asset(
                                    AppAssetImages.information,
                                    color: AppColors.primaryColor,
                                    height: 24,
                                    width: 24,
                                  ),
                                  onTap: () {
                                    Get.toNamed(AppPageNames.aboutUsScreen);
                                  }),
                              AppGaps.hGap24,
                              CustomListTileMyAccountWidget(
                                  text: LanguageHelper.currentLanguageText(
                                      LanguageHelper.termsConditionTransKey),
                                  icon: SvgPicture.asset(
                                    AppAssetImages.bookmarkSVGLogoDualTone,
                                    color: AppColors.primaryColor,
                                    height: 24,
                                    width: 24,
                                  ),
                                  onTap: () {
                                    Get.toNamed(
                                        AppPageNames.termsConditionScreen);
                                  }),
                              /* AppGaps.hGap24,
                              // / <---- 'Help & support' list tile button ----> /
                              CustomListTileMyAccountWidget(
                                  text: 'Help & support',
                                  icon: SvgPicture.asset(
                                    AppAssetImages.sendSVGLogoDualTone,
                                    color: AppColors.primaryColor,
                                    height: 24,
                                    width: 24,
                                  ),
                                  onTap: () {
                                    Get.toNamed(AppPageNames
                                        .singleProductReviewsScreen);
                                  }), */
                              AppGaps.hGap24,
                              // / <---- 'Settings' list tile button ----> /
                              CustomListTileMyAccountWidget(
                                  text: LanguageHelper.currentLanguageText(
                                      LanguageHelper.policyTransKey),
                                  icon: SvgPicture.asset(
                                    AppAssetImages.shieldTick,
                                    color: AppColors.primaryColor,
                                    height: 24,
                                    width: 24,
                                  ),
                                  onTap: () {
                                    Get.toNamed(AppPageNames.policyScreen);
                                  }),
                              if (Helper.isUserLoggedIn()) AppGaps.hGap24,
                              // / <---- 'Settings' list tile button ----> /
                              if (Helper.isUserLoggedIn())
                                CustomListTileMyAccountWidget(
                                    text: LanguageHelper.currentLanguageText(
                                        LanguageHelper.deleteAccountTransKey),
                                    icon: SvgPicture.asset(
                                      AppAssetImages.deleteSvg,
                                      color: AppColors.primaryColor,
                                      height: 24,
                                      width: 24,
                                    ),
                                    onTap: () {
                                      Get.toNamed(
                                          AppPageNames.deleteAccountScreen);
                                    }),
                              if (Helper.isUserLoggedIn()) AppGaps.hGap24,
                              // / <---- 'Sign out' list tile button ----> /
                              if (Helper.isUserLoggedIn())
                                CustomListTileMyAccountWidget(
                                    text: LanguageHelper.currentLanguageText(
                                        LanguageHelper.signOutTransKey),
                                    icon: SvgPicture.asset(
                                      AppAssetImages.logoutSVGLogoDualTone,
                                      color: AppColors.primaryColor,
                                      height: 24,
                                      width: 24,
                                    ),
                                    onTap: () {
                                      // Get.toNamed(context, AppPageNames.signInScreen);
                                      Helper.logout();
                                    }),
                              // Bottom extra spaces
                              AppGaps.hGap24,
                              if (!Helper.isUserLoggedIn())
                                CustomListTileMyAccountWidget(
                                    text: LanguageHelper.currentLanguageText(
                                        LanguageHelper.signInTransKey),
                                    icon: SvgPicture.asset(
                                      AppAssetImages.loginSvg,
                                      color: AppColors.primaryColor,
                                      height: 24,
                                      width: 24,
                                    ),
                                    onTap: () async {
                                      Helper.gotoSignInScreen(true);
                                    }),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ));
  }
}
