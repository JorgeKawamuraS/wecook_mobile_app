import 'dart:developer';

import 'package:wecookmobile/api/cookbook.dart';

class listCookbook{

  static List<Cookbook> listaCookbook(List<dynamic> listaJson){
    List<Cookbook> listadoCookbook=[];
    //log('listadoRecipepre: $listaJson');
    if(listaJson!=null){
      for(var c in listaJson){
        //log('c: $c');
        final ca=Cookbook.objJson(c);
        //inspect(ca);
        listadoCookbook.add(ca);
        //log('aaaaa: $listadoRecipe');
      }
    }
    //log('data: $listadoRecipe');
    return listadoCookbook;
  }
}