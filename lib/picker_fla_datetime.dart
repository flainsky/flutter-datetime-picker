import 'package:fla_datetime_picker/callbacks/pick_callback.dart';
import 'package:fla_datetime_picker/views/view_date_range_picker.dart';
import 'package:fla_datetime_picker/views/view_day_picker.dart';
import 'package:fla_datetime_picker/views/view_month_picker.dart';
import 'package:fla_datetime_picker/views/view_week_picker.dart';
import 'package:flutter/material.dart';


class FlaDatePickerController extends ChangeNotifier
{
  FlaDatePickOneDayCallback oneDayCallback;
  FlaDatePickDateRangeCallback dateRangeCallback;
  FlaDatePickAllCallback allDateCallback;

  FlaDatePickerController({this.oneDayCallback,this.dateRangeCallback,this.allDateCallback});
}

class FlaDatePicker extends StatefulWidget
{
  FlaDatePickerController controller;

  FlaDatePicker({this.controller});

  @override
  State<StatefulWidget> createState() {
    return FlaDatePickerState();
  }

}

class FlaDatePickerState extends State<FlaDatePicker> with SingleTickerProviderStateMixin
{
  TabController _tabController;

  FlaDatePickOneDayCallback oneDayCallback;
  FlaDatePickDateRangeCallback dateRangeCallback;

  Widget oneDayPickView;
  Widget weekPickView;
  Widget monthPickView;
  Widget dateRangePickView;

  DayPickerViewController oneDayPickController;
  WeekPickerViewController weekPickerViewController;
  MonthPickerViewController monthPickerViewController;
  DateRangePickerViewController dateRangePickerViewController;

  Scaffold mainScaffold;

  void _oneDayPick(DateTime dt)
  {
    print(dt.toString());
    if(widget.controller != null && widget.controller.oneDayCallback != null) {
      widget.controller.oneDayCallback(dt);
    }
    Navigator.pop(context);
  }

  void _dateRangePick(DateTime startDt, DateTime endDt, DatePickType datePickType)
  {
    print(startDt.toString() + ' - - ' + endDt.toString());
    if(widget.controller != null && widget.controller.dateRangeCallback != null) {
      widget.controller.dateRangeCallback(startDt, endDt, datePickType);
    }
    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();

    _tabController = new TabController(vsync: this,length: 4);

    oneDayPickController = new DayPickerViewController();
    oneDayPickView = DayPickerView(
      controller: oneDayPickController,
    );
    oneDayPickController.oneDayCallback = _oneDayPick;

    weekPickerViewController = new WeekPickerViewController();
    weekPickView = WeekPickerView(
      controller: weekPickerViewController,
    );
    weekPickerViewController.dateRangeCallback = _dateRangePick;

    monthPickerViewController = new MonthPickerViewController();
    monthPickView = MonthPickerView(
      controller: monthPickerViewController,
    );
    monthPickerViewController.dateRangeCallback = _dateRangePick;

    dateRangePickerViewController = new DateRangePickerViewController();
    dateRangePickView = DateRangePickerView(
      controller: dateRangePickerViewController,
    );
    dateRangePickerViewController.dateRangeCallback = _dateRangePick;

    mainScaffold = Scaffold(
      appBar: new AppBar(
        title: Text('选择日期',
          style: new TextStyle(
            fontWeight: FontWeight.normal,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: GestureDetector(
          onTap: ()
          {
            //Application.router.pop(context);
            Navigator.pop(context);
          },
          child: Icon(Icons.close),
        ),
        actions: <Widget>[
          Container(
              padding: EdgeInsets.fromLTRB(0, 0, 16, 0),
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: ((){
                  if(widget.controller != null && widget.controller.allDateCallback != null) {
                    widget.controller.allDateCallback();
                  }
                  Navigator.pop(context);
                }),
                child:Container(
                  color: Colors.white,
                  child: Text('全部'),
                ),
              )
          )
        ],
      ),
      body: SafeArea(
        child: Container(
          child: Column(
            children: <Widget>[
              Container(
                height: 50,
                child: TabBar(
                  labelColor: Colors.black,
                  controller: _tabController,
                  tabs: <Widget>[
                    Tab(text: '日',),
                    Tab(text: '周',),
                    Tab(text: '月',),
                    Tab(text: '自定义',)
                  ],
                ),
              ),
              Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: <Widget>[
                      oneDayPickView,
                      weekPickView,
                      monthPickView,
                      dateRangePickView,
                    ],
                  )
              )

            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return mainScaffold;
  }
  
}


Future showFlaDatePicker({
  @required BuildContext context,
  DateTime initialFirstDate,
  DateTime initialLastDate,
  FlaDatePickerController controller,
}) async {

  Widget child = new FlaDatePicker(
    controller: controller,
  );

  return await showDialog(
    context: context,
    builder: (BuildContext context) => child,
  );
}