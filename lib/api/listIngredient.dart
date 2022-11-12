import 'dart:developer';

import 'package:wecookmobile/api/ingredient.dart';

class listIngredient{

  static List<Ingredient> listaIngredient(List<dynamic> listaJson){
    List<Ingredient> listadoIngredient = [];
    //log('listadoRecipepre: $listaJson');
    if(listaJson != null){
      for(var c in listaJson){
        //log('c: $c');
        final ca = Ingredient.objJson(c);
        //inspect(listaJson);
        //log('pepew: $ca');
        listadoIngredient.add(ca);
       // log('aaaaa: $listadoProfile');
      }
    }
    //log('data: $listadoRecipe');
    return listadoIngredient;
  }
}