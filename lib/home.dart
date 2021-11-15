import 'package:expence_management/expence_list.dart';
import 'package:expence_management/set_limit_module.dart';
import 'package:expence_management/sumoflimamt().dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:expence_management/note.dart';
import 'add_limits.dart';
import 'expence_add.dart';
import 'lastweekGraph.dart';
import 'lim_list.dart';
import 'database_helper_exp.dart';
import 'add_category.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
  // // void addcategory(BuildContext context){ showModalBottomSheet<dynamic>(
  // //   isScrollControlled: true,
  // //   context: context,
  // //   backgroundColor: Colors.transparent,
  // //   builder: (BuildContext bc) {
  // //     return Container(
  // //       height: MediaQuery.of(context).size.height * 0.50,
  // //       decoration: new BoxDecoration(
  // //         color: Colors.white,
  // //         borderRadius: new BorderRadius.only(
  // //           topLeft: const Radius.circular(25.0),
  // //           topRight: const Radius.circular(25.0),
  // //         ),
  // //       ),
  // //       child: Container(
  // //         //
  // //         //
  // //         // margin: const EdgeInsets.fromLTRB(0,2,0,0),
  // //         // padding: const EdgeInsets.all(3.0),
  // //
  // //         child: Form(
  // //           key: _formKey1,
  // //           child: Padding(
  // //               padding: EdgeInsets.all(_minimumPadding * 2),
  // //               child: ListView(
  // //                 children: <Widget>[
  // //                   Padding(
  // //                       padding: EdgeInsets.only(
  // //                         top: 40, bottom: _minimumPadding,left:15,right:15,),
  // //                       child: Row(
  // //                         children: <Widget>[
  // //                           Expanded(
  // //                               child: TextFormField(
  // //                                 controller: nameMController,
  // //                                 validator: (value) {
  // //                                   if (value == null || value.isEmpty) {
  // //                                     return 'Please enter term';
  // //                                   }
  // //
  // //                                 },
  // //                                 decoration: InputDecoration(
  // //                                     enabledBorder: OutlineInputBorder(
  // //                                       borderRadius: BorderRadius.circular(30.0),
  // //                                       borderSide: const BorderSide(color: Colors.blue, width: 2.0),
  // //                                     ),
  // //                                     labelText: 'category name',
  // //                                     hintText: 'write category name',
  // //                                     errorStyle: TextStyle(
  // //                                         color: Colors.redAccent,
  // //                                         fontSize: 15.0
  // //                                     ),
  // //                                     border: OutlineInputBorder(
  // //                                         borderRadius: BorderRadius.circular(30.0))
  // //                                 ),
  // //                               )),
  // //                           Container(
  // //                             width: _minimumPadding * 6,
  // //                           ),
  // //                           Expanded(
  // //                               child: TextFormField(
  // //                                 keyboardType: TextInputType.number,
  // //                                 controller: amountMController,
  // //                                 validator: (value) {
  // //                                   if (value == null || value.isEmpty) {
  // //                                     return 'Please enter term';
  // //                                   }
  // //                                   else if (!isNumeric(value)){
  // //                                     return 'Please enter valid amount';
  // //                                   }
  // //                                 },
  // //                                 decoration: InputDecoration(
  // //                                     enabledBorder: OutlineInputBorder(
  // //                                       borderRadius: BorderRadius.circular(30.0),
  // //                                       borderSide: const BorderSide(color: Colors.blue, width: 2.0),
  // //                                     ),
  // //                                     labelText: '\u{20B9}limit Amount',
  // //                                     hintText: 'write limit amount',
  // //                                     errorStyle: TextStyle(
  // //                                         color: Colors.yellowAccent,
  // //                                         fontSize: 15.0
  // //                                     ),
  // //                                     border: OutlineInputBorder(
  // //                                         borderRadius: BorderRadius.circular(30.0))
  // //                                 ),
  // //                               )),
  // //                         ],
  // //                       )),Padding(
  // //                       padding: EdgeInsets.only(
  // //                         top: 30, bottom: _minimumPadding,left:15,right:15,),
  // //                       child: TextFormField(
  // //                         controller: descriptionMController,
  // //                         decoration: InputDecoration(
  // //                             enabledBorder: OutlineInputBorder(
  // //                               borderRadius: BorderRadius.circular(15.0),
  // //                               borderSide: const BorderSide(color: Colors.blue, width: 2.0),
  // //                             ),
  // //                             labelText: 'discription',
  // //                             errorStyle: TextStyle(
  // //                                 color: Colors.yellowAccent,
  // //                                 fontSize: 13.0
  // //                             ),
  // //                             border: OutlineInputBorder(
  // //                                 borderSide: new BorderSide(color: Colors.blue),
  // //                                 borderRadius: BorderRadius.circular(15.0))),
  // //                       )),
  // //                   Padding(
  // //                     padding: EdgeInsets.only(
  // //                       bottom: _minimumPadding, top: _minimumPadding,left: 80,right: 80,),
  // //                     child: Expanded(
  // //                         child: ElevatedButton(
  // //                           child: Text('add',style: TextStyle(
  // //                             fontSize: 25.0, // insert your font size here
  // //                           ),),
  // //                           style: ElevatedButton.styleFrom(
  // //                             //minimumSize: Size(80, 20),
  // //                               primary: Colors.blue,
  // //                               onPrimary: Colors.white,
  // //                               shape:
  // //                               RoundedRectangleBorder(
  // //                                 borderRadius: BorderRadius.circular(15.0),
  // //                                 side: BorderSide(color: Colors.blue,width:2),
  // //                               )
  // //
  // //                           ),
  // //                           onPressed: () {
  // //
  // //                               if (_formKey1.currentState!.validate()) {
  // //                                 Future<bool> res= addCategory(descriptionMController.text,amountMController.text,nameMController.text);
  // //                                 res.then((ress){
  // //                                   setState(() {
  // //                                     descriptionMController.text='';
  // //                                     amountMController.text='';
  // //                                     nameMController.text='';
  // //                                     category_list();
  // //                                     Navigator.pop(context);
  // //                                   });
  // //                                 });
  // //                               }
  // //
  // //                             })
  // //
  // //                         )),
  // //                     //RaisedButton(
  // //                     //   color: Theme.of(context).accentColor,
  // //                     //   textColor: Theme.of(context).primaryColorDark,
  // //                     //   child: Text(
  // //                     //     'add',
  // //                     //     textScaleFactor: 1.5,
  // //                     //   ),
  // //                     //   onPressed: () {
  // //                     //     setState(() {
  // //                     //       if (_formKey.currentState!.validate()) {
  // //                     //         this.displayResult = _calculateTotalReturns();
  // //                     //       }
  // //                     //     });
  // //                     //   },
  // //                     // ),
  // //
  // //
  // //
  // //
  // //                 ],
  // //               )),
  // //         ),
  // //
  // //       ),
  //     );
  //   },
  // );
  // }
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
  late List<lastweekdata> _lineseriesdata= [];
  void getday_monthdata(){
    Future<List<lastweekdata>>_chartData3=  helper.lastmonth();
    _chartData3.then((dataa){
      setState(() {
        _lineseriesdata=dataa;
      });
      print(dataa);
    //  updateexpence(context,note);
    });
  }
  int thismonthexpence=0;
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
        thismonthexpence=dataa;
      });

    });
  }
  List<lastweekdata>pieData=[];
  void getpiedata(){
    final Future<List<lastweekdata>>_category1= helper.getcategorywisedaata();
    print('res1------------------------------------------------10');
    _category1.then((cat){
      setState(() {
        pieData=cat;
        });});
  }
  late TooltipBehavior _tooltipBehavior = TooltipBehavior(enable: true);
  final String MY_PREFS_NAME = "MyPrefsFile";
  int limitmonthly=0;
  void get_shared_preferences(){
    Future<SharedPreferences> prefs = SharedPreferences.getInstance();
    prefs.then((prefs) {
      bool test=(prefs.getBool('checkvalue')??false);
      if(test){
        Future<int> cat_amt= getcategorylimitAmount();
        cat_amt.then((cat_amtt){
        setState(() {

        limitmonthly = (prefs.getInt('limit') ?? 0 )+cat_amtt;});});
      }
      else{
      setState(() {

    limitmonthly = (prefs.getInt('limit') ?? 0 );});}});
  }

  @override
  void initState() {
    // SharedPreferences prefs = getSharedPreferences(MY_PREFS_NAME, MODE_PRIVATE);
    // int limitamt = prefs.getInt("idName", 0);
    get_shared_preferences();
    getpiedata();
    getday_monthdata();
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
    Future.delayed(Duration(seconds: 3)).then((_) {
      updateexpence(context,Note('',updatedDt,formattedDate,0,''));
    });
  //  updateexpence(context,note);
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
  void category_list() {
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
        backgroundColor: Colors.grey[300],
//			resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text("Expence Management",
            style:TextStyle(
          color: Colors.black,
         // fontWeight: FontWeight.w500,
           fontSize: 22,
        )),
        iconTheme: IconThemeData(color: Colors.black),
          backgroundColor:Colors.white,
      ),
        drawer:Theme(
        data: Theme.of(context).copyWith(
    canvasColor: Colors.grey[300], //This will change the drawer background to blue.
    //other styles
    ),child: Drawer(
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
                  leading: Icon(Icons.home,color: Color(0xFF5084bc),),
                  title: Text('home'),
                  onTap: (){}
              ),
              ListTile(
                leading: Icon(Icons.history_outlined,color: Color(0xFF5084bc),),
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

      body:  Column(
    children: <Widget>[
      Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.fromLTRB(15,15,10,0),
          child: Text(
            'Total expence this month: \u{20B9}$thismonthexpence',

            style: TextStyle(
    color: Color(0xFF5084bc),
              fontWeight: FontWeight.w600,
              fontSize: 18,
            ),
          )),
              InkWell(
                      onTap: () {
                        Future<void> modelss=showModalBottomSheet<dynamic>(

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
                        modelss.then((rr){
                            get_shared_preferences();

                        });},

                  child:Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.fromLTRB(15,5,10,3),
                      child: limitmonthly!=0?RichText(
                        text: TextSpan(
                          text: 'limit for month: \u{20B9}$limitmonthly',
                          style: TextStyle(color: Color(0xFF5084bc),
                                fontWeight: FontWeight.w600,
                                fontSize: 18,), /*defining default style is optional */
                          children: <TextSpan>[
                            TextSpan(
                                text: ' (Tap to change)', style: TextStyle(color: Colors.redAccent,
                              fontWeight: FontWeight.w600,
                              fontSize: 18,)),
                          ],
                        ),
                      ):Text(' Set limit',style: TextStyle(
                          color: Colors.redAccent,
                          fontWeight: FontWeight.w600,
                          fontSize: 22,
                        ),),
                      // Text(
                      //   limitmonthly!=0?
                      //   'limit for month: \u{20B9}$limitmonthly (Tap to change)':'set limit',
                      //
                      //   style: TextStyle(
                      //     color: Colors.blueAccent,
                      //     fontWeight: FontWeight.w500,
                      //     fontSize: 18,
                      //   ),
                      // )
                  )),

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
      child: Card(
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
    child: Container(
          margin: const EdgeInsets.fromLTRB(0,0,0,0),
          child: SfCircularChart(
        tooltipBehavior: _tooltipBehavior,
            title: ChartTitle(text: 'this month limit vs expence',textStyle: TextStyle(fontWeight: FontWeight.w400,
              fontSize: 14,
            ),),
        series: <CircularSeries>[
          RadialBarSeries<lastweekdata, String>(

              dataSource: _chartData,
              xValueMapper: (lastweekdata data, _) => data.continent,
              yValueMapper: (lastweekdata data, _) => data.gdp,
              dataLabelSettings: DataLabelSettings(isVisible: true),
              enableTooltip: true,
              maximumValue: limitmonthly*1.0,)
        ],
      )
      ),),),
            Expanded(
              child: Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
    child:Container(
                margin: const EdgeInsets.fromLTRB(0,0,0,0),
                child: SfCartesianChart(
                  title: ChartTitle(text: 'last week data'),
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
              ))
            )
          ]),),),),
      Expanded(
        flex: 2,
      child:Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
    child: Container(
       child:SfCartesianChart(

           primaryXAxis: CategoryAxis(),
           // Chart title
           title: ChartTitle(text: 'last month data'),
           // Enable legend
           // legend: Legend(isVisible: true),
           // // Enable tooltip
           // tooltipBehavior: _tooltipBehavior,

           series: <LineSeries<lastweekdata, String>>[
             LineSeries<lastweekdata, String>(
                 dataSource: _lineseriesdata,
                 xValueMapper: (lastweekdata sales, _) => sales.continent,
                 yValueMapper: (lastweekdata sales, _) => sales.gdp,
                 // Enable data label
                 dataLabelSettings: DataLabelSettings(isVisible: true)
             )
           ]
       )
      ),),),
        Expanded(
          flex: 2,
        child:Container(
    padding: EdgeInsets.fromLTRB(70, 0, 70, 0),
    child: Card(
      elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
    child: Container(
            child: SfCircularChart(
                title: ChartTitle(text: 'category and expences'),
                series: <PieSeries>[PieSeries<lastweekdata, String>(
                    explode: true,
                    // explodeIndex: 0,
                    // explodeOffset: '10%',
                    dataSource: pieData,
                    xValueMapper: (lastweekdata data, _) => data.continent,
                    yValueMapper: (lastweekdata data, _) => data.gdp,
                    dataLabelMapper: (lastweekdata data, _) => data.continent+' \n'+data.gdp.toString(),
                    startAngle: 90,
                    endAngle: 90,
                    dataLabelSettings: const DataLabelSettings(isVisible: true,labelPosition: ChartDataLabelPosition.outside,)),
           ] ),
        )),),),
   ],),
        floatingActionButton: FloatingActionButton (
        backgroundColor: Color(0xFF5084bc),

        onPressed: (){
          // Navigator.of(context).push(
          //   MaterialPageRoute(
          //     builder: (context) => list_expence(),
          //   ),
          // );
          updateexpence(context,Note('',dateinput.text,timeinput.text,0,''));
    },


    child: Icon(Icons.add_outlined,color: Colors.white),
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
    future.then((value) => {getpiedata(),
        getday_monthdata(),
    getweekdata(),
    getmonthdata(),
    category_list(),
      get_shared_preferences(),
    atom=Note('',atom.date,atom.time,0,''),}
    );
  }
}


