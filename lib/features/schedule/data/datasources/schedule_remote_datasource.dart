import 'package:dio/dio.dart';
import 'package:jose_app/core/network/api_endpoints.dart';
import 'package:jose_app/features/schedule/data/models/schedule_model.dart';
import 'package:retrofit/retrofit.dart';

part 'schedule_remote_datasource.g.dart';

@RestApi()
abstract class ScheduleRemoteDataSource {
  factory ScheduleRemoteDataSource(Dio dio) = _ScheduleRemoteDataSource;

  @GET(ApiEndpoints.schedule)
  Future<List<ScheduleModel>> getSchedules();
}
