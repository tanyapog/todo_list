import 'package:auto_route/annotations.dart';
import 'package:todo_list/presentation/pages/sign_in/sign_in_page.dart';
import 'package:todo_list/presentation/pages/splash/splash_page.dart';
import 'package:todo_list/presentation/tasks/task_form_page.dart';
import 'package:todo_list/presentation/tasks/tasks_overview_page.dart';

@MaterialAutoRouter(
    replaceInRouteName: 'Page,Route',
    routes: <AutoRoute> [
      MaterialRoute(page: SplashPage, initial: true),
      MaterialRoute(page: SignInPage),
      MaterialRoute(page: TasksOverviewPage),
      MaterialRoute(page: TaskFormPage),
    ]
)
class $Router {}