// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i3;

import 'application/auth/auth_bloc.dart' as _i6;
import 'application/auth/sign_in_form/sign_in_form_bloc.dart' as _i5;
import 'infrastructure/auth/authentication_repository.dart' as _i4;
import 'infrastructure/shared_preferences_injectable_module.dart'
    as _i7; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
Future<_i1.GetIt> $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) async {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final registerModule = _$RegisterModule();
  await gh.factoryAsync<_i3.SharedPreferences>(() => registerModule.prefs,
      preResolve: true);
  gh.lazySingleton<_i4.AuthenticationRepository>(
      () => _i4.AuthenticationRepository(get<_i3.SharedPreferences>()));
  gh.factory<_i5.SignInFormBloc>(
      () => _i5.SignInFormBloc(get<_i4.AuthenticationRepository>()));
  gh.factory<_i6.AuthBloc>(
      () => _i6.AuthBloc(get<_i4.AuthenticationRepository>()));
  return get;
}

class _$RegisterModule extends _i7.RegisterModule {}
