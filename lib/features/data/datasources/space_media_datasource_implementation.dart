import 'dart:convert';

import 'package:clean_arch_tdd/core/errors/exceptions.dart';
import 'package:clean_arch_tdd/core/http_client/http_client.dart';
import 'package:clean_arch_tdd/core/utils/converters/date_to_string_converter.dart';
import 'package:clean_arch_tdd/features/data/datasources/endpoints/nasa_endpoints.dart';
import 'package:clean_arch_tdd/features/data/models/space_media_model.dart';

import 'space_media_datasource.dart';

class SpaceMediaDatasouceImplementation implements ISpaceMediaDatasource {
  final DateInputConverter converter;
  final HttpClient client;

  SpaceMediaDatasouceImplementation({
    required this.converter,
    required this.client,
  });

  @override
  Future<SpaceMediaModel> getSpaceMediaFromDate(DateTime date) async {
    final dateConverted = converter.format(date);
    final response = await client.get(NasaEndpoints.getSpaceMedia(
      'DEMO_KEY',
      dateConverted,
    ));

    if (response.statusCode == 200) {
      return SpaceMediaModel.fromJson(jsonDecode(response.data));
    } else {
      throw ServerException();
    }
  }
}
