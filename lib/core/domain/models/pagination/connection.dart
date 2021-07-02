import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shetter_app/core/domain/domain.dart';

part 'connection.freezed.dart';

@freezed
class Connection<Entity> with _$Connection<Entity> {
  factory Connection({
    required IVector<Entity> nodes,
    required PageInfo pageInfo,
  }) = _Connection;
}
