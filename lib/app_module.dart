import 'package:clean_arch_tdd/core/utils/converters/date_to_string_converter.dart';
import 'package:clean_arch_tdd/features/data/datasources/space_media_datasource_implementation.dart';
import 'package:clean_arch_tdd/features/data/repositories/space_media_repository_implementation.dart';
import 'package:clean_arch_tdd/features/domain/usecases/get_space_media_from_date_usecase.dart';
import 'package:clean_arch_tdd/features/presenter/controllers/home_store.dart';
import 'package:clean_arch_tdd/features/presenter/pages/home_page.dart';
import 'package:clean_arch_tdd/features/presenter/pages/picture_page.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:http/http.dart' as http;

class AppModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.factory((i) => HomeStore(i())),
    Bind.lazySingleton((i) => GetSpaceMediaFromDateUsecase(i())),
    Bind.lazySingleton((i) => SpaceMediaRepositoryImplementation(i())),
    Bind.lazySingleton(
        (i) => SpaceMediaDatasouceImplementation(converter: i(), client: i())),
    Bind.lazySingleton((i) => http.Client()),
    Bind.lazySingleton((i) => DateInputConverter()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, __) => HomePage()),
    ChildRoute('/picture', child: (_, args) => PicturePage.fromArgs(args.data)),
  ];
}
