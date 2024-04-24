


import 'modal.dart';

abstract class NoteState {}

 class NoteInitial extends NoteState {}

 class LoadingState extends NoteState {}

 class LoadedState extends NoteState {
  List<BlocModal> allnotes=[];
  LoadedState({ required this.allnotes});
}

class ErrorState extends NoteState {
  String errormsg;
  ErrorState({required this.errormsg});
}

