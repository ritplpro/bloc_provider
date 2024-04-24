
import 'package:bloc_provider/bloc/database.dart';

import 'modal.dart';

abstract class NoteEvent {}


class Addbloc extends NoteEvent{
 BlocModal addevent;
  Addbloc({required this.addevent});
}

class Updatebloc extends NoteEvent{
  BlocModal updateevent;
  Updatebloc({required this.updateevent});
}

class Deletebloc extends NoteEvent{
  int id;
  Deletebloc({required this.id});
}

class fetchbloc extends NoteEvent{}
