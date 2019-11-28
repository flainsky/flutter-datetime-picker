import 'package:fla_datetime_picker/callbacks/pick_callback.dart';
import 'package:fla_datetime_picker/picker_fla_datetime.dart';
import 'package:flutter/material.dart';
import 'package:fla_datetime_picker/picker_fla_datetime.dart' as FlaDateTimePicker;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  
  DateTime dt;

  void _flaDatePickDateRangeCallback(DateTime startDt, DateTime endDt,DatePickType dateType)
  {
    setState(() {
      dt = startDt;
    });
  }

  void _flaDatePickOneDayCallback(DateTime dateTime)
  {
    setState(() {
      dt = dateTime;
    });
  }

  void _flaDatePickAllCallback()
  {
    setState(() {
      dt = DateTime.now();
    });
  }

  FlaDatePickerController controller;

  @override
  Widget build(BuildContext context) {
    
    controller = new FlaDatePickerController(
      allDateCallback: _flaDatePickAllCallback,
      oneDayCallback: _flaDatePickOneDayCallback,
      dateRangeCallback: _flaDatePickDateRangeCallback
    );

    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: FlatButton(
          child: Text((dt == null)?'点击选取时间':dt.toString()),
          onPressed: ((){
            FlaDateTimePicker.showFlaDatePicker(context: context,
            controller: controller);
          }),
        )
      ),
    );
  }
}
