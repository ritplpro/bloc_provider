
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'modal.dart';


class BlocDataBase{

  BlocDataBase._();

  static final BlocDataBase BlocBase=BlocDataBase._();

  static const String Table_Name="notebloc";
  static const String Column_ID="note_id";
  static const String Column_Title="note_title";
  static const String Column_Desc="note_desc";




  Database? myData;

  createBase() async {
    if(myData != null){
      return myData;
    }else{
      var myData=await initBase();
      return myData;
    }
  }

  initBase() async {
    var mpath=await getApplicationDocumentsDirectory();
    var actualpath=join(mpath.path,"Nobloc.db");
    return await openDatabase(actualpath,version: 1,onCreate: (BlocBase,version){
      BlocBase.execute("Create table $Table_Name ( $Column_ID integer primary key autoincrement, $Column_Title text, $Column_Desc text )");
    });

  }

     addDataBase({required BlocModal insertData}) async {
    var adddata=await BlocBase.createBase();
    var check =adddata.insert(Table_Name,insertData.toMap());
    return check;

  }

  fetchDataBase() async {
    var adddata=await BlocBase.createBase();
    var find= await adddata.query(Table_Name);
    List<BlocModal> bData=[];

    for(Map<String,dynamic> eachModal in find){
      var alldata=BlocModal.fromMap(eachModal);
      bData.add(alldata);
    }
    return bData;

  }

   updateDataBase({required BlocModal updateNote}) async {
    var upddata=await BlocBase.createBase();
    var check =upddata.update(Table_Name,updateNote.toMap(),where: "$Column_ID = ${updateNote.id}");
    return check;
  }

  deleteDataBase({required int id}) async {
    var adddata=await BlocBase.createBase();
    var check=adddata.delete(Table_Name,where:"$Column_ID = ?",whereArgs:["$id"]);
    return check;

  }




}