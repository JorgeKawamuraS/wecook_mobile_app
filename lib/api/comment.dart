import 'dart:convert';
import 'dart:developer';

import 'package:wecookmobile/api/profile.dart';

import 'cookbook.dart';
import 'tag.dart';
import 'ingredient.dart';
import 'multimedia.dart';

class Comment{
  final int id;
  final String text;
  final int profileId;


  Comment({
    required this.id,
    required this.text,
    required this.profileId,


  });

  static Comment objJson(Map<String, dynamic> json){
    return Comment(
      id: json['id'] as int,
      text:json['text'] as String,
      profileId:json['profileId'] as int,
    );
  }

}