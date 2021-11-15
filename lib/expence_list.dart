import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:expence_management/note.dart';
import 'add_limits.dart';
import 'database_helper_exp.dart';
import 'expence_add.dart';
import 'home.dart';
class list_expence extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _list_expenceState();
  }
}

class _list_expenceState extends State<list_expence> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  late List<Note> atom_list;
  int count=0;
  @override
  void initState() {
  updateListView();
  super.initState();
  }
  void updateListView() {

    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((database) {

      Future<List<Note>> noteListFuture = databaseHelper.getNoteList();
      noteListFuture.then((noteList) {
        setState(() {
          atom_list = noteList;
          count = noteList.length;
        });
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
          title: Text("Expence history",style:TextStyle(
            color: Colors.black,
            // fontWeight: FontWeight.w500,
            fontSize: 22,
          )),iconTheme: IconThemeData(color: Colors.black),
          backgroundColor:Colors.white,
        ),

        drawer: Theme(
        data: Theme.of(context).copyWith(
        canvasColor: Colors.grey[300], //This will change the drawer background to blue.
        //other styles
        ),child:Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Text(

                  '  Hello world!',

                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 30,
                  ),
                ),
              ),
              ListTile(
                  leading: Icon(Icons.home,color: Color(0xFF5084bc)),
                  title: Text('home'),
                  onTap: (){Navigator.pushAndRemoveUntil(context,
                    MaterialPageRoute(
                      builder: (context) => SIForm(),
                    ),
                        (Route<dynamic> route) => false,
                  );}
              ),
              ListTile(
                  leading: Icon(Icons.history,color: Color(0xFF5084bc)),
                  title: Text('expence history'),
                  onTap: (){Navigator.push(context,
                    MaterialPageRoute(
                      builder: (context) => list_expence(),
                    ),
                  );}
              ),
              ListTile(
                  leading: Icon(Icons.account_circle,color: Color(0xFF5084bc)),
                  title: Text('spending categories'),
                  onTap: (){Navigator.push(context,
                    MaterialPageRoute(
                      builder: (context) => list_limit(),
                    ),
                  );}
              ),
              ListTile(
                leading: Icon(Icons.settings,color: Color(0xFF5084bc)),
                title: Text('Settings'),
              ),
            ],
          ),
        ),),
        body:ListView.builder(
          itemCount: count,
          itemExtent: 80.0,
          itemBuilder: (BuildContext context, int position) {
            return Padding(
              padding: const EdgeInsets.only(top:7.0,bottom:7.0),
              child: ListTile(

                  leading: IconButton(
                      icon: Icon(
                        Icons.arrow_right_outlined,
                          color: Color(0xFF5084bc),
                    size: 30.0,
                      ), onPressed: () {  },),
                  title: Text(atom_list[position].category.toString()+'  → '+atom_list[position].amount.toString(),textScaleFactor:1.3),
                  subtitle: Text(atom_list[position].date.toString()+'  '+atom_list[position].description.toString(),overflow: TextOverflow.ellipsis,maxLines: 1),
                  onTap: () {
                    updateexpence(context,atom_list[position]);
                  },
                  onLongPress: (){
                    var alertDialog = AlertDialog(
                        title: Text('time= ${atom_list[position].time}'),
                        content: Text('description= ${atom_list[position].description}'),
                    );
                    debugPrint('hiii');
                    showDialog(
                        context: context,
                        builder: (BuildContext context) => alertDialog);
                  },
                  trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        IconButton(
                            icon: Icon(
                                Icons.delete_outline,
                                size: 20.0,
                      color: Color(0xFF5084bc),
                              //  color: Colors.cyanAccent
                            ),
                            onPressed: () {
                              alertDialogbox(context, atom_list[position]);
                            }
                        ),
                      ]
                  )
              ),);
          },),
        floatingActionButton: FloatingActionButton (
          backgroundColor: Color(0xFF5084bc),
          onPressed: (){
            Navigator.pushAndRemoveUntil(context,
              MaterialPageRoute(
                builder: (context) => SIForm(),
              ),
                  (Route<dynamic> route) => false,
            );
          },


          child: Icon(Icons.add_outlined,color: Colors.tealAccent[600]),
          tooltip: 'Add One More Item',
        )
    );
  }
  void alertDialogbox(BuildContext context,Note atom){
    var alertDialogbox = AlertDialog(
      title: Text('delete note?'),

      content: Padding(
        padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
        child: Row(
          children: <Widget>[
            Expanded(
              child: RaisedButton(
                color: Color(0xFF5084bc),
                textColor: Colors.grey[300],
                child: Text(
                  'delete',
                  textScaleFactor: 1.3,

                ),
                onPressed: () {
                  deleteNote(context,atom);
                  Navigator.of(context, rootNavigator: true).pop('dialog');
                  // goBack();
                },
              ),
            ),
            Container(width: 5.0, height: 0,),
            Expanded(
              child: RaisedButton(
                  color: Colors.grey[300],
                  textColor: Color(0xFF5084bc),
                  child: Text(
                    'Don\'t delete',
                    textScaleFactor: 1.3,
                  ),
                  onPressed: () {
                    Navigator.of(context, rootNavigator: true).pop('dialog');
                  }
              ),
            ),
          ],
        ),),);
    showDialog(
        context: context,
        builder: (BuildContext context) => alertDialogbox);
  }
  void deleteNote(BuildContext context, Note atom) async{
    int result = await databaseHelper.deleteNote(int.parse(atom.id.toString()));
    updateListView();
  }
void updateexpence(BuildContext context,Note atom){
  Future<void> future=showModalBottomSheet<dynamic>(
      isScrollControlled: true,
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext bc) {
    return Container(
        height: MediaQuery.of(context).size.height * 0.50,
  decoration: new BoxDecoration(
  color: Colors.white,
  borderRadius: new BorderRadius.only(
  topLeft: const Radius.circular(25.0),
  topRight: const Radius.circular(25.0),
  ),
  ),
  child: expence_add(atom),);
}
  );
  future.then((value) => updateListView());
  }

}
