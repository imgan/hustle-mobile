class Banner {
  int? id;
  String? image;
  String? title;
  String? description;
  String? link;
  int? priority;
  String? imageUrl;

  Banner({
    this.id,
    this.image,
    this.title,
    this.description,
    this.link,
    this.priority,
    this.imageUrl,
  });

  factory Banner.fromJson(Map<String, dynamic> json) => Banner(
        id: json["id"],
        image: json["image"],
        title: json["title"],
        description: json["description"],
        link: json["link"],
        priority: json["priority"],
        imageUrl: json["imageUrl"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
        "title": title,
        "description": description,
        "link": link,
        "priority": priority,
        "imageUrl": imageUrl,
      };
}
