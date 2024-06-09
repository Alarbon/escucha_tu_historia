
class MonumentReduced {
    String? name;
    int? number;
    String? language;
    String? image;

    MonumentReduced({
        this.name,
        this.number,
        this.language,
        this.image,
    });

    factory MonumentReduced.fromJson(Map<String, dynamic> json) => MonumentReduced(
        name: json["name"],
        number: json["number"],
        language: json["language"],
        image: json["image"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "number": number,
        "language": language,
        "image": image,
    };
}
