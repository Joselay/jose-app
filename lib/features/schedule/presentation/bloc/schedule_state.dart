import 'package:equatable/equatable.dart';
import 'package:jose_app/features/schedule/domain/entities/schedule_entity.dart';

enum ScheduleStatus { initial, loading, success, failure }

class ScheduleState extends Equatable {
  final ScheduleStatus status;
  final List<ScheduleEntity> schedules;
  final String? errorMessage;
  final Map<String, List<ScheduleEntity>> schedulesByDay;

  const ScheduleState({
    this.status = ScheduleStatus.initial,
    this.schedules = const [],
    this.errorMessage,
    this.schedulesByDay = const {},
  });

  @override
  List<Object?> get props => [status, schedules, errorMessage, schedulesByDay];

  ScheduleState copyWith({
    ScheduleStatus? status,
    List<ScheduleEntity>? schedules,
    String? errorMessage,
    Map<String, List<ScheduleEntity>>? schedulesByDay,
  }) {
    return ScheduleState(
      status: status ?? this.status,
      schedules: schedules ?? this.schedules,
      errorMessage: errorMessage ?? this.errorMessage,
      schedulesByDay: schedulesByDay ?? this.schedulesByDay,
    );
  }

  static Map<String, List<ScheduleEntity>> groupByDay(
    List<ScheduleEntity> schedules,
  ) {
    final grouped = schedules.fold<Map<String, List<ScheduleEntity>>>(
      {},
      (map, schedule) => {
        ...map,
        schedule.day: [...(map[schedule.day] ?? []), schedule],
      },
    );

    final daysOrder = [
      'MONDAY',
      'TUESDAY',
      'WEDNESDAY',
      'THURSDAY',
      'FRIDAY',
      'SATURDAY',
      'SUNDAY',
    ];

    return Map.fromEntries(
      daysOrder
          .map((day) => (day: day, schedules: grouped[day]))
          .where((record) => record.schedules != null)
          .map((record) => MapEntry(record.day, record.schedules!)),
    );
  }
}
