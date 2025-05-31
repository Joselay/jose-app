import 'package:jose_app/features/schedule/domain/entities/schedule_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'schedule_model.g.dart';

@JsonSerializable()
class ScheduleModel extends ScheduleEntity {
  const ScheduleModel({
    required String id,
    required String teacherName,
    required String room,
    required String startTime,
    required String endTime,
    required String day,
    required String subject,
    required String semester,
    required String year,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super(
          id: id,
          teacherName: teacherName,
          room: room,
          startTime: startTime,
          endTime: endTime,
          day: day,
          subject: subject,
          semester: semester,
          year: year,
          createdAt: createdAt,
          updatedAt: updatedAt,
        );

  factory ScheduleModel.fromJson(Map<String, dynamic> json) {
    return ScheduleModel(
      id: json['id'] as String,
      teacherName: json['teacherName'] as String,
      room: json['room'] as String,
      startTime: json['startTime'] as String,
      endTime: json['endTime'] as String,
      day: json['day'] as String,
      subject: json['subject'] as String,
      semester: json['semester'] as String,
      year: json['year'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }

  Map<String, dynamic> toJson() => _$ScheduleModelToJson(this);

  factory ScheduleModel.fromEntity(ScheduleEntity entity) {
    return ScheduleModel(
      id: entity.id,
      teacherName: entity.teacherName,
      room: entity.room,
      startTime: entity.startTime,
      endTime: entity.endTime,
      day: entity.day,
      subject: entity.subject,
      semester: entity.semester,
      year: entity.year,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }
}
