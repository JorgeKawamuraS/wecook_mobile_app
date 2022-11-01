import 'dart:developer';

import 'package:wecookmobile/api/profile.dart';

class listProfile{

  static List<Profile> listaProfile(List<dynamic> listaJson){
    List<Profile> listadoProfile=[];
    //log('listadoRecipepre: $listaJson');
    if(listaJson!=null){
      for(var c in listaJson){
        log('c: $c');
        final ca=Profile.objJson(c);
        //inspect(listaJson);
        //log('pepew: $ca');
        listadoProfile.add(ca);
       // log('aaaaa: $listadoProfile');
      }
    }
    //log('data: $listadoRecipe');
    return listadoProfile;
  }
}