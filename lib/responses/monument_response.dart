// To parse this JSON data, do
//
//     final monumentResponse = monumentResponseFromJson(jsonString);

import 'dart:convert';

import '../models/monument.dart';

MonumentResponse monumentResponseFromJson(String str) => MonumentResponse.fromJson(json.decode(str));

String monumentResponseToJson(MonumentResponse data) => json.encode(data.toJson());

class MonumentResponse {
    List<Monument>? monuments;
    int? count;

    MonumentResponse({
        this.monuments,
        this.count,
    });

    factory MonumentResponse.fromJson(Map<String, dynamic> json) => MonumentResponse(
        monuments: json["monuments"] == null ? [] : List<Monument>.from(json["monuments"]!.map((x) => Monument.fromJson(x))),
        count: json["count"],
    );

    Map<String, dynamic> toJson() => {
        "monuments": monuments == null ? [] : List<dynamic>.from(monuments!.map((x) => x.toJson())),
        "count": count,
    };
}
