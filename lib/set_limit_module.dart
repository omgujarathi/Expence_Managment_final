import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:expence_management/note.dart';
import 'add_limits.dart';
import 'database_helper_limits.dart';
import 'home.dart';
import 'lastweekGraph.dart';
import 'lim_list.dart';
import 'add_category.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:expence_management/sumoflimamt().dart';

class addlimit_amt extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return addlimit_amtState();
  }

}
class addlimit_amtState extends State<addlimit_amt>{

var _formKey1 = GlobalKey<FormState>();
final double _minimumPadding = 5.0;
TextEditingController LimitController = TextEditingController();
bool isNumeric(String s) {
  if(s == null) {
    return false;
  }
  return double.parse(s, (e) => 0) !=0;
}
bool checkedValue=false;
// int cat_amt=0;
// void getcategorylimitAmountt(){
//   DatabaseHelper helper = DatabaseHelper();
//   Future<int> a= helper.getsum();
//   a.then((amnt){
//     setState(() {
//     cat_amt=amnt;});
//   });
// }
// int limitmonthly=0;
// void get_shared_preferences(){
//   Future<SharedPreferences> prefs = SharedPreferences.getInstance();
//   prefs.then((prefs) {
//     bool test=(prefs.getBool('checkvalue')??false);
//     if(test){
//       setState(() {
//       Future<int> cat_amt= getcategorylimitAmount();
//       cat_amt.then((cat_amtt){
//         limitmonthly = (prefs.getInt('limit') ?? 0 )+cat_amtt;});});
//     }
//     else{
//       setState(() {
//
//         limitmonthly = (prefs.getInt('limit') ?? 0 );});}});
// // }
// @override
// void initState() {
//   get_shared_preferences();
//   super.initState();
// }
@override
Widget build(BuildContext context) {

  return Container(
          //
          //
          // margin: const EdgeInsets.fromLTRB(0,2,0,0),
          // padding: const EdgeInsets.all(3.0),

          child: Form(
            key: _formKey1,
            child: Padding(
                padding: EdgeInsets.all(_minimumPadding * 2),
                child: ListView(
                  children: <Widget>[
                    Padding(
                        padding: EdgeInsets.only(
                          top: 40, bottom: _minimumPadding,left:15,right:15,),

                            child: Expanded(
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  controller: LimitController,
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
                                          color: Colors.redAccent,
                                          fontSize: 15.0
                                      ),
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(30.0))
                                  ),
                                )),
                    ),
                    Padding(
                        padding: EdgeInsets.only(
                          top: 30, bottom: _minimumPadding,left:15,right:15,),
                        child: CheckboxListTile(
                          title: Text("add limit amount to this limit amount from category wise list "),
                          value: checkedValue,
                          onChanged: (newValue) {
                            setState(() {
                              checkedValue = newValue!;
                            });
                          },
                          controlAffinity: ListTileControlAffinity.leading,  //  <-- leading Checkbox
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

                                if (_formKey1.currentState!.validate()) {
                                  Future<SharedPreferences> res =  SharedPreferences.getInstance();
                                  res.then((prefs){
                                    Future<void>resultl= prefs.setBool('checkvalue', checkedValue);
                                    resultl.then((result){

                                      Future<void>result= prefs.setInt('limit', int.parse(LimitController.text));
                                      result.then((resu){
                                        LimitController.text='';
                                        Navigator.pop(context);
                                      });

                                    });
                              
                                  });
                                }

                              })

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




                  ],
                )),
          ),

        );

    }


  }