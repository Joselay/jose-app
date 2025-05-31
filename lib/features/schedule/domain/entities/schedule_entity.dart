import 'package:equatable/equatable.dart';

class ScheduleEntity extends Equatable {
  final String id;
  final String teacherName;
  final String room;
  final String startTime;
  final String endTime;
  final String day;
  final String subject;
  final String semester;
  final String year;
  final DateTime createdAt;
  final DateTime updatedAt;

  const ScheduleEntity({
    required this.id,
    required this.teacherName,
    required this.room,
    required this.startTime,
    required this.endTime,
    required this.day,
    required this.subject,
    required this.semester,
    required this.year,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object?> get props => [
        id,
        teacherName,
        room,
        startTime,
        endTime,
        day,
        subject,
        semester,
        year,
        createdAt,
        updatedAt,
      ];

  @override
  String toString() {
    return 'ScheduleEntity(id: $id, teacherName: $teacherName, room: $room, startTime: $startTime, endTime: $endTime, day: $day, subject: $subject, semester: $semester, year: $year, createdAt: $createdAt, updatedAt: $updatedAt)';
  }
}
