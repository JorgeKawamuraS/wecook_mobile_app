import 'dart:convert';

class Profile{
  final int id;
  final String name;
  final String profilePictureUrl;
  final String gender;
  final String birthdate;
  final double subscribersPrice;
  final bool subsOn;
  final bool tipsOn;
  final int dni;

  Profile({
    required this.id,
    required this.name,
    required this.profilePictureUrl,
    required this.gender,
    required this.birthdate,
    required this.subscribersPrice,
    required this.subsOn,
    required this.tipsOn,
    required this.dni,
  });

  static Profile objJson(Map<String, dynamic> json){
    return Profile(
      id: json['id'] as int,
      name:json['name'] as String,
      profilePictureUrl:json['profilePictureUrl'] as String,
      gender:json['gender'] as String,
      birthdate:json['birthdate'] as String,
      subscribersPrice: json['subscribersPrice'] as double,
      subsOn: json['subsOn'] as bool,
      tipsOn: json['tipsOn'] as bool,
      dni:json['dni'] as int,
    );
  }

}