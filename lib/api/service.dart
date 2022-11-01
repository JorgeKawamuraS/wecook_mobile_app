import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:wecookmobile/api/profile.dart';
import 'package:wecookmobile/api/recipe.dart';
import 'listProfile.dart';
import 'listRecipe.dart';


class service{

  static Future<List<Recipe>> getRecipe() async{

    final rspta=await http.get(Uri.parse('http://ec2-44-202-132-149.compute-1.amazonaws.com:8093/recipes'));

    if(rspta.statusCode==200){
      final rsptaJson=json.decode(rspta.body);
      //log('data: $rsptaJson');
      final todosRecipe=listRecipe.listaRecipe(rsptaJson);
     // log('data222: $todosRecipe');
      return todosRecipe;
    }
    return <Recipe>[];
  }
  static Future<List<Profile>> getProfile() async{

    final rspta=await http.get(Uri.parse('http://ec2-44-202-132-149.compute-1.amazonaws.com:8093/profiles'));

    if(rspta.statusCode==200){
      final rsptaJson=json.decode(rspta.body);
      //log('data: $rsptaJson');
      final todosProfile=listProfile.listaProfile(rsptaJson);
      // log('data222: $todosRecipe');
      return todosProfile;
    }
    return <Profile>[];
  }

  static Future<Profile> getProfileById() async{

    final rspta=await http.get(Uri.parse('http://ec2-44-202-132-149.compute-1.amazonaws.com:8093/profiles/1'));

    if(rspta.statusCode==200){
      final rsptaJson=json.decode(rspta.body);
      log('data: $rsptaJson');
      final profile=Profile.objJson(rsptaJson);
      // log('data222: $todosRecipe');
      //return todosProfile;
      return profile;
    }
    else{
      throw Exception('Failed to load profile');
    }
   // return <Profile>[];
  }

}