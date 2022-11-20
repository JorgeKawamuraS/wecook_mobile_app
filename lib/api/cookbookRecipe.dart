import 'dart:convert';

class CookbookR{
  final int id;

  CookbookR({
    required this.id,
  });

  static CookbookR objJson(Map<String, dynamic> json){
    return CookbookR(
        id: json['id'] as int,
    );
  }

}