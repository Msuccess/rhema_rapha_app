import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:rhema_rapha_app/core/services/appointment.service.dart';
import 'package:rhema_rapha_app/core/services/authservice.dart';
import 'package:rhema_rapha_app/core/services/department.service.dart';
import 'package:rhema_rapha_app/core/services/doctor.service.dart';
import 'package:rhema_rapha_app/core/services/patient.service.dart';
import 'package:rhema_rapha_app/core/services/user.service.dart';

List<SingleChildWidget> providers = [
  ...independentServices,
  ...dependentServices,
  ...uiConsumableProviders,
];


List<SingleChildWidget> independentServices = [
  Provider.value(value: AuthService()),
  Provider.value(value: DoctorService()),
  Provider.value(value: AppointmentService()),
  Provider.value(value: DepartmentService()),
  Provider.value(value: UserService()),
  Provider.value(value: PatientService()),
];

List<SingleChildWidget> dependentServices = [
  
];

List<SingleChildWidget> uiConsumableProviders = [];