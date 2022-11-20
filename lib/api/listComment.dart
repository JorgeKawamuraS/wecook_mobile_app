import 'dart:developer';

import 'package:wecookmobile/api/comment.dart';

class listComment{

  static List<Comment> listaComment(List<dynamic> listaJson){
    List<Comment> listadoComment=[];
    //log('listadoRecipepre: $listaJson');
    if(listaJson!=null){
      for(var c in listaJson){
        //log('c: $c');
        final ca=Comment.objJson(c);
        //inspect(ca);
        listadoComment.add(ca);
        //log('aaaaa: $listadoRecipe');
      }
    }
    //log('data: $listadoRecipe');
    return listadoComment;
  }
}