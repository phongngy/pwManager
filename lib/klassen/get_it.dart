import 'package:get_it/get_it.dart';
import 'package:pwsafe/klassen/local_auth.dart';
import 'package:pwsafe/klassen/passwort_generator.dart';

final getItInjector = GetIt.instance;

void init() {
  getItInjector.registerLazySingleton(() => PasswordGenerator());
  getItInjector.registerLazySingleton(() => Auth());
}
