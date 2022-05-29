
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  @override
  TabController tb;
  int hour = 0;
  int sec = 0;
  int min = 0;
  bool started= true;
  bool stopped = true;
  int timeForTimer=0;
  String timetodisplay=""; 
  bool checktimer=true;


  @override
  noSuchMethod(Invocation invocation) {
    // TODO: implement noSuchMethod
    return super.noSuchMethod(invocation);
  }

  void initState() {
    tb = TabController(length: 2, vsync: this);
    super.initState();
  }
  void start(){
    setState(() {
          started=false;
          stopped=false;
        });
    timeForTimer = ((hour*3600)+ (min *60)+sec);
    Timer.periodic(Duration(
      seconds: 1,
    ), (Timer t){
      setState(() {
              if(timeForTimer <1 || checktimer==false){
                t.cancel();
                checktimer=true;
                timetodisplay = "";
              }else{
                timeForTimer=timeForTimer-1;
              }
              timetodisplay= timeForTimer.toString();
            });

    });

  }
  void stop(){
    setState(() {
          started=true;
          stopped=true;
          checktimer=false;
        });
        timeForTimer=0;

  }
//timer widget
  Widget timer() {
    return Container(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
                flex: 6,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    //upto 28 minutes desi programmer
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(
                            bottom: 10.0,
                          ),
                          child: Text(
                            "hh",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w100),
                          ),
                        ),
                        NumberPicker.integer(
                          initialValue: hour,
                          minValue: 0,
                          maxValue: 23,
                          listViewWidth: 60.0,
                          onChanged: (val) {
                            setState(() {
                              hour = val;
                            });
                          },
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(
                            bottom: 10.0,
                          ),
                          child: Text(
                            "mm",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w100),
                          ),
                        ),
                        NumberPicker.integer(
                          initialValue: min,
                          minValue: 0,
                          maxValue: 23,
                          onChanged: (val) {
                            setState(() {
                              min = val;
                            });
                          },
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(
                            bottom: 10.0,
                          ),
                          child: Text(
                            "ss",
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        NumberPicker.integer(
                          initialValue: sec,
                          minValue: 0,
                          maxValue: 23,
                          listViewWidth: 60.0,
                          onChanged: (val) {
                            setState(() {
                              sec = val;
                            });
                          },
                        ),
                      ],
                    )
                  ],
                )),
            Expanded(
                flex: 1,
                child: Text(
                 timetodisplay,
                  style: TextStyle(
                    fontSize: 40.0,
                    fontWeight: FontWeight.w600,
                  ),
                )),
            Expanded(
                flex: 3,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    MaterialButton(onPressed: started ? start: null,
                      padding: EdgeInsets.symmetric(
                        horizontal: 40.0,
                        vertical: 10.0,
                      ),
                      color: Colors.green,
                      child: Text(
                        "start",
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.white,
                        ),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                    MaterialButton(onPressed: stopped? stop:null,
                    padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 10.0,),
                    color: Colors.red,
                    child: Text("stop",
                    style:TextStyle(
                      fontSize:10.0,
                     color: Colors.white,
                    ),),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0),)
                    )
                  ],
                ))
          ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Time Project"),
        centerTitle: true,
        bottom: TabBar(
          tabs: <Widget>[
            Text("timer"),
            Text("stopwatch"),
          ],
          labelPadding: EdgeInsets.only(
            bottom: 10.0,
          ),
          labelStyle: TextStyle(
            fontSize: 18.0,
          ),
          unselectedLabelColor: Colors.red,
          controller: tb,
        ),
      ),
      body: TabBarView(
        children: <Widget>[
          timer(),
          Text("stopwatch"),
        ],
        controller: tb,
      ),
    );
  }
}
