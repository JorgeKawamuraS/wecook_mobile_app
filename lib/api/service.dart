import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:wecookmobile/api/recipe.dart';
import 'listRecipe.dart';


class service{

  static Future<List<Recipe>> getRecipe() async{

    final rspta=await http.get(Uri.parse('http://192.168.1.36:8092/recipes'));

    if(rspta.statusCode==200){
      final rsptaJson=json.decode(rspta.body);
      log('data: $rsptaJson');
      final todosRecipe=listRecipe.listaRecipe(rsptaJson);
      return todosRecipe;
    }
    return <Recipe>[];
  }

}