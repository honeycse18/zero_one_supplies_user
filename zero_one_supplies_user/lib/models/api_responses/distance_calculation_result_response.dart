import 'package:ecomik/utils/helpers/api_helper.dart';

class DistanceCalculationResultResponse {
  bool error;
  String msg;
  DistanceCalculationResult data;

  DistanceCalculationResultResponse(
      {this.error = false, this.msg = '', required this.data});

  factory DistanceCalculationResultResponse.fromJson(
      Map<String, dynamic> json) {
    return DistanceCalculationResultResponse(
      error: APIHelper.getSafeBoolValue(json['error']),
      msg: APIHelper.getSafeStringValue(json['msg']),
      data:
          DistanceCalculationResult.getAPIResponseObjectSafeValue(json['data']),
    );
  }

  Map<String, dynamic> toJson() => {
        'error': error,
        'msg': msg,
        'data': data.toJson(),
      };

  factory DistanceCalculationResultResponse.empty() =>
      DistanceCalculationResultResponse(
          data: DistanceCalculationResult.empty());

  static DistanceCalculationResultResponse getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? DistanceCalculationResultResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : DistanceCalculationResultResponse.empty();
}

class DistanceCalculationResult {
  DistanceCalculationResultDistance distance;
  DistanceCalculationResultDuration duration;
  String status;
  double kmDistance;
  double distanceFare;
  DistanceCalculationResultMyFare myFare;

  DistanceCalculationResult({
    required this.distance,
    required this.duration,
    this.status = '',
    this.kmDistance = 0,
    this.distanceFare = 0,
    required this.myFare,
  });

  factory DistanceCalculationResult.fromJson(Map<String, dynamic> json) =>
      DistanceCalculationResult(
        distance:
            DistanceCalculationResultDistance.getAPIResponseObjectSafeValue(
                json['distance']),
        duration:
            DistanceCalculationResultDuration.getAPIResponseObjectSafeValue(
                json['duration']),
        status: APIHelper.getSafeStringValue(json['status']),
        kmDistance: APIHelper.getSafeDoubleValue(json['kmDistance'], 0),
        distanceFare: APIHelper.getSafeDoubleValue(json['distanceFare'], 0),
        myFare: DistanceCalculationResultMyFare.getAPIResponseObjectSafeValue(
            json['myFare']),
      );

  Map<String, dynamic> toJson() => {
        'distance': distance.toJson(),
        'duration': duration.toJson(),
        'status': status,
        'kmDistance': kmDistance,
        'distanceFare': distanceFare,
        'myFare': myFare.toJson(),
      };

  factory DistanceCalculationResult.empty() => DistanceCalculationResult(
      distance: DistanceCalculationResultDistance(),
      duration: DistanceCalculationResultDuration(),
      myFare: DistanceCalculationResultMyFare());

  static DistanceCalculationResult getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? DistanceCalculationResult.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : DistanceCalculationResult.empty();
}

class DistanceCalculationResultDistance {
  String text;
  double value;

  DistanceCalculationResultDistance({this.text = '', this.value = 0});

  factory DistanceCalculationResultDistance.fromJson(
          Map<String, dynamic> json) =>
      DistanceCalculationResultDistance(
        text: APIHelper.getSafeStringValue(json['text']),
        value: APIHelper.getSafeDoubleValue(json['value'], 0),
      );

  Map<String, dynamic> toJson() => {
        'text': text,
        'value': value,
      };

  static DistanceCalculationResultDistance getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? DistanceCalculationResultDistance.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : DistanceCalculationResultDistance();
}

class DistanceCalculationResultDuration {
  String text;
  double value;

  DistanceCalculationResultDuration({this.text = '', this.value = 0});

  factory DistanceCalculationResultDuration.fromJson(
          Map<String, dynamic> json) =>
      DistanceCalculationResultDuration(
        text: APIHelper.getSafeStringValue(json['text']),
        value: APIHelper.getSafeDoubleValue(json['value'], 0),
      );

  Map<String, dynamic> toJson() => {
        'text': text,
        'value': value,
      };
  static DistanceCalculationResultDuration getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? DistanceCalculationResultDuration.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : DistanceCalculationResultDuration();
}

class DistanceCalculationResultMyFare {
  double from;
  double to;
  double fare;
  String id;

  DistanceCalculationResultMyFare(
      {this.from = 0, this.to = 0, this.fare = 0, this.id = ''});

  factory DistanceCalculationResultMyFare.fromJson(Map<String, dynamic> json) =>
      DistanceCalculationResultMyFare(
        from: APIHelper.getSafeDoubleValue(json['from'], 0),
        to: APIHelper.getSafeDoubleValue(json['to'], 0),
        fare: APIHelper.getSafeDoubleValue(json['fare'], 0),
        id: APIHelper.getSafeStringValue(json['_id']),
      );

  Map<String, dynamic> toJson() => {
        'from': from,
        'to': to,
        'fare': fare,
        '_id': id,
      };

  static DistanceCalculationResultMyFare getAPIResponseObjectSafeValue(
          Object? unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? DistanceCalculationResultMyFare.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : DistanceCalculationResultMyFare();
}
