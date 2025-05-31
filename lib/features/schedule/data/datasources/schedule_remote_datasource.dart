import 'package:dio/dio.dart';
import 'package:jose_app/features/schedule/data/models/schedule_model.dart';
import 'package:retrofit/retrofit.dart';

part 'schedule_remote_datasource.g.dart';

@RestApi(baseUrl: "https://jose-backend.up.railway.app")
abstract class ScheduleRemoteDataSource {
  factory ScheduleRemoteDataSource(Dio dio) = _ScheduleRemoteDataSource;

  @GET("/schedule")
  Future<List<ScheduleModel>> getSchedules();
}
