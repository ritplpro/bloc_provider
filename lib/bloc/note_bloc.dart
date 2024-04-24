import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'database.dart';
import 'note_event.dart';
import 'note_state.dart';


class NoteBloc extends Bloc<NoteEvent, NoteState> {
  BlocDataBase BlocBase;
  NoteBloc({required this.BlocBase}):super(NoteInitial()){


    on<Addbloc>((event, emit) async {
      emit(LoadingState());
     var isadded=await BlocBase.addDataBase(insertData:event.addevent);
      if(isadded!=null ){
        var mData= await BlocBase.fetchDataBase();
        emit(LoadedState(allnotes: mData));
      }else{
        emit(ErrorState(errormsg: "note was not added!!"));
      }
    });

    on<Updatebloc>((event, emit) async {
      emit(LoadingState());
      var isupdated=await BlocBase.updateDataBase(updateNote:event.updateevent);
      if(isupdated!=null){
        var mData=await BlocBase.fetchDataBase();
        emit(LoadedState(allnotes: mData));
      }else{
        emit(ErrorState(errormsg: "not updated!!"));
      }
    });

    on<Deletebloc>((event, emit) async {
      emit(LoadingState());
      var isdeleted=await BlocBase.deleteDataBase(id: event.id);
      if(isdeleted!=null){
        var mData=await BlocBase.fetchDataBase();
        emit(LoadedState(allnotes: mData));
      }else{
        emit(ErrorState(errormsg: "not deleted!!"));
      }
    });


    on<fetchbloc>((event, emit) async {
      emit(LoadingState());
      var mData= await BlocBase.fetchDataBase();
      emit(LoadedState(allnotes: mData));



    });






  }
}
