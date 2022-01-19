import 'dart:convert';

import 'package:clean_arch_tdd/features/data/models/space_media_model.dart';
import 'package:clean_arch_tdd/features/domain/entities/space_media_entity.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../mocks/space_media_mock.dart';

void main() {
  final tSpaceMediaModel = SpaceMediaModel(
    description:
        'The most distant object easily visible to the unaided eye is M31, the great Andromeda Galaxy. Even at some two and a half million light-years distant, this immense spiral galaxy -- spanning over 200,000 light years -- is visible, although as a faint, nebulous cloud in the constellation Andromeda. In contrast, a bright yellow nucleus, dark winding dust lanes, and expansive spiral arms dotted with blue star clusters and red nebulae, are recorded in this stunning telescopic image which combines data from orbiting Hubble with ground-based images from Subaru and Mayall. In only about 5 billion years, the Andromeda galaxy may be even easier to see -- as it will likely span the entire night sky -- just before it merges with our Milky Way Galaxy.',
    mediaType: 'image',
    title: "M31: The Andromeda Galaxy",
    mediaUrl:
        "https://apod.nasa.gov/apod/image/2201/M31_HstSubaruGendler_960.jpg",
  );

  test('should be a subclass of SpaceMediaEntity', () {
    expect(tSpaceMediaModel, isA<SpaceMediaEntity>());
  });

  test('should return a valid model', () {
    //Arrange
    final Map<String, dynamic> jsonMap = json.decode(spaceMediaMock);

    //Act
    final result = SpaceMediaModel.fromJson(jsonMap);

    //Assert
    expect(result, tSpaceMediaModel);
  });

  test('should return a json map containing the proper data', () {
    //Arrange
    final expectedMap = {
      "explanation":
          "The most distant object easily visible to the unaided eye is M31, the great Andromeda Galaxy. Even at some two and a half million light-years distant, this immense spiral galaxy -- spanning over 200,000 light years -- is visible, although as a faint, nebulous cloud in the constellation Andromeda. In contrast, a bright yellow nucleus, dark winding dust lanes, and expansive spiral arms dotted with blue star clusters and red nebulae, are recorded in this stunning telescopic image which combines data from orbiting Hubble with ground-based images from Subaru and Mayall. In only about 5 billion years, the Andromeda galaxy may be even easier to see -- as it will likely span the entire night sky -- just before it merges with our Milky Way Galaxy.",
      "media_type": "image",
      "title": "M31: The Andromeda Galaxy",
      "url":
          "https://apod.nasa.gov/apod/image/2201/M31_HstSubaruGendler_960.jpg",
    };

    //Act
    final result = tSpaceMediaModel.toJson();

    //Assert
    expect(result, expectedMap);
  });
}
