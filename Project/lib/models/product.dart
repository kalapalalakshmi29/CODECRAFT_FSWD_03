import 'package:mongo_dart/mongo_dart.dart';

class Product {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final String category;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.category,
  });

  Map<String, dynamic> toJson() => {
    '_id': ObjectId.fromHexString(id.length == 24 ? id : ObjectId().toHexString()),
    'name': name,
    'description': description,
    'price': price,
    'imageUrl': imageUrl,
    'category': category,
  };

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json['_id'].toString(),
    name: json['name'],
    description: json['description'],
    price: json['price'].toDouble(),
    imageUrl: json['imageUrl'],
    category: json['category'],
  );
}