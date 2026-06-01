import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:local_source/local_source.dart';

import '../../features/auth/presentation/bloc/auth_cubit.dart';
import '../../features/auth/presentation/screen/login_screen.dart';
import '../../features/home/presentation/cubit/home_cubit.dart';
import '../../features/home/presentation/screen/home_screen.dart';
import '../../features/journal/presentation/cubit/journal_cubit.dart';
import '../../features/journal/presentation/screen/journal_screen.dart';
import '../../features/main/presentation/screen/main_screen.dart';
import '../../features/profile/presentation/cubit/profile_cubit.dart';
import '../../features/profile/presentation/screen/profile_screen.dart';
import '../auth/auth_session_notifier.dart';
import '../di/injection.dart';

sealed class AppRouter {
  const AppRouter._();

  static const String initial = '/';
  static const String home = '/home';
  static const String journal = '/journal';
  static const String profile = '/profile';

  static final rootNavigatorKey = GlobalKey<NavigatorState>();
  static final shellNavigatorKey = GlobalKey<NavigatorState>();

  static String? _redirect(GoRouterState state) {
    final bool isAuthenticated = sl<LocalSource>().isUserAuthenticated;
    final String location = state.uri.path;

    final bool isInAuthFlow = location == initial;
    final bool isInProtectedArea =
        location.startsWith(home) || location.startsWith(journal) || location.startsWith(profile);

    if (!isAuthenticated && isInProtectedArea) return initial;
    if (isAuthenticated && isInAuthFlow) return home;
    return null;
  }

  static ShellRoute _authShellRoute() => ShellRoute(
    builder: (context, state, child) => BlocProvider(create: (_) => sl<AuthCubit>(), child: child),
    routes: [GoRoute(path: initial, name: initial, builder: (_, _) => const LoginScreen())],
  );

  static ShellRoute _mainShellRoute() => ShellRoute(
    navigatorKey: shellNavigatorKey,
    builder: (context, state, child) => MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<AuthCubit>()),
        BlocProvider(create: (_) => sl<HomeCubit>()),
        BlocProvider(create: (_) => sl<JournalCubit>()),
        BlocProvider(create: (_) => sl<ProfileCubit>()),
      ],
      child: MainScreen(child: child),
    ),
    routes: [
      GoRoute(
        path: home,
        name: home,
        pageBuilder: (_, _) => const NoTransitionPage(child: HomeScreen()),
      ),
      GoRoute(
        path: journal,
        name: journal,
        pageBuilder: (_, _) => const NoTransitionPage(child: JournalScreen()),
      ),
      GoRoute(
        path: profile,
        name: profile,
        pageBuilder: (_, _) => const NoTransitionPage(child: ProfileScreen()),
      ),
    ],
  );

  static final router = GoRouter(
    debugLogDiagnostics: true,
    errorBuilder: (context, state) => Scaffold(body: Center(child: Text('Page not found: ${state.error}'))),
    navigatorKey: rootNavigatorKey,
    refreshListenable: sl<AuthSessionNotifier>(),
    redirect: (_, state) => _redirect(state),
    initialLocation: initial,
    routes: [_authShellRoute(), _mainShellRoute()],
  );
}
