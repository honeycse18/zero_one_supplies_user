import 'package:ecomik/models/enums.dart';
import 'package:ecomik/utils/helpers/api_helper.dart';

class SiteSettingsResponse {
  bool error;
  String msg;
  SiteSettings data;

  SiteSettingsResponse({this.error = false, this.msg = '', required this.data});

  factory SiteSettingsResponse.fromJson(Map<String, dynamic> json) {
    return SiteSettingsResponse(
      error: APIHelper.getSafeBoolValue(json['error']),
      msg: APIHelper.getSafeStringValue(json['msg']),
      data: SiteSettings.getAPIResponseObjectSafeValue(json['data']),
    );
  }

  Map<String, dynamic> toJson() => {
        'error': error,
        'msg': msg,
        'data': data.toJson(),
      };

  factory SiteSettingsResponse.empty() =>
      SiteSettingsResponse(data: SiteSettings.empty());

  static SiteSettingsResponse getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? SiteSettingsResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : SiteSettingsResponse.empty();
}

class SiteSettings {
  SiteSettingsPaypal paypal;
  SiteSettingsCompanyVat companyVat;
  String description;
  String email;
  String logo;
  String name;
  String currencyCode;
  String currencySymbol;
  String address;
  List<SiteSettingsPaymentMethod> paymentMethods;
  String phone;
  List<SiteSettingsSocialMediaLink> socialMediaLink;
  List<SiteSettingsDeliveryCharge> deliveryCharge;
  List<SiteSettingsDeliveryArea> deliveryArea;
  List<SiteSettingsPickupArea> pickupArea;
  double dollarRate;
  String otpOption;

  SiteSettings({
    required this.paypal,
    required this.companyVat,
    this.description = '',
    this.email = '',
    this.logo = '',
    this.name = '',
    this.currencyCode = '',
    this.currencySymbol = '',
    this.address = '',
    this.paymentMethods = const [],
    this.phone = '',
    this.socialMediaLink = const [],
    this.deliveryCharge = const [],
    this.deliveryArea = const [],
    this.pickupArea = const [],
    this.dollarRate = 0,
    this.otpOption = '',
  });

  factory SiteSettings.fromJson(Map<String, dynamic> json) => SiteSettings(
        paypal:
            SiteSettingsPaypal.getAPIResponseObjectSafeValue(json['paypal']),
        companyVat: SiteSettingsCompanyVat.getAPIResponseObjectSafeValue(
            json['company_vat']),
        description: APIHelper.getSafeStringValue(json['description']),
        email: APIHelper.getSafeStringValue(json['email']),
        logo: APIHelper.getSafeStringValue(json['logo']),
        name: APIHelper.getSafeStringValue(json['name']),
        currencyCode: APIHelper.getSafeStringValue(json['currency_code']),
        currencySymbol: APIHelper.getSafeStringValue(json['currency_symbol']),
        address: APIHelper.getSafeStringValue(json['address']),
        paymentMethods: (APIHelper.getSafeListValue(json['payment_methods']))
            .map((e) =>
                SiteSettingsPaymentMethod.getAPIResponseObjectSafeValue(e))
            .toList(),
        phone: APIHelper.getSafeStringValue(json['phone']),
        socialMediaLink: (APIHelper.getSafeListValue(json['social_media_link']))
            .map((e) =>
                SiteSettingsSocialMediaLink.getAPIResponseObjectSafeValue(e))
            .toList(),
        deliveryCharge: (APIHelper.getSafeListValue(json['delivery_charge']))
            .map((e) =>
                SiteSettingsDeliveryCharge.getAPIResponseObjectSafeValue(e))
            .toList(),
        deliveryArea: APIHelper.getSafeListValue(json['delivery_area'])
            .map((e) =>
                SiteSettingsDeliveryArea.getAPIResponseObjectSafeValue(e))
            .toList(),
        pickupArea: APIHelper.getSafeListValue(json['pickup_area'])
            .map((e) => SiteSettingsPickupArea.getAPIResponseObjectSafeValue(e))
            .toList(),
        dollarRate: APIHelper.getSafeDoubleValue(json['dollar_rate']),
        otpOption: APIHelper.getSafeStringValue(json['otp_option']),
      );

  Map<String, dynamic> toJson() => {
        'paypal': paypal.toJson(),
        'company_vat': companyVat.toJson(),
        'description': description,
        'email': email,
        'logo': logo,
        'name': name,
        'currency_code': currencyCode,
        'currency_symbol': currencySymbol,
        'address': address,
        'payment_methods': paymentMethods.map((e) => e.toJson()).toList(),
        'phone': phone,
        'social_media_link': socialMediaLink.map((e) => e.toJson()).toList(),
        'delivery_charge': deliveryCharge.map((e) => e.toJson()).toList(),
        'delivery_area': deliveryArea.map((e) => e.toJson()).toList(),
        'pickup_area': pickupArea.map((e) => e.toJson()).toList(),
        'dollar_rate': dollarRate,
        'otp_option': otpOption,
      };

  factory SiteSettings.empty() => SiteSettings(
      paypal: SiteSettingsPaypal.empty(), companyVat: SiteSettingsCompanyVat());

  static SiteSettings getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? SiteSettings.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : SiteSettings.empty();

  bool isEmpty() => name.isEmpty;

  SettingsOTPOption get otpOptionAsEnum =>
      SettingsOTPOption.toEnumValue(otpOption);
}

class SiteSettingsCompanyVat {
  String type;
  double value;

  SiteSettingsCompanyVat({this.type = '', this.value = 0});

  factory SiteSettingsCompanyVat.fromJson(Map<String, dynamic> json) =>
      SiteSettingsCompanyVat(
        type: APIHelper.getSafeStringValue(json['type']),
        value: APIHelper.getSafeDoubleValue(json['value'], 0),
      );

  Map<String, dynamic> toJson() => {
        'type': type,
        'value': value,
      };

  static SiteSettingsCompanyVat getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? SiteSettingsCompanyVat.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : SiteSettingsCompanyVat();
}

class SiteSettingsPaypal {
  SiteSettingsPaypalCredential credentials;
  String name;
  String image;

  SiteSettingsPaypal(
      {required this.credentials, this.name = '', this.image = ''});

  factory SiteSettingsPaypal.fromJson(Map<String, dynamic> json) =>
      SiteSettingsPaypal(
        credentials: SiteSettingsPaypalCredential.getAPIResponseObjectSafeValue(
            json['credentials']),
        name: APIHelper.getSafeStringValue(json['name']),
        image: APIHelper.getSafeStringValue(json['image']),
      );

  Map<String, dynamic> toJson() => {
        'credentials': credentials.toJson(),
        'name': name,
        'image': image,
      };

  factory SiteSettingsPaypal.empty() =>
      SiteSettingsPaypal(credentials: SiteSettingsPaypalCredential());

  static SiteSettingsPaypal getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? SiteSettingsPaypal.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : SiteSettingsPaypal.empty();
}

class SiteSettingsPaypalCredential {
  String liveURL;
  String clientID;
  String secretKey;
  bool active;

  SiteSettingsPaypalCredential(
      {this.liveURL = '',
      this.clientID = '',
      this.secretKey = '',
      this.active = false});

  factory SiteSettingsPaypalCredential.fromJson(Map<String, dynamic> json) =>
      SiteSettingsPaypalCredential(
        liveURL: APIHelper.getSafeStringValue(json['live_url']),
        clientID: APIHelper.getSafeStringValue(json['client_id']),
        secretKey: APIHelper.getSafeStringValue(json['secret_key']),
        active: APIHelper.getSafeBoolValue(json['active']),
      );

  Map<String, dynamic> toJson() => {
        'live_url': liveURL,
        'client_id': clientID,
        'secret_key': secretKey,
        'active': active,
      };

  static SiteSettingsPaypalCredential getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? SiteSettingsPaypalCredential.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : SiteSettingsPaypalCredential();
}

class SiteSettingsDeliveryCharge {
  String key;
  double value;
  String id;

  SiteSettingsDeliveryCharge({this.key = '', this.value = 0, this.id = ''});

  factory SiteSettingsDeliveryCharge.fromJson(Map<String, dynamic> json) {
    return SiteSettingsDeliveryCharge(
      key: APIHelper.getSafeStringValue(json['key']),
      value: APIHelper.getSafeDoubleValue(json['value'], 0),
      id: APIHelper.getSafeStringValue(json['_id']),
    );
  }

  Map<String, dynamic> toJson() => {
        'key': key,
        'value': value,
        '_id': id,
      };

  static SiteSettingsDeliveryCharge getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? SiteSettingsDeliveryCharge.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : SiteSettingsDeliveryCharge();
}

class SiteSettingsDeliveryArea {
  String name;
  double amount;
  int estimatedDay;
  String id;

  SiteSettingsDeliveryArea({
    this.name = '',
    this.amount = 0,
    this.estimatedDay = 0,
    this.id = '',
  });

  factory SiteSettingsDeliveryArea.fromJson(Map<String, dynamic> json) {
    return SiteSettingsDeliveryArea(
      name: APIHelper.getSafeStringValue(json['name']),
      amount: APIHelper.getSafeDoubleValue(json['amount'], 0),
      estimatedDay: APIHelper.getSafeIntValue(json['estimated_day'], 0),
      id: APIHelper.getSafeStringValue(json['_id']),
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'amount': amount,
        'estimated_day': estimatedDay,
        '_id': id,
      };

  static SiteSettingsDeliveryArea getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? SiteSettingsDeliveryArea.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : SiteSettingsDeliveryArea();
}

class SiteSettingsPickupArea {
  String location;
  String address;
  int estimatedDay;
  String id;

  SiteSettingsPickupArea({
    this.location = '',
    this.address = '',
    this.estimatedDay = 0,
    this.id = '',
  });

  factory SiteSettingsPickupArea.fromJson(Map<String, dynamic> json) {
    return SiteSettingsPickupArea(
      location: APIHelper.getSafeStringValue(json['location']),
      address: APIHelper.getSafeStringValue(json['address']),
      estimatedDay: APIHelper.getSafeIntValue(json['estimated_day'], 0),
      id: APIHelper.getSafeStringValue(json['_id']),
    );
  }

  Map<String, dynamic> toJson() => {
        'location': location,
        'address': address,
        'estimated_day': estimatedDay,
        '_id': id,
      };

  static SiteSettingsPickupArea getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? SiteSettingsPickupArea.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : SiteSettingsPickupArea();
}

class SiteSettingsPaymentMethod {
  String name;
  String image;
  SiteSettingsPaymentMethodCredentials credentials;
  String id;

  SiteSettingsPaymentMethod(
      {this.name = '',
      this.image = '',
      required this.credentials,
      this.id = ''});

  factory SiteSettingsPaymentMethod.fromJson(Map<String, dynamic> json) =>
      SiteSettingsPaymentMethod(
        name: APIHelper.getSafeStringValue(json['name']),
        image: APIHelper.getSafeStringValue(json['image']),
        credentials:
            SiteSettingsPaymentMethodCredentials.getAPIResponseObjectSafeValue(
                json['credentials']),
        id: APIHelper.getSafeStringValue(json['_id']),
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'image': image,
        'credentials': credentials.toJson(),
        '_id': id,
      };

  factory SiteSettingsPaymentMethod.empty() => SiteSettingsPaymentMethod(
      credentials: SiteSettingsPaymentMethodCredentials());

  static SiteSettingsPaymentMethod getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? SiteSettingsPaymentMethod.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : SiteSettingsPaymentMethod.empty();
}

class SiteSettingsPaymentMethodCredentials {
  String publishableKey;
  String secretKey;
  String baseUrl;
  bool active;

  SiteSettingsPaymentMethodCredentials({
    this.publishableKey = '',
    this.secretKey = '',
    this.baseUrl = '',
    this.active = false,
  });

  factory SiteSettingsPaymentMethodCredentials.fromJson(
          Map<String, dynamic> json) =>
      SiteSettingsPaymentMethodCredentials(
        publishableKey: APIHelper.getSafeStringValue(json['publishable_key']),
        secretKey: APIHelper.getSafeStringValue(json['secret_key']),
        baseUrl: APIHelper.getSafeStringValue(json['base_url']),
        active: APIHelper.getSafeBoolValue(json['active']),
      );

  Map<String, dynamic> toJson() => {
        'publishable_key': publishableKey,
        'secret_key': secretKey,
        'base_url': baseUrl,
        'active': active,
      };

  static SiteSettingsPaymentMethodCredentials getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? SiteSettingsPaymentMethodCredentials.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : SiteSettingsPaymentMethodCredentials();
}

class SiteSettingsSocialMediaLink {
  String icon;
  String name;
  String link;
  String id;

  SiteSettingsSocialMediaLink(
      {this.icon = '', this.name = '', this.link = '', this.id = ''});

  factory SiteSettingsSocialMediaLink.fromJson(Map<String, dynamic> json) {
    return SiteSettingsSocialMediaLink(
      icon: APIHelper.getSafeStringValue(json['icon']),
      name: APIHelper.getSafeStringValue(json['name']),
      link: APIHelper.getSafeStringValue(json['link']),
      id: APIHelper.getSafeStringValue(json['_id']),
    );
  }

  Map<String, dynamic> toJson() => {
        'icon': icon,
        'name': name,
        'link': link,
        '_id': id,
      };

  static SiteSettingsSocialMediaLink getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? SiteSettingsSocialMediaLink.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : SiteSettingsSocialMediaLink();
}
