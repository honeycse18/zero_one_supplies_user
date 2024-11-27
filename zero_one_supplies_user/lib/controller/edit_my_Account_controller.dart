import 'dart:convert';
import 'dart:developer';

import 'package:ecomik/models/api_responses/edit_accound_response.dart';
import 'package:ecomik/models/api_responses/single_image_upload_response.dart';
import 'package:ecomik/models/api_responses/vendor_details_response.dart';
import 'package:ecomik/models/enums.dart';
import 'package:ecomik/utils/api_repo.dart';
import 'package:ecomik/utils/constants/app_components.dart';
import 'package:ecomik/utils/constants/app_constants.dart';
import 'package:ecomik/utils/constants/app_language_translations.dart';
import 'package:ecomik/utils/extensions/datetime.dart';
import 'package:ecomik/utils/extensions/string.dart';
import 'package:ecomik/utils/helpers/api_helper.dart';
import 'package:ecomik/utils/helpers/helpers.dart';
import 'package:ecomik/utils/helpers/image_picker_helper.dart';
import 'package:ecomik/widgets/dialogs.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart' as image_picker;

class EditMyAccountScreenController extends GetxController {
  UserDetails userDetails = UserDetails.empty();
  final RxBool _isLoading = false.obs;
  bool get isLoading => _isLoading.value;
  set isLoading(bool value) {
    _isLoading.value = value;
    update();
  }

  List<String> genderOptions = [
    AppLanguageTranslation.maleTransKey.toCurrentLanguage,
    AppLanguageTranslation.femaleTransKey.toCurrentLanguage
  ];

  DateTime selectedBirthDate = AppComponents.defaultUnsetDateTime;
  final GlobalKey<FormState> userUpdateProfileFormKey = GlobalKey<FormState>();

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController dateOfBirthController = TextEditingController();
  // TextEditingController genderController = TextEditingController();
  String? selectedGender = Constants.userGenderMale;
  // Need to update this line later...
  // String imageURI =
  //     'https://appstick-resources.s3.ap-southeast-1.amazonaws.com/01supplies/store/6458942906c88c812ed2ec60/image.jpg';

  Future<void> updateUser() async {
    final UserDetails currentUserUpdated = Helper.getUser();
    currentUserUpdated.firstName = firstNameController.text;
    currentUserUpdated.lastName = lastNameController.text;
    currentUserUpdated.email = emailController.text;
    currentUserUpdated.image = userDetails.image;
    currentUserUpdated.phone = phoneController.text;
    currentUserUpdated.birthday = APIHelper.getSafeDateTimeValue(
        selectedBirthDate.toServerDateTimeFormatted);
    currentUserUpdated.gender =
        UserGender.toEnumValueFromViewable(selectedGender ?? '').stringValue;
    await Helper.setLoggedInUserToLocalStorage(currentUserUpdated);
  }

  String? nameFormValidator(String? name) {
    if (name != null) {
      if (name.isEmpty) {
        return AppLanguageTranslation.canNotBeEmptyTransKey.toCurrentLanguage;
      }
      if (name.length < 3) {
        return AppLanguageTranslation.canNotBeEmptyTransKey.toCurrentLanguage;
      }
    }
    return null;
  }
/* 
  String? emailFormValidator(String? text) {
    if (text != null) {
      if (!GetUtils.isEmail(text)) {
        return 'Invalid email format';
      }
      return null;
    }
    return null;
  } */

  String? phoneFormValidator(String? text) {
    if (text != null) {
      if (!GetUtils.isPhoneNumber(text)) {
        return AppLanguageTranslation
            .invalidPhoneFormatTransKey.toCurrentLanguage;
      }
      return null;
    }
    return null;
  }

  void onSaveChangesButtonTap() {
    if (userUpdateProfileFormKey.currentState?.validate() ?? false) {
      saveChanges();
    } else {
      AppDialogs.showErrorDialog(
          messageText: AppLanguageTranslation
              .somethingWrongFixThemFirstTransKey.toCurrentLanguage);
    }
  }

  void onBirthDateTap(BuildContext context) async {
    DateTime? selectedDate;
    try {
      selectedDate = await showDatePicker(
          context: context,
          initialDate: userDetails.birthday,
          firstDate: DateTime(DateTime.now().year - 100),
          lastDate: DateTime.now());
    } catch (e) {
      selectedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(DateTime.now().year - 100),
          lastDate: DateTime.now());
    }
    if (selectedDate == null) {
      return;
    }
    selectedBirthDate = selectedDate;
    dateOfBirthController.text = Helper.ddMMyyFormattedDateTime(selectedDate);
    update();
  }

  void userProfileImageAdd() {
    pickUserImage();
  }

  void pickUserImage() async {
    final image_picker.XFile? pickedImage =
        await ImagePickerHelper.getPhoneImage();
    if (pickedImage == null) {
      return;
    }
    processUserProfileImage(pickedImage);
    AppDialogs.showImageProcessingDialog();
  }

  void processUserProfileImage(image_picker.XFile pickedImage) async {
    Uint8List? processedImage =
        await ImagePickerHelper.getProcessedImage(pickedImage);
    if (processedImage == null) {
      AppDialogs.showErrorDialog(
          messageText: AppLanguageTranslation
              .errorOccurredWhileProcessingImageTransKey.toCurrentLanguage);
      return;
    }
    if (Get.isDialogOpen ?? false) {
      Get.back();
    }
    Object? confirmResponse = await AppDialogs.showConfirmDialog(
      shouldCloseDialogOnceYesTapped: false,
      messageText: AppLanguageTranslation
          .areYouSureToSetProfileImageTransKey.toCurrentLanguage,
      onYesTap: () async {
        return Get.back(result: true);
      },
    );
    if (confirmResponse is bool && confirmResponse) {
      String imageFileName = '';
      String id = '';
      Uri? logoUri = Uri.tryParse(userDetails.image);
      if (logoUri != null) {
        if (logoUri.pathSegments.length >= 2) {}
      }
      APIHelper.uploadSingleImage(
          processedImage, onUploadUserProfileImageSuccess,
          imageFileName: imageFileName, id: id);
    }
  }

  void onUploadUserProfileImageSuccess(
      SingleImageUploadResponse response, Map<String, dynamic> extras) {
    userDetails.image = response.data;
    update();
    Helper.showSnackBar(AppLanguageTranslation
        .successfullyUploadedProfileImageTransKey.toCurrentLanguage);
  }

  Future<void> saveChanges() async {
    final Map<String, Object> requestBody = {
      'first_name': firstNameController.text,
      'last_name': lastNameController.text,
      'email': emailController.text,
      'image': userDetails.image,
      'phone': phoneController.text,
      'birthday': APIHelper.toServerDateTimeFormattedStringFromDateTime(
          selectedBirthDate),
      'gender':
          UserGender.toEnumValueFromViewable(selectedGender ?? '').stringValue,
    };
    String requestBodyJson = jsonEncode(requestBody);
    isLoading = true;
    EditAccountResponse? response = await APIRepo.editAccount(requestBodyJson);
    isLoading = false;
    if (response == null) {
      APIHelper.onError(response?.msg);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    }
    log(response.toJson().toString());
    onSuccessEditingAccountResponse(response);
  }

  void onSuccessEditingAccountResponse(EditAccountResponse response) async {
    await updateUser();
    fillUserDetails();
    update();
    AppDialogs.showSuccessDialog(
        messageText: AppLanguageTranslation
            .accountUpdatedSuccessfullyTransKey.toCurrentLanguage);

    // Get.offNamed(AppPageNames.myAccountScreen);
  }

  void fillUserDetails() {
    userDetails = Helper.getUser();
    firstNameController.text = userDetails.firstName;
    lastNameController.text = userDetails.lastName;
    emailController.text = userDetails.email;
    phoneController.text = userDetails.phone;
    dateOfBirthController.text =
        Helper.ddMMyyFormattedDateTime(userDetails.birthday);
    selectedGender = _setSelectedGender();
    // currentUserUpdated.image = imageURI;
  }

  String _setSelectedGender() {
    if (UserGender.toEnumValue(userDetails.gender) == UserGender.unknown) {
      return UserGender.male.stringValueForView;
    }
    return UserGender.toEnumValue(userDetails.gender).stringValueForView;
  }

  @override
  void onInit() {
    fillUserDetails();
    super.onInit();
  }
}
