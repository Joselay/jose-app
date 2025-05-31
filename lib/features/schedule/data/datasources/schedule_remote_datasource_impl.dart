import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:jose_app/features/schedule/data/datasources/schedule_remote_datasource.dart';
import 'package:jose_app/features/schedule/data/models/schedule_model.dart';

@injectable
class ScheduleRemoteDataSourceImpl implements ScheduleRemoteDataSource {
  final ScheduleRemoteDataSource _dataSource;

  ScheduleRemoteDataSourceImpl(Dio dio)
      : _dataSource = ScheduleRemoteDataSource(dio);

  @override
  Future<List<ScheduleModel>> getSchedules() {
    return _dataSource.getSchedules();
  }
}
