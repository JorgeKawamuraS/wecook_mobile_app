import 'dart:convert';
import 'dart:developer';

import 'package:wecookmobile/api/profile.dart';

import 'cookbook.dart';
import 'tag.dart';
import 'ingredient.dart';
import 'multimedia.dart';

class Recipe{
  final int id;
  final String name;
  final int views;
  final bool exclusive;
  final String preparation;
  final String recommendation;
  final int profileId;
  final int cookbookId;

  Recipe({
    required this.id,
    required this.name,
    required this.views,
    required this.exclusive,
    required this.preparation,
    required this.recommendation,
    required this.profileId,
    required this.cookbookId

  });

  static Recipe objJson(Map<String, dynamic> json){
    return Recipe(
        id: json['id'] as int,
        name:json['name'] as String,
        views:json['views'] as int,
        exclusive:json['exclusive'] as bool,
        preparation:json['preparation'] as String,
        recommendation:json['recommendation'] as String,
        profileId: json['profileId'] as int,
        cookbookId: json['cookbookId'] as int);
  }

}