import 'package:clean_arch_tdd/core/errors/failures.dart';
import 'package:clean_arch_tdd/core/usecase/usecase.dart';
import 'package:clean_arch_tdd/features/domain/entities/space_media_entity.dart';
import 'package:clean_arch_tdd/features/domain/repositories/space_media_repository.dart';
import 'package:dartz/dartz.dart';

class GetSpaceMediaFromDateUsecase
    implements Usecase<SpaceMediaEntity, DateTime> {
  final ISpaceMediaRepository repository;

  GetSpaceMediaFromDateUsecase(this.repository);

  @override
  Future<Either<Failure, SpaceMediaEntity>> call(DateTime? date) async {
    return date != null
        ? await repository.getSpaceMediaFromDate(date)
        : Left(NullParamFailure());
  }
}
