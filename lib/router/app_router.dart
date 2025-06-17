
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:eassist_tools_app/pages/splash/splash_page.dart';
import 'package:eassist_tools_app/widgets/account/profile/profile_main_page.dart';
import '../pages/about_jps/about_main.dart';
import '../pages/active_assets/active_assets_main.dart';
import '../pages/article_page/article_main.dart';
import '../pages/summary_polis_assets/assets_management_main.dart';
import '../pages/find_insurance/find_insurance_main.dart';
import '../pages/hero_client_page/hero_user_main.dart';
import '../pages/heropage/hero_main.dart';
import '../pages/profile/rekanbank_form.dart';
import '../pages/profile/rekanpic_form.dart';
import '../pages/profile/rekanpiccrud_form.dart';
import '../pages/profile/rekanpiccrud_main.dart';
import '../pages/profile/rekanpiclist_list.dart';
import '../pages/profile/rekanpiclist_list_widget.dart';
import '../pages/user_jps/user_jps_main.dart';
import '../pages/user_non_jps/user_non_jps_main.dart';
import '../pages/profile/rekancontact_form.dart';
import '../pages/profile/rekangeneral_form.dart';
import '../pages/profile/rekanpajak_form.dart';
import '../pages/testimony_page/testimony_main.dart';
import '../pages/customer_service/cs_main.dart';

import '../repositories/user/user_repository.dart';

class DummyUserRepository extends UserRepository {
  // Override semua method yang dibutuhkan dengan return dummy data atau kosong
}

final dummyUserRepository = DummyUserRepository();

final GoRouter router = GoRouter(
  initialLocation: '/hero', //base dari mulai project
  routes: [
    GoRoute(path: '/splash', builder: (context, state) => const SplashPage()),
    GoRoute(
      path: '/profile_individu',
      builder: (context, state) {
        final userId = int.tryParse(state.uri.queryParameters['userid'] ?? '') ?? 123;
        return ProfileMainPage(
          userid: userId,
          selectedChoice: 'Individual',
        );
      },
    ),
    GoRoute(path: '/about', builder: (context, state) => const AboutMain()),
    GoRoute(path: '/active_assets', builder: (context, state) => const ActiveAssetPage()),
    GoRoute(path: '/article', builder: (context, state) => const ArticleMain()),
    GoRoute(path: '/assets_management', builder: (context, state) => const AssetsManagementMain()),
    GoRoute(path: '/find_insurance', builder: (context, state) => const FindInsuranceMain()),
    GoRoute(path: '/hero_user', builder: (context, state) => const HeroUserMain()),
    GoRoute(path: '/testimony', builder: (context, state) => const TestimonyMain()),
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
        // final query = state.uri.queryParameters['search'] ?? '';
        return RekanPicListPage();
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
);




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
