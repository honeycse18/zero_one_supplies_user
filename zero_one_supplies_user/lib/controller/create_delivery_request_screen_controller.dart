import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:collection/collection.dart';
import 'package:ecomik/models/api_responses/vendor_details_response.dart';
import 'package:ecomik/models/enums.dart';
import 'package:ecomik/utils/constants/app_colors.dart';
import 'package:ecomik/utils/constants/app_gaps.dart';
import 'package:ecomik/utils/constants/app_images.dart';
import 'package:ecomik/utils/constants/app_language_translations.dart';
import 'package:ecomik/utils/constants/app_text_styles.dart';
import 'package:ecomik/utils/extensions/string.dart';
import 'package:ecomik/utils/helpers/api_helper.dart';
import 'package:ecomik/utils/helpers/helpers.dart';
import 'package:ecomik/utils/helpers/language_helper.dart';
import 'package:ecomik/widgets/core_widgets.dart';
import 'package:ecomik/widgets/dialogs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class CreateDeliveryRequestScreenController extends GetxController {
  UserDetails userDetails = UserDetails.empty();
  String carId = '';
  bool _shouldPop = false;
  bool get shouldPop => _shouldPop;
  set shouldPop(bool value) {
    _shouldPop = value;
    update();
  }

  final GlobalKey<FormState> addCarFstFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> addCarSecondFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> addCarThirdFormKey = GlobalKey<FormState>();
  Rx<AddDeliveryRequestTabState> addDeliveryRequestTabState =
      AddDeliveryRequestTabState.step1.obs;
  var isLoading = false.obs;
  List<String> galleryImageURLs = [];
  List<dynamic> selectedVehicleImageURLs = [];
  List<dynamic> selectedDocumentsImageURLs = [];

  bool hasAC = false;

  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController senderNameTextEditingController =
      TextEditingController();
  TextEditingController senderNumberTextEditingController =
      TextEditingController();
  TextEditingController receiverEmailTextEditingController =
      TextEditingController();
  TextEditingController receiverNameTextEditingController =
      TextEditingController();
  TextEditingController receiverPhoneTextEditingController =
      TextEditingController();

  final RxBool isSubmitAddDeliveryRequestLoading = false.obs;
  final RxBool isAddDeliveryRequestDetailsLoading = false.obs;

  void onUploadAddVehicleImageTap({bool forVehicle = true}) {
    Helper.pickImages(
        onSuccessUploadSingleImage: forVehicle
            ? _onSuccessOnUploadAddGalleryImageTap
            : _onSuccessOnUploadAddDocumentsImageTap,
        imageName: 'Upload Image');
  }

  void _onSuccessOnUploadAddGalleryImageTap(
      List<Uint8List> rawImagesData, Map<String, dynamic> additionalData) {
    selectedVehicleImageURLs
        .addAll(rawImagesData.map((e) => e as dynamic).toList());
    update();
    Helper.showSnackBar(
        AppLanguageTranslation.updateThumbImageTransKey.toCurrentLanguage);
  }

  void _onSuccessOnUploadAddDocumentsImageTap(
      List<Uint8List> rawImagesData, Map<String, dynamic> additionalData) {
    selectedDocumentsImageURLs
        .addAll(rawImagesData.map((e) => e as dynamic).toList());
    update();
    Helper.showSnackBar(
        AppLanguageTranslation.updateThumbImageTransKey.toCurrentLanguage);
  }

  void onUploadDeleteVehicleImageTap(int index) {
    try {
      selectedVehicleImageURLs.removeAt(index);
      update();
      Helper.showSnackBar(
          AppLanguageTranslation.removeThumbImageTransKey.toCurrentLanguage);
    } catch (e) {
      APIHelper.onError(
          AppLanguageTranslation.wrongThumbImageTransKey.toCurrentLanguage);
      return;
    }
  }

  void onUploadDeleteDocumentImageTap(int index) {
    try {
      selectedDocumentsImageURLs.removeAt(index);
      update();
      Helper.showSnackBar(
          AppLanguageTranslation.removeThumbImageTransKey.toCurrentLanguage);
    } catch (e) {
      APIHelper.onError(
          AppLanguageTranslation.wrongThumbImageTransKey.toCurrentLanguage);
      return;
    }
  }

  void onSubmitButtonTap() {
    // if (validateAddVehicle()) {
    //   addVehicle();
    // }
  }

  @override
  void onInit() async {
    userDetails = Helper.getUser();
    super.onInit();
  }

  List<Widget> step1TabContentWidgets() {
    return [
      Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextFormField(
              isReadOnly: true,
              controller: emailTextEditingController,
              // labelText: 'Email address',
              labelText: 'Sender Name',
              hintText: '  ${userDetails.firstName} ${userDetails.lastName}',
              prefixIcon: const Icon(Icons.person),
            ),
            AppGaps.hGap20,
            CustomTextFormField(
              isReadOnly: true,

              controller: emailTextEditingController,
              // labelText: 'Email address',
              labelText: 'Sender Phone',
              hintText: userDetails.phone,
              prefixIcon: const Icon(Icons.phone),
            ),
            AppGaps.hGap10,
          ])
    ];
  }

  List<Widget> step2TabContentWidgets() {
    return [
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        CustomTextFormField(
          controller: emailTextEditingController,
          // labelText: 'Email address',
          labelText: 'Receiver Name',
          hintText: 'Enter Receiver Name',
        ),
        AppGaps.hGap20,
        CustomTextFormField(
          controller: emailTextEditingController,
          // labelText: 'Email address',
          labelText: 'Receiver Email',
          hintText: 'Enter Receiver Email',
        ),
        AppGaps.hGap16,
        CustomTextFormField(
          controller: emailTextEditingController,
          // labelText: 'Email address',
          labelText: 'Receiver Phone',
          hintText: 'Enter Receiver Phone Number',
        ),
      ])
    ];
  }

  List<Widget> step3TabContentWidgets() {
    return [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextFormField(
            controller: emailTextEditingController,
            // labelText: 'Email address',
            labelText: 'Weight(KG)',
            hintText: 'Enter weight',
          ),
          AppGaps.hGap20,
          Text('Dimension (cm)'),
          AppGaps.hGap10,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: CustomTextFormField(
                  controller: emailTextEditingController,
                  // labelText: 'Email address',

                  hintText: 'Enter Height',
                ),
              ),
              AppGaps.wGap10,
              Expanded(
                child: CustomTextFormField(
                  controller: emailTextEditingController,
                  // labelText: 'Email address',

                  hintText: 'Enter Width',
                ),
              ),
              AppGaps.wGap10,
              Expanded(
                child: CustomTextFormField(
                  controller: emailTextEditingController,
                  // labelText: 'Email address',

                  hintText: 'Enter width',
                ),
              ),
            ],
          ),
          AppGaps.hGap30,
          selectedDocumentsImageURLs.isEmpty
              ? MultiImageUploadSectionWidget(
                  label: 'Product Image (Optional)',
                  isRequired: true,
                  imageURLs: galleryImageURLs,
                  onImageUploadTap: () =>
                      onUploadAddVehicleImageTap(forVehicle: false),
                )
              : SelectedLocalImageWidget(
                  label: 'Product Image (Optional)',
                  isRequired: true,
                  imageURLs: galleryImageURLs,
                  onImageUploadTap: () =>
                      onUploadAddVehicleImageTap(forVehicle: false),
                  imagesBytes: selectedDocumentsImageURLs,
                  onImageDeleteTap: onUploadDeleteDocumentImageTap,
                ),
          AppGaps.hGap10,
        ],
      )
    ];
  }

  List<Widget> completeTabContentWidgets() {
    return [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Delivery Summary',
            style: AppTextStyles.headLine6MediumTextStyle,
          ),
        ],
      )
    ];
  }

  List<Widget> currentOrderDetailsTabContentWidgets(
      AddDeliveryRequestTabState addDeliveryRequestTabState) {
    switch (addDeliveryRequestTabState) {
      case AddDeliveryRequestTabState.step1:
        return step1TabContentWidgets();
      case AddDeliveryRequestTabState.step2:
        return step2TabContentWidgets();
      case AddDeliveryRequestTabState.step3:
        return step3TabContentWidgets();
      case AddDeliveryRequestTabState.step4:
        return completeTabContentWidgets();
      default:
        return step1TabContentWidgets();
    }
  }

  Widget currentAddDeliveryRequestTabBottomButtonWidget(
      AddDeliveryRequestTabState addDeliveryRequestStateValue) {
    Map<AddDeliveryRequestTabState, Widget> addDeliveryRequestStateWidgetMap = {
      AddDeliveryRequestTabState.step1: isSubmitAddDeliveryRequestLoading.value
          ? const EnrollPaymentButtonLoadingWidget()
          : StretchedTextButtonWidget(
              buttonText: AppLanguageTranslation.nextTransKey.toCurrentLanguage,
              onTap: () async {
                // await submitOrderCreate();

                addDeliveryRequestTabState.value =
                    AddDeliveryRequestTabState.step2;
              }),
      AddDeliveryRequestTabState.step2: isAddDeliveryRequestDetailsLoading.value
          ? const EnrollPaymentButtonLoadingWidget()
          : StretchedTextButtonWidget(
              buttonText: AppLanguageTranslation.nextTransKey.toCurrentLanguage,
              onTap: () async {
                addDeliveryRequestTabState.value =
                    AddDeliveryRequestTabState.step3;
              }),
      AddDeliveryRequestTabState.step3: isAddDeliveryRequestDetailsLoading.value
          ? const EnrollPaymentButtonLoadingWidget()
          : StretchedTextButtonWidget(
              buttonText: AppLanguageTranslation.nextTransKey.toCurrentLanguage,
              onTap: () async {
                addDeliveryRequestTabState.value =
                    AddDeliveryRequestTabState.step4;
              }),
      AddDeliveryRequestTabState.step4: isAddDeliveryRequestDetailsLoading.value
          ? const EnrollPaymentButtonLoadingWidget()
          : StretchedTextButtonWidget(
              buttonText:
                  AppLanguageTranslation.submitTransKey.toCurrentLanguage,
              onTap: onSubmitButtonTap),
    };
    return addDeliveryRequestStateWidgetMap[addDeliveryRequestStateValue] ??
        Text('Empty');
  }
}
