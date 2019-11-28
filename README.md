# fla_datetime_picker

A Flutter Datetime picker project.

## Features
1 DayPicker
2 WeekPicker
3 MonthPicker
4 DateRangePicker


<div style="text-align: center">
  <table>
    <tr>
      <td style="text-align: center">
        <img src='https://github.com/flainsky/flutter_datetime_picker/raw/master/pics/pre_day.jpeg' height='200'/>
      </td>
      <td style="text-align: center">
        <img src='https://github.com/flainsky/flutter_datetime_picker/raw/master/pics/pre_week.jpeg' height='200'/>
      </td>
      <td style="text-align: center">
        <img src='https://github.com/flainsky/flutter_datetime_picker/raw/master/pics/pre_month.jpeg' height='200'/>
      </td>
      <td style="text-align: center">
        <img src='https://github.com/flainsky/flutter_datetime_picker/raw/master/pics/pre_daterange.jpeg' height='200'/>
      </td>
    </tr>
  </table>
 </div>

# Usage

```dart
class _MyHomePageState extends State<MyHomePage> {
  
  void _flaDatePickDateRangeCallback(DateTime startDt, DateTime endDt,DatePickType dateType)
  {
  }
  void _flaDatePickOneDayCallback(DateTime dateTime)
  {
  }
  void _flaDatePickAllCallback()
  {
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
        title: Text(widget.title),
      ),
      body: Center(
        child: FlatButton(
          child: Text('点击选取时间'),
          onPressed: ((){
            FlaDateTimePicker.showFlaDatePicker(context: context,
            controller: controller);
          }),
        )
      ),
    );
  }
}
```

<br/><br/><br/>
<b>TODO LIST:</b><br/>
1 Custom DateRange<br/>
2 Multilingual<br/>


## License

```
Copyright 2019 HuHu

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

   http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```
