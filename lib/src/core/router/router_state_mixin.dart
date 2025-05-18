import 'package:flutter/widgets.dart';
import 'package:octopus/octopus.dart';
import 'package:vm_app/src/core/di/dependencies.dart';
import 'package:vm_app/src/core/router/auth_guard.dart';
import 'package:vm_app/src/core/router/routes.dart';

mixin RouterStateMixin<T extends StatefulWidget> on State<T> {
  late final Octopus router;
  late final ValueNotifier<List<({Object error, StackTrace stackTrace})>> errorsObserver;

  @override
  void initState() {
    super.initState();

    final dependencies = Dependencies.of(context);

    // Observe all errors.
    errorsObserver = ValueNotifier<List<({Object error, StackTrace stackTrace})>>(
      <({Object error, StackTrace stackTrace})>[],
    );

    // Create router.
    router = Octopus(
      routes: Routes.values,
      defaultRoute: Routes.home,
      guards: <IOctopusGuard>[
        AuthenticationGuard(
          // Get current user from authentication controller.
          getStatus: () => dependencies.authController.state.status,
          // Available routes for non authenticated user.
          routes: <String>{Routes.login.name},
          // Default route for non authenticated user.
          signinNavigation: OctopusState.single(Routes.login.node()),
          // Default route for authenticated user.
          homeNavigation: OctopusState.single(Routes.home.node()),
          // Check authentication on every authentication controller state change.
          refresh: dependencies.authController,
        ),
      ],
      // transitionDelegate: const DefaultTransitionDelegate<void>(),
      onError:
          (error, stackTrace) =>
              errorsObserver.value = <({Object error, StackTrace stackTrace})>[
                (error: error, stackTrace: stackTrace),
                ...errorsObserver.value,
              ],
    );
  }
}

final class RefreshListenable with ChangeNotifier {
  Future<void> start() async {
    while (true) {
      await Future<void>.delayed(const Duration(seconds: 1));
      notifyListeners();
    }
  }
}
