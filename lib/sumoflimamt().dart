import 'database_helper_limits.dart';

Future<int> getcategorylimitAmount()async{
  DatabaseHelper helper = DatabaseHelper();
  int a=await helper.getsum();
  // a.then((amnt){
  //   setState(() {
  //     cat_amt=amnt;});
  // });
  return a;
}




// import 'package:sqflite/sqflite.dart';
//
// import 'database_helper_limits.dart';
// import 'limits.dart';
// class category{
//
//
// //   static Future<List<String>> categoryListView() async{
// //     DatabaseHelper databaseHelper = DatabaseHelper();
// //     List<String> atom_list=[];
// //     print('res1------------------------------------------------1');
// //     int count=0;
// //     Database dbFuture = await databaseHelper.initializeDatabase();
// //     //dbFuture.then((database) {
// //     print('res1------------------------------------------------3');
// //     List<String> limitListFuture = await databaseHelper.getcatagoryList();
// //     //  limitListFuture.then((limitList) async {
// //     atom_list = limitListFuture;
// //     print('res1------------------------------------------------4');
// //     count = limitListFuture.length;
// //     if(count==0){
// //       Future<int> res1=databaseHelper.insertlimit(limit('food',0,''));
// //       res1.then((databa) {
// //         Future<int> res2=databaseHelper.insertlimit(limit('shoping',0,''));
// //         res2.then((databa) {
// //
// //         });
// //       });
// //       print(res1);
// //       print('res1------------------------------------------------');
// //       // print(res2);
// //     }
// //     //  });
// //     // });
// //     return atom_list;
// //   }
// // }