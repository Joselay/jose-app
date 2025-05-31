import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jose_app/features/schedule/presentation/bloc/schedule_bloc.dart';
import 'package:jose_app/features/schedule/presentation/bloc/schedule_event.dart';
import 'package:jose_app/features/schedule/presentation/bloc/schedule_state.dart';
import 'package:jose_app/features/schedule/presentation/widgets/schedule_carousel.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class SchedulePage extends StatelessWidget {
  const SchedulePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ScheduleBloc, ScheduleState>(
      builder: (context, state) {
        return ScheduleView(state: state);
      },
    );
  }
}

class ScheduleView extends StatefulWidget {
  final ScheduleState state;

  const ScheduleView({super.key, required this.state});

  @override
  State<ScheduleView> createState() => _ScheduleViewState();
}

class _ScheduleViewState extends State<ScheduleView> {
  String _selectedDay = '';

  @override
  void initState() {
    super.initState();
    context.read<ScheduleBloc>().add(const ScheduleStarted());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Class Schedule'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              context.read<ScheduleBloc>().add(const ScheduleRefreshed());
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: _buildBody(),
        ),
      ),
    );
  }

  Widget _buildBody() {
    return switch (widget.state) {
      ScheduleState(status: ScheduleStatus.initial || ScheduleStatus.loading) =>
        const Center(child: CircularProgressIndicator()),

      ScheduleState(
        status: ScheduleStatus.failure,
        errorMessage: final error,
      ) =>
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Error loading schedules',
                style: ShadTheme.of(context).textTheme.h4,
              ),
              const SizedBox(height: 8),
              Text(
                error ?? 'Unknown error',
                style: ShadTheme.of(context).textTheme.muted,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              ShadButton(
                onPressed: () =>
                    context.read<ScheduleBloc>().add(const ScheduleRefreshed()),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),

      ScheduleState(status: ScheduleStatus.success, schedules: final schedules)
          when schedules.isEmpty =>
        Center(
          child: Text(
            'No schedules found',
            style: ShadTheme.of(context).textTheme.h4,
          ),
        ),

      ScheduleState(status: ScheduleStatus.success, schedulesByDay: final byDay)
          when byDay.isEmpty =>
        const Center(child: CircularProgressIndicator()),

      ScheduleState(
        status: ScheduleStatus.success,
        schedulesByDay: final byDay,
      ) =>
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 40,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: byDay.keys.map((day) {
                    final formattedDay = _formatDayName(day);
                    final isSelected = _selectedDay.isEmpty
                        ? day == byDay.keys.first
                        : day == _selectedDay;

                    return Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: isSelected
                          ? ShadButton(
                              size: ShadButtonSize.sm,
                              onPressed: () {
                                setState(() {
                                  _selectedDay = day;
                                });
                              },
                              child: Text(formattedDay),
                            )
                          : ShadButton.outline(
                              size: ShadButtonSize.sm,
                              onPressed: () {
                                setState(() {
                                  _selectedDay = day;
                                });
                              },
                              child: Text(formattedDay),
                            ),
                    );
                  }).toList(),
                ),
              ),
            ),

            const SizedBox(height: 16),

            Expanded(
              child: Builder(
                builder: (context) {
                  final selectedDayKey = _selectedDay.isEmpty
                      ? byDay.keys.first
                      : _selectedDay;
                  final daySchedules = byDay[selectedDayKey] ?? [];
                  final formattedDay = _formatDayName(selectedDayKey);

                  return SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          formattedDay,
                          style: ShadTheme.of(context).textTheme.h3,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '${daySchedules.length} classes scheduled',
                          style: ShadTheme.of(context).textTheme.muted,
                        ),
                        const SizedBox(height: 24),
                        ScheduleCarousel(schedules: daySchedules),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
    };
  }

  String _formatDayName(String day) {
    return day[0] + day.substring(1).toLowerCase();
  }
}
