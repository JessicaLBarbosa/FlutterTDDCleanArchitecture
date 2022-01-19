import 'package:clean_arch_tdd/core/errors/exceptions.dart';
import 'package:clean_arch_tdd/core/errors/failures.dart';
import 'package:clean_arch_tdd/features/data/datasources/space_media_datasource.dart';
import 'package:clean_arch_tdd/features/data/models/space_media_model.dart';
import 'package:clean_arch_tdd/features/data/repositories/space_media_repository_implementation.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockSpaceMediaDatasource extends Mock implements ISpaceMediaDatasource {}

void main() {
  late SpaceMediaRepositoryImplementation repository;
  late ISpaceMediaDatasource datasource;

  setUp(() {
    datasource = MockSpaceMediaDatasource();
    repository = SpaceMediaRepositoryImplementation(datasource);
  });

  final tSpaceMediaModel = SpaceMediaModel(
    description:
        "The most distant object easily visible to the unaided eye is M31, the great Andromeda Galaxy. Even at some two and a half million light-years distant, this immense spiral galaxy -- spanning over 200,000 light years -- is visible, although as a faint, nebulous cloud in the constellation Andromeda. In contrast, a bright yellow nucleus, dark winding dust lanes, and expansive spiral arms dotted with blue star clusters and red nebulae, are recorded in this stunning telescopic image which combines data from orbiting Hubble with ground-based images from Subaru and Mayall. In only about 5 billion years, the Andromeda galaxy may be even easier to see -- as it will likely span the entire night sky -- just before it merges with our Milky Way Galaxy.",
    mediaType: 'image',
    title: "M31: The Andromeda Galaxy",
    mediaUrl:
        "https://apod.nasa.gov/apod/image/2201/M31_HstSubaruGendler_960.jpg",
  );

  final tDate = DateTime(2022, 01, 19);

  test('should return space media model when calls the datasource', () async {
    // Arrange
    when(() => datasource.getSpaceMediaFromDate(any()))
        .thenAnswer((_) async => tSpaceMediaModel);
    // Act
    final result = await repository.getSpaceMediaFromDate(tDate);
    // Assert
    expect(result, Right(tSpaceMediaModel));
    verify(() => datasource.getSpaceMediaFromDate(tDate)).called(1);
  });

  test(
      'should return a server failure when the call to datasource is unsucessful',
      () async {
    // Arrange
    when(() => datasource.getSpaceMediaFromDate(any()))
        .thenThrow(ServerException());
    // Act
    final result = await repository.getSpaceMediaFromDate(tDate);
    // Assert
    expect(result, Left(ServerFailure()));
    verify(() => datasource.getSpaceMediaFromDate(tDate)).called(1);
  });
}
