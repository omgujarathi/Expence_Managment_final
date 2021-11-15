import 'package:expence_management/expence_list.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:expence_management/note.dart';
import 'add_limits.dart';
import 'lastweekGraph.dart';
import 'lim_list.dart';
import 'database_helper_exp.dart';
import 'add_category.dart';
//import 'package:syncfusion_flutter_charts/charts.dart';
//import 'package:example/demo/pie_chart/half_pie.dart';
void home() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Simple Interest Calculator App',
    home: SIForm(),
    theme: ThemeData(
      // brightness: Brightness.dark,
      // primaryColor: Colors.indigo,
      // accentColor: Colors.indigoAccent
    ),
  ));
}

class SIForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SIFormState();
  }
}

class _SIFormState extends State<SIForm> {
  bool isNumeric(String s) {
    if(s == null) {
      return false;
    }
    return double.parse(s, (e) => 0) !=0;
  }
  void addcategory(BuildContext context){ showModalBottomSheet<dynamic>(
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
                        child: Row(
                          children: <Widget>[
                            Expanded(
                                child: TextFormField(
                                  controller: nameMController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter term';
                                    }

                                  },
                                  decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30.0),
                                        borderSide: const BorderSide(color: Colors.blue, width: 2.0),
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
                                  controller: amountMController,
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
                                        borderSide: const BorderSide(color: Colors.blue, width: 2.0),
                                      ),
                                      labelText: '\u{20B9}limit Amount',
                                      hintText: 'write limit amount',
                                      errorStyle: TextStyle(
                                          color: Colors.yellowAccent,
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
                          controller: descriptionMController,
                          decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                                borderSide: const BorderSide(color: Colors.blue, width: 2.0),
                              ),
                              labelText: 'discription',
                              errorStyle: TextStyle(
                                  color: Colors.yellowAccent,
                                  fontSize: 13.0
                              ),
                              border: OutlineInputBorder(
                                  borderSide: new BorderSide(color: Colors.blue),
                                  borderRadius: BorderRadius.circular(15.0))),
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
                                    primary: Colors.blue,
                                    onPrimary: Colors.white,
                                    shape:
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                      side: BorderSide(color: Colors.blue,width:2),
                                    )

                                ),
                                onPressed: () {

                                  if (_formKey1.currentState!.validate()) {
                                    Future<bool> res= addCategory(descriptionMController.text,amountMController.text,nameMController.text);
                                    res.then((ress){
                                      setState(() {
                                        descriptionMController.text='';
                                        amountMController.text='';
                                        nameMController.text='';
                                        category_list();
                                        Navigator.pop(context);
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

        ),
      );
    },
  );
  }
  var _formKey = GlobalKey<FormState>();
  var _formKey1 = GlobalKey<FormState>();

  var dropDownCategory='';
  var _category = ['food', 'shopping','rent'];

  final double _minimumPadding = 5.0;
  late final Note note=Note('','','',0,'');
  var _currentItemSelected = '';
  late List<lastweekdata> _chartData= [
  ];
  DatabaseHelper helper = DatabaseHelper();
  late List<lastweekdata> _chartData1=[];
  void getweekdata(){
    print('----------------------------------ok-------');
    Future<List<lastweekdata>>_chartData2=  helper.lastweek();
    _chartData2.then((dataa){
      setState(() {
        _chartData1=dataa;
      });
      print(dataa);
    });
  }
  void getmonthdata(){
    print('-------------------------------pl----------');
    var dt1 = DateTime.now();
    var newFormatx = DateFormat("yyyy-MM-dd");
    String monthNo = newFormatx.format(dt1);
    print('---------------------------------ko--------');

    print(monthNo.substring(0,7));
    Future<int>_chartData3=  helper.month(monthNo.substring(0,7));
    _chartData3.then((dataa){
      setState(() {
        _chartData=[lastweekdata('limit',dataa)];
      });

    });
  }
  late TooltipBehavior _tooltipBehavior = TooltipBehavior(enable: true);

  @override
  void initState() {

    getweekdata();
    getmonthdata();
    var dt = DateTime.now();
    var newFormat = DateFormat("yyyy-MM-dd");
    String updatedDt = newFormat.format(dt);
    dateinput= TextEditingController(text: updatedDt.toString() );

    String formattedDate = DateFormat('kk:mm:ss').format(dt);
    timeinput=TextEditingController(text: formattedDate.toString());
    _currentItemSelected = _category[0];
    // _chartData = getChartData();
    _tooltipBehavior = TooltipBehavior(enable: true);

    category_list();

    super.initState();
  }
  TextEditingController dateinput = TextEditingController();
  TextEditingController discriptionController = TextEditingController();
  TextEditingController roiController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController timeinput = TextEditingController();
  TextEditingController descriptionMController = TextEditingController();
  TextEditingController nameMController = TextEditingController();
  TextEditingController amountMController = TextEditingController();
  var displayResult = '';
  void category_list() async{
    print('res1------------------------------------------------0');

    final Future<List<String>>_category1= category.categoryListView();
    print('res1------------------------------------------------10');
    _category1.then((cat){
      setState(() {
        _category=cat;
        _category.add('+ add category');});});
  }
  //
  // @override
  // void initState() {
  //   _chartData = getChartData();
  //   _tooltipBehavior = TooltipBehavior(enable: true);
  //   super.initState();
  // }
  @override
  Widget build(BuildContext context) {
    TextStyle? textStyle = Theme.of(context).textTheme.headline6;
    bool isNumeric(String s) {
      if(s == null) {
        return false;
      }
      return double.parse(s, (e) => 0) !=0;
    }
    return Scaffold(
//			resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          title: Text("expence Management"),),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: Text(

                  '  hello world',

                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                  ),
                ),
              ),
              ListTile(
                  leading: Icon(Icons.home),
                  title: Text('home'),
                  onTap: (){}
              ),
              ListTile(
                  leading: Icon(Icons.history),
                  title: Text('expence history'),
                  onTap: (){Navigator.push(context,
                    MaterialPageRoute(
                      builder: (context) => list_expence(),
                    ),
                  );}
              ),
              ListTile(
                  leading: Icon(Icons.account_circle),
                  title: Text('spending categories'),
                  onTap: (){Navigator.push(context,
                    MaterialPageRoute(
                      builder: (context) => list_limit(),
                    ),
                  );}
              ),
              ListTile(
                leading: Icon(Icons.settings),
                title: Text('Settings'),
              ),
            ],
          ),
        ),

        body:  Column(
          children: <Widget>[
            Expanded(
              flex: 2,
              child:InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => list_expence(),
                    ),
                  );
                },
                child:Container(
                  child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Container
                            (
                              margin: const EdgeInsets.fromLTRB(0,0,0,0),
                              child: SfCircularChart(
                                tooltipBehavior: _tooltipBehavior,
                                series: <CircularSeries>[
                                  RadialBarSeries<lastweekdata, String>(
                                      dataSource: _chartData,
                                      xValueMapper: (lastweekdata data, _) => data.continent,
                                      yValueMapper: (lastweekdata data, _) => data.gdp,
                                      dataLabelSettings: DataLabelSettings(isVisible: true),
                                      enableTooltip: true,
                                      maximumValue: 1000)
                                ],
                              )
                          ),),
                        Expanded(
                            child: Container(
                              margin: const EdgeInsets.fromLTRB(0,0,0,0),
                              child: SfCartesianChart(
                                tooltipBehavior: _tooltipBehavior,
                                series: <ChartSeries>[
                                  BarSeries<lastweekdata, String>(
                                      name: 'GDP',
                                      dataSource: _chartData1,
                                      xValueMapper: (lastweekdata gdp, _) => gdp.continent,
                                      yValueMapper: (lastweekdata gdp, _) => gdp.gdp,
                                      dataLabelSettings: DataLabelSettings(isVisible: true),
                                      enableTooltip: true)
                                ],
                                primaryXAxis: CategoryAxis(),
                                primaryYAxis: NumericAxis(
                                  edgeLabelPlacement: EdgeLabelPlacement.shift,
                                  numberFormat: NumberFormat.simpleCurrency(decimalDigits: 0),
                                ),
                              ),
                            )
                        )
                      ]),),),),
            Expanded(
              flex: 5,
              child: Container(
                margin: const EdgeInsets.fromLTRB(0,2,0,0),
                padding: const EdgeInsets.all(3.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(35.0),
                    color: Colors.blueGrey[100],
                    border: Border.all(color: Colors.blueAccent)
                ),
                child: Form(
                  key: _formKey,
                  child: Padding(
                      padding: EdgeInsets.all(_minimumPadding * 2),
                      child: ListView(
                        children: <Widget>[
                          // getImageAsset(),
                          Container(
                              alignment: Alignment.centerLeft,
                              padding: EdgeInsets.fromLTRB(2,30,10,10),
                              child: Text(
                                'Total: \u{20B9}5000',

                                style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 20,
                                ),
                              )),
                          Padding(
                              padding: EdgeInsets.only(
                                top: 40, bottom: _minimumPadding,left:15,right:15,),
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                      child: TextFormField(
                                        keyboardType: TextInputType.number,
                                        style: textStyle,
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
                                              borderRadius: BorderRadius.circular(15.0),
                                              borderSide: const BorderSide(color: Colors.blue, width: 2.0),
                                            ),
                                            labelText: '\u{20B9}Amount',
                                            hintText: 'write amount spent',
                                            labelStyle: textStyle,
                                            errorStyle: TextStyle(
                                                color: Colors.yellowAccent,
                                                fontSize: 15.0
                                            ),
                                            border: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(15.0))
                                        ),
                                      )),
                                  Container(
                                    width: _minimumPadding * 6,
                                  ),
                                  Expanded(

                                      child: Container(
                                        height:62,
                                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(15.0),
                                          border: Border.all(
                                              color: Colors.blue, style: BorderStyle.solid, width: 2),
                                        ),
                                        child: DropdownButton(

                                          hint: dropDownCategory == ''
                                              ? Text('category',textScaleFactor: 1.5,)
                                              : Text(
                                            dropDownCategory,textScaleFactor: 1.5,
                                            style: TextStyle(color: Colors.blue),
                                          ),
                                          isExpanded: true,
                                          iconSize: 30.0,
                                          style: TextStyle(color: Colors.blue),
                                          items: _category.map(
                                                (val) {
                                              return DropdownMenuItem<String>(
                                                value: val,
                                                child: Text(val),
                                              );
                                            },
                                          ).toList(),
                                          onChanged: (val) {
                                            setState(
                                                  () {
                                                if(val.toString()=='+ add category'){
                                                  addcategory(context);
                                                }
                                                else{
                                                  dropDownCategory = val.toString();}

                                              },
                                            );
                                          },
                                        ),
                                        // DropdownButton<String>(
                                        //   items: _category.map((String value) {
                                        //     return DropdownMenuItem<String>(
                                        //       value: value,
                                        //       child: Text(value),
                                        //     );
                                        //   }).toList(),
                                        //   value: _currentItemSelected,
                                        //   onChanged: (newValueSelected) {
                                        //     // Your code to execute, when a menu item is selected from dropdown
                                        //     _onDropDownItemSelected(
                                        //         newValueSelected!);
                                        //   },
                                        // )
                                      )
                                  ), ],
                              )),Padding(
                              padding: EdgeInsets.only(
                                top: 30, bottom: _minimumPadding,left:15,right:15,),
                              child: TextFormField(
                                style: textStyle,
                                controller: discriptionController,
                                decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                      borderSide: const BorderSide(color: Colors.blue, width: 2.0),
                                    ),
                                    labelText: 'discription',
                                    labelStyle: textStyle,
                                    errorStyle: TextStyle(
                                        color: Colors.yellowAccent,
                                        fontSize: 13.0
                                    ),
                                    border: OutlineInputBorder(
                                        borderSide: new BorderSide(color: Colors.blue),
                                        borderRadius: BorderRadius.circular(15.0))),
                              )),
                          Padding(padding: EdgeInsets.only(
                            top: 30, bottom: 50,left:15,right:15,),
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Container(
                                        height:62,
                                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(15.0),
                                          border: Border.all(
                                              color: Colors.blue, style: BorderStyle.solid, width: 2),
                                        ),
                                        child: TextField(
                                          controller: dateinput, //editing controller of this TextField
                                          decoration: InputDecoration(
                                              icon: Icon(Icons.calendar_today), //icon of text field
                                              labelText: "Enter Date" //label text of field
                                          ),
                                          readOnly: true,  //set it true, so that user will not able to edit text
                                          onTap: () async {
                                            DateTime? pickedDate = await showDatePicker(
                                                context: context, initialDate: DateTime.now(),
                                                firstDate: DateTime(2000), //DateTime.now() - not to allow to choose before today.
                                                lastDate: DateTime(2101)
                                            );

                                            if(pickedDate != null ){
                                              print(pickedDate);  //pickedDate output format => 2021-03-10 00:00:00.000
                                              String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                                              print(formattedDate); //formatted date output using intl package =>  2021-03-16
                                              //you can implement different kind of Date Format here according to your requirement

                                              setState(() {
                                                dateinput.text = formattedDate; //set output date to TextField value.
                                              });
                                            }else{
                                              print("Date is not selected");
                                            }
                                          },
                                        )),),
                                  Container(
                                    width: _minimumPadding * 5,
                                  ),
                                  Expanded(
                                    child: Container(
                                      height:62,
                                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15.0),
                                        border: Border.all(
                                            color: Colors.blue, style: BorderStyle.solid, width: 2),
                                      ),
                                      child: TextField(
                                        controller: timeinput, //editing controller of this TextField
                                        decoration: InputDecoration(
                                            icon: Icon(Icons.timer), //icon of text field
                                            labelText: "Enter Time" //label text of field
                                        ),
                                        readOnly: true,  //set it true, so that user will not able to edit text
                                        onTap: () async {
                                          TimeOfDay? pickedTime =  await showTimePicker(
                                            initialTime: TimeOfDay.now(),
                                            context: context,
                                          );

                                          if(pickedTime != null ){
                                            print(pickedTime.format(context));   //output 10:51 PM
                                            DateTime parsedTime = DateFormat.jm().parse(pickedTime.format(context).toString());
                                            //converting to DateTime so that we can further format on different pattern.
                                            print(parsedTime); //output 1970-01-01 22:53:00.000
                                            String formattedTime = DateFormat('HH:mm:ss').format(parsedTime);
                                            print(formattedTime); //output 14:59:00
                                            //DateFormat() is from intl package, you can format the time on any pattern you need.

                                            setState(() {
                                              timeinput.text = formattedTime; //set the value of text field.
                                            });
                                          }else{
                                            print("Time is not selected");
                                          }
                                        },
                                      ),),
                                    // DropdownButton<String>(
                                    //   items: _category.map((String value) {
                                    //     return DropdownMenuItem<String>(
                                    //       value: value,
                                    //       child: Text(value),
                                    //     );
                                    //   }).toList(),
                                    //   value: _currentItemSelected,
                                    //   onChanged: (newValueSelected) {
                                    //     // Your code to execute, when a menu item is selected from dropdown
                                    //     _onDropDownItemSelected(
                                    //         newValueSelected!);
                                    //   },
                                    // )
                                  )
                                ],
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
                                      primary: Colors.blue,
                                      onPrimary: Colors.white,
                                      shape:
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15.0),
                                        side: BorderSide(color: Colors.blue,width:2),
                                      )

                                  ),
                                  onPressed: () {
                                    setState(() {
                                      if (_formKey.currentState!.validate()) {
                                        if(dropDownCategory==''){
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(
                                              content: Text('add category'),
                                              backgroundColor: Colors.redAccent,
                                            ),
                                          );
                                        }
                                        else{
                                          saveTransaction();}
                                      }
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


                          Padding(
                            padding: EdgeInsets.all(_minimumPadding * 2),
                            child: Text(
                              this.displayResult,
                              style: textStyle,
                            ),
                          )
                        ],
                      )),
                ),
              ),),
          ],),
        floatingActionButton: FloatingActionButton (
          // backgroundColor: Colors.cyanAccent[900],
          onPressed: (){
            // Navigator.of(context).push(
            //   MaterialPageRoute(
            //     builder: (context) => list_expence(),
            //   ),
            // );
            addcategory(context);
          },


          child: Icon(Icons.add_outlined,color: Colors.tealAccent[600]),
          tooltip: 'Add One More Item',
        ));


  }

  // Widget getImageAsset() {
  //   AssetImage assetImage = AssetImage('images/flight.png');
  //   Image image = Image(
  //     image: assetImage,
  //     width: 125.0,
  //     height: 125.0,
  //   );
  //
  //   return Container(
  //     child: image,
  //     margin: EdgeInsets.all(_minimumPadding * 10),
  //   );
  // }



  void saveTransaction() async {
    DatabaseHelper helper = DatabaseHelper();
    //  final helper = DatabaseHelper.instance;
    // note=Note('','','',0,'');
    note.amount=int.parse(amountController.text);
    note.category=dropDownCategory.toString();
    note.description=discriptionController.text==null?'':discriptionController.text;
    note.date=dateinput.text;
    note.time=timeinput.text;
    int result = await helper.insertNote(note);
    print('------------------*******************************-------');
    print(result);
    if(result%1==0) {
      discriptionController.text='';
      amountController.text='';
      dropDownCategory='';
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('expence added'),
          backgroundColor: Colors.greenAccent,
        ),
      );
      getweekdata();
      getmonthdata();
    }
  }
// TextStyle? textStyle = Theme.of(context).textTheme.headline6;


}


