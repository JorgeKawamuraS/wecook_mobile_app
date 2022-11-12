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
  // final List<Multimedia> multimedia;
  // final List<Tag> tags;
  final List<Ingredient> ingredients;

  Recipe({
    required this.id,
    required this.name,
    required this.views,
    required this.exclusive,
    required this.preparation,
    required this.recommendation,
    required this.profileId,
    required this.cookbookId,
    // required this.multimedia,
    // required this.tags,
    required this.ingredients

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
        cookbookId: json['cookbookId'] as int,
        // multimedia: json['multimedia'] as List<Multimedia>,
        // tags: json['tags'] as List<Tag>,
        ingredients: List<Ingredient>.from(json['ingredients'].map((x)=>Ingredient.objJson(x)))
        // ingredients: json['ingredients'].map((value)=>
        //     Ingredient.objJson(value)).toList() as List<Ingredient>
    );
  }

}