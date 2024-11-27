import 'dart:convert';
import 'dart:developer';

// import 'package:ecomik/models/api_responses/t/signin_response.dart';
// import 'package:ecomik/models/api_responses/vendor_details_response.dart';
import 'package:ecomik/models/api_responses/send_otp_response.dart';
import 'package:ecomik/models/api_responses/signin_response.dart';
import 'package:ecomik/models/api_responses/vendor_details_response.dart';
import 'package:ecomik/models/enums.dart';
import 'package:ecomik/models/screen_parameters/otp_screen_parameter.dart';
import 'package:ecomik/utils/api_repo.dart';
import 'package:ecomik/utils/app_singleton.dart';
import 'package:ecomik/utils/constants/app_constants.dart';
import 'package:ecomik/utils/constants/app_language_translations.dart';
import 'package:ecomik/utils/constants/app_local_stored_keys.dart';
import 'package:ecomik/utils/constants/app_page_names.dart';
import 'package:ecomik/utils/extensions/string.dart';
import 'package:ecomik/utils/helpers/api_helper.dart';
import 'package:ecomik/utils/helpers/helpers.dart';
import 'package:ecomik/widgets/dialogs.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignInController extends GetxController {
  // Variables
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passTextEditingController = TextEditingController();

  final RxBool _isLoading = false.obs;
  bool get isLoading => _isLoading.value;
  set isLoading(bool value) {
    _isLoading.value = value;
    update();
  }

  /// Toggle value of remember me
  RxBool toggleRememberLogin = false.obs;

  /// Toggle value of hide password
  RxBool toggleHidePassword = true.obs;

  // Functions
  void onSignInButtonTap() {
    signIn();
  }

  void onPasswordHideButtonTap() {
    toggleHidePassword.value = !toggleHidePassword.value;
  }

  void onToggleRememberMe(bool value) async {
    toggleRememberLogin.value = value;
    await GetStorage().write(LocalStoredKeyName.rememberMe, value);
  }

  void onForgotPasswordButtonTap() {
    switch (AppSingleton.instance.settings.otpOptionAsEnum) {
      case SettingsOTPOption.email:
        // Go to password recovery enter email address screen
        Get.toNamed(AppPageNames.passwordRecoveryEmailScreen);
        break;
      case SettingsOTPOption.sms:
        // Go to password recovery enter phone number screen
        Get.toNamed(AppPageNames.passwordRecoveryPromptScreen);
        break;
      default:
    }
/*     // Goto verification method selection screen.
    Get.toNamed(AppPageNames.passwordRecoverySelectScreen); */
  }

  void onGoogleSignButtonTap() async {
    isLoading = true;
    await Helper.googleLogout();
    final UserCredential? uc = await signInWithGoogle();
    log(uc?.credential?.accessToken?.toString() ?? '');
    log(uc?.user?.uid.toString() ?? '');
    // final idToken = await uc?.user?.getIdToken();
    // final idTokenRefresh = await uc?.user?.getIdToken(true);
    final idTokenResult = await uc?.user?.getIdTokenResult(true);
    log((idTokenResult?.token).toString());
    if (uc == null) {
      isLoading = false;
      onErrorSignIn(null);
      return;
    }
    googleSignIn(uc, idTokenResult);
  }

  Future<void> googleSignIn(UserCredential uc, IdTokenResult? idToken) async {
    final Map<String, dynamic> requestBody = {
      // 'uid': uc.user?.uid,
      'email': uc.user?.email,
      'emailVerified': uc.user?.emailVerified,
      'displayName': uc.user?.displayName,
      'isAnonymous': uc.user?.isAnonymous,
      'photoURL': uc.user?.photoURL,
      // 'providerData': uc.user?.providerData.first.,
      'stsTokenManager': <String, dynamic>{
        // 'refreshToken': uc.user?.refreshToken,
        'accessToken': idToken?.token,
        // 'expirationTime': idToken?.expirationTime?.millisecondsSinceEpoch,
      },
      'remember_me': toggleRememberLogin.value,
    };
    String requestBodyJson = jsonEncode(requestBody);
    isLoading = true;
    SignInResponse? response = await APIRepo.googleLogin(requestBodyJson);
    if (response == null) {
      isLoading = false;
      onErrorSignIn(response);
      return;
    } else if (response.error) {
      isLoading = false;
      onFailureSignIn(response);
      return;
    } else if (response.role != Constants.userRoleUser) {
      isLoading = false;
      onWrongUserTypeSignIn();
      return;
    } else if (response.phone.isEmpty) {
      isLoading = false;
      onNoPhoneNumberSetForGoogleSignIn(
          response, uc.user?.email ?? '', uc, idToken);
      return;
    } else if (!response.verified) {
      isLoading = false;
      onUnVerifiedSignIn(response, emailAddress: uc.user?.email ?? '');
      return;
    }
    log((response.toJson().toString()).toString());
    onSuccessSignIn(response);
  }

  Future<void> signIn() async {
    isLoading = true;
    final Map<String, Object> requestBody = {
      'email': emailTextEditingController.text,
      'password': passTextEditingController.text,
      'remember_me': toggleRememberLogin.value,
    };
    final String? fcmToken = await Helper.getFCMToken;
    if (fcmToken != null) {
      requestBody['fcm_token'] = fcmToken;
    }
    String requestBodyJson = jsonEncode(requestBody);
    SignInResponse? response = await APIRepo.login(requestBodyJson);
    if (response == null) {
      isLoading = false;
      onErrorSignIn(response);
      return;
    } else if (response.error) {
      isLoading = false;
      onFailureSignIn(response);
      return;
    } else if (response.role != Constants.userRoleUser) {
      isLoading = false;
      onWrongUserTypeSignIn();
      return;
    } else if (!response.verified) {
      isLoading = false;
      onUnVerifiedSignIn(response);
      return;
    }
    log((response.toJson().toString()).toString());
    onSuccessSignIn(response);
  }

  void onErrorSignIn(SignInResponse? response) {
    // AppDialogs.showErrorDialog(messageText: response?.msg ?? '');
    APIHelper.onError(response?.msg);
  }

  void onFailureSignIn(SignInResponse response) {
    // AppDialogs.showErrorDialog(messageText: response.msg);
    isLoading = false;
    APIHelper.onFailure(response.msg);
  }

  void onWrongUserTypeSignIn() {
    AppDialogs.showErrorDialog(
        messageText:
            AppLanguageTranslation.userDoesNotExistTransKey.toCurrentLanguage);
  }

  void onSuccessSignIn(SignInResponse response) async {
    await GetStorage()
        .write(LocalStoredKeyName.loggedInVendorToken, response.token);
    getLoggedInUserDetails();
  }

  Future<void> onNoPhoneNumberSetForGoogleSignIn(SignInResponse response,
      String emailAddress, UserCredential uc, IdTokenResult? idToken) async {
    await AppDialogs.showActionableDialog(
        messageText: AppLanguageTranslation
            .pleaseAddPhoneNumberForYourAccountTransKey.toCurrentLanguage,
        buttonText: AppLanguageTranslation.addNewTransKey.toCurrentLanguage,
        onTap: () {
          Get.back(result: true);
        });
    _putTokenGlobally(response.token);
    Get.create<String>(() => emailAddress,
        tag: 'email_address', permanent: false);
    final result =
        await Get.toNamed(AppPageNames.enterPhoneNumberForGoogleLoginScreen);
    if (result is bool && result) {
      googleSignIn(uc, idToken);
    }
  }

  Future<void> onUnVerifiedSignIn(SignInResponse response,
      {String emailAddress = ''}) async {
    await AppDialogs.showActionableDialog(
        messageText: AppLanguageTranslation
            .yourAccountIsNotVerifiedTransKey.toCurrentLanguage,
        buttonText: AppLanguageTranslation.verifyNowTransKey.toCurrentLanguage,
        onTap: () {
          Get.back(result: true);
        });
    sendOTPCode(response, emailAddress);
    _putTokenGlobally(response.token);
    if (emailAddress.isNotEmpty) {
      Get.create<String>(() => emailAddress,
          tag: 'email_address', permanent: false);
    }

    switch (AppSingleton.instance.settings.otpOptionAsEnum) {
      case SettingsOTPOption.email:
        Get.toNamed(AppPageNames.passwordRecoveryVerificationScreen,
            arguments: OTPScreenParameter(
                email: emailTextEditingController.text,
                type: 'email',
                fromScreenName: FromScreenName.verifyUnverified));
        break;
      case SettingsOTPOption.sms:
        Get.toNamed(AppPageNames.passwordRecoveryVerificationScreen,
            arguments: OTPScreenParameter(
                phone: response.phone,
                type: 'phone',
                fromScreenName: FromScreenName.verifyUnverified));
      default:
    }
    // Get.toNamed(AppPageNames.enterPhoneNumberScreen);
  }

  void _putTokenGlobally(String token) {
    Get.create<String>(() => token, tag: 'token', permanent: false);
  }

  Future<void> getLoggedInUserDetails() async {
    UserDetailsResponse? response = await APIRepo.getUserDetails();
    isLoading = false;
    if (response == null) {
      onErrorGetLoggedInUserDetails(response);
      return;
    } else if (response.error) {
      onFailureGetLoggedInUserDetails(response);
      return;
    }
    log((response.toJson().toString()).toString());
    onSuccessGetLoggedInUserDetails(response);
  }

  void onErrorGetLoggedInUserDetails(UserDetailsResponse? response) {}

  void onFailureGetLoggedInUserDetails(UserDetailsResponse response) {}

  void onSuccessGetLoggedInUserDetails(UserDetailsResponse response) async {
    await Helper.setLoggedInUserToLocalStorage(response.data);
    BuildContext? context = Get.context;
    if (context != null) {
      Get.offAllNamed(AppPageNames.homeNavigatorScreen);
    }
    update();
  }

  Future<void> sendOTPCode(
      SignInResponse responseBefore, String emailAddress) async {
    final Map<String, Object> requestBody = {
      'email':
          emailAddress.isEmpty ? emailTextEditingController.text : emailAddress,
      'role': Constants.userRoleUser,
    };

    /* switch (AppSingleton.instance.settings.otpOptionAsEnum) {
      case SettingsOTPOption.email:
        requestBody['email'] = emailTextEditingController.text;
        break;
      case SettingsOTPOption.sms:
        requestBody['phone'] = responseBefore.phone;
        break;
      default:
        requestBody['email'] = emailTextEditingController.text;
    } */
    String requestBodyJson = jsonEncode(requestBody);
    isLoading = true;
    SendOtpResponse? response =
        await APIRepo.sendVerifyVendorOTP(requestBodyJson);
    isLoading = false;
    if (response == null) {
      onErrorSendOTP(response);
      return;
    } else if (response.error) {
      onFailureSendOTP(response);
      return;
    }
    log(response.toJson().toString());
  }

  void onErrorSendOTP(SendOtpResponse? response) {
    AppDialogs.showErrorDialog(messageText: response?.msg ?? '');
  }

  void onFailureSendOTP(SendOtpResponse response) {
    AppDialogs.showErrorDialog(messageText: response.msg);
  }

  Future<UserCredential?> signInWithGoogle() async {
    // Trigger the authentication flow
    try {
      final GoogleSignInAccount? googleUser =
          // await GoogleSignIn(scopes: <String>["email"]).signIn();
          await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      return await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      log(e.toString());
      if (e is PlatformException) {
        AppDialogs.showErrorDialog(
            messageText:
                '${AppLanguageTranslation.googleSignInFailedErrorCodeTransKey.toCurrentLanguage} ${e.code}');
      } else {
        AppDialogs.showErrorDialog(
            messageText: AppLanguageTranslation
                .googleSigninFailedSomethingWentWrongTransKey
                .toCurrentLanguage);
      }
      return null;
    }
  }

  void _setNotificationPermission() async {
    await Helper.setNotificationPermission();
  }

  void _getScreenParameter() {
    final argument = Get.arguments;
    if (argument is bool) {
      final isSessionExpired = argument;
      if (isSessionExpired) {
        AppDialogs.showErrorDialog(
            messageText: AppLanguageTranslation
                .sessionExpiredPleaseLoginTransKey.toCurrentLanguage);
      }
    }
  }

  @override
  void onInit() {
    _getScreenParameter();
    toggleRememberLogin.value = Helper.isRememberedMe();
    super.onInit();
  }

  @override
  void onReady() {
    _setNotificationPermission();
    super.onReady();
  }

  @override
  void onClose() {
    emailTextEditingController.dispose();
    passTextEditingController.dispose();
    super.onClose();
  }
}
