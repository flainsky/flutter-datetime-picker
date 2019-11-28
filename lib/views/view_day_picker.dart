import 'package:fla_datetime_picker/callbacks/pick_callback.dart';
import 'package:fla_datetime_picker/utils/screen_util.dart';
import 'package:fla_datetime_picker/views/flutter_section_table_view.dart';
import 'package:flutter/material.dart';


class DayPickerViewController extends ChangeNotifier
{
  FlaDatePickOneDayCallback oneDayCallback;

  DayPickerViewController({this.oneDayCallback});

}


class DayPickerView extends StatefulWidget
{
  final DayPickerViewController controller;

  DayPickerView({this.controller});


  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return DayPickerViewState();
  }

}

class DayPickerViewState extends State<DayPickerView> with AutomaticKeepAliveClientMixin
{

  List monthList;
  List linesList;
  List firstDayList;
  List totalDayList;

  DateTime nowDt;

  DateTime startDt;
  DateTime endDt;

  int monthes;

  final monthController = SectionTableController();

  Widget weekHeader;

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

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
    DateTime tmpDt = DateTime(nowDt.year,nowDt.month,nowDt.day);
    int curentMonth = tmpDt.year * 100 + tmpDt.month;
    for(int i = 0; i < monthes; i++)
    {
      String monthStr = _getZHStr(tmpDt.month) + '月 ' + tmpDt.year.toString();
      monthList.add(monthStr);
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


  @override
  Widget build(BuildContext context) {
    super.build(context);
    // TODO: implement build
    SectionTableView monthTb = new SectionTableView(
      sectionCount: monthes,
      controller: monthController,
      numOfRowInSection: (section) => 1,
      sectionHeaderHeight: (section) => 40,
      cellHeightAtIndexPath: (section,row)=>(60 * linesList[section]).toDouble(),
      cellAtIndexPath: (section,row)
      {
        double gridRatio = ScreenUtil.getScreenW(context) / 7 / 60;
        return Container(
          alignment: Alignment.center,
          height: (60 * linesList[section]).toDouble(),
          child: Column(
            children: <Widget>[
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  child: GridView.builder(
                    itemCount: (7 * linesList[section]).toInt(),
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
                      if(index % 7 > 4)
                      {
                        strColor = Color.fromARGB(255, 168, 46, 1);
                      }
                      DateTime fDt = firstDayList[section];
                      if((index + 1 < fDt.weekday) || (index + 2 > totalDayList[section] + fDt.weekday))
                      {
                        dateStr = '';
                      }
                      else
                      {
                        dateStr = (index - fDt.weekday + 2).toString();
                      }
                      return Container(
                        alignment: Alignment.center,
                        child: GestureDetector(
                          onTap: (()
                          {
                            if(widget.controller != null && dateStr.length > 0)
                            {
                              if(widget.controller.oneDayCallback != null)
                              {
                                widget.controller.oneDayCallback(fDt.add(Duration(days: index - fDt.weekday + 1)));
                              }
                            }
                          }),
                          child:
                          Container(
                            child: Text(dateStr,
                              style: new TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.normal,
                                color: strColor,
                              ),
                            ),
                            alignment: Alignment.center,
                            color: Colors.white,
                          )
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
      },
      headerInSection: (section)
      {
        return Container(
          height: 40,
          alignment: Alignment.center,
          child: Text(monthList[section],
            style: new TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.normal,
              color: Color.fromARGB(255, 153, 153, 153),
            ),
          ),
        );
      },
    );

    return Container(
      child: Column(
        children: <Widget>[
          weekHeader,
          Expanded(
            child: monthTb,
          )
        ],
      ),
    );
  }
  
}