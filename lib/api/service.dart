import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:wecookmobile/api/profile.dart';
import 'package:wecookmobile/api/multimedia.dart';
import 'package:wecookmobile/api/recipe.dart';
import 'ingredient.dart';
import 'listProfile.dart';
import 'listRecipe.dart';
import 'listIngredient.dart';
import 'package:wecookmobile/api/comment.dart';
import 'listComment.dart';
import 'user.dart';
import 'package:wecookmobile/globals.dart' as globals;



class service{


  static Future<List<Ingredient>> getAllIngredients() async{

    final rspta = await http.get(Uri.parse('${globals.url}recipes/ingredients'));

    if(rspta.statusCode == 200){
      final rsptaJson = json.decode(rspta.body);
      //log('data: $rsptaJson');
      final allIngredients = listIngredient.listaIngredient(rsptaJson);
      // log('data222: $todosRecipe');
      return allIngredients;
    }
    return <Ingredient>[];
  }

  static Future<List<Recipe>> getRecipe() async{

    final rspta=await http.get(Uri.parse('${globals.url}recipes'));
   //log('data: $rspta');
    if(rspta.statusCode==200){
      final rsptaJson=json.decode(rspta.body);
      final rsptacero=rsptaJson[0];
      //log('rsptaJson: $rsptacero');
      final todosRecipe=listRecipe.listaRecipe(rsptaJson);
     // log('data222: $todosRecipe');
      return todosRecipe;
    }
    return <Recipe>[];
  }


  static Future<List<Profile>> getProfile() async{

    //log('getprofile');
    final rspta=await http.get(Uri.parse('${globals.url}profiles'));
    //log('rptass');


    if(rspta.statusCode==200){
      final rsptaJson=json.decode(rspta.body);
      //log('data: $rsptaJson');
      final todosProfile=listProfile.listaProfile(rsptaJson);
     // log('data222: $todosProfile');
      return todosProfile;
    }
    return <Profile>[];
  }

  static Future<Profile> getProfileById() async{

    final rspta=await http.get(Uri.parse('${globals.url}profiles/1'));

    if(rspta.statusCode==200){
      final rsptaJson=json.decode(rspta.body);
      //log('data: $rsptaJson');
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

  static Future<Profile> getObjectProfileById(int id) async{

    final rspta=await http.get(Uri.parse('${globals.url}profiles/$id'));

   log('rspta');
    if(rspta.statusCode==200){
      final rsptaJson=json.decode(rspta.body);
     log('data: $rsptaJson');
      final profile=Profile.objJson(rsptaJson);
      log('data222: $profile');
      //return todosProfile;
      return profile;
    }
    else{
      throw Exception('Failed to load profile');
    }
   // return <Profile>[];
  }

  static Future<Multimedia> getMultimediaByRecipeId(recipeId) async{

    // log('profile id');

    final rspta=await http.get(Uri.parse('${globals.url}recipes/$recipeId/multimedia'));

  //  log('rspta');
    if(rspta.statusCode==200){
      final rsptaJson=json.decode(rspta.body);
     // log('data: ${rsptaJson[0]}');
      final multimedia=Multimedia.objJson(rsptaJson[0]);
     // log('data222: $multimedia');
      //return todosProfile;
      return multimedia;
    }
    else{
      throw Exception('Failed to load multimedia');
    }
    // return <Profile>[];
  }

  static Future<int> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('${globals.url}profiles/users/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'password':password
      }),
    );

    if (response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      final data=User.objJson(jsonDecode(response.body));

      final userId= data.id;
      //log('200: $data');
      //log('200: $userId');
      return userId;
    } else {
      //log('200 no');
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      return 0;
    }
  }

  static Future<List<Comment>> getComment(int recipeId) async{

    final rspta=await http.get(Uri.parse('${globals.url}recipes/$recipeId/comments'));
    //log('data: $rspta');
    if(rspta.statusCode==200){
      final rsptaJson=json.decode(rspta.body);
     // log('data: $rsptaJson');
      final todosComment=listComment.listaComment(rsptaJson);
      // log('data222: $todosRecipe');
      return todosComment;
    }
    return <Comment>[];
  }

  static Future<int> createComment(String text, int profileId,int recipeId) async {
    final response = await http.post(
      Uri.parse('${globals.url}recipes/$recipeId/comments'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<dynamic, dynamic>{
        'text': text,
        'profileId': profileId,
      }),
    );

    //log((response.statusCode).toString());
    if (response.statusCode == 201) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.

      //final data=User.objJson(jsonDecode(response.body));
      //final userId= data.id;
      //log('200: $data');
      //log('200: $userId');
      return response.statusCode;
    } else {
      //log('200 no');
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      return 0;
    }
  }
}