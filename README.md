## Clean Architecture Flutter + BLoC (Questions + Login)

This project is a small learning-oriented Flutter app that demonstrates feature-driven Clean Architecture with BLoC/Cubit, dependency injection via GetIt, networking with Dio, and two different error-handling approaches:
- **Either-based flow** (functional error handling) in the Questions feature
- **try/catch flow** (imperative error handling) in the Login feature

The code aims to be friendly for all levels, with small, composable widgets and clear separation of concerns.

### Tech stack
- **Flutter**: UI layer
- **BLoC/Cubit**: State management (`flutter_bloc`)
- **Dio**: HTTP client
- **GetIt**: Service Locator (Dependency Injection)
- **Dartz**: `Either<L, R>` for functional error handling (Questions feature)
- **SharedPreferences**: Local persistence (Login data source)

## Project structure (high-level)

```
lib/
  app.dart                         # MaterialApp root
  core/                            # Cross-cutting concerns
    base_use_cases.dart            # Base UseCase and NoParams
    dependency_registrar/          # GetIt registrations per module
      core_dep.dart
      dependencies.dart
      login_dep.dart
      questions_dep.dart
    errors/                        # Exceptions and Failures
      exceptions.dart
      failures.dart
    navigation/
      app_router.dart              # Central app routing
    network/
      connection_checker.dart
      dio_client.dart

  features/
    login/
      data/                        # Data layer (sources + repository)
        datasources/
          login_local_data_source.dart
          login_remote_data_source.dart
        models/
        repositories/
          login_repository.dart
      presentation/                # UI layer (widgets + bloc + usecases for demo)
        bloc/
          login_bloc.dart
          login_event.dart
          login_state.dart
        pages/
          login_page.dart
        widgets/
          login_error_message.dart
          login_submit_button.dart
          login_text_field.dart
        usecases/
          login_use_case.dart

    questions/
      data/
        datasources/
          question_local_data_source.dart
          question_remote_data_source.dart
        models/
          question_model.dart
        repositories/
          questions_repository_impl.dart
      ui/                           # UI layer (named ui instead of presentation in this feature)
        cubit/
          questions_cubit.dart
          questions_state.dart
        pages/
          questions_page.dart
        usecases/
          get_question.dart
          get_questions.dart
        widgets/
          question_list_item.dart
          questions_error.dart
          questions_list.dart
          questions_loader.dart
```

Note on structure: as this is an example, this repo places use cases under the UI/presentation folder in each feature to keep files close to where they are used. In a stricter Clean Architecture, you can create a `domain/` folder inside each feature and move the `usecases/` folder there. If you do so here, that `domain/` folder would only contain `usecases/`, which is why we kept them under UI/presentation for brevity.

Additional notes about the chosen pattern:
- This simplified layout helps you write code faster than a strict, fully abstracted Clean Architecture template. We intentionally avoid extra boilerplate such as creating an abstract interface for every remote data source plus a separate implementation when it does not add concrete value at this scale. Less ceremony, same learning outcome.
- We never register a Bloc/Cubit in the Service Locator. Blocs/Cubits are UI-scoped and should be created/disposed with the widget tree (e.g., via `BlocProvider` in routes/pages) to respect their lifecycle and avoid leaking state.

## Architecture overview

- **Data sources**: Know how to fetch data (remote via `DioClient`, local via `SharedPreferences`, etc.)
- **Repository**: Orchestrates data sources; provides a simple API to the domain/UI
- **Use cases**: Encapsulate a single business action (e.g., `GetQuestions`, `LoginUseCase`)
- **State management**: BLoC/Cubit coordinate UI and use cases
- **Widgets/Pages**: Small, composable UI widgets consume the state

Data flow:
1. Page dispatches an event or calls a Cubit method
2. Bloc/Cubit invokes the UseCase
3. UseCase delegates to Repository
4. Repository talks to Data Sources (remote/local)
5. Results bubble back up, and Bloc/Cubit emits a new UI state

### How classes interact (concrete examples)
- `QuestionsCubit` calls `GetQuestions` (a use case) which returns `Either<Failure, List<Question>>`
- `LoginBloc` calls `LoginUseCase` inside a `try/catch` and emits success/error states
- `AppRouter` wires pages with their Bloc/Cubit and injects dependencies from `GetIt`

## Dependency Injection (Service Locator: GetIt)

All dependencies are registered in `lib/core/dependency_registrar/` and accessed via the global `sl` instance.

- `dependencies.dart` exposes `sl` and `slInit()`
- `core_dep.dart` registers cross-cutting services (`DioClient`, `ConnectionChecker`, `SharedPreferences`)
- `login_dep.dart` registers login data sources, repository, and `LoginUseCase`
- `questions_dep.dart` registers question data sources, repository, and use cases

Usage patterns:
- Register once on startup (e.g., before `runApp`): `await slInit();`
- Resolve in constructors or factories: `sl<LoginUseCase>()`
- Example: in `AppRouter`, we create a `LoginBloc(loginUseCase: sl<LoginUseCase>())`

Why Service Locator?
- Centralized wiring with zero boilerplate in UI
- Easy swapping of implementations (e.g., mock vs prod)
- Clear module boundaries via per-feature registration files

## Error handling: Either vs try/catch

This repo intentionally shows both styles so you can compare.

### Either style (Questions feature)
- `UseCase` base class returns `Future<Either<Failure, T>>`
- UI calls the use case and folds the result:
  - On `Failure`, emit error state with message
  - On `Success`, emit loaded state

Benefits:
- Compile-time signaling of success vs failure
- Encourages explicit, testable error mapping (e.g., Exceptions → Failures)

Trade-offs:
- Slightly more boilerplate
- Requires learning the `Either` API

### try/catch style (Login feature)
- UI calls the use case inside a `try/catch`
- On success → `LoginSuccess`; on error → `LoginError` with message

Benefits:
- Minimal learning curve 
- Quick to write for simple operations

Trade-offs:
- Easy to accidentally swallow/overgeneralize errors
- Error contracts are implicit (vs. `Either`’s explicit type)

## Navigation

Current implementation uses `MaterialApp.onGenerateRoute` with `Navigator` to push pages (see `lib/core/navigation/app_router.dart`). This keeps setup minimal and is very clear.

Why you might choose GoRouter (recommended for larger apps):
- Declarative routes, URL-based navigation (web-friendly)
- Strong deep-linking and redirection support
- Cleaner nested navigation

If you want to switch later, you can migrate `AppRouter` to `go_router` and keep dependency injection the same (wrap pages with `BlocProvider` in route builders).

## UI: small, composable widgets

Each feature’s page uses small widgets from its `widgets/` folder:
- Questions: `QuestionsLoader`, `QuestionsErrorView`, `QuestionsList`, `QuestionListItem`
- Login: `LoginTextField`, `LoginErrorMessage`, `LoginSubmitButton`

Tip: A feature can also have a `common/` (or `shared/`) folder for widgets reusable across features (e.g., a generic loader). In this repo, the Questions feature includes a loader; you can promote it to a shared/common folder later if multiple features need it.

## Networking

- `DioClient` wraps Dio, sets timeouts, and adds logging.
- `ConnectionChecker` guards requests by checking network reachability.
- Remote data sources call `DioClient` and can throw domain-specific exceptions.
- Repositories map exceptions to `Failure`s (for Either flow) or rethrow for try/catch handling.

## Running the app

1. Ensure Flutter SDK is installed and set up
2. Get packages: `flutter pub get`
3. Initialize dependencies (happens in app bootstrap where you call `slInit()`)
4. Run: `flutter run`

## Where to move UseCases (Domain option)

As noted above, you can create `features/<feature>/domain/usecases/` and move the current `usecases/` there. In this demo, the domain layer would then only contain use cases, which is why we chose to keep them under presentation/UI to reduce folders. Both layouts are valid; choose based on team preference and scale.

## Learning checklist
- Understand feature boundaries and folder structure
- Know how DI works with GetIt (`slInit`, registrations, and lookups)
- Compare error handling with Either vs try/catch
- See how Bloc/Cubit mediates between UI and UseCases
- Recognize when to migrate routing to GoRouter in larger apps

