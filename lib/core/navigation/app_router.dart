import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/questions/ui/cubit/questions_cubit.dart';
import '../../features/questions/ui/pages/questions_page.dart';
import '../../features/login/presentation/pages/login_page.dart';
import '../../features/login/presentation/bloc/login_bloc.dart';
import '../../features/login/presentation/usecases/login_use_case.dart';
import '../dependency_registrar/dependencies.dart';

class AppRoutes {
  static const String login = '/';
  static const String questions = '/questions';
}

class AppRouter {
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.login:
        return MaterialPageRoute<Widget>(
          builder: (_) => BlocProvider<LoginBloc>(
            create: (_) => LoginBloc(loginUseCase: sl<LoginUseCase>()),
            child: const LoginPage(),
          ),
          settings: settings,
        );
      case AppRoutes.questions:
        return MaterialPageRoute<Widget>(
          builder: (_) => BlocProvider<QuestionsCubit>(
            create: (_) => QuestionsCubit(),
            child: const QuestionsPage(),
          ),
          settings: settings,
        );
      default:
        return MaterialPageRoute<Widget>(
          builder: (_) => BlocProvider<LoginBloc>(
            create: (_) => LoginBloc(loginUseCase: sl<LoginUseCase>()),
            child: const LoginPage(),
          ),
          settings: settings,
        );
    }
  }
}
