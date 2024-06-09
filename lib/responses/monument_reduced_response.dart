// To parse this JSON data, do
//
//     final monumentReducedResponse = monumentReducedResponseFromJson(jsonString);

import 'dart:convert';

import 'package:escucha_tu_historia/models/monument_reduced.dart';

MonumentReducedResponse monumentReducedResponseFromJson(String str) => MonumentReducedResponse.fromJson(json.decode(str));

String monumentReducedResponseToJson(MonumentReducedResponse data) => json.encode(data.toJson());

class MonumentReducedResponse {
    List<MonumentReduced>? monuments;
    int? count;

    MonumentReducedResponse({
        this.monuments,
        this.count,
    });

    factory MonumentReducedResponse.fromJson(Map<String, dynamic> json) => MonumentReducedResponse(
        monuments: json["monuments"] == null ? [] : List<MonumentReduced>.from(json["monuments"]!.map((x) => MonumentReduced.fromJson(x))),
        count: json["count"],
    );

    Map<String, dynamic> toJson() => {
        "monuments": monuments == null ? [] : List<dynamic>.from(monuments!.map((x) => x.toJson())),
        "count": count,
    };
}
