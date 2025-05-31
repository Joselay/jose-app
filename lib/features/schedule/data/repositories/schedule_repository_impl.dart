import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:jose_app/features/schedule/data/datasources/schedule_remote_datasource_impl.dart';
import 'package:jose_app/features/schedule/domain/entities/schedule_entity.dart';
import 'package:jose_app/features/schedule/domain/repositories/schedule_repository.dart';

@Injectable(as: ScheduleRepository)
class ScheduleRepositoryImpl implements ScheduleRepository {
  final ScheduleRemoteDataSourceImpl _remoteDataSource;

  ScheduleRepositoryImpl(this._remoteDataSource);

  @override
  Future<List<ScheduleEntity>> getSchedules() async {
    try {
      return await _remoteDataSource.getSchedules();
    } catch (e) {
      final errorMessage = switch (e) {
        DioException(message: final message?) => 'Network error: $message',
        DioException() => 'Network error occurred',
        final error => 'Failed to load schedules: $error',
      };
      throw Exception(errorMessage);
    }
  }
}
