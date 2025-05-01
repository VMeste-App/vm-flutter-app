import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:octopus/octopus.dart';
import 'package:vm_app/src/feature/auth/model/authentication_status.dart';

/// A router guard that checks if the user is authenticated.
final class AuthenticationGuard extends OctopusGuard {
  AuthenticationGuard({
    required FutureOr<AuthenticationStatus> Function() getStatus,
    required Set<String> routes,
    required OctopusState signinNavigation,
    required OctopusState homeNavigation,
    OctopusState? lastNavigation,
    super.refresh,
  }) : _getStatus = getStatus,
       _routes = routes,
       _lastNavigation = lastNavigation ?? homeNavigation,
       _signinNavigation = signinNavigation {
    // Get the last navigation from the platform default route.
    if (lastNavigation == null) {
      try {
        final platformDefault = WidgetsBinding.instance.platformDispatcher.defaultRouteName;
        final state = OctopusState.fromLocation(platformDefault);
        if (state.isNotEmpty) {
          _lastNavigation = state;
        }
      } on Object {
        /* ignore */
      }
    }
  }

  /// Get the current user.
  final FutureOr<AuthenticationStatus> Function() _getStatus;

  /// Routes names that stand for the authentication routes.
  final Set<String> _routes;

  /// The navigation to use when the user is not authenticated.
  final OctopusState _signinNavigation;

  /// The navigation to use when the user is authenticated.
  OctopusState _lastNavigation;

  @override
  FutureOr<OctopusState> call(
    List<OctopusHistoryEntry> history,
    OctopusState$Mutable state,
    Map<String, Object?> context,
  ) async {
    final status = await _getStatus(); // Get the current status.
    final isAuthenticated = status.isAuthenticated;
    context['status'] = status; // Save the user in the context.
    final isAuthNav = state.children.any((child) => _routes.contains(child.name));

    if (isAuthNav) {
      // New state is an authentication navigation.
      if (isAuthenticated) {
        // User authenticated.
        // Remove any navigation that is an authentication navigation.
        state.removeWhere((child) => _routes.contains(child.name));
        // Restore the last navigation when the user is authenticated
        // if the state contains only the authentication routes.
        return state.isEmpty ? _lastNavigation : state;
      }
      // User not authenticated.
      // Remove any navigation that is not an authentication navigation.
      state.removeWhere((child) => !_routes.contains(child.name));
      // Add the signin navigation if the state is empty.
      // Or return the state if it contains the signin navigation.
      return state.isEmpty ? _signinNavigation : state;
    }

    // New state is not an authentication navigation.
    if (isAuthenticated) {
      // User authenticated.
      // Save the current navigation as the last navigation.
      _lastNavigation = state;
      return super.call(history, state, context);
    }

    // User not authenticated.
    // Replace the current navigation with the signin navigation.
    return _signinNavigation;
  }
}
