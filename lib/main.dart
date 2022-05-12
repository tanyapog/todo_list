import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/application/auth/auth_bloc.dart';
import 'package:todo_list/injection.dart';
import 'package:todo_list/presentation/routes/router.gr.dart' as app_router;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureInjection();
  runApp(TodoApp());
}

class TodoApp extends StatelessWidget {
  TodoApp({Key? key}) : super(key: key);

  final _appRouter = app_router.Router();

  // This widget is the root of the application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
      getIt<AuthBloc>()..add(const AuthEvent.authCheckRequested()),
      child: MaterialApp.router(
        title: 'Todo App',
        routerDelegate: _appRouter.delegate(),
        routeInformationParser: _appRouter.defaultRouteParser(),
        theme: ThemeData(primarySwatch: Colors.blue,),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
