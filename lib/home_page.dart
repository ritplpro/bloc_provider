


import 'package:bloc_provider/bloc/modal.dart';
import 'package:bloc_provider/bloc/note_bloc.dart';
import 'package:bloc_provider/bloc/note_event.dart';
import 'package:bloc_provider/bloc/note_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class MyHomePage extends StatefulWidget {
  bool isUpdated;
  BlocModal? blocModal;
  MyHomePage({this.isUpdated=false,this.blocModal});



  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var titleController=TextEditingController();
  var descController=TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<NoteBloc>().add(fetchbloc());

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('bloc provider'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body:BlocBuilder<NoteBloc, NoteState>(
        builder: (context, state) {
          if(State is LoadingState){
            return Center(child: CircularProgressIndicator());
          }else if(state is ErrorState){
            return Center(child: Text(state.errormsg));
          }else if(state is LoadedState){
            var mData=state.allnotes;

            return ListView.builder(
                itemCount:mData.length,
                itemBuilder: (context,index){
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 4,
                        spreadRadius: 1,
                        color: Theme.of(context).colorScheme.inversePrimary
                      )
                    ]
                  ),
                  child: ListTile(
                    onTap: (){
                      titleController.text=mData[index].title;
                      descController.text=mData[index].desc;
                      showModalBottomSheet(context: context, builder: (context){
                        return bottomsSheet(isUpdated: true,blocModal: mData[index].id);
                      });
                    },
                    leading: Text('${index+1}'),
                    title: Text(mData[index].title),
                    subtitle:Text(mData[index].desc),
                    trailing: IconButton(onPressed: (){
                      context.read<NoteBloc>().add(Deletebloc(id:mData[index].id!));
                    },icon: Icon(Icons.delete)),
                  ),
                ),
              );
            });
          }else{
            return Container();
          }
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          showModalBottomSheet(context: context, builder: (context){
            titleController.clear();
            descController.clear();
            return bottomsSheet(isUpdated: false);
          });

        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget bottomsSheet({isUpdated,blocModal}){
    return Padding(
      padding: const EdgeInsets.all(11.0),
      child: Center(
        child: Column(
          children: [
            Text(isUpdated ? "Update Data" :'Add Data'),
            SizedBox(height: 10),
            Row(
              children: [
                Text('Enter Title'),
              ],
            ),
            SizedBox(height: 10),
            TextField(
              controller: titleController,
              keyboardType: TextInputType.text,
              autofocus: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(23)
                )
              ),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Text('Enter subtitle'),
              ],
            ),
            SizedBox(height: 10),
            TextField(
              controller: descController,
              keyboardType: TextInputType.text,
              autofocus: true,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(23)
                  )
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(onPressed: (){

                  if(isUpdated!=true) {
                    context.read<NoteBloc>().add(Addbloc(addevent:  BlocModal(
                        title: titleController.text,
                        desc: descController.text)));


                    Navigator.pop(context);
                  }else{
                    context.read<NoteBloc>().add(Updatebloc(updateevent:BlocModal(
                      id: blocModal,
                        title:titleController.text,
                        desc:descController.text)));

                    Navigator.pop(context);


                  }



                }, child:Text(isUpdated ? "Update Data" :'Add Data')),
                ElevatedButton(onPressed: (){
                  Navigator.pop(context);
                }, child:Text('Cancel')),
              ],
            ),



          ],
        ),
      ),
    );
  }
}


