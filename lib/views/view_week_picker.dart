import 'package:fla_datetime_picker/callbacks/pick_callback.dart';
import 'package:fla_datetime_picker/utils/date_util.dart';
import 'package:fla_datetime_picker/views/flutter_section_table_view.dart';
import 'package:flutter/material.dart';

class WeekPickerViewController extends ChangeNotifier
{
  FlaDatePickDateRangeCallback dateRangeCallback;
  WeekPickerViewController({this.dateRangeCallback});
}

class WeekPickerView extends StatefulWidget
{
  WeekPickerViewController controller;

  WeekPickerView({this.controller});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return WeekPickerViewState();
  }

}

class WeekPickerViewState extends State<WeekPickerView> with AutomaticKeepAliveClientMixin
{

  static int selectedSection = 0;
  // final monthController = SectionTableController(
  //   sectionTableViewScrollTo: _monthScolled);

  final weekController = SectionTableController();

  final yearController = SectionTableController();

  void _weekScolled(int section,int row,bool isScrollDown)
  {
    //print('received scroll to $section $row scrollDown:$isScrollDown');
    if(selectedSection != section)
    {
      setState(() {
        selectedSection = section;
      });
    }
  }
  DateTime nowDt;
  List yearList;
  int years;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nowDt = DateTime.now();
    nowDt = DateTime(nowDt.year,nowDt.month,nowDt.day,0,0,0,0,0);
    years = nowDt.year - 2014;

    yearList = new List();
    DateTime tmpDt = new DateTime(nowDt.year,nowDt.month,nowDt.day);
    for(int i = 0; i < years; i++)
    {
      int tmpYear = tmpDt.year;
      List weekList = new List();
      for(;;)
      {
        if(tmpYear != tmpDt.year)
        {
          break;
        }
        if(tmpDt.weekday == 1)
        {
          weekList.add(tmpDt);
        }
        tmpDt = tmpDt.add(Duration(days: -1));
      }
      yearList.add(weekList);
    }

    weekController.sectionTableViewScrollTo = _weekScolled;
  }

    @override
  Widget build(BuildContext context) {
    super.build(context);
    SectionTableView weekTb = new SectionTableView(
      sectionCount: years,
      controller: weekController,
      numOfRowInSection: (section){
        List list = yearList[section] as List;
        return list.length;
      },
      headerInSection: (section)
      {
        return Container(
          padding: EdgeInsets.fromLTRB(16, 0, 0, 0),
          color: Color.fromARGB(255, 248, 248, 248),
          height: 30,
          alignment: Alignment.centerLeft,
          child: Text((nowDt.year - section).toString()),
        );
      },
      sectionHeaderHeight: (section)
      {
        return 30.0;
      },
      cellHeightAtIndexPath: (section,row)
      {
        return 45.0;
      },
      cellAtIndexPath: (section,row)
      {
        List list = yearList[section] as List;
        DateTime dt = list[row];
        DateTime dt2 = dt.add(Duration(days: 6));
        String showStr = '第' + (list.length - row).toString() + '周 ('+ DateUtil.getDateStrByDateTime(dt,format: DateFormat.ZH_MONTH_DAY) + '——'+ DateUtil.getDateStrByDateTime(dt2,format: DateFormat.ZH_MONTH_DAY) +')';
        if(section == 0 && row == 0)
        {
          showStr = showStr + ' 本周';
        }
        return GestureDetector(
          onTap: (()
          {
            if(widget.controller != null && widget.controller.dateRangeCallback != null)
            {
              widget.controller.dateRangeCallback(dt,dt2.add(Duration(days: 1)),DatePickType.Week);
            }
          }),
          child: Container(
            color: Colors.white,
            padding: EdgeInsets.fromLTRB(16, 0, 0, 0),
            height: 45,
            alignment: Alignment.centerLeft,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  alignment: Alignment.centerLeft,
                  height: 44,
                  child: Text(showStr),
                ),
                Container(
                  color: Color.fromARGB(255, 229, 229, 229),
                  height: 1,
                )
              ],
            ),
          ),
        ) ;

      }
    );

    SectionTableView yearTb = new SectionTableView(
      sectionCount: 1,
      controller: yearController,
      numOfRowInSection: (section) => years,
      sectionHeaderHeight: (section) => 0,
      cellHeightAtIndexPath: (section, row) => 40,
      cellAtIndexPath: (section, row)
      {
        Color bgColor = Color.fromARGB(255, 248, 248, 248);
        if(selectedSection == row)
        {
          bgColor = Colors.white;
        }
        return GestureDetector(
          onTap: (){
            weekController.animateTo(row, -1);

            if(selectedSection != row)
            {
              setState(() {
                selectedSection = row;
              });
            }
          },
          child: Container(
            height: 40,
            color: bgColor,
            alignment: Alignment.center,
            child: Text((nowDt.year - row).toString()),
          ),
        );
      },
    );

    return Container(
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            color: Color.fromARGB(255, 248, 248, 248),
            width: 80,
            child: yearTb,
          ),
          Expanded(
            child: Container(
              child: weekTb,
            ),
          )
        ],
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
  
}