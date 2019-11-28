import 'package:fla_datetime_picker/callbacks/pick_callback.dart';
import 'package:fla_datetime_picker/utils/screen_util.dart';
import 'package:fla_datetime_picker/views/flutter_tableView.dart';
import 'package:flutter/material.dart';

class DateRangePickerViewController extends ChangeNotifier
{
  FlaDatePickDateRangeCallback dateRangeCallback;

  DateRangePickerViewController({this.dateRangeCallback});
}

class DateRangePickerView extends StatefulWidget
{
  DateRangePickerViewController controller;

  DateRangePickerView({this.controller});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return DateRangePickerViewState();
  }

}

class DateRangePickerViewState extends State<DateRangePickerView> with AutomaticKeepAliveClientMixin
{
  List monthList;
  List linesList;
  List firstDayList;
  List totalDayList;

  DateTime nowDt;

  DateTime startDt;
  DateTime endDt;

  int monthes;

  ScrollController monthController;

  Widget weekHeader;

  FlutterTableView monthTb;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nowDt = DateTime.now();
    nowDt = DateTime(nowDt.year,nowDt.month,nowDt.day,0,0,0,0,0);

    monthList = new List();
    linesList = new List();
    firstDayList = new List();
    totalDayList = new List();

    int years = nowDt.year - 2014;
    monthes = years * 12 - 12 + nowDt.month;
    DateTime tmpDt = DateTime.now();
    int curentMonth = tmpDt.year * 100 + tmpDt.month;
    for(int i = 0; i < monthes; i++)
    {
      //String monthStr = _getZHStr(tmpDt.month) + '月 ' + tmpDt.year.toString();
      DateTime monthDt = new DateTime(tmpDt.year,tmpDt.month,1);
      monthList.add(monthDt);
      linesList.add(_culLines4Month(tmpDt));
      for(;;)
      {
        tmpDt = tmpDt.add(Duration(days:-1));
        if(curentMonth != (tmpDt.year * 100 + tmpDt.month))
        {
          curentMonth = tmpDt.year * 100 + tmpDt.month;
          break;
        }
      }
    }

    weekHeader = Container(
      height: 25,
      color: Color.fromARGB(255, 245, 245, 245),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text('一',
              style: new TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.normal,
                color: Color.fromARGB(255, 111, 111, 111),
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: Text('二',
              style: new TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.normal,
                color: Color.fromARGB(255, 111, 111, 111),
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: Text('三',
              style: new TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.normal,
                color: Color.fromARGB(255, 111, 111, 111),
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: Text('四',
              style: new TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.normal,
                color: Color.fromARGB(255, 111, 111, 111),
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: Text('五',
              style: new TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.normal,
                color: Color.fromARGB(255, 111, 111, 111),
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: Text('六',
              style: new TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.normal,
                color: Color.fromARGB(255, 168, 46, 1),
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: Text('日',
              style: new TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.normal,
                color: Color.fromARGB(255, 168, 46, 1),
              ),
              textAlign: TextAlign.center,
            ),
          )

        ],
      ),
    );
  }

  int _culLines4Month(DateTime dt)
  {
    DateTime firstDay = dt.add(Duration(days:1 - dt.day));
    firstDayList.add(firstDay);
    int totalDays = 31;
    switch(dt.month)
    {
      case 1:
        totalDays = 31;
        break;
      case 2:
        if(dt.year % 4 == 0)
        {
          totalDays = 29;
        }
        else
        {
          totalDays = 28;
        }
        break;
      case 3:
        totalDays = 31;
        break;
      case 4:
        totalDays = 30;
        break;
      case 5:
        totalDays = 31;
        break;
      case 6:
        totalDays = 30;
        break;
      case 7:
        totalDays = 31;
        break;
      case 8:
        totalDays = 31;
        break;
      case 9:
        totalDays = 30;
        break;
      case 10:
        totalDays = 31;
        break;
      case 11:
        totalDays = 30;
        break;
      case 12:
        totalDays = 31;
        break;
    }
    totalDayList.add(totalDays);
    totalDays += firstDay.weekday - 1;
    double lines = totalDays / 7;
    return lines.ceil();
  }

  String _getZHStr(int value)
  {
    if(value == 1)
    {
      return '一';
    }
    else if(value == 2)
    {
      return '二';
    }
    else if(value == 3)
    {
      return '三';
    }
    else if(value == 4)
    {
      return '四';
    }
    else if(value == 5)
    {
      return '五';
    }
    else if(value == 6)
    {
      return '六';
    }
    else if(value == 7)
    {
      return '七';
    }
    else if(value == 8)
    {
      return '八';
    }
    else if(value == 9)
    {
      return '九';
    }
    else if(value == 10)
    {
      return '十';
    }
    else if(value == 11)
    {
      return '十一';
    }
    else if(value == 12)
    {
      return '十二';
    }
    else
    {
      return '';
    }
  }

  void _selectDate(DateTime dt) {
    if(dt == startDt) {
      return;
    }
    else {
      setState(() {
        if(startDt != null && endDt != null){
          startDt = dt;
          endDt = null;
        }
        else if(startDt == null) {
          startDt = dt;
        }
        else if(startDt != null && endDt == null) {
          if(startDt.isAfter(dt)) {
            endDt = startDt;
            startDt = dt;
          }
          else{
            endDt = dt;
          }
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    double totalHeight = 0;
    for(int i = 0;i<monthes;i++) {
      totalHeight+=40;
      totalHeight+=(linesList[i] * 60);
    }

    monthController = new ScrollController(initialScrollOffset: totalHeight);

    monthTb = new FlutterTableView(
      sectionCount: monthes,
      controller: monthController,
      sectionHeaderHeight: ((buildContext, section){
        return 40.0;
      }),
      cellHeight: ((buildContext, section, row){
        return (60 * linesList[monthes - section - 1]).toDouble();
      }),
      rowCountAtSection: ((section){
        return 1;
      }),
      sectionHeaderBuilder: ((buildContext,section){
        int selectedSection = monthes - section - 1;
        DateTime dt = monthList[selectedSection];
        String monthStr = _getZHStr(dt.month) + '月 ' + dt.year.toString();
        return Container(
          height: 40,
          alignment: Alignment.center,
          child: Text(monthStr,
            style: new TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.normal,
              color: Color.fromARGB(255, 153, 153, 153),
            ),
          ),
        );
      }),
      cellBuilder: ((buildContext,section,row){
        int selectedSection = monthes - section - 1;
        double gridRatio = ScreenUtil.getScreenW(context) / 7 / 60;
        DateTime monthDt = monthList[selectedSection];

        return Container(
          alignment: Alignment.center,
          height: (60 * linesList[selectedSection]).toDouble(),
          child: Column(
            children: <Widget>[
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  child: GridView.builder(
                    itemCount: (7 * linesList[selectedSection]).toInt(),
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      //横轴元素个数
                      crossAxisCount: 7,
                      //纵轴间距
                      mainAxisSpacing: 0,
                      //横轴间距
                      crossAxisSpacing: 0,
                      //子组件宽高长度比例
                      childAspectRatio: gridRatio,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      //Widget Function(BuildContext context, int index)
                      String dateStr = '';
                      Color strColor = Colors.black;
                      Color bgColor = Colors.white;
                      if(index % 7 > 4)
                      {
                        strColor = Color.fromARGB(255, 168, 46, 1);
                      }
                      DateTime fDt = firstDayList[selectedSection];

                      DateTime todayDt;

                      if((index + 1 < fDt.weekday) || (index + 2 > totalDayList[selectedSection] + fDt.weekday))
                      {
                        dateStr = '';
                      }
                      else
                      {
                        todayDt = DateTime(monthDt.year,monthDt.month,index - fDt.weekday + 2);
                        dateStr = (index - fDt.weekday + 2).toString();
                        if(todayDt == startDt || todayDt == endDt){
                          bgColor = Colors.deepOrange;
                          if(strColor == Colors.black) {
                            strColor = Colors.white;
                          }
                          else {
                            strColor = Colors.red[50];
                          }
                        }
                        else if(startDt != null && endDt != null && (startDt.isBefore(todayDt) && endDt.isAfter(todayDt))) {
                          bgColor = Colors.orangeAccent;
                          if(strColor == Colors.black) {
                            strColor = Colors.white;
                          }
                          else {
                            strColor = Colors.red[50];
                          }
                        }


                      }
                      return GestureDetector(
                        onTap: (()
                        {
                          if(todayDt != null) {
                            _selectDate(todayDt);
                          }
                        }),
                        child: Container(
                          color: bgColor,
                          alignment: Alignment.center,
                          child: Text(dateStr,
                            style: new TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.normal,
                              color: strColor,
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              Container(
                height: 1,
                width: ScreenUtil.getScreenW(context),
                color: Colors.black12,
              )
            ],
          ),
        );
      }),

    );

    Container bottomBar = Container(
      alignment: Alignment.center,
      height: 60,
      child:Container(
        alignment: Alignment.center,
        padding: EdgeInsets.fromLTRB(16, 5, 16, 5),
        child: Row(
            children:[
              Container(
                alignment: Alignment.center,
                width: 60,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: Text('开始时间：',
                        style: new TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                        ),),
                    ),
                    Expanded(
                      child: Text('结束时间：',
                        style: new TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                        ),),
                    )
                  ],
                ),
              ),
              Expanded(
                //child: Text(startDt == null ?'':startDt.toString() + '' + (endDt == null ?'':endDt.toString())),
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: Text( startDt == null ?'':(startDt.year.toString() + '-' + startDt.month.toString() + '-' + startDt.day.toString()),
                          style: new TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.normal,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Expanded(
                        child: Text(endDt == null ?'':(endDt.year.toString() + '-' + endDt.month.toString() + '-' + endDt.day.toString()),
                          style: new TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.normal,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                width: 100,
                child: FlatButton(
                  onPressed: ((){
                    if(startDt != null && endDt != null && widget.controller != null && widget.controller.dateRangeCallback != null){
                      widget.controller.dateRangeCallback(startDt,endDt.add(Duration(days: 1)), DatePickType.Custom);
                    }
                  }),
                  child: Text('确认',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      color: Colors.white,
                    )
                  ),
                  color: Colors.orange,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                ),
              )
            ]),
      )
    );
    return Container(
      child: Column(
        children: <Widget>[
          weekHeader,
          Expanded(
            child: monthTb,
          ),
          bottomBar
        ],
      ),
    );
  }


  @override
  bool get wantKeepAlive => true;
  
}