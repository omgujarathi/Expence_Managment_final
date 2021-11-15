import 'database_helper_limits.dart';
import 'limits.dart';

Future<bool> addCategory(String Description,String amount,String name) async{
  DatabaseHelper helper = DatabaseHelper();
  final limit lim=limit('',0,'');
  lim.category=name;
  lim.limits_amount=int.parse(amount);
  lim.description=Description;
  int result = await helper.insertlimit(lim);
  print('------------------*******************************-------');
  print(result);
  if(result%1==0) {
    return true;
  }
  return false;
}