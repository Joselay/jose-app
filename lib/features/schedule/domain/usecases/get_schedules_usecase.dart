import 'package:injectable/injectable.dart';
import 'package:jose_app/features/schedule/domain/entities/schedule_entity.dart';
import 'package:jose_app/features/schedule/domain/repositories/schedule_repository.dart';

@injectable
class GetSchedulesUseCase {
  final ScheduleRepository repository;

  GetSchedulesUseCase(this.repository);

  Future<List<ScheduleEntity>> call() async {
    return await repository.getSchedules();
  }
}
