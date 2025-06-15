import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:eassist_tools_app/pages/splash/splash_page.dart';
import 'package:eassist_tools_app/widgets/account/profile/profile_individu/profile_individu_main_page.dart';
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

  initialLocation: '/splash',
  routes: [
    GoRoute(path: '/splash', builder: (context, state) => const SplashPage()),
    GoRoute(path: '/profile_individu', builder: (context, state) => ProfileIndividuMainPage(userid: 123, userRepository: dummyUserRepository)),
    GoRoute(path: '/about', builder: (context, state) => const AboutMain()),
    GoRoute(path: '/active_assets', builder: (context, state) => const ActiveAssetMain()),
    GoRoute(path: '/article', builder: (context, state) => const ArticleMain()),
    GoRoute(path: '/assets_management', builder: (context, state) => const AssetsManagementMain()),
    GoRoute(path: '/find_insurance', builder: (context, state) => const FindInsuranceMain()),
    GoRoute(path: '/hero_user', builder: (context, state) => const HeroUserMain()),
    GoRoute(path: '/hero', builder: (context, state) => const HeroMain()),
    GoRoute(path: '/rekanbank', builder: (context, state) => const RekanBankFormPage(viewMode: 'tambah',recordId: '')),
    GoRoute(path: '/rekanpic', builder: (context, state) => const RekanPicFormPage(viewMode: 'tambah',recordId: '')),
    GoRoute(path: '/rekanpiccrud', builder: (context, state) => const RekanPicCrudFormPage(viewMode: 'tambah',recordId: '')), // bisa diubah jadi child route
    GoRoute(path: '/rekanpiccrud_main', builder: (context, state) => const RekanPicCrudMainPage(viewMode: 'tambah',recordId: '')),
    GoRoute(path: '/rekanpiclist', builder: (context, state) => const RekanPicListListWidget(searchText: '')),
    GoRoute(path: '/rekanpiclist_widget', builder: (context, state) => const RekanPicListListWidget(searchText: '')),
    GoRoute(path: '/user_jps', builder: (context, state) => const UserJpsMain()),
    GoRoute(path: '/user_non_jps', builder: (context, state) => const UserNonJpsMain()),
    GoRoute(path: '/rekancontact', builder: (context, state) => const RekanContactFormPage(viewMode: 'tambah',recordId: '')),
    GoRoute(path: '/rekangeneral', builder: (context, state) => const RekanGeneralFormPage(viewMode: 'tambah',recordId: '')),
    GoRoute(path: '/rekanpajak', builder: (context, state) => const RekanPajakFormPage(viewMode: 'tambah',recordId: '')),
    GoRoute(path: '/testimony', builder: (context, state) => const TestimonyMain()),
    GoRoute(path: '/cs', builder: (context, state) => const CSMain()),
  ],
);