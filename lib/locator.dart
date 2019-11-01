import 'package:get_it/get_it.dart';
import 'package:pixart/service/navigation_service.dart';
import 'package:pixart/store/app_flow.dart';
import 'package:pixart/store/auth/auth.dart';
import 'package:pixart/store/pictures/pictures.dart';

GetIt locator = GetIt.instance;
const String DB_PICTURE_INSTANCE = 'DBPictures';
const String LIBRARY_PICTURE_INSTANCE = 'LabraryPictures';

void setupLocator() {
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => AppFlow());
  locator.registerLazySingleton(() => Pictures());
  locator.registerLazySingleton(() => LibraryPictures());
  locator.registerLazySingleton(() => Auth());
}
