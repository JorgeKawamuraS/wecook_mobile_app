import 'dart:convert';

class Ingredient{
  final int id;
  final String name;
  final double calories;
  final double price;

  Ingredient({
    required this.id,
    required this.name,
    required this.calories,
    required this.price,
  });

  static Ingredient objJson(Map<String, dynamic> json){
    return Ingredient(
      id: json['id'] as int,
      name: json['name'] as String,
      calories: json['calories'] as double,
      price: json['price'] as double,
    );
  }

}