import 'package:flutter_test_app/model/safe_convert.dart';

class ProductListModelItem {
  final int id;
  final String title;
  final String slug;
  final int price;
  final String description;
  final Category category;
  final List<String> images;
  final String creationAt;
  final String updatedAt;

  ProductListModelItem({
    this.id = 0,
    this.title = "",
    this.slug = "",
    this.price = 0,
    this.description = "",
    required this.category,
    this.images = const [],
    this.creationAt = "",
    this.updatedAt = "",
  });

  factory ProductListModelItem.fromJson(Map<String, dynamic>? json) => ProductListModelItem(
    id: asT<int>(json, 'id'),
    title: asT<String>(json, 'title'),
    slug: asT<String>(json, 'slug'),
    price: asT<int>(json, 'price'),
    description: asT<String>(json, 'description'),
    category: Category.fromJson(asT<Map<String, dynamic>>(json, 'category')),
    images: asT<List>(json, 'images').map((e) => e.toString()).toList(),
    creationAt: asT<String>(json, 'creationAt'),
    updatedAt: asT<String>(json, 'updatedAt'),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'slug': slug,
    'price': price,
    'description': description,
    'category': category.toJson(),
    'images': images.map((e) => e).toList(),
    'creationAt': creationAt,
    'updatedAt': updatedAt,
  };
}

class Category {
  final int id;
  final String name;
  final String slug;
  final String image;
  final String creationAt;
  final String updatedAt;

  Category({
    this.id = 0,
    this.name = "",
    this.slug = "",
    this.image = "",
    this.creationAt = "",
    this.updatedAt = "",
  });

  factory Category.fromJson(Map<String, dynamic>? json) => Category(
    id: asT<int>(json, 'id'),
    name: asT<String>(json, 'name'),
    slug: asT<String>(json, 'slug'),
    image: asT<String>(json, 'image'),
    creationAt: asT<String>(json, 'creationAt'),
    updatedAt: asT<String>(json, 'updatedAt'),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'slug': slug,
    'image': image,
    'creationAt': creationAt,
    'updatedAt': updatedAt,
  };
} 

