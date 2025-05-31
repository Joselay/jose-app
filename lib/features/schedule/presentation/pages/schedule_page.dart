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

class _ScheduleViewState extends State<ScheduleView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();

    context.read<ScheduleBloc>().add(const ScheduleStarted());
  }

  @override
  void didUpdateWidget(ScheduleView oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.state.status == ScheduleStatus.success &&
        widget.state.schedulesByDay.isNotEmpty) {
      _initTabController();
    }
  }

  void _initTabController() {
    if (widget.state.schedulesByDay.isEmpty) return;

    _tabController = TabController(
      length: widget.state.schedulesByDay.keys.length,
      vsync: this,
    );
  }

  @override
  void dispose() {
    if (widget.state.schedulesByDay.isNotEmpty) {
      _tabController.dispose();
    }
    super.dispose();
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
        bottom:
            widget.state.status == ScheduleStatus.success &&
                widget.state.schedulesByDay.isNotEmpty
            ? TabBar(
                controller: _tabController,
                isScrollable: true,
                tabs: widget.state.schedulesByDay.keys.map((day) {
                  return Tab(text: _formatDayName(day));
                }).toList(),
              )
            : null,
      ),
      body: SafeArea(child: _buildBody()),
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
        TabBarView(
          controller: _tabController,
          children: byDay.entries.map((entry) {
            final (day, daySchedules) = (entry.key, entry.value);

            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _formatDayName(day),
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
              ),
            );
          }).toList(),
        ),
    };
  }

  String _formatDayName(String day) {
    return day[0] + day.substring(1).toLowerCase();
  }
}
