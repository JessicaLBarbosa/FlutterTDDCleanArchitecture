import 'package:clean_arch_tdd/core/errors/exceptions.dart';
import 'package:clean_arch_tdd/features/data/datasources/space_media_datasource.dart';
import 'package:clean_arch_tdd/features/domain/entities/space_media_entity.dart';
import 'package:clean_arch_tdd/core/errors/failures.dart';
import 'package:clean_arch_tdd/features/domain/repositories/space_media_repository.dart';
import 'package:dartz/dartz.dart';

class SpaceMediaRepositoryImplementation implements ISpaceMediaRepository {
  final ISpaceMediaDatasource datasource;

  SpaceMediaRepositoryImplementation(this.datasource);

  @override
  Future<Either<Failure, SpaceMediaEntity>> getSpaceMediaFromDate(
      DateTime date) async {
    try {
      final result = await datasource.getSpaceMediaFromDate(date);
      return Right(result);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
