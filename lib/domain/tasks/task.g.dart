// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Task _$$_TaskFromJson(Map<String, dynamic> json) => _$_Task(
      id: json['id'] as String,
      name: json['name'] as String,
      body: json['body'] as String,
      status: $enumDecodeNullable(_$StatusEnumMap, json['status']) ??
          Status.waiting,
    );

Map<String, dynamic> _$$_TaskToJson(_$_Task instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'body': instance.body,
      'status': _$StatusEnumMap[instance.status],
    };

const _$StatusEnumMap = {
  Status.waiting: 'waiting',
  Status.inProgress: 'inProgress',
  Status.done: 'done',
};
