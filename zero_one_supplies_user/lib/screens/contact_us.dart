import 'package:ecomik/controller/contact_us_controller.dart';
import 'package:ecomik/utils/app_singleton.dart';
import 'package:ecomik/utils/constants/app_constants_import.dart';
import 'package:ecomik/utils/constants/app_language_translations.dart';
import 'package:ecomik/utils/extensions/string.dart';
import 'package:ecomik/utils/helpers/helpers.dart';
import 'package:ecomik/utils/helpers/language_helper.dart';
import 'package:ecomik/widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    /// Get screen size
    // final screenSize = MediaQuery.of(context).size;
    return GetBuilder<ContactUsScreenController>(
        init: ContactUsScreenController(),
        builder: (controller) => DecoratedBox(
              decoration: BoxDecoration(
                  color: Colors.white,
                  image: DecorationImage(
                      image:
                          Image.asset(AppAssetImages.backgroundFullPng).image,
                      fit: BoxFit.fill)),
              child: Scaffold(
                /* <-------- Empty appbar with back button --------> */
                /* <-------- Appbar --------> */
                appBar: CoreWidgets.appBarWidget(
                    screenContext: context,
                    titleWidget: Text(
                      LanguageHelper.currentLanguageText(
                          LanguageHelper.contactUsTransKey),
                      style: const TextStyle(
                          fontSize: 24, fontWeight: FontWeight.w700),
                    )),
                // appBar: CoreWidgets.appBarWidget(screenContext: context),
                /* <-------- Content --------> */
                body: Center(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: AppGaps.screenPaddingValue),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppGaps.hGap5,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                children: [
                                  Container(
                                    // margin: const EdgeInsets.all(15),
                                    height: 40,
                                    width: 40,
                                    decoration: const BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(12))),
                                    child: Padding(
                                        padding: const EdgeInsets.all(8),
                                        child: SvgPicture.asset(
                                            AppAssetImages.location)),
                                  )
                                ],
                              ),
                              AppGaps.wGap20,
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        LanguageHelper.currentLanguageText(
                                            LanguageHelper.addressTransKey),
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        AppSingleton.instance.settings.address,
                                        style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                          AppGaps.hGap15,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                children: [
                                  Container(
                                    // margin: const EdgeInsets.all(15),
                                    height: 40,
                                    width: 40,
                                    decoration: const BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(12))),
                                    child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: SvgPicture.asset(
                                            AppAssetImages.email)),
                                  )
                                ],
                              ),
                              AppGaps.wGap20,
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        LanguageHelper.currentLanguageText(
                                            LanguageHelper
                                                .emailAddressTransKey),
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        AppSingleton.instance.settings.email,
                                        style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                          AppGaps.hGap15,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                children: [
                                  Container(
                                    // margin: const EdgeInsets.all(15),
                                    height: 40,
                                    width: 40,
                                    decoration: const BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(12))),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child:
                                          SvgPicture.asset(AppAssetImages.call),
                                    ),
                                  )
                                ],
                              ),
                              AppGaps.wGap20,
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        LanguageHelper.currentLanguageText(
                                            LanguageHelper.phoneTransKey),
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        AppSingleton.instance.settings.phone,
                                        style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                          AppGaps.hGap25,
                          /* <---- User full name text field ----> */
                          Text(
                            LanguageHelper.currentLanguageText(
                                LanguageHelper.getInTouchTransKey),
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w700),
                          ),
                          AppGaps.hGap15,
                          CustomTextFormField(
                              controller: controller.firstNameController,
                              validator: controller.nameFormValidator,
                              labelText: LanguageHelper.currentLanguageText(
                                  LanguageHelper.firstNameTransKey),
                              hintText: LanguageHelper.currentLanguageText(
                                  LanguageHelper.firstNameTransKey),
                              prefixIcon: SvgPicture.asset(
                                  AppAssetImages.profileSVGLogoLine)),
                          AppGaps.hGap15,
                          CustomTextFormField(
                              controller: controller.lastNameController,
                              validator: controller.nameFormValidator,
                              labelText: LanguageHelper.currentLanguageText(
                                  LanguageHelper.lastNameTransKey),
                              hintText: LanguageHelper.currentLanguageText(
                                  LanguageHelper.lastNameTransKey),
                              prefixIcon: SvgPicture.asset(
                                  AppAssetImages.profileSVGLogoLine)),
                          AppGaps.hGap15,
                          /* <---- User full name text field ----> */
                          CustomTextFormField(
                            controller: controller.phoneController,
                            validator: Helper.phoneFormValidator,
                            labelText: LanguageHelper.currentLanguageText(
                                LanguageHelper.phoneTransKey),
                            hintText: '  +01712000000',
                            prefixIcon: SvgPicture.asset(
                                AppAssetImages.phoneSVGLogoLine),
                          ),
                          AppGaps.hGap15,
                          /* <---- User full name text field ----> */
                          CustomTextFormField(
                            controller: controller.emailController,
                            validator: Helper.emailFormValidator,
                            labelText: LanguageHelper.currentLanguageText(
                                LanguageHelper.emailAddressTransKey),
                            hintText: '  support@appstick.com.bd',
                            prefixIcon: SvgPicture.asset(
                                AppAssetImages.messageSVGLogoSolid),
                          ),
                          AppGaps.hGap15,
                          /* <---- User full name text field ----> */
                          CustomTextFormField(
                            controller: controller.subjectController,
                            validator: controller.massageFormValidator,
                            labelText: LanguageHelper.currentLanguageText(
                                LanguageHelper.subjectTransKey),
                            hintText: AppLanguageTranslation
                                .subjectSpaceBeforeTransKey.toCurrentLanguage,
                            // prefixIcon:
                            //     SvgPicture.asset(AppAssetImages.setting),
                          ),
                          AppGaps.hGap15,
                          /* <---- Email text field ----> */
                          CustomTextFormField(
                            controller: controller.massageController,
                            validator: controller.massageFormValidator,
                            labelText: LanguageHelper.currentLanguageText(
                                LanguageHelper.messageTransKey),
                            maxLines: 5,
                            hintText: AppLanguageTranslation
                                .typeYourMessageTransKey.toCurrentLanguage,
                          ),
                          AppGaps.hGap15,
                        ],
                      ),
                    ),
                  ),
                ),
                /* <-------- Bottom bar of sign up text --------> */
                bottomNavigationBar: CustomScaffoldBottomBarWidget(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      /* <---- Sign up text button ----> */
                      CustomStretchedTextButtonWidget(
                          isLoading: controller.isLoading,
                          buttonText: LanguageHelper.currentLanguageText(
                              LanguageHelper.sendMailTransKey),
                          onTap: () {
                            controller.sendMassage();
                          })
                    ],
                  ),
                ),
              ),
            ));
  }
}
