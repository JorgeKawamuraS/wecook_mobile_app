import 'dart:convert';

class Profile{
  final int id;
  final String name;
  final String profilePictureUrl;
  final int DNI;
  final String gender;
  final DateTime birthdate;
  final int subscribersPrice;
  final bool subsOn;
  final bool tipsOn;

  Profile({
    required this.id,
    required this.name,
    required this.profilePictureUrl,
    required this.DNI,
    required this.gender,
    required this.birthdate,
    required this.subscribersPrice,
    required this.subsOn,
    required this.tipsOn,
  });

}