import 'dart:convert';

class Multimedia{
  final int id;
  final String url;

  Multimedia({
    required this.id,
    required this.url,
  });

  static Multimedia objJson(Map<String, dynamic> json){
    return Multimedia(
      id: json['id'] as int,
      url:json['url'] as String,

    );
  }

}