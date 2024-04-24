import 'package:bloc_provider/bloc/database.dart';

class BlocModal{
  int? id;
  String title;
  String desc;
  BlocModal({this.id,required this.title,required this.desc});

  factory BlocModal.fromMap(Map<String,dynamic> map){
    return BlocModal(
      id: map[BlocDataBase.Column_ID],
        title: map[BlocDataBase.Column_Title],
        desc:map[BlocDataBase.Column_Desc]);
  }


  Map<String,dynamic> toMap(){
    return {
      BlocDataBase.Column_ID:id,
      BlocDataBase.Column_Title:title,
      BlocDataBase.Column_Desc:desc
    };
  }



}