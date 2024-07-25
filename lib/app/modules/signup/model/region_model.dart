import 'dart:convert';

import '../../../core/contants.dart';
import '../../../core/utils.dart';

class RegionModel {
  final String status;
  final String country;
  final String countryCode;
  final String region;
  final String regionName;
  final String city;
  final String zip;
  final double lat;
  final double lon;
  final String timezone;
  final String isp;
  final String org;
  final String provider;
  final String query;
  final String saveDate;

  RegionModel({
    required this.status,
    required this.country,
    required this.countryCode,
    required this.region,
    required this.regionName,
    required this.city,
    required this.zip,
    required this.lat,
    required this.lon,
    required this.timezone,
    required this.isp,
    required this.org,
    required this.provider,
    required this.query,
    required this.saveDate,
  });

  RegionModel copyWith({
    String? status,
    String? country,
    String? countryCode,
    String? region,
    String? regionName,
    String? city,
    String? zip,
    double? lat,
    double? lon,
    String? timezone,
    String? isp,
    String? org,
    String? provider,
    String? query,
    String? saveDate,
  }) =>
      RegionModel(
        status: status ?? this.status,
        country: country ?? this.country,
        countryCode: countryCode ?? this.countryCode,
        region: region ?? this.region,
        regionName: regionName ?? this.regionName,
        city: city ?? this.city,
        zip: zip ?? this.zip,
        lat: lat ?? this.lat,
        lon: lon ?? this.lon,
        timezone: timezone ?? this.timezone,
        isp: isp ?? this.isp,
        org: org ?? this.org,
        provider: provider ?? this.provider,
        query: query ?? this.query,
        saveDate: saveDate ?? this.saveDate,
      );

  factory RegionModel.fromRawJson(String str) => RegionModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RegionModel.fromJson(Map<String, dynamic> json) => RegionModel(
    status: json["status"] ?? "",
    country: json["country"] ?? "",
    countryCode: json["countryCode"] ?? "",
    region: json["region"] ?? "",
    regionName: json["regionName"] ?? "",
    city: json["city"] ?? "",
    zip: json["zip"] ?? "",
    lat: Utils.toDouble(json["lat"]),
    lon: Utils.toDouble(json["lon"]),
    timezone: json["timezone"] ?? "",
    isp: json["isp"] ?? "",
    org: json["org"] ?? "",
    provider: json["as"] ?? "",
    query: json["query"] ?? "",
    saveDate: json["saveDate"] ??Constants.dateFormat.format(DateTime.now()),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "country": country,
    "countryCode": countryCode,
    "region": region,
    "regionName": regionName,
    "city": city,
    "zip": zip,
    "lat": lat,
    "lon": lon,
    "timezone": timezone,
    "isp": isp,
    "org": org,
    "as": provider,
    "query": query,
    "saveDate": saveDate,
  };
}
