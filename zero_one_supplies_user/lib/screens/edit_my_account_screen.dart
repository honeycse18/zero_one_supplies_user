import 'package:ecomik/controller/edit_my_Account_controller.dart';
import 'package:ecomik/utils/constants/app_constants_import.dart';
import 'package:ecomik/utils/constants/app_language_translations.dart';
import 'package:ecomik/utils/extensions/string.dart';
import 'package:ecomik/utils/helpers/helpers.dart';
import 'package:ecomik/widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class EditMyAccountScreen extends StatelessWidget {
  const EditMyAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EditMyAccountScreenController>(
        init: EditMyAccountScreenController(),
        builder: (controller) => DecoratedBox(
              decoration: BoxDecoration(
                  color: Colors.white,
                  image: DecorationImage(
                      image:
                          Image.asset(AppAssetImages.backgroundFullPng).image,
                      fit: BoxFit.fill)),
              child: Scaffold(
                /* <-------- Appbar --------> */
                appBar: CoreWidgets.appBarWidget(
                    screenContext: context,
                    hasBackButton: true,
                    titleWidget: Text(AppLanguageTranslation
                        .editAccountTransKey.toCurrentLanguage)),
                /* <-------- Content --------> */
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
                          child: Form(
                            key: controller.userUpdateProfileFormKey,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Stack(
                                  clipBehavior: Clip.none,
                                  children: [
                                    /* <---- Profile picture ----> */
                                    CachedNetworkImageWidget(
                                      imageURL: controller.userDetails.image,
                                      imageBuilder: (context, imageProvider) =>
                                          CircleAvatar(
                                        backgroundImage: imageProvider,
                                        radius: 64,
                                      ),
                                    ),
                                    /* <---- Small camera circle icon button ----> */
                                    Positioned(
                                        bottom: 7,
                                        right: -3,
                                        child: IconButton(
                                          onPressed: () {
                                            controller.userProfileImageAdd();
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
                                              AppAssetImages.cameraSVGLogoSolid,
                                              height: 14,
                                              width: 14,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ))
                                  ],
                                ),
                                AppGaps.hGap18,
                                /* <---- Profile name ----> */
                                Text(
                                  '${controller.userDetails.firstName} ${controller.userDetails.lastName}',
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelLarge
                                      ?.copyWith(),
                                ),
                                AppGaps.hGap8,
                                /* <---- Profile phone number ----> */
                                Text(controller.userDetails.phone,
                                    style: const TextStyle(
                                        color: AppColors.bodyTextColor)),
                                AppGaps.hGap5,
                                /* <---- Profile email address ----> */
                                Text(controller.userDetails.email,
                                    style: const TextStyle(
                                        color: AppColors.bodyTextColor)),
                                AppGaps.hGap32,
                                CustomHorizontalDashedLineWidget(
                                    color:
                                        AppColors.darkColor.withOpacity(0.1)),
                                AppGaps.hGap32,
                                /* <---- Edit your name ----> */
                                CustomTextFormField(
                                    controller: controller.firstNameController,
                                    validator: controller.nameFormValidator,
                                    labelText: AppLanguageTranslation
                                        .firstNameTransKey.toCurrentLanguage,
                                    hintText: AppLanguageTranslation
                                        .firstNameTransKey.toCurrentLanguage,
                                    prefixIcon: SvgPicture.asset(
                                        AppAssetImages.profileSVGLogoLine)),
                                AppGaps.hGap32,
                                /* <---- Edit your name ----> */
                                CustomTextFormField(
                                    controller: controller.lastNameController,
                                    validator: controller.nameFormValidator,
                                    labelText: AppLanguageTranslation
                                        .lastNameTransKey.toCurrentLanguage,
                                    hintText: AppLanguageTranslation
                                        .lastNameTransKey.toCurrentLanguage,
                                    prefixIcon: SvgPicture.asset(
                                        AppAssetImages.profileSVGLogoLine)),
                                AppGaps.hGap24,
                                /* <---- Edit your email address ----> */
                                CustomTextFormField(
                                    controller: controller.emailController,
                                    validator: Helper.emailFormValidator,
                                    labelText: AppLanguageTranslation
                                        .emailAddressTransKey.toCurrentLanguage,
                                    hintText: 'support@appstick.com.bd',
                                    prefixIcon: SvgPicture.asset(
                                        AppAssetImages.messageSVGLogoLine)),
                                AppGaps.hGap24,
                                /* <---- Edit your phone number ----> */
                                CustomTextFormField(
                                    controller: controller.phoneController,
                                    validator: controller.phoneFormValidator,
                                    labelText: AppLanguageTranslation
                                        .phoneNumberTransKey.toCurrentLanguage,
                                    hintText: AppLanguageTranslation
                                        .phoneNumberTransKey.toCurrentLanguage,
                                    prefixIcon: SvgPicture.asset(
                                        AppAssetImages.phoneSVGLogoLine)),
                                AppGaps.hGap24,
                                /* <---- Edit your date of birth ----> */
                                CustomTextFormField(
                                    controller:
                                        controller.dateOfBirthController,
                                    isReadOnly: true,
                                    onTap: () =>
                                        controller.onBirthDateTap(context),
                                    labelText: AppLanguageTranslation
                                        .dateOfBirthTransKey.toCurrentLanguage,
                                    hintText: '28-10-96',
                                    prefixIcon: SvgPicture.asset(
                                        AppAssetImages.calenderSVGLogoLine)),

                                AppGaps.hGap24,
                                /* <---- Edit your email address ----> */
                                DropdownButtonFormFieldWidget<String>(
                                  labelText: AppLanguageTranslation
                                      .genderTransKey.toCurrentLanguage,
                                  hintText: AppLanguageTranslation
                                      .maleTransKey.toCurrentLanguage,
                                  value: controller.selectedGender,
                                  prefixIcon: SvgPicture.asset(
                                      AppAssetImages.profileSVGLogoLine),
                                  items: controller.genderOptions,
                                  getItemText: (value) => value,
                                  onChanged: (value) {
                                    controller.selectedGender = value!;
                                    controller.update();
                                  },
                                ),
                                // Bottom extra spaces
                                AppGaps.hGap30,
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                /* <-------- Bottom bar --------> */
                bottomNavigationBar: CustomScaffoldBottomBarWidget(
                    child: CustomStretchedButtonWidget(
                  isLoading: controller.isLoading,
                  onTap: () {
                    controller.onSaveChangesButtonTap();
                  },
                  child: Text(AppLanguageTranslation
                      .saveChangesTransKey.toCurrentLanguage),
                )),
              ),
            ));
  }
}
