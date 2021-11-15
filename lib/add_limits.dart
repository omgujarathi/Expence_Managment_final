import 'package:expence_management/set_limit_module.dart';
import 'package:expence_management/sumoflimamt().dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:expence_management/limits.dart';
import 'database_helper_limits.dart';
import 'expence_list.dart';
import 'home.dart';
class list_limit extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _list_limitState();
  }
}

class _list_limitState extends State<list_limit> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  late List<limit> atom_list=[];
  int count=0;
  @override
  int limitMonthlyxx=0;
  void get_shared_preferences(){
    Future<SharedPreferences> prefs = SharedPreferences.getInstance();
    prefs.then((prefs) {
      bool test=(prefs.getBool('checkvalue')??false);
      if(test){
        setState(() {
          Future<int> cat_amt= getcategorylimitAmount();
          cat_amt.then((cat_amtt){
            limitMonthlyxx = (prefs.getInt('limit') ?? 0 )+cat_amtt;});});
      }
      else{
        setState(() {

          limitMonthlyxx = (prefs.getInt('limit') ?? 0 );});}});
  }
  void initState() {
    updateListView();
    get_shared_preferences();
    super.initState();
  }
  void updateListView() {

    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((database) {

      Future<List<limit>> limitListFuture = databaseHelper.getlimitList();
      limitListFuture.then((limitList) {
        setState(() {
          atom_list = limitList;
          count = limitList.length;
          // if(count==0){
          //   int res1=await databaseHelper.insertlimit(limit('food',0,''));
          //   int res2=await databaseHelper.insertlimit(limit('shoping',0,''));
          //   print(res1);
          //   print(res2);
          // }
        });
      });
    });
  }
  bool isNumeric(String s) {
    if(s == null) {
      return false;
    }
    return double.parse(s, (e) => 0) !=0;
  }
  var _formKey = GlobalKey<FormState>();
  final double _minimumPadding = 5.0;
  TextEditingController descriptionController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    TextStyle? textStyle = Theme.of(context).textTheme.headline6;

    return Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
        title: Text("Categories",style:TextStyle(
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

                  '  hello world',

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
        body: Column(
          children: <Widget>[
            InkWell(
                onTap: () {
                  Future<void> models=showModalBottomSheet<dynamic>(

                      isScrollControlled: true,
                      context: context,
                      backgroundColor: Colors.transparent,
                      builder: (BuildContext bc) {
                        bool checkedValue=true;
                        return Container(
                            height: MediaQuery.of(context).size.height * 0.50,
                            decoration: new BoxDecoration(
                              color: Colors.white,
                              borderRadius: new BorderRadius.only(
                                topLeft: const Radius.circular(25.0),
                                topRight: const Radius.circular(25.0),
                              ),
                            ),
                            child:addlimit_amt());});
                  models.then((rr){
                    setState(() {
                      get_shared_preferences();
                    });

                  });},

                child:Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.fromLTRB(35,25,10,10),
                    child: Text(
                      limitMonthlyxx!=0?
                      'Limit for month: \u{20B9}$limitMonthlyxx':'Set limit',

                      style: TextStyle(
                      color: Color(0xFF5084bc),
                        fontWeight: FontWeight.w600,
                        fontSize: 22,
                      ),
                    ))),
        Expanded(
        child: ListView.builder(
          itemCount: count,
          itemExtent: 80.0,
          itemBuilder: (BuildContext context, int position) {
            return Padding(
              padding: const EdgeInsets.only(top:7.0,bottom:7.0),
              child: ListTile(

                  leading: IconButton(
                    icon: Icon(
                      Icons.arrow_right,
                      size: 30.0,color: Color(0xFF5084bc)
                    ), onPressed: () {  },),
                  title: Text(atom_list[position].category.toString()+'  -    Limit(\u{20B9}'+atom_list[position].limits_amount.toString()+')',textScaleFactor:1.3),
                  onTap: () {
                    limit_modelBottomsheet(atom_list[position]);
                  },
            subtitle: Text(atom_list[position].description),
                  onLongPress: (){
                    // var alertDialog = AlertDialog(
                    //     title: Text('date= ${atom_list[position].date}'),
                    //     content: Text(passwrdDetect(atom_list[position]))
                    // );
                    // debugPrint('hiii');
                    // showDialog(
                    //     context: context,
                    //     builder: (BuildContext context) => alertDialog);
                  },
                  trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        IconButton(
                            icon: Icon(
                                Icons.delete,
                                size: 20.0,color: Color(0xFF5084bc)
                            ),
                            onPressed: () {
                              alertDialogbox(context, atom_list[position]);
                            }
                        ),
                      ]
                  )
              ),);
          },),),]),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton (
          backgroundColor: Color(0xFF5084bc),
        // backgroundColor: Colors.cyanAccent[900],
        onPressed: (){
          limit_modelBottomsheet(limit('',0,''));
    },


    child: Icon(Icons.add_outlined,color: Colors.tealAccent[600]),
    tooltip: 'Add One More Item',
    )

    );
  }

  void alertDialogbox(BuildContext context,limit atom){
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
  void deleteNote(BuildContext context, limit atom) async{
    int result = await databaseHelper.deletelimit(int.parse(atom.id.toString()));
    updateListView();
  }

 void addCategory(limit lim) async{
   DatabaseHelper helper = DatabaseHelper();
  // final limit lim=limit('',0,'');
   lim.category=nameController.text;
   lim.limits_amount=int.parse(amountController.text);
   lim.description=descriptionController.text;
   if(lim.id!=null){
     int result1 = await helper.updatelimit(lim);
     if(result1%1==0) {
       descriptionController.text='';
       amountController.text='';
       nameController.text='';
       ScaffoldMessenger.of(context).showSnackBar(
         SnackBar(
           content: Text('expence added'),
           backgroundColor: Colors.greenAccent,
         ),
       );
       updateListView();
       get_shared_preferences();

     }
   }
   else{
   int result = await helper.insertlimit(lim);
   print('------------------*******************************-------');
  // print(result);
   if(result%1==0) {
     descriptionController.text='';
     amountController.text='';
     nameController.text='';
     ScaffoldMessenger.of(context).showSnackBar(
       SnackBar(
         content: Text('expence added'),
         backgroundColor: Colors.greenAccent,
       ),
     );
     updateListView();
     get_shared_preferences();

   }}
  }
  void limit_modelBottomsheet(limit lim_list){
    nameController.text=lim_list.category;
    descriptionController.text=lim_list.description;
    amountController.text=lim_list.limits_amount.toString();
    Future<void>check=showModalBottomSheet<dynamic>(
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
          child: Container(


            margin: const EdgeInsets.fromLTRB(0,2,0,0),
            padding: const EdgeInsets.all(3.0),

            child: Form(
              key: _formKey,
              child: Padding(
                  padding: EdgeInsets.all(_minimumPadding * 2),
                  child: ListView(
                    children: <Widget>[
                      Padding(
                          padding: EdgeInsets.only(
                            top: 40, bottom: _minimumPadding,left:15,right:15,),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                  child: TextFormField(
                                    controller: nameController,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter term';
                                      }

                                    },
                                    decoration: InputDecoration(
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(30.0),
                                          borderSide: const BorderSide(color: Color(0xFF5084bc), width: 2.0),
                                        ),
                                        labelText: 'category name',
                                        hintText: 'write category name',

                                        errorStyle: TextStyle(
                                            color: Colors.redAccent,
                                            fontSize: 15.0
                                        ),
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(30.0))
                                    ),
                                  )),
                              Container(
                                width: _minimumPadding * 6,
                              ),
                              Expanded(
                                  child: TextFormField(
                                    keyboardType: TextInputType.number,
                                    controller: amountController,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter term';
                                      }
                                      else if (!isNumeric(value)){
                                        return 'Please enter valid amount';
                                      }
                                    },
                                    decoration: InputDecoration(
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(30.0),
                                          borderSide: const BorderSide(color: Color(0xFF5084bc), width: 2.0),
                                        ),
                                        labelText: '\u{20B9}limit Amount',
                                        hintText: 'write limit amount',
                                        errorStyle: TextStyle(
                                            color: Colors.red,
                                            fontSize: 15.0
                                        ),
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(30.0))
                                    ),
                                  )),
                            ],
                          )),Padding(
                          padding: EdgeInsets.only(
                            top: 30, bottom: _minimumPadding,left:15,right:15,),
                          child: TextFormField(
                            controller: descriptionController,

                            decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                  borderSide: const BorderSide(color: Color(0xFF5084bc), width: 2.0),
                                ),
                                labelText: 'discription',
                                errorStyle: TextStyle(
                                    color: Colors.red,
                                    fontSize: 13.0
                                ),
                                border: OutlineInputBorder(
                                    borderSide: new BorderSide(color: Color(0xFF5084bc),),
                                    borderRadius: BorderRadius.circular(30.0))),
                          )),
                      Padding(
                        padding: EdgeInsets.only(
                          bottom: _minimumPadding, top: _minimumPadding,left: 80,right: 80,),
                        child: Expanded(
                            child: ElevatedButton(
                              child: Text('add',style: TextStyle(
                                fontSize: 25.0, // insert your font size here
                              ),),
                              style: ElevatedButton.styleFrom(
                                //minimumSize: Size(80, 20),
                                  primary: Color(0xFF5084bc),
                                  onPrimary: Colors.white,
                                  shape:
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                    side: BorderSide(color: Color(0xFF5084bc),width:2),
                                  )

                              ),
                              onPressed: () {
                                setState(() {
                                  if (_formKey.currentState!.validate()) {

                                    addCategory(lim_list);}

                                });
                              },
                            )),
                        //RaisedButton(
                        //   color: Theme.of(context).accentColor,
                        //   textColor: Theme.of(context).primaryColorDark,
                        //   child: Text(
                        //     'add',
                        //     textScaleFactor: 1.5,
                        //   ),
                        //   onPressed: () {
                        //     setState(() {
                        //       if (_formKey.currentState!.validate()) {
                        //         this.displayResult = _calculateTotalReturns();
                        //       }
                        //     });
                        //   },
                        // ),
                      ),



                    ],
                  )),
            ),

          ),
        );
      },
    );

  }
}
