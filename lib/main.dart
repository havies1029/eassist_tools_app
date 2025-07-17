import 'package:eassist_tools_app/blocs/authentication/authentication_bloc.dart';
import 'package:eassist_tools_app/blocs/chatting/guestscrud_bloc.dart';
import 'package:eassist_tools_app/blocs/gallery/galleryeventcari_bloc.dart';
import 'package:eassist_tools_app/blocs/gallery/gallerymembercari_bloc.dart';
import 'package:eassist_tools_app/blocs/gallery/gallerytestimonycari_bloc.dart';
import 'package:eassist_tools_app/blocs/gen_aset_dashboard/asetdashboardcari_bloc.dart';
import 'package:eassist_tools_app/blocs/gen_aset_health/asethealthcari_bloc.dart';
import 'package:eassist_tools_app/blocs/gen_aset_mv/asetmvcari_bloc.dart';
import 'package:eassist_tools_app/blocs/gen_aset_par/asetparcari_bloc.dart';
import 'package:eassist_tools_app/blocs/gen_aset_ringkasan/asetringkasancari_bloc.dart';
import 'package:eassist_tools_app/blocs/gen_cob_app/cobcari_bloc.dart';
import 'package:eassist_tools_app/blocs/gen_profile/mrekan1crud_bloc.dart';
import 'package:eassist_tools_app/blocs/gen_profile/mrekancontactcrud_bloc.dart';
import 'package:eassist_tools_app/blocs/gen_profile/mrekangeneralcmpcrud_bloc.dart';
import 'package:eassist_tools_app/blocs/gen_profile/mrekangeneralidvcrud_bloc.dart';
import 'package:eassist_tools_app/blocs/gen_profile/mrekanpiccrud_bloc.dart';
import 'package:eassist_tools_app/blocs/gen_profile/mrekanpiclist_bloc.dart';
import 'package:eassist_tools_app/blocs/gen_status_aset/statusasetcari_bloc.dart';
import 'package:eassist_tools_app/blocs/klaim/klaim1list_bloc.dart';
import 'package:eassist_tools_app/blocs/klaim/klaim2list_bloc.dart';
import 'package:eassist_tools_app/blocs/login/change_password_bloc.dart';
import 'package:eassist_tools_app/blocs/login/emailverification_bloc.dart';
import 'package:eassist_tools_app/blocs/login/login_bloc.dart';
import 'package:eassist_tools_app/blocs/networkconnection/network_bloc.dart';
import 'package:eassist_tools_app/blocs/onboardmenu/onboardmenucari_bloc.dart';
import 'package:eassist_tools_app/blocs/profile/profile_download_foto_bloc.dart';
import 'package:eassist_tools_app/blocs/profile/profile_upload_foto_bloc.dart';
import 'package:eassist_tools_app/blocs/profile/profile_upload_ktp_bloc.dart';
import 'package:eassist_tools_app/blocs/progressindicator/progressindicator_bloc.dart';
import 'package:eassist_tools_app/blocs/reguser/reguser_bloc.dart';
import 'package:eassist_tools_app/blocs/simuleei/simuleeicrud_bloc.dart';
import 'package:eassist_tools_app/blocs/simuleei/simuleeilist_bloc.dart';
import 'package:eassist_tools_app/blocs/simulgis/simulgiscrud_bloc.dart';
import 'package:eassist_tools_app/blocs/simulgit/simulgitcrud_bloc.dart';
import 'package:eassist_tools_app/blocs/simulmv/simulmvcrud_bloc.dart';
import 'package:eassist_tools_app/blocs/simulmv/simulmvlist_bloc.dart';
import 'package:eassist_tools_app/blocs/simulpar/simulparcrud_bloc.dart';
import 'package:eassist_tools_app/blocs/simulpar/simulparlist_bloc.dart';
import 'package:eassist_tools_app/blocs/simulbon/simulboncrud_bloc.dart';
import 'package:eassist_tools_app/blocs/simulwp/simulwpcrud_bloc.dart';
import 'package:eassist_tools_app/blocs/takeimage/takeimage_cubit.dart';
import 'package:eassist_tools_app/common/app_data.dart';
import 'package:eassist_tools_app/pages/heropage/hero_main.dart';
import 'package:eassist_tools_app/repositories/chatting/guestscrud_repository.dart';
import 'package:eassist_tools_app/repositories/gen_profile/mrekan1crud_repository.dart';
import 'package:eassist_tools_app/repositories/gen_profile/mrekancontactcrud_repository.dart';
import 'package:eassist_tools_app/repositories/gen_profile/mrekangeneralcmpcrud_repository.dart';
import 'package:eassist_tools_app/repositories/gen_profile/mrekangeneralidvcrud_repository.dart';
import 'package:eassist_tools_app/repositories/gen_profile/mrekanpiccrud_repository.dart';
import 'package:eassist_tools_app/repositories/login/change_password_repository.dart';
import 'package:eassist_tools_app/repositories/login/emailverification_repository.dart';
import 'package:eassist_tools_app/repositories/profile/profile_ktp_repository.dart';
import 'package:eassist_tools_app/repositories/profile/userfoto_repository.dart';
import 'package:eassist_tools_app/repositories/reguser/reguser_repository.dart';
import 'package:eassist_tools_app/repositories/simulbon/simulboncrud_repository.dart';
import 'package:eassist_tools_app/repositories/simulcar/simulcarcrud_repository.dart';
import 'package:eassist_tools_app/repositories/simulcargo/simulcargocrud_repository.dart';
import 'package:eassist_tools_app/repositories/simuleei/simuleeicrud_repository.dart';
import 'package:eassist_tools_app/repositories/simulgis/simulgiscrud_repository.dart';
import 'package:eassist_tools_app/repositories/simulgit/simulgitcrud_repository.dart';
import 'package:eassist_tools_app/repositories/simulmb/simulmbcrud_repository.dart';
import 'package:eassist_tools_app/repositories/simulmv/simulmvcrud_repository.dart';
import 'package:eassist_tools_app/repositories/simulpar/simulparcrud_repository.dart';
import 'package:eassist_tools_app/repositories/simultree/simultreecrud_repository.dart';
import 'package:eassist_tools_app/repositories/simulwp/simulwpcrud_repository.dart';
import 'package:eassist_tools_app/repositories/user/user_repository.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'blocs/simulcar/simulcarcrud_bloc.dart';
import 'blocs/simulcargo/simulcargocrud_bloc.dart';
import 'blocs/simulmb/simulmbcrud_bloc.dart';
import 'blocs/simultree/simultreecrud_bloc.dart';

Future<void> main() async {
  
  final userRepository = UserRepository();
  AppData.kIsWeb = kIsWeb;
  
  runApp(BlocProvider<AuthenticationBloc>(
    create: (context) {
      return AuthenticationBloc(userRepository: userRepository)
        ..add(AppStarted());
    },
    child: App(
      userRepository: userRepository,
      key: null,
    ),
  ));
}

class App extends StatelessWidget {
  final UserRepository userRepository;
  const App({required super.key, required this.userRepository});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginBloc>(
          create: (context) =>
              LoginBloc(
                authenticationBloc: BlocProvider.of<AuthenticationBloc>(context),
                userRepository: userRepository,
              )
        ),
        BlocProvider<EmailVerificationBloc>(
          create: (context) =>
              EmailVerificationBloc(
                repository: EmailVerificationRepository(), 
              authenticationBloc: BlocProvider.of<AuthenticationBloc>(context))),
        BlocProvider<ChangePasswordBloc>(
          create: (context) =>
              ChangePasswordBloc(repository: ChangePasswordRepository())),
        BlocProvider<TakeImageCubit>(
          create: (context) => TakeImageCubit(),
        ),        
        BlocProvider<ProgressIndicatorBloc>(
          create: (context) => ProgressIndicatorBloc()),
        BlocProvider<NetworkBloc>(
          create: (context) => NetworkBloc()..add(NetworkObserve())), 
        BlocProvider<OnBoardMenuCariBloc>(
          create: (context) => OnBoardMenuCariBloc()),   
        BlocProvider<SimulmvListBloc>(
          create: (context) => SimulmvListBloc()),      
        BlocProvider<SimulmvCrudBloc>(
          create: (context) =>
              SimulmvCrudBloc(repository: SimulmvCrudRepository())), 
        BlocProvider<SimulparListBloc>(
          create: (context) => SimulparListBloc()),      
        BlocProvider<SimulparCrudBloc>(
          create: (context) =>
              SimulparCrudBloc(repository: SimulparCrudRepository())),
        BlocProvider<SimuleeiListBloc>(
          create: (context) => SimuleeiListBloc()),   
        BlocProvider<SimuleeiCrudBloc>(
          create: (context) =>
              SimuleeiCrudBloc(repository: SimuleeiCrudRepository())), 
        BlocProvider<SimulgitCrudBloc>(
          create: (context) =>
              SimulgitCrudBloc(repository: SimulgitCrudRepository())),
        BlocProvider<SimulgisCrudBloc>(
          create: (context) =>
              SimulgisCrudBloc(repository: SimulgisCrudRepository())), 
        BlocProvider<SimulbonCrudBloc>(
          create: (context) =>
              SimulbonCrudBloc(repository: SimulbonCrudRepository())),
        BlocProvider<SimulwpCrudBloc>(
          create: (context) =>
              SimulwpCrudBloc(repository: SimulwpCrudRepository())),
        BlocProvider<SimulcargoCrudBloc>(
          create: (context) =>
              SimulcargoCrudBloc(repository: SimulcargoCrudRepository())),
        BlocProvider<SimulcarCrudBloc>(
          create: (context) =>
            SimulcarCrudBloc(repository: SimulcarCrudRepository())),
        BlocProvider<SimulmbCrudBloc>(
          create: (context) =>
            SimulmbCrudBloc(repository: SimulmbCrudRepository())),
        BlocProvider<SimultreeCrudBloc>(
          create: (context) =>
              SimultreeCrudBloc(repository: SimultreeCrudRepository())),
        BlocProvider<Klaim1ListBloc>(
          create: (context) =>
            Klaim1ListBloc()),
        BlocProvider<Klaim2ListBloc>(
          create: (context) =>
              Klaim2ListBloc()),        
        BlocProvider<GuestsCrudBloc>(
          create: (context) =>
              GuestsCrudBloc(repository: GuestsCrudRepository())),
        BlocProvider<GalleryeventCariBloc>(
          create: (context) =>
              GalleryeventCariBloc()),        
        BlocProvider<GallerytestimonyCariBloc>(
          create: (context) =>
              GallerytestimonyCariBloc()),        
        BlocProvider<GallerymemberCariBloc>(
          create: (context) =>
              GallerymemberCariBloc()),          
        BlocProvider<GallerymemberCariBloc>(
          create: (context) =>
              GallerymemberCariBloc()),        
        BlocProvider<RegUserBloc>(
            create: (context) =>
                RegUserBloc(repository: RegUserRepository(), authenticationBloc: BlocProvider.of<AuthenticationBloc>(context))),   
        BlocProvider<MRekanGeneralCmpCrudBloc>(
          create: (context) => MRekanGeneralCmpCrudBloc(repository: MRekanGeneralCmpCrudRepository()),
        ),
        BlocProvider<MRekanGeneralIdvCrudBloc>(
          create: (context) => MRekanGeneralIdvCrudBloc(repository: MRekanGeneralIdvCrudRepository()),
        ),  
        BlocProvider<MRekanContactCrudBloc>(
          create: (context) => MRekanContactCrudBloc(repository: MRekanContactCrudRepository()),
        ), 
        BlocProvider<MRekanPicListBloc>(
          create: (context) =>
              MRekanPicListBloc()),        
        BlocProvider<MRekanPicCrudBloc>(
          create: (context) => MRekanPicCrudBloc(repository: MRekanPicCrudRepository()),
        ), 
        BlocProvider<MRekan1CrudBloc>(
          create: (context) => MRekan1CrudBloc(repository: MRekan1CrudRepository()),
        ), 
        BlocProvider<ProfileUploadFotoBloc>(
          create: (context) =>
              ProfileUploadFotoBloc()),    
        BlocProvider<ProfileDownloadFotoBloc>(
          create: (context) =>
              ProfileDownloadFotoBloc(repository: UserFotoRepository())), 
        BlocProvider<ProfileUploadKtpBloc>(
          create: (context) =>
              ProfileUploadKtpBloc(repository: ProfileKtpRepository())),    
        BlocProvider<CobCariBloc>(
          create: (context) => CobCariBloc()),   
        BlocProvider<AsetDashboardCariBloc>(
          create: (context) => AsetDashboardCariBloc()),
        BlocProvider(create: (context) => AsetRingkasanCariBloc()),
        BlocProvider(create: (context) => AsetParCariBloc()),
        BlocProvider(create: (context) => AsetMvCariBloc()),
        BlocProvider(create: (context) => AsetHealthCariBloc()),
        BlocProvider(create: (context) => StatusAsetCariBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'JPS Insurance',
        theme: FlexThemeData.light(scheme: FlexScheme.mandyRed),
        // The Mandy red, dark theme.
        darkTheme: FlexThemeData.dark(scheme: FlexScheme.mandyRed),
        // Use dark or light theme based on system setting.
        themeMode: ThemeMode.light,

        routes: const {},
        
        home: const HeroMain(),   
        
      ),
    );
  }
}
