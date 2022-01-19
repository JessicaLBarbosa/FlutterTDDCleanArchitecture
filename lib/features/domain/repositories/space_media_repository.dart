import 'package:clean_arch_tdd/core/errors/failures.dart';
import 'package:clean_arch_tdd/features/domain/entities/space_media_entity.dart';
import 'package:dartz/dartz.dart';

abstract class ISpaceMediaRepository {
  Future<Either<Failure, SpaceMediaEntity>> getSpaceMediaFromDate(
      DateTime date);
}
