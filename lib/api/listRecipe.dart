import 'dart:developer';

import 'package:wecookmobile/api/recipe.dart';

class listRecipe{

  static List<Recipe> listaRecipe(List<dynamic> listaJson){
    List<Recipe> listadoRecipe=[];
    log('listadoRecipepre: $listaJson');
    if(listaJson!=null){
      for(var c in listaJson){
        log('c: $c');
        final ca=Recipe.objJson(c);
        log('listado: $ca');
        listadoRecipe.add(ca);

      }
    }
    log('data: $listadoRecipe');
    return listadoRecipe;
  }
}