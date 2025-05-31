import 'package:flutter/material.dart';
import 'package:jose_app/features/schedule/domain/entities/schedule_entity.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class ScheduleCard extends StatelessWidget {
  final ScheduleEntity schedule;
  final int index;

  const ScheduleCard({super.key, required this.schedule, this.index = 0});

  @override
  Widget build(BuildContext context) {
    final shadTheme = ShadTheme.of(context);

    return ShadCard(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ShadBadge.outline(
                    child: Text(
                      schedule.day,
                      style: TextStyle(color: shadTheme.colorScheme.primary),
                    ),
                  ),
                  Text(
                    '${schedule.startTime} - ${schedule.endTime}',
                    style: shadTheme.textTheme.muted,
                  ),
                ],
              ),
              const SizedBox(height: 16),

              Text(schedule.subject, style: shadTheme.textTheme.h4),
              const SizedBox(height: 8),

              Row(
                children: [
                  const Icon(Icons.person, size: 16),
                  const SizedBox(width: 4),
                  Text(schedule.teacherName, style: shadTheme.textTheme.p),
                  const SizedBox(width: 16),
                  const Icon(Icons.room, size: 16),
                  const SizedBox(width: 4),
                  Text('Room ${schedule.room}', style: shadTheme.textTheme.p),
                ],
              ),
              const SizedBox(height: 8),

              Text(
                'Year ${schedule.year}, Semester ${schedule.semester}',
                style: shadTheme.textTheme.muted,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
