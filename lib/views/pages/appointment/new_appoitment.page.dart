import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:provider/provider.dart';

import 'package:rhema_rapha_app/assets/styles/colors.dart';
import 'package:rhema_rapha_app/core/models/department.model.dart';
import 'package:rhema_rapha_app/core/models/doctor.model.dart';
import 'package:rhema_rapha_app/core/view_models/appointment.viewmodel.dart';
import 'package:rhema_rapha_app/views/pages/appointment/appointments.page.dart';
import 'package:rhema_rapha_app/views/widgets/appbar.widget.dart';
import 'package:rhema_rapha_app/views/widgets/base.widget.dart';
import 'package:rhema_rapha_app/views/widgets/button.widget.dart';
import 'package:rhema_rapha_app/core/services/util.service.dart';
import 'package:rhema_rapha_app/views/widgets/input.widget.dart';

class NewAppointmentPage extends StatefulWidget {
  @override
  _NewAppointmentPageState createState() => _NewAppointmentPageState();
}

class _NewAppointmentPageState extends State<NewAppointmentPage> {
  @override
  Widget build(BuildContext context) {
    return BaseWidget<AppointmentViewModel>(
      model: AppointmentViewModel(
        departmentService: Provider.of(context),
        appointmentService: Provider.of(context),
        doctorService: Provider.of(context),
      ),
      onModelReady: (AppointmentViewModel model) async {
        await model.getDepartments();
      },
      builder: (
        BuildContext context,
        AppointmentViewModel model,
        Widget child,
      ) {
        Widget loading = Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircularProgressIndicator(),
          ),
        );

        return Scaffold(
          appBar: AppBar(
            leading: InkWell(
              onTap: () => Navigator.pop(context),
              child: Icon(
                Icons.arrow_back,
                color: AppColors.primaryColor,
              ),
            ),
            title: Text(
              'New Appointment',
              style: TextStyle(color: AppColors.primaryColor),
            ),
            elevation: 0,
            backgroundColor: AppColors.white,
          ),
          body: SingleChildScrollView(
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (model.busy) loading,
                  SizedBox(height: 10),
                  Text('Department'),
                  SizedBox(height: 10),
                  _buildDepartmentSelectField(context, model),
                  SizedBox(height: 10),
                  Text('Doctor'),
                  SizedBox(height: 10),
                  _buildDoctorSelectField(context, model),
                  SizedBox(height: 10),
                  Text('Date'),
                  SizedBox(height: 10),
                  GestureDetector(
                    onTap: () async {
                      model.date =
                          model.date == null ? DateTime.now() : model.date;
                      var date = await showDatePicker(
                        context: context,
                        initialDate: model.date,
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2100),
                        helpText: 'Select Appointment Date',
                        selectableDayPredicate: (DateTime date) {
                          return model.setDaysAvailable(date);
                        },
                      );
                      model.onDateSelected(date);
                    },
                    child: Container(
                      margin: EdgeInsets.only(right: 10, bottom: 10),
                      width: MediaQuery.of(context).size.width,
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 15),
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            UtilService.formatDate(model.date),
                            style: TextStyle(fontSize: 15),
                          ),
                          Icon(Icons.keyboard_arrow_down)
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text('Time'),
                  SizedBox(height: 10),
                  Wrap(
                    children: [
                      ...model.appointmentTimes
                          .map(
                            (appointmentTime) => TimeButtonWidget(
                              appointmentTime: appointmentTime,
                              selectedTime: model.time,
                              onSelect: (appointmentTime) => model.onTimeSelect(
                                appointmentTime,
                              ),
                            ),
                          )
                          .toList()
                    ],
                  ),
                  SizedBox(height: 10),
                  Text('Type'),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      AppointmentType(
                        name: 'Voice call',
                        isCall: true,
                        selectedType: model.type,
                        onSelect: (type) => model.onTypeSelect(type),
                      ),
                      AppointmentType(
                        name: 'Visit',
                        isCall: false,
                        selectedType: model.type,
                        onSelect: (type) => model.onTypeSelect(type),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  appointmentDescription(model),
                  SizedBox(height: 20),
                  ButtonWidget(
                    // busy: model.busy,
                    text: 'Submit',
                    onPressed: () {
                      model.onAppointmentSubmit(context);
                    },
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  _buildDoctorSelectField(BuildContext context, AppointmentViewModel model) {
    return GestureDetector(
      onTap: () async {
        showDialog(
          context: context,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 100,
            ),
            child: Dialog(
              backgroundColor: Colors.transparent,
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                child: ListView.builder(
                  itemCount: model.doctors.length,
                  itemBuilder: (BuildContext context, int index) {
                    return _buildDoctorTile(
                      model,
                      model.doctors[index],
                    );
                  },
                ),
              ),
            ),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(right: 10, bottom: 10),
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CircleAvatar(
                  child: Text(
                    AppBarWidget.getInitials(
                      name: model.doctor.fullName,
                      limitTo: 2,
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Text(
                  model.doctor.fullName,
                  style: TextStyle(fontSize: 15),
                ),
              ],
            ),
            Icon(Icons.keyboard_arrow_down)
          ],
        ),
      ),
    );
  }

  GestureDetector _buildDepartmentSelectField(
      BuildContext context, AppointmentViewModel model) {
    return GestureDetector(
      onTap: () async {
        showDialog(
          context: context,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 100,
            ),
            child: Dialog(
              backgroundColor: Colors.transparent,
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                child: ListView.builder(
                  itemCount: model.departments.length,
                  itemBuilder: (BuildContext context, int index) {
                    return _buildDepartmentTile(
                      model,
                      model.departments[index],
                    );
                  },
                ),
              ),
            ),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(right: 10, bottom: 10),
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CircleAvatar(
                  child: Text(
                    AppBarWidget.getInitials(
                      name: model.department.name,
                      limitTo: 1,
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Text(
                  model.department.name,
                  style: TextStyle(fontSize: 15),
                ),
              ],
            ),
            Icon(Icons.keyboard_arrow_down)
          ],
        ),
      ),
    );
  }

  _buildDepartmentTile(AppointmentViewModel model, Department department) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
        model.onDepartmentSelected(department);
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 1),
        child: ListTile(
          leading: CircleAvatar(
            child: Text(
              AppBarWidget.getInitials(
                name: department.name,
                limitTo: 1,
              ),
            ),
          ),
          trailing: Icon(
            Icons.check_circle,
            color: department.id == model.department.id
                ? AppColors.primaryColor
                : Colors.transparent,
          ),
          title: Text(department.name),
        ),
        decoration: BoxDecoration(
          color: Colors.black12,
        ),
      ),
    );
  }

  _buildDoctorTile(AppointmentViewModel model, Doctor doctor) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
        model.onDoctorSelected(doctor);
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 1),
        child: ListTile(
          leading: CircleAvatar(
            child: Text(
              AppBarWidget.getInitials(name: doctor.fullName, limitTo: 2),
            ),
          ),
          trailing: Icon(
            Icons.check_circle,
            color: doctor.id == model.doctor.id
                ? AppColors.primaryColor
                : Colors.transparent,
          ),
          title: Text(doctor.fullName),
        ),
        decoration: BoxDecoration(
          color: Colors.black12,
        ),
      ),
    );
  }

  appointmentDescription(AppointmentViewModel model) {
    return InputWidget(
      text: 'Description',
      iconSize: 15.0,
      isTextArea: true,
      controller: model.descriptionController,
      inputPrefixIcon: FeatherIcons.paperclip,
    );
  }
}

class TimeButtonWidget extends StatelessWidget {
  final String appointmentTime;
  final Function onSelect;
  final String selectedTime;
  const TimeButtonWidget({
    Key key,
    this.appointmentTime,
    this.onSelect,
    this.selectedTime,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onSelect == null ? () {} : () => onSelect(appointmentTime),
      child: Container(
        margin: EdgeInsets.only(right: 10, bottom: 10),
        padding: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 15,
        ),
        decoration: BoxDecoration(
          color: appointmentTime == selectedTime
              ? AppColors.primaryColor
              : AppColors.white,
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
        child: Text(
          appointmentTime,
          style: TextStyle(
            color: appointmentTime == selectedTime
                ? AppColors.white
                : AppColors.darkModeColor,
          ),
        ),
      ),
    );
  }
}

class AppointmentType extends StatelessWidget {
  final String name;
  final Function onSelect;
  final String selectedType;
  final bool isCall;

  const AppointmentType({
    Key key,
    @required this.name,
    this.isCall = false,
    this.selectedType,
    this.onSelect,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onSelect == null ? () {} : () => onSelect(name),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
        margin: EdgeInsets.only(right: 20.0),
        decoration: BoxDecoration(
          color:
              selectedType == name ? AppColors.primaryColor : AppColors.white,
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
            Text(
              name,
              style: TextStyle(
                color: selectedType == name
                    ? AppColors.white
                    : AppColors.darkModeColor,
              ),
            ),
            SizedBox(width: 4),
          ],
        ),
      ),
    );
  }
}
