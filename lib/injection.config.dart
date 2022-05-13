// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:rx_shared_preferences/rx_shared_preferences.dart' as _i3;

import 'application/auth/auth_bloc.dart' as _i7;
import 'application/auth/sign_in_form/sign_in_form_bloc.dart' as _i6;
import 'infrastructure/auth/authentication_repository.dart' as _i5;
import 'infrastructure/shared_preferences_injectable_module.dart' as _i8;
import 'infrastructure/tasks/task_repository.dart'
    as _i4; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
Future<_i1.GetIt> $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) async {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final registerModule = _$RegisterModule();
  gh.factory<_i3.RxSharedPreferences>(() => registerModule.rxPrefs);
  await gh.factoryAsync<_i3.SharedPreferences>(() => registerModule.prefs,
      preResolve: true);
  gh.lazySingleton<_i4.TaskRepository>(
      () => _i4.TaskRepository(get<_i3.RxSharedPreferences>()));
  gh.lazySingleton<_i5.AuthenticationRepository>(
      () => _i5.AuthenticationRepository(get<_i3.RxSharedPreferences>()));
  gh.factory<_i6.SignInFormBloc>(
      () => _i6.SignInFormBloc(get<_i5.AuthenticationRepository>()));
  gh.factory<_i7.AuthBloc>(
      () => _i7.AuthBloc(get<_i5.AuthenticationRepository>()));
  return get;
}

class _$RegisterModule extends _i8.RegisterModule {}
