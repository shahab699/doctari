import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import '../select_date_hour_screen/widgets/hourstabs_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:doctari/core/app_export.dart';

class SelectDateHourScreen extends StatelessWidget {
  SelectDateHourScreen({Key? key})
      : super(
          key: key,
        );

  List<DateTime?> selectedDatesFromCalendar1 = [];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(horizontal: 24.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Select Date",
                style: CustomTextStyles.titleLargeBluegray90002,
              ),
              SizedBox(height: 9.v),
              _buildDatepickerDropdown(context),
              SizedBox(height: 32.v),
              Text(
                "Select Hour",
                style: CustomTextStyles.titleLargeBluegray90002,
              ),
              SizedBox(height: 17.v),
              _buildHoursTabs(context),
              SizedBox(height: 2.v),
            ],
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildDatepickerDropdown(BuildContext context) {
    return SizedBox(
      height: 269.v,
      width: 342.h,
      child: CalendarDatePicker2(
        config: CalendarDatePicker2Config(
          calendarType: CalendarDatePicker2Type.single,
          firstDate: DateTime(DateTime.now().year - 5),
          lastDate: DateTime(DateTime.now().year + 5),
          selectedDayHighlightColor: Color(0XFF0066FF),
          firstDayOfWeek: 0,
          weekdayLabelTextStyle: TextStyle(
            color: appTheme.blueGray700,
            fontFamily: 'Nunito',
            fontWeight: FontWeight.w700,
          ),
          selectedDayTextStyle: TextStyle(
            color: Color(0XFFFFFFFF),
            fontFamily: 'Nunito',
            fontWeight: FontWeight.w800,
          ),
          dayTextStyle: TextStyle(
            color: appTheme.gray600,
            fontFamily: 'Nunito',
            fontWeight: FontWeight.w700,
          ),
          disabledDayTextStyle: TextStyle(
            color: appTheme.gray600,
            fontFamily: 'Nunito',
            fontWeight: FontWeight.w700,
          ),
          weekdayLabels: ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"],
          dayBorderRadius: BorderRadius.circular(
            8.h,
          ),
        ),
        value: selectedDatesFromCalendar1,
        onValueChanged: (dates) {},
      ),
    );
  }

  /// Section Widget
  Widget _buildHoursTabs(BuildContext context) {
    return Wrap(
      runSpacing: 13.5.v,
      spacing: 13.5.h,
      children: List<Widget>.generate(12, (index) => HourstabsItemWidget()),
    );
  }
}
