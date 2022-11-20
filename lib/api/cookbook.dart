import 'dart:convert';

class Cookbook{
  final int id;
  final String name;

  Cookbook({
    required this.id,
    required this.name,
  });

  static Cookbook objJson(Map<String, dynamic> json){
    return Cookbook(
      id: json['id'] as int,
      name:json['name'] as String
    );
  }

}