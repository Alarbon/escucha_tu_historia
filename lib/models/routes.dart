// To parse this JSON data, do
//
//     final routes = routesFromJson(jsonString);

import 'dart:convert';

List<Routes> routesFromJson(String str) => List<Routes>.from(json.decode(str).map((x) => Routes.fromJson(x)));

String routesToJson(List<Routes> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Routes {
    int? id;
    String? name;
    String? description;
    List<int>? monuments;
    String? type;

    Routes({
        this.id,
        this.name,
        this.description,
        this.monuments,
        this.type,
    });

    factory Routes.fromJson(Map<String, dynamic> json) => Routes(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        monuments: json["monuments"] == null ? [] : List<int>.from(json["monuments"]!.map((x) => x)),
        type: json["type"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "monuments": monuments == null ? [] : List<dynamic>.from(monuments!.map((x) => x)),
        "type": type,
    };
}
