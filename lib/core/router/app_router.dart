import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/clients/presentation/pages/form/client_form_page.dart';
import '../../features/clients/presentation/pages/view/clients_page.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../features/profile/presentation/pages/profile_page.dart';
import '../../features/splash/presentation/pages/splash_gate.dart';
import '../../features/users/presentation/users_page.dart';
import 'route_guards.dart';

GoRouter buildRouter() {
  return GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(path: '/', builder: (_, __) => const SplashGate()),
      GoRoute(path: '/login', redirect: loginGuard, builder: (_, __) => const LoginPage()),
      ShellRoute(
        redirect: authGuard,
        builder: (_, state, child) => HomePage(key: state.pageKey, child: child),
        routes: [
          GoRoute(path: '/home', redirect: (_, __) => '/home/clients'),
          GoRoute(
            path: '/home/clients',
            redirect: authGuard,
            builder: (_, state) => ClientsPage(key: state.pageKey),
          ),
          GoRoute(
            path: '/home/clients/new',
            redirect: adminGuard,
            builder: (_, state) => ClientFormPage(key: state.pageKey),
          ),
          GoRoute(
            path: '/home/clients/:id',
            redirect: authGuard,
            builder: (_, st) => ClientFormPage(key: st.pageKey, clientId: st.pathParameters['id']!),
          ),
          GoRoute(
            path: '/home/profile',
            redirect: authGuard,
            builder: (_, state) => ProfilePage(key: state.pageKey),
          ),
          GoRoute(
            path: '/home/users',
            redirect: adminGuard,
            builder: (_, state) => UsersPage(key: state.pageKey),
          ),
        ],
      ),
    ],
  );
}
