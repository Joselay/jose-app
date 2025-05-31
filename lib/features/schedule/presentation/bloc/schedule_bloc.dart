import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:jose_app/features/schedule/domain/usecases/get_schedules_usecase.dart';
import 'package:jose_app/features/schedule/presentation/bloc/schedule_event.dart';
import 'package:jose_app/features/schedule/presentation/bloc/schedule_state.dart';

@injectable
class ScheduleBloc extends Bloc<ScheduleEvent, ScheduleState> {
  final GetSchedulesUseCase _getSchedulesUseCase;

  ScheduleBloc({required GetSchedulesUseCase getSchedulesUseCase})
    : _getSchedulesUseCase = getSchedulesUseCase,
      super(const ScheduleState()) {
    on<ScheduleStarted>(_onScheduleStarted);
    on<ScheduleRefreshed>(_onScheduleRefreshed);
  }

  Future<void> _onScheduleStarted(
    ScheduleStarted event,
    Emitter<ScheduleState> emit,
  ) async {
    emit(state.copyWith(status: ScheduleStatus.loading));
    await _fetchSchedules(emit);
  }

  Future<void> _onScheduleRefreshed(
    ScheduleRefreshed event,
    Emitter<ScheduleState> emit,
  ) async {
    emit(state.copyWith(status: ScheduleStatus.loading));
    await _fetchSchedules(emit);
  }

  Future<void> _fetchSchedules(Emitter<ScheduleState> emit) async {
    try {
      final schedules = await _getSchedulesUseCase();
      final result = (
        schedules: schedules,
        byDay: ScheduleState.groupByDay(schedules),
      );

      switch (result) {
        case (schedules: var s, byDay: var grouped) when s.isEmpty:
          emit(
            state.copyWith(
              status: ScheduleStatus.success,
              schedules: s,
              schedulesByDay: grouped,
              errorMessage: 'No schedules found',
            ),
          );
        case (schedules: var s, byDay: var grouped):
          emit(
            state.copyWith(
              status: ScheduleStatus.success,
              schedules: s,
              schedulesByDay: grouped,
              errorMessage: null,
            ),
          );
      }
    } catch (e) {
      emit(
        state.copyWith(
          status: ScheduleStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
