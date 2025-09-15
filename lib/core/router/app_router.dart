import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/clients/presentation/pages/clients_page.dart';
import '../../features/clients/presentation/pages/edit_client_page.dart';
import '../../features/clients/presentation/pages/register_client_page.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../features/profile/presentation/pages/profile_page.dart';
import '../../features/splash/presentation/pages/splash_gate.dart';
import 'route_guards.dart';

GoRouter buildRouter() {
  return GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(path: '/', builder: (_, __) => const SplashGate()),
      GoRoute(path: '/login', redirect: loginGuard, builder: (_, __) => const LoginPage()),
      GoRoute(
        path: '/home',
        redirect: authGuard,
        builder: (_, __) => const HomePage(),
        routes: [
          GoRoute(path: '/clients', redirect: authGuard, builder: (_, __) => const ClientsPage()),
          GoRoute(
            path: '/clients/new',
            redirect: adminGuard,
            builder: (_, __) => const RegisterClientPage(),
          ),
          GoRoute(
            path: '/clients/:id',
            redirect: authGuard,
            builder: (_, st) => EditClientPage(clientId: st.pathParameters['id']!),
          ),
          GoRoute(path: '/profile', redirect: authGuard, builder: (_, __) => const ProfilePage()),
        ],
      ),
    ],
  );
}
