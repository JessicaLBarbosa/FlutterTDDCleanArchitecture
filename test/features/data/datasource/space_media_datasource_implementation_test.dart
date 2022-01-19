// ignore_for_file: prefer_const_declarations

import 'package:clean_arch_tdd/core/errors/exceptions.dart';
import 'package:clean_arch_tdd/core/http_client/http_client.dart';
import 'package:clean_arch_tdd/core/utils/converters/date_to_string_converter.dart';
import 'package:clean_arch_tdd/features/data/datasources/space_media_datasource.dart';
import 'package:clean_arch_tdd/features/data/datasources/space_media_datasource_implementation.dart';
import 'package:clean_arch_tdd/features/data/models/space_media_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart' as http;

import '../../mocks/space_media_mock.dart';

class MockDateInputConverter extends Mock implements DateInputConverter {}

class HttpClientMock extends Mock implements HttpClient {}

void main() {
  late ISpaceMediaDatasource datasource;
  late DateInputConverter converter;
  late HttpClient client;

  setUp(() {
    client = HttpClientMock();
    datasource = SpaceMediaDatasouceImplementation(
      converter: converter,
      client: client,
    );
    registerFallbackValue(DateTime(2000));
    registerFallbackValue(Uri());
  });

  final tDateTime = DateTime(2022, 01, 19);
  final tDateTimeString = '2022-01-19';

  final urlExpected =
      "https://apod.nasa.gov/apod/image/2201/M31_HstSubaruGendler_960.jpg";
  DateInputConverter.format(tDateTime);

  final tSpaceMediaModel = SpaceMediaModel(
    description:
        'Meteors can be colorful. While the human eye usually cannot discern many colors, cameras often can. Pictured is a Quadrantids meteor captured by camera over Missouri, USA, early this month that was not only impressively bright, but colorful. The radiant grit, likely cast off by asteroid 2003 EH1, blazed a path across Earth\'s atmosphere.  Colors in meteors usually originate from ionized elements released as the meteor disintegrates, with blue-green typically originating from magnesium, calcium radiating violet, and nickel glowing green. Red, however, typically originates from energized nitrogen and oxygen in the Earth\'s atmosphere.  This bright meteoric fireball was gone in a flash -- less than a second -- but it left a wind-blown ionization trail that remained visible for several minutes.   APOD is available via Facebook: in English, Catalan and Portuguese',
    mediaType: 'image',
    title: 'A Colorful Quadrantid Meteor',
    mediaUrl:
        'https://apod.nasa.gov/apod/image/2102/MeteorStreak_Kuszaj_1080.jpg',
  );

  void successMock() {
    when(() => converter.format(any())).thenReturn(tDateTimeString);
    when(() => client.get(any()))
        .thenAnswer((_) async => http.Response(spaceMediaMock, 200));
  }

  test('should call the get method with correct url', () async {
    // Arrange
    successMock();
    // Act
    await datasource.getSpaceMediaFromDate(tDateTime);
    // Assert
    verify(() => client.get(Uri.https('api.nasa.gov', '/planetary/apod', {
          'api_key': 'DEMO_KEY',
          'date': '2021-02-02',
        }))).called(1);
  });
  test('should return a SpaceMediaModel when the call is successful', () async {
    // Arrange
    successMock();
    // Act
    final result = await datasource.getSpaceMediaFromDate(tDateTime);
    // Assert
    expect(result, tSpaceMediaModel);
    verify(() => converter.format(tDateTime)).called(1);
  });
  test('should throw a ServerException when the call is unccessful', () async {
    // Arrange
    when(() => converter.format(any())).thenReturn(tDateTimeString);
    when(() => client.get(any()))
        .thenAnswer((_) async => http.Response('something went wrong', 400));
    // Act
    final result = datasource.getSpaceMediaFromDate(tDateTime);
    // Assert
    expect(() => result, throwsA(ServerException()));
    verify(() => converter.format(tDateTime)).called(1);
  });
}
