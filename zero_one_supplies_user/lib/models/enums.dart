/* <-------- Enums for various screens --------> */

import 'package:ecomik/utils/constants/app_constants.dart';

enum AddDeliveryRequestTabState { step1, step2, step3, step4 }

enum AddDeliveryRequestTabStateStatus { step1, step2, step3, step4 }

enum AddDeliveryRequestDetailsTabState { incomplete, current, last, completed }

enum ResetPasswordSelectedChoice {
  none,
  mail,
  phoneNumber,
}

enum PasswordStrongLevel {
  none,
  error,
  weak,
  normal,
  strong,
  veryStrong,
}

enum LanguageSetting { english, russian, french, canada, australian, german }

enum DeliveryLocationSetAs { none, home, office, other }

enum DiscountType {
  flat('flat'),
  percent('percentage'),
  unknown('unknown');

  final String stringValue;
  const DiscountType(this.stringValue);

  static DiscountType toEnumValue(String value) {
    final Map<String, DiscountType> stringToEnumMap = {
      DiscountType.flat.stringValue: DiscountType.flat,
      DiscountType.percent.stringValue: DiscountType.percent,
      DiscountType.unknown.stringValue: DiscountType.unknown,
    };
    return stringToEnumMap[value] ?? DiscountType.unknown;
  }
}

enum CompanyVatType {
  flat(Constants.companyVatTypeFlat),
  percent(Constants.companyVatTypePercentage),
  unknown(Constants.unknown);

  final String stringValue;
  const CompanyVatType(this.stringValue);

  static CompanyVatType toEnumValue(String value) {
    final Map<String, CompanyVatType> stringToEnumMap = {
      CompanyVatType.flat.stringValue: CompanyVatType.flat,
      CompanyVatType.percent.stringValue: CompanyVatType.percent,
      CompanyVatType.unknown.stringValue: CompanyVatType.unknown,
    };
    return stringToEnumMap[value] ?? CompanyVatType.unknown;
  }
}

enum PreferredDeliveryTimeSlot {
  fullDay(Constants.preferredDeliveryTimeFullDay),
  morning(Constants.preferredDeliveryTimeMorning),
  afternoon(Constants.preferredDeliveryTimeAfternoon),
  unknown(Constants.unknown);

  final String stringValue;
  const PreferredDeliveryTimeSlot(this.stringValue);

  static PreferredDeliveryTimeSlot toEnumValue(String value) {
    final Map<String, PreferredDeliveryTimeSlot> stringToEnumMap = {
      PreferredDeliveryTimeSlot.fullDay.stringValue:
          PreferredDeliveryTimeSlot.fullDay,
      PreferredDeliveryTimeSlot.morning.stringValue:
          PreferredDeliveryTimeSlot.morning,
      PreferredDeliveryTimeSlot.afternoon.stringValue:
          PreferredDeliveryTimeSlot.afternoon,
      PreferredDeliveryTimeSlot.unknown.stringValue:
          PreferredDeliveryTimeSlot.unknown,
    };
    return stringToEnumMap[value] ?? PreferredDeliveryTimeSlot.unknown;
  }
}

enum SavedAddressDeliveryType {
  home(Constants.savedAddressDeliveryTypeHome),
  office(Constants.savedAddressDeliveryTypeOffice),
  unknown(Constants.unknown);

  final String stringValue;
  const SavedAddressDeliveryType(this.stringValue);

  static SavedAddressDeliveryType toEnumValue(String value) {
    final Map<String, SavedAddressDeliveryType> stringToEnumMap = {
      SavedAddressDeliveryType.home.stringValue: SavedAddressDeliveryType.home,
      SavedAddressDeliveryType.office.stringValue:
          SavedAddressDeliveryType.office,
      SavedAddressDeliveryType.unknown.stringValue:
          SavedAddressDeliveryType.unknown,
    };
    return stringToEnumMap[value] ?? SavedAddressDeliveryType.unknown;
  }
}

enum MyOrderStatusTypes {
  allOrders('', 'all orders'),
  placed(Constants.myOrderStatusTypePlaced, 'placed'),
  pending(Constants.myOrderStatusTypePending, 'pending'),
  confirm(Constants.myOrderStatusTypeConfirm, 'confirm'),
  processing(Constants.myOrderStatusTypeProcessing, 'processing'),
  picked(Constants.myOrderStatusTypePicked, 'picked'),
  onWay(Constants.myOrderStatusTypeOnWay, 'on way'),
  delivered(Constants.myOrderStatusTypeDelivered, 'delivered'),
  cancelled(Constants.myOrderStatusTypeCancelled, 'cancelled');

  final String stringValue;
  final String stringValueForView;
  const MyOrderStatusTypes(this.stringValue, this.stringValueForView);

  static MyOrderStatusTypes toEnumValue(String value) {
    final Map<String, MyOrderStatusTypes> stringToEnumMap = {
      MyOrderStatusTypes.placed.stringValue: MyOrderStatusTypes.placed,
      MyOrderStatusTypes.pending.stringValue: MyOrderStatusTypes.pending,
      MyOrderStatusTypes.confirm.stringValue: MyOrderStatusTypes.confirm,
      MyOrderStatusTypes.processing.stringValue: MyOrderStatusTypes.processing,
      MyOrderStatusTypes.picked.stringValue: MyOrderStatusTypes.picked,
      MyOrderStatusTypes.onWay.stringValue: MyOrderStatusTypes.onWay,
      MyOrderStatusTypes.delivered.stringValue: MyOrderStatusTypes.delivered,
      MyOrderStatusTypes.cancelled.stringValue: MyOrderStatusTypes.cancelled,
      MyOrderStatusTypes.allOrders.stringValue: MyOrderStatusTypes.allOrders,
    };
    return stringToEnumMap[value] ?? MyOrderStatusTypes.pending;
  }

  static MyOrderStatusTypes toEnumValueFromViewable(String value) {
    final Map<String, MyOrderStatusTypes> stringToEnumMap = {
      MyOrderStatusTypes.placed.stringValueForView: MyOrderStatusTypes.placed,
      MyOrderStatusTypes.pending.stringValueForView: MyOrderStatusTypes.pending,
      MyOrderStatusTypes.confirm.stringValueForView: MyOrderStatusTypes.confirm,
      MyOrderStatusTypes.processing.stringValueForView:
          MyOrderStatusTypes.processing,
      MyOrderStatusTypes.picked.stringValueForView: MyOrderStatusTypes.picked,
      MyOrderStatusTypes.onWay.stringValueForView: MyOrderStatusTypes.onWay,
      MyOrderStatusTypes.delivered.stringValueForView:
          MyOrderStatusTypes.delivered,
      MyOrderStatusTypes.cancelled.stringValueForView:
          MyOrderStatusTypes.cancelled,
      MyOrderStatusTypes.allOrders.stringValueForView:
          MyOrderStatusTypes.allOrders,
    };
    return stringToEnumMap[value] ?? MyOrderStatusTypes.pending;
  }
}

enum NotificationType {
  order(Constants.notificationTypeOrder, 'Order'),
  confirmOrder(Constants.notificationTypeConfirmOrder, 'Confirm order'),
  delivery(Constants.notificationTypeDelivery, 'Delivery');

  final String stringValue;
  final String stringValueForView;
  const NotificationType(this.stringValue, this.stringValueForView);

  static NotificationType toEnumValue(String value) {
    final Map<String, NotificationType> stringToEnumMap = {
      NotificationType.order.stringValue: NotificationType.order,
      NotificationType.confirmOrder.stringValue: NotificationType.confirmOrder,
      NotificationType.delivery.stringValue: NotificationType.delivery,
    };
    return stringToEnumMap[value] ?? NotificationType.order;
  }

  static NotificationType toEnumValueFromViewable(String value) {
    final Map<String, NotificationType> stringToEnumMap = {
      NotificationType.order.stringValueForView: NotificationType.order,
      NotificationType.confirmOrder.stringValueForView:
          NotificationType.confirmOrder,
      NotificationType.delivery.stringValueForView: NotificationType.delivery,
    };
    return stringToEnumMap[value] ?? NotificationType.order;
  }
}

enum NotificationTypeStatus {
  placed(Constants.notificationTypeStatusPlaced, 'Placed'),
  pending(Constants.notificationTypeStatusPending, 'Pending'),
  confirm(Constants.notificationTypeStatusConfirm, 'Confirm'),
  cancelled(Constants.notificationTypeStatusCancelled, 'Cancelled'),
  processing(Constants.notificationTypeStatusProcessing, 'Processing'),
  onWay(Constants.notificationTypeStatusOnWay, 'On the way'),
  delivered(Constants.notificationTypeStatusDelivered, 'Delivered'),
  approved(Constants.notificationTypeStatusApproved, 'Approved'),
  rejected(Constants.notificationTypeStatusRejected, 'Rejected'),
  accepted(Constants.notificationTypeStatusAccepted, 'Accepted'),
  picked(Constants.notificationTypeStatusPicked, 'Picked');

  final String stringValue;
  final String stringValueForView;
  const NotificationTypeStatus(this.stringValue, this.stringValueForView);

  static NotificationTypeStatus toEnumValue(String value) {
    final Map<String, NotificationTypeStatus> stringToEnumMap = {
      NotificationTypeStatus.placed.stringValue: NotificationTypeStatus.placed,
      NotificationTypeStatus.pending.stringValue:
          NotificationTypeStatus.pending,
      NotificationTypeStatus.confirm.stringValue:
          NotificationTypeStatus.confirm,
      NotificationTypeStatus.cancelled.stringValue:
          NotificationTypeStatus.cancelled,
      NotificationTypeStatus.processing.stringValue:
          NotificationTypeStatus.processing,
      NotificationTypeStatus.onWay.stringValue: NotificationTypeStatus.onWay,
      NotificationTypeStatus.delivered.stringValue:
          NotificationTypeStatus.delivered,
      NotificationTypeStatus.approved.stringValue:
          NotificationTypeStatus.approved,
      NotificationTypeStatus.rejected.stringValue:
          NotificationTypeStatus.rejected,
      NotificationTypeStatus.accepted.stringValue:
          NotificationTypeStatus.accepted,
      NotificationTypeStatus.picked.stringValue: NotificationTypeStatus.picked,
    };
    return stringToEnumMap[value] ?? NotificationTypeStatus.pending;
  }

  static NotificationTypeStatus toEnumValueFromViewable(String value) {
    final Map<String, NotificationTypeStatus> stringToEnumMap = {
      NotificationTypeStatus.placed.stringValueForView:
          NotificationTypeStatus.placed,
      NotificationTypeStatus.pending.stringValueForView:
          NotificationTypeStatus.pending,
      NotificationTypeStatus.confirm.stringValueForView:
          NotificationTypeStatus.confirm,
      NotificationTypeStatus.cancelled.stringValueForView:
          NotificationTypeStatus.cancelled,
      NotificationTypeStatus.processing.stringValueForView:
          NotificationTypeStatus.processing,
      NotificationTypeStatus.onWay.stringValueForView:
          NotificationTypeStatus.onWay,
      NotificationTypeStatus.delivered.stringValueForView:
          NotificationTypeStatus.delivered,
      NotificationTypeStatus.approved.stringValueForView:
          NotificationTypeStatus.approved,
      NotificationTypeStatus.rejected.stringValueForView:
          NotificationTypeStatus.rejected,
      NotificationTypeStatus.accepted.stringValueForView:
          NotificationTypeStatus.accepted,
      NotificationTypeStatus.picked.stringValueForView:
          NotificationTypeStatus.picked,
    };
    return stringToEnumMap[value] ?? NotificationTypeStatus.pending;
  }
}

enum PushNotificationTypeStatus {
  order(Constants.pushNotificationTypeOrder, 'Order'),
  unknown(Constants.unknown, 'Unknown');

  final String stringValue;
  final String stringValueForView;
  const PushNotificationTypeStatus(this.stringValue, this.stringValueForView);

  static PushNotificationTypeStatus toEnumValue(String value) {
    final Map<String, PushNotificationTypeStatus> stringToEnumMap = {
      PushNotificationTypeStatus.order.stringValue:
          PushNotificationTypeStatus.order,
    };
    return stringToEnumMap[value] ?? PushNotificationTypeStatus.unknown;
  }

  static PushNotificationTypeStatus toEnumValueFromViewable(String value) {
    final Map<String, PushNotificationTypeStatus> stringToEnumMap = {
      PushNotificationTypeStatus.order.stringValueForView:
          PushNotificationTypeStatus.order,
    };
    return stringToEnumMap[value] ?? PushNotificationTypeStatus.unknown;
  }
}

enum UserGender {
  male(Constants.userGenderMale, 'Male'),
  female(Constants.userGenderFemale, 'Female'),
  unknown(Constants.unknown, Constants.unknown);

  final String stringValue;
  final String stringValueForView;
  const UserGender(this.stringValue, this.stringValueForView);

  static UserGender toEnumValue(String value) {
    final Map<String, UserGender> stringToEnumMap = {
      UserGender.male.stringValue: UserGender.male,
      UserGender.female.stringValue: UserGender.female,
      UserGender.unknown.stringValue: UserGender.unknown,
    };
    return stringToEnumMap[value] ?? UserGender.unknown;
  }

  static UserGender toEnumValueFromViewable(String value) {
    final Map<String, UserGender> stringToEnumMap = {
      UserGender.male.stringValueForView: UserGender.male,
      UserGender.female.stringValueForView: UserGender.female,
      UserGender.unknown.stringValueForView: UserGender.unknown,
    };
    return stringToEnumMap[value] ?? UserGender.unknown;
  }
}

enum SellerStatus {
  best('Best seller'),
  top('Top seller'),
  newSeller('New seller'),
  unknown(Constants.unknown);

  final String stringValueForView;
  const SellerStatus(this.stringValueForView);

  static SellerStatus toEnumValueFromViewable(String value) {
    final Map<String, SellerStatus> stringToEnumMap = {
      SellerStatus.best.stringValueForView: SellerStatus.best,
      SellerStatus.top.stringValueForView: SellerStatus.top,
      SellerStatus.newSeller.stringValueForView: SellerStatus.newSeller,
      SellerStatus.unknown.stringValueForView: SellerStatus.unknown,
    };
    return stringToEnumMap[value] ?? SellerStatus.unknown;
  }
}

enum FromScreenName {
  signupScreen,
  verifyUnverified,
  googleSignupScreen,
  resetOrForgetPassScreen,
  vendorScreen,
  homeScreen;
}

enum SettingsOTPOption {
  email(Constants.otpOptionEmail, 'Email'),
  sms(Constants.otpOptionSMS, 'SMS'),
  unknown(Constants.unknown, 'Unknown');

  final String stringValue;
  final String stringValueForView;
  const SettingsOTPOption(this.stringValue, this.stringValueForView);

  static SettingsOTPOption toEnumValue(String value) {
    final Map<String, SettingsOTPOption> stringToEnumMap = {
      SettingsOTPOption.email.stringValue: SettingsOTPOption.email,
      SettingsOTPOption.sms.stringValue: SettingsOTPOption.sms,
      SettingsOTPOption.unknown.stringValue: SettingsOTPOption.unknown,
    };
    return stringToEnumMap[value] ?? SettingsOTPOption.unknown;
  }
}

enum ProductConditionStatus {
  newStatus(Constants.productConditionNew, 'New'),
  usedStatus(Constants.productConditionUsed, 'Used'),
  unknown(Constants.unknown, 'Unknown');

  final String stringValue;
  final String stringValueForView;
  const ProductConditionStatus(this.stringValue, this.stringValueForView);

  static ProductConditionStatus toEnumValue(String value) {
    final Map<String, ProductConditionStatus> stringToEnumMap = {
      ProductConditionStatus.newStatus.stringValue:
          ProductConditionStatus.newStatus,
      ProductConditionStatus.usedStatus.stringValue:
          ProductConditionStatus.usedStatus,
      ProductConditionStatus.unknown.stringValue:
          ProductConditionStatus.unknown,
    };
    return stringToEnumMap[value] ?? ProductConditionStatus.unknown;
  }
}

enum ProductLocation {
  none(-1, '', ''),
  store(1, 'store', 'Store'),
  pickupStations(2, 'replay_point', 'Pickup station');

  final int selectionIndex;
  final String type;
  final String viewableText;
  const ProductLocation(this.selectionIndex, this.type, this.viewableText);

  static ProductLocation get defaultValue => ProductLocation.none;

  static List<ProductLocation> get list => [store, pickupStations];

  static ProductLocation indexToEnumValue(int selectionIndex) {
    final Map<int, ProductLocation> stringToEnumMap = {
      ProductLocation.store.selectionIndex: ProductLocation.store,
      ProductLocation.pickupStations.selectionIndex:
          ProductLocation.pickupStations,
    };
    return stringToEnumMap[selectionIndex] ?? defaultValue;
  }

  static ProductLocation typeToEnumValue(String type) {
    final Map<String, ProductLocation> stringToEnumMap = {
      ProductLocation.store.type: ProductLocation.store,
      ProductLocation.pickupStations.type: ProductLocation.pickupStations,
    };
    return stringToEnumMap[type] ?? defaultValue;
  }
}
