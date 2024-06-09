// To parse this JSON data, do
//
//     final monument = monumentFromJson(jsonString);

import 'dart:convert';

Monument monumentFromJson(String str) => Monument.fromJson(json.decode(str));

String monumentToJson(Monument data) => json.encode(data.toJson());

class Monument {
    List<String>? imagesUrls;
    int? number;
    String? audioUrl;
    String? subtittle;
    String? name;
    String? language;
    Location? location;
    String? text;

    Monument({
        this.imagesUrls,
        this.number,
        this.audioUrl,
        this.subtittle,
        this.name,
        this.language,
        this.location,
        this.text,
    });

    factory Monument.fromJson(Map<String, dynamic> json) => Monument(
        imagesUrls: json["imagesUrls"] == null ? [] : List<String>.from(json["imagesUrls"]!.map((x) => x)),
        number: json["number"],
        audioUrl: json["audioUrl"],
        subtittle: json["subtittle"],
        name: json["name"],
        language: json["language"],
        location: json["location"] == null ? null : Location.fromJson(json["location"]),
        text: json["text"],
    );

    Map<String, dynamic> toJson() => {
        "imagesUrls": imagesUrls == null ? [] : List<dynamic>.from(imagesUrls!.map((x) => x)),
        "number": number,
        "audioUrl": audioUrl,
        "subtittle": subtittle,
        "name": name,
        "language": language,
        "location": location?.toJson(),
        "text": text,
    };
}

class Location {
    String? lon;
    String? lat;

    Location({
        this.lon,
        this.lat,
    });

    factory Location.fromJson(Map<String, dynamic> json) => Location(
        lon: json["lon"],
        lat: json["lat"],
    );

    Map<String, dynamic> toJson() => {
        "lon": lon,
        "lat": lat,
    };
}
