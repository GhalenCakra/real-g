import 'dart:convert';

List<ProductEntry> productEntryFromJson(String str) =>
    List<ProductEntry>.from(json.decode(str).map((x) => ProductEntry.fromJson(x)));

String productEntryToJson(List<ProductEntry> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductEntry {
  String id;
  String title;
  int price;
  String description;
  String category;
  String thumbnail;
  bool isFeatured;
  int stock;
  double rating;
  String brand;
  int views;
  String? userUsername;
  DateTime createdAt;
  DateTime updatedAt;

  ProductEntry({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.thumbnail,
    required this.isFeatured,
    required this.stock,
    required this.rating,
    required this.brand,
    required this.views,
    required this.userUsername,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ProductEntry.fromJson(Map<String, dynamic> json) => ProductEntry(
        id: json["id"],
        title: json["title"],
        price: json["price"],
        description: json["description"],
        category: json["category"],
        thumbnail: json["thumbnail"] ?? "",
        isFeatured: json["is_featured"],
        stock: json["stock"],
        rating: (json["rating"] ?? 0).toDouble(),
        brand: json["brand"] ?? "",
        views: json["views"],
        userUsername: json["user_username"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "price": price,
        "description": description,
        "category": category,
        "thumbnail": thumbnail,
        "is_featured": isFeatured,
        "stock": stock,
        "rating": rating,
        "brand": brand,
        "views": views,
        "user_username": userUsername,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
