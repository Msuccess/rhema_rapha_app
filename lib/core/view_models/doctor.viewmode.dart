
import 'package:rhema_rapha_app/core/message/result.model.dart';
import 'package:rhema_rapha_app/core/models/doctor.model.dart';
import 'package:rhema_rapha_app/core/services/doctor.service.dart';
import 'package:rhema_rapha_app/core/view_models/base.viewmodel.dart';

class DoctorViewModel extends BaseViewModel {
  DoctorService _doctorService;
  List<Doctor> doctors = List<Doctor>();

  Future<Result> getDoctors() async {
    setBusy(true);
    Result<List<Doctor>> result = await _doctorService.getDoctors();
    doctors = result.isSuccessful ? result.data : new Doctor();
    setBusy(false);
    return result;
  }
}
