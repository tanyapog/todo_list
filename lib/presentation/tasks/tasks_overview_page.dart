import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/application/auth/auth_bloc.dart';
import 'package:todo_list/injection.dart';
import 'package:todo_list/presentation/routes/router.gr.dart';

class TasksOverviewPage extends StatelessWidget {
  const TasksOverviewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todos'),
        actions: [
          BlocProvider(
            create: (context) => getIt<AuthBloc>(),
            child: BlocConsumer<AuthBloc, AuthState>(
              listener: (context, state) {
                print("::: $state");
                state.maybeMap(
                  unauthenticated: (_) => AutoRouter.of(context).replace(const SignInRoute()),
                  orElse: () => Container(),);
              },
              builder: (context, state) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () {
                    context.read<AuthBloc>().add(const AuthEvent.signedOut());
                  },
                  child: const Icon(Icons.exit_to_app),
                ),
              ),
            ),
          )
        ],
      ),
      body: const Center(
        child: Text('Tasks'),
      ),
    );
  }
}
