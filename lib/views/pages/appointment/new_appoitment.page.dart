import 'package:flutter/material.dart';
import 'package:rhema_rapha_app/assets/styles/colors.dart';
import 'package:rhema_rapha_app/views/pages/appointment/appointments.page.dart';
import 'package:flutter_date_pickers/flutter_date_pickers.dart' as dp;

class NewAppointmentPage extends StatefulWidget {
  @override
  _NewAppointmentPageState createState() => _NewAppointmentPageState();
}

class _NewAppointmentPageState extends State<NewAppointmentPage> {
  Color selectedDateStyleColor;
  Color selectedSingleDateDecorationColor;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // defaults for styles
    selectedDateStyleColor = Theme.of(context).accentTextTheme.bodyText1.color;
    selectedSingleDateDecorationColor = Theme.of(context).accentColor;
  }

  @override
  Widget build(BuildContext context) {
    dp.DatePickerStyles styles = dp.DatePickerRangeStyles(
      selectedDateStyle: Theme.of(context)
          .accentTextTheme
          .bodyText1
          .copyWith(color: selectedDateStyleColor),
      selectedSingleDateDecoration: BoxDecoration(
          color: selectedSingleDateDecorationColor, shape: BoxShape.circle),
    );

    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: Icon(
            Icons.keyboard_arrow_left,
            color: AppColors.primaryColor,
            size: 35,
          ),
        ),
        title: Text(
          'New Appointment',
          style: TextStyle(color: AppColors.primaryColor),
        ),
        elevation: 0,
        backgroundColor: AppColors.white,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Doctor'),
            Text('Date'),
            Text('Time'),
            SizedBox(height: 10),
            dp.DayPicker(
              selectedDate: DateTime.now(),
              onChanged: (DateTime newDate) {
                setState(() {
                  print(newDate.toString());
                });
              },
              firstDate: DateTime.now().subtract(Duration(days: 45)),
              lastDate: DateTime.now().add(Duration(days: 45)),
              datePickerStyles: styles,
              datePickerLayoutSettings: dp.DatePickerLayoutSettings(
                maxDayPickerRowCount: 2,
                showPrevMonthEnd: true,
                showNextMonthStart: true,
              ),
              selectableDayPredicate: (DateTime day) {
                return day.weekday < 6;
              },
            ),
            Text('Type'),
            SizedBox(height: 10),
            Row(
              children: [
                AppointmentType(
                  name: 'Voice call',
                  isCall: true,
                ),
                AppointmentType(
                  name: 'Visit',
                  isCall: false,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class AppointmentType extends StatelessWidget {
  final String name;
  final bool isCall;
  const AppointmentType({
    Key key,
    @required this.name,
    this.isCall = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      margin: EdgeInsets.only(right: 20.0),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.greyShade8,
            offset: Offset(0, 1),
            blurRadius: 2,
          ),
        ],
      ),
      child: Row(
        children: [
          AppointmentTypeIcon(isCall: isCall),
          SizedBox(width: 10),
          Text(name),
          SizedBox(width: 4),
        ],
      ),
    );
  }
}
