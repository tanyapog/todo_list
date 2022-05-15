// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:rx_shared_preferences/rx_shared_preferences.dart' as _i3;

import 'application/auth/auth_bloc.dart' as _i10;
import 'application/auth/sign_in_form/sign_in_form_bloc.dart' as _i7;
import 'application/tasks/task_actor/task_actor_cubit.dart' as _i8;
import 'application/tasks/task_form/task_form_cubit.dart' as _i9;
import 'application/tasks/task_watcher/task_watcher_bloc.dart' as _i5;
import 'infrastructure/auth/authentication_repository.dart' as _i6;
import 'infrastructure/shared_preferences_injectable_module.dart' as _i11;
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
  gh.factory<_i5.TaskWatcherBloc>(() => _i5.TaskWatcherBloc());
  gh.lazySingleton<_i6.AuthenticationRepository>(
      () => _i6.AuthenticationRepository(get<_i3.RxSharedPreferences>()));
  gh.factory<_i7.SignInFormBloc>(
      () => _i7.SignInFormBloc(get<_i6.AuthenticationRepository>()));
  gh.factory<_i8.TaskActorCubit>(
      () => _i8.TaskActorCubit(get<_i4.TaskRepository>()));
  gh.factory<_i9.TaskFormCubit>(
      () => _i9.TaskFormCubit(get<_i4.TaskRepository>()));
  gh.factory<_i10.AuthBloc>(
      () => _i10.AuthBloc(get<_i6.AuthenticationRepository>()));
  return get;
}

class _$RegisterModule extends _i11.RegisterModule {}
