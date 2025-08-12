import 'package:get_it/get_it.dart';
import 'core_dep.dart';
import 'questions_dep.dart';
import 'login_dep.dart';

final GetIt sl = GetIt.instance;

Future<void> slInit() async {
  await registerCoreDep();
  registerQuestionsDep();
  registerLoginDep();
}
