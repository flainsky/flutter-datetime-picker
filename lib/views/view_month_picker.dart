import 'package:fla_datetime_picker/callbacks/pick_callback.dart';
import 'package:fla_datetime_picker/views/flutter_section_table_view.dart';
import 'package:flutter/material.dart';


class MonthPickerViewController extends ChangeNotifier
{
  FlaDatePickDateRangeCallback dateRangeCallback;

  MonthPickerViewController({this.dateRangeCallback});
}

class MonthPickerView extends StatefulWidget
{
  MonthPickerViewController controller;

  MonthPickerView({this.controller});

  @override
  State<StatefulWidget> createState() {
    return MonthPickerViewState();
  }

}

class MonthPickerViewState extends State<MonthPickerView> with AutomaticKeepAliveClientMixin
{
  void _monthScolled(int section,int row,bool isScrollDown)
  {
    if(selectedSection != section)
    {
      setState(() {
        selectedSection = section;
      });
    }
  }

  static int selectedSection = 0;
  // final monthController = SectionTableController(
  //   sectionTableViewScrollTo: _monthScolled);

  final monthController = SectionTableController();

  final yearController = SectionTableController(
    sectionTableViewScrollTo: (section, row, isScrollDown) {
  });

  @override
  void initState() {
    super.initState();

    monthController.sectionTableViewScrollTo = _monthScolled;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    DateTime nowDt = DateTime.now();
    nowDt = DateTime(nowDt.year,nowDt.month,nowDt.day,0,0,0,0,0);
    int years = nowDt.year - 2014;

    SectionTableView monthTb = new SectionTableView(
      sectionCount: years,
      controller: monthController,
      numOfRowInSection: (section){
        return 12;
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
        return GestureDetector(
          onTap: ((){
            if(widget.controller != null && widget.controller.dateRangeCallback != null)
            {
              DateTime startDt = DateTime(nowDt.year - section,12 - row,1);
              DateTime endDt = startDt.add(Duration(days: getMonthDays(startDt)));
              widget.controller.dateRangeCallback(startDt,endDt,DatePickType.Month);
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
                  child: Text((12 - row).toString() + '月'),
                ),
                Container(
                  color: Color.fromARGB(255, 229, 229, 229),
                  height: 1,
                )
              ],
            ),
          ),
        );
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
            monthController.animateTo(row, -1);

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
              child: monthTb,
            ),
          )
        ],
      ),
    );
  }

  int getMonthDays(DateTime dt)
  {
    DateTime firstDay = dt.add(Duration(days:1 - dt.day));
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
    return totalDays;
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  
}