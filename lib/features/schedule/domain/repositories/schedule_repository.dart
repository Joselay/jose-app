import 'package:jose_app/features/schedule/domain/entities/schedule_entity.dart';

abstract class ScheduleRepository {
  Future<List<ScheduleEntity>> getSchedules();
}
