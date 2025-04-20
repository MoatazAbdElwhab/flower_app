import 'package:flower_app/core/di/injectable.config.dart';
import 'package:flower_app/features/home/domain/entities/category_occasion_entity.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

final getIt = GetIt.instance;

@InjectableInit()
Future<void> configureDependencies() async {
  await getIt.init();


}
