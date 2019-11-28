enum DatePickType
{
  All,      //0
  Day,      //1
  Week,     //2
  Month,    //3
  Custom    //4
}

enum DatePickLanguage
{
  EN,
  CN
}

typedef void FlaDatePickOneDayCallback(DateTime dateTime);
typedef void FlaDatePickDateRangeCallback(DateTime startDt, DateTime endDt,DatePickType dateType);
typedef void FlaDatePickAllCallback();