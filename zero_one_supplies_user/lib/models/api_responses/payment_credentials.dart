import 'package:ecomik/utils/helpers/api_helper.dart';

class PaymentCredentialsResponse {
  bool error;
  String msg;
  PaymentCredentials data;

  PaymentCredentialsResponse(
      {this.error = false, this.msg = '', required this.data});

  factory PaymentCredentialsResponse.fromJson(Map<String, dynamic> json) {
    return PaymentCredentialsResponse(
      error: APIHelper.getSafeBoolValue(json['error']),
      msg: APIHelper.getSafeStringValue(json['msg']),
      data: PaymentCredentials.getAPIResponseObjectSafeValue(json['data']),
    );
  }

  Map<String, dynamic> toJson() => {
        'error': error,
        'msg': msg,
        'data': data.toJson(),
      };

  factory PaymentCredentialsResponse.empty() =>
      PaymentCredentialsResponse(data: PaymentCredentials.empty());

  static PaymentCredentialsResponse getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? PaymentCredentialsResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : PaymentCredentialsResponse.empty();
}

class PaymentCredentials {
  SiteSettingsCredentialsStripe stripe;
  SiteSettingsCredentialsPaypal paypal;
  SiteSettingsCredentialsCinetpay cinetpay;
  String id;

  PaymentCredentials({
    required this.stripe,
    required this.paypal,
    required this.cinetpay,
    this.id = '',
  });

  factory PaymentCredentials.fromJson(Map<String, dynamic> json) =>
      PaymentCredentials(
        stripe: SiteSettingsCredentialsStripe.getAPIResponseObjectSafeValue(
            json['stripe']),
        paypal: SiteSettingsCredentialsPaypal.getAPIResponseObjectSafeValue(
            json['paypal']),
        cinetpay: SiteSettingsCredentialsCinetpay.fromJson(json['cinetpay']),
        id: APIHelper.getSafeStringValue(json['_id']),
      );

  Map<String, dynamic> toJson() => {
        'stripe': stripe.toJson(),
        'paypal': paypal.toJson(),
        'cinetpay': cinetpay.toJson(),
        '_id': id,
      };

  factory PaymentCredentials.empty() => PaymentCredentials(
      stripe: SiteSettingsCredentialsStripe.empty(),
      paypal: SiteSettingsCredentialsPaypal.empty(),
      cinetpay: SiteSettingsCredentialsCinetpay.empty());

  static PaymentCredentials getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? PaymentCredentials.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : PaymentCredentials.empty();

  bool get isEmpty => id.isEmpty;
}

class SiteSettingsCredentialsStripe {
  SiteSettingsCredentialsStripeCredentials credentials;
  String name;
  String image;

  SiteSettingsCredentialsStripe(
      {required this.credentials, this.name = '', this.image = ''});

  factory SiteSettingsCredentialsStripe.fromJson(Map<String, dynamic> json) =>
      SiteSettingsCredentialsStripe(
        credentials: SiteSettingsCredentialsStripeCredentials
            .getAPIResponseObjectSafeValue(json['credentials']),
        name: APIHelper.getSafeStringValue(json['name']),
        image: APIHelper.getSafeStringValue(json['image']),
      );

  Map<String, dynamic> toJson() => {
        'credentials': credentials.toJson(),
        'name': name,
        'image': image,
      };

  factory SiteSettingsCredentialsStripe.empty() =>
      SiteSettingsCredentialsStripe(
          credentials: SiteSettingsCredentialsStripeCredentials());

  static SiteSettingsCredentialsStripe getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? SiteSettingsCredentialsStripe.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : SiteSettingsCredentialsStripe.empty();
}

class SiteSettingsCredentialsPaypal {
  SiteSettingsCredentialsPaypalCredentials credentials;
  String name;
  String image;

  SiteSettingsCredentialsPaypal(
      {required this.credentials, this.name = '', this.image = ''});

  factory SiteSettingsCredentialsPaypal.fromJson(Map<String, dynamic> json) =>
      SiteSettingsCredentialsPaypal(
        credentials: SiteSettingsCredentialsPaypalCredentials
            .getAPIResponseObjectSafeValue(json['credentials']),
        name: APIHelper.getSafeStringValue(json['name']),
        image: APIHelper.getSafeStringValue(json['image']),
      );

  Map<String, dynamic> toJson() => {
        'credentials': credentials.toJson(),
        'name': name,
        'image': image,
      };

  factory SiteSettingsCredentialsPaypal.empty() =>
      SiteSettingsCredentialsPaypal(
          credentials: SiteSettingsCredentialsPaypalCredentials());

  static SiteSettingsCredentialsPaypal getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? SiteSettingsCredentialsPaypal.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : SiteSettingsCredentialsPaypal.empty();
}

class SiteSettingsCredentialsCinetpay {
  SiteSettingsCredentialsCinetpayCredentials credentials;
  String name;
  String image;

  SiteSettingsCredentialsCinetpay(
      {required this.credentials, this.name = '', this.image = ''});

  factory SiteSettingsCredentialsCinetpay.fromJson(Map<String, dynamic> json) =>
      SiteSettingsCredentialsCinetpay(
        credentials: SiteSettingsCredentialsCinetpayCredentials
            .getAPIResponseObjectSafeValue(json['credentials']),
        name: APIHelper.getSafeStringValue(json['name']),
        image: APIHelper.getSafeStringValue(json['image']),
      );

  Map<String, dynamic> toJson() => {
        'credentials': credentials.toJson(),
        'name': name,
        'image': image,
      };

  factory SiteSettingsCredentialsCinetpay.empty() =>
      SiteSettingsCredentialsCinetpay(
          credentials: SiteSettingsCredentialsCinetpayCredentials());

  static SiteSettingsCredentialsCinetpay getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? SiteSettingsCredentialsCinetpay.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : SiteSettingsCredentialsCinetpay.empty();
}

class SiteSettingsCredentialsStripeCredentials {
  String publishableKey;
  String secretKey;
  bool active;

  SiteSettingsCredentialsStripeCredentials(
      {this.publishableKey = '', this.secretKey = '', this.active = false});

  factory SiteSettingsCredentialsStripeCredentials.fromJson(
          Map<String, dynamic> json) =>
      SiteSettingsCredentialsStripeCredentials(
        publishableKey: APIHelper.getSafeStringValue(json['publishable_key']),
        secretKey: APIHelper.getSafeStringValue(json['secret_key']),
        active: APIHelper.getSafeBoolValue(json['active']),
      );

  Map<String, dynamic> toJson() => {
        'publishable_key': publishableKey,
        'secret_key': secretKey,
        'active': active,
      };
  static SiteSettingsCredentialsStripeCredentials getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? SiteSettingsCredentialsStripeCredentials.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : SiteSettingsCredentialsStripeCredentials();
}

class SiteSettingsCredentialsPaypalCredentials {
  String liveURL;
  String clientID;
  String secretKey;
  bool active;

  SiteSettingsCredentialsPaypalCredentials(
      {this.liveURL = '',
      this.clientID = '',
      this.secretKey = '',
      this.active = false});

  factory SiteSettingsCredentialsPaypalCredentials.fromJson(
          Map<String, dynamic> json) =>
      SiteSettingsCredentialsPaypalCredentials(
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
  static SiteSettingsCredentialsPaypalCredentials getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? SiteSettingsCredentialsPaypalCredentials.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : SiteSettingsCredentialsPaypalCredentials();
}

class SiteSettingsCredentialsCinetpayCredentials {
  String apiKey;
  String siteID;
  String returnURL;
  String notifyURL;
  bool active;

  SiteSettingsCredentialsCinetpayCredentials(
      {this.apiKey = '',
      this.siteID = '',
      this.returnURL = '',
      this.notifyURL = '',
      this.active = false});

  factory SiteSettingsCredentialsCinetpayCredentials.fromJson(
          Map<String, dynamic> json) =>
      SiteSettingsCredentialsCinetpayCredentials(
        apiKey: APIHelper.getSafeStringValue(json['apiKey']),
        siteID: APIHelper.getSafeStringValue(json['site_id']),
        returnURL: APIHelper.getSafeStringValue(json['return_url']),
        notifyURL: APIHelper.getSafeStringValue(json['notify_url']),
        active: APIHelper.getSafeBoolValue(json['active']),
      );

  Map<String, dynamic> toJson() => {
        'apiKey': apiKey,
        'site_id': siteID,
        'return_url': returnURL,
        'notify_url': notifyURL,
        'active': active,
      };
  static SiteSettingsCredentialsCinetpayCredentials
      getAPIResponseObjectSafeValue(dynamic unsafeResponseValue) =>
          APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
              ? SiteSettingsCredentialsCinetpayCredentials.fromJson(
                  unsafeResponseValue as Map<String, dynamic>)
              : SiteSettingsCredentialsCinetpayCredentials();
}
