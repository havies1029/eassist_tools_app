import 'package:eassist_tools_app/pages/splash/loading_user_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:go_router/go_router.dart';
// import 'package:go_router/src/refresh_stream.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:eassist_tools_app/pages/splash/splash_page.dart';
import 'package:eassist_tools_app/widgets/account/profile/profile_main_page.dart';
import 'package:eassist_tools_app/pages/about_jps/about_main.dart';
import 'package:eassist_tools_app/pages/active_assets/active_assets_main.dart';
import 'package:eassist_tools_app/pages/article_page/article_main.dart';
import 'package:eassist_tools_app/pages/article_page/article_detail.dart';
import 'package:eassist_tools_app/pages/gen_profile/mrekanpajakcrud_form.dart';
import 'package:eassist_tools_app/pages/summary_polis_assets/assets_management_main.dart';
import 'package:eassist_tools_app/pages/find_insurance/find_insurance_main.dart';
import 'package:eassist_tools_app/pages/hero_client_page/hero_user_main.dart';
import 'package:eassist_tools_app/pages/heropage/hero_main.dart';
import 'package:eassist_tools_app/pages/user_jps/user_jps_main.dart';
import 'package:eassist_tools_app/pages/user_non_jps/user_non_jps_main.dart';
import 'package:eassist_tools_app/pages/testimony_page/testimony_main.dart';
import 'package:eassist_tools_app/pages/customer_service/cs_main.dart';

import 'package:eassist_tools_app/repositories/user/user_repository.dart';
import 'package:eassist_tools_app/blocs/authentication/authentication_bloc.dart';

import '../helper/go_router_refresh_stream.dart';
import '../pages/gen_profile/test_profile_main.dart';
import '../pages/splash/loading_client_page.dart';
import '../widgets/section/article/article_detail_page.dart';

/// Dummy fallback (tidak digunakan langsung dalam router)
class DummyUserRepository extends UserRepository {}

final dummyUserRepository = DummyUserRepository();

GoRouter buildRouter(BuildContext context) {
  final AuthenticationBloc authBloc = BlocProvider.of<AuthenticationBloc>(context, listen: false);

  var constraints;
  return GoRouter(
    initialLocation: '/hero',

    /// 👇 Sangat penting agar GoRouter tahu ketika state berubah
    refreshListenable: GoRouterRefreshStream(authBloc.stream),

    /// 👇 Handle redirect berbasis AuthenticationBloc state
    redirect: (context, state) {
      final authState = authBloc.state;
      final location = state.matchedLocation;

      debugPrint('[DEBUG REDIRECT] location: $location, authState: $authState');

      // Daftar halaman yang boleh diakses oleh siapa saja (public route)
      final publicRoutes = [
        '/testimony',
        '/about',
        '/article',
        '/article_1',
      ];

      // 1. Belum login diarahkan ke hero (kecuali public)
      if (authState is AuthenticationUnauthenticated &&
          !publicRoutes.contains(location)) {
        return '/hero';
      }

      // 2. login_client boleh akses hero_user
      if (authState is AuthenticationAuthenticated) {
        final from = authState.authenticatedFrom;

        if ((from == 'login_client' && from == 'login_token') && location == '/hero') {
          return '/loading_hero_user';
        }

        // 3. login_user boleh akses hero & public
        if (from == 'login_user' &&
            location != '/hero' &&
            !publicRoutes.contains(location)) {
          return '/hero';
        }
      }

      return null;
    },


    /// 👇 Semua route aplikasi
    routes: [
      GoRoute(path: '/splash', builder: (context, state) => const SplashPage()),
      GoRoute(
        path: '/loading_hero_user',
        builder: (context, state) => const LoadingClientPage(),
      ),
      GoRoute(
        path: '/loading_hero',
        builder: (context, state) => const LoadingUserPage(),
      ),
      GoRoute(
        path: '/profile_individu',
        builder: (context, state) {
          final userId = int.tryParse(state.uri.queryParameters['userid'] ?? '') ?? 123;
          return ProfileMainPage(userid: userId, selectedChoice: 'Individu');
        },
      ),
      GoRoute(
        path: '/profile_perusahaan',
        builder: (context, state) {
          final userId = int.tryParse(state.uri.queryParameters['userid'] ?? '') ?? 123;
          return ProfileMainPage(userid: userId, selectedChoice: 'Perusahaan');
        },
      ),
      GoRoute(path: '/article_1', builder: (context, state) => const ArticleDetailMain()),
      GoRoute(path: '/test_profile', builder: (context, state) => const TestProfileMain()),
      GoRoute(path: '/about', builder: (context, state) => const AboutMain()),
      GoRoute(path: '/active_assets', builder: (context, state) => const ActiveAssetPage()),
      GoRoute(path: '/article', builder: (context, state) => const ArticleMain()),
      GoRoute(path: '/assets_management', builder: (context, state) => const AssetsManagementMain()),
      GoRoute(path: '/find_insurance', builder: (context, state) => const FindInsuranceMain()),
      GoRoute(path: '/hero_user', builder: (context, state) => const HeroUserMain()),
      GoRoute(path: '/hero', builder: (context, state) => const HeroMain()),
      GoRoute(path: '/testimony', builder: (context, state) => const TestimonyMain()),
      GoRoute(path: '/cs', builder: (context, state) => const CSMain()),

      // 👇 Contoh form dengan query param
      GoRoute(
        path: '/rekanpajak1',
        builder: (context, state) {
          final mode = state.uri.queryParameters['mode'] ?? 'tambah';
          final id = state.uri.queryParameters['id'] ?? '';
          return MRekanPajakCrudFormPage(viewMode: mode, recordId: id);
        },
      ),
    ],
  );
}

/*

final GoRouter router = GoRouter(
  initialLocation: '/hero', // base awal saat app dibuka
  routes: [
    ShellRoute(
      builder: (context, state, child) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: Stack(
            children: [
              child,
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Material(
                  color: Colors.transparent,
                  elevation: 20,
                  child: NavbarWidget(
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
      routes: [
        GoRoute(path: '/splash', builder: (context, state) => const SplashPage()),
        GoRoute(
          path: '/profile_individu',
          builder: (context, state) {
            final userId = int.tryParse(state.uri.queryParameters['userid'] ?? '') ?? 123;
            return ProfileIndividuMainPage(
              userid: userId,
              userRepository: dummyUserRepository,
            );
          },
        ),
        GoRoute(path: '/about', builder: (context, state) => const AboutMain()),
        GoRoute(path: '/active_assets', builder: (context, state) => const ActiveAssetMain()),
        GoRoute(path: '/article', builder: (context, state) => const ArticleMain()),
        GoRoute(path: '/assets_management', builder: (context, state) => const AssetsManagementMain()),
        GoRoute(path: '/find_insurance', builder: (context, state) => const FindInsuranceMain()),
        GoRoute(path: '/hero_user', builder: (context, state) => const HeroUserMain()),
        GoRoute(path: '/hero', builder: (context, state) => const HeroMain()),
        GoRoute(
          path: '/rekanbank',
          builder: (context, state) {
            final mode = state.uri.queryParameters['mode'] ?? 'tambah';
            final id = state.uri.queryParameters['id'] ?? '';
            return RekanBankFormPage(viewMode: mode, recordId: id);
          },
        ),
        GoRoute(
          path: '/rekanpic',
          builder: (context, state) {
            final mode = state.uri.queryParameters['mode'] ?? 'tambah';
            final id = state.uri.queryParameters['id'] ?? '';
            return RekanPicFormPage(viewMode: mode, recordId: id);
          },
        ),
        GoRoute(
          path: '/rekanpiccrud',
          builder: (context, state) {
            final mode = state.uri.queryParameters['mode'] ?? 'tambah';
            final id = state.uri.queryParameters['id'] ?? '';
            return RekanPicCrudFormPage(viewMode: mode, recordId: id);
          },
        ),
        GoRoute(
          path: '/rekanpiccrud_main',
          builder: (context, state) {
            final mode = state.uri.queryParameters['mode'] ?? 'tambah';
            final id = state.uri.queryParameters['id'] ?? '';
            return RekanPicCrudMainPage(viewMode: mode, recordId: id);
          },
        ),
        GoRoute(
          path: '/rekanpiclist',
          builder: (context, state) {
            final query = state.uri.queryParameters['search'] ?? '';
            return RekanPicListListWidget(searchText: query);
          },
        ),
        GoRoute(
          path: '/rekanpiclist_widget',
          builder: (context, state) {
            final query = state.uri.queryParameters['search'] ?? '';
            return RekanPicListListWidget(searchText: query);
          },
        ),
        GoRoute(path: '/user_jps', builder: (context, state) => const UserJpsMain()),
        GoRoute(path: '/user_non_jps', builder: (context, state) => const UserNonJpsMain()),
        GoRoute(
          path: '/rekancontact',
          builder: (context, state) {
            final mode = state.uri.queryParameters['mode'] ?? 'tambah';
            final id = state.uri.queryParameters['id'] ?? '';
            return RekanContactFormPage(viewMode: mode, recordId: id);
          },
        ),
        GoRoute(
          path: '/rekangeneral',
          builder: (context, state) {
            final mode = state.uri.queryParameters['mode'] ?? 'tambah';
            final id = state.uri.queryParameters['id'] ?? '';
            return RekanGeneralFormPage(viewMode: mode, recordId: id);
          },
        ),
        GoRoute(
          path: '/rekanpajak',
          builder: (context, state) {
            final mode = state.uri.queryParameters['mode'] ?? 'tambah';
            final id = state.uri.queryParameters['id'] ?? '';
            return RekanPajakFormPage(viewMode: mode, recordId: id);
          },
        ),
        GoRoute(path: '/testimony', builder: (context, state) => const TestimonyMain()),
        GoRoute(path: '/cs', builder: (context, state) => const CSMain()),
      ],
    ),
  ],
);

 */
