import 'package:eassist_tools_app/apis/payment/paymentdn_api.dart';
import 'package:eassist_tools_app/blocs/authentication/authentication_bloc.dart';
import 'package:eassist_tools_app/blocs/calpar/calpar1crud_bloc.dart';
import 'package:eassist_tools_app/blocs/calpar/calpar1list_bloc.dart';
import 'package:eassist_tools_app/blocs/calpar/calpar2form_bloc.dart';
import 'package:eassist_tools_app/blocs/calpar/calpar3form_bloc.dart';
import 'package:eassist_tools_app/blocs/calpar/calpar4form_bloc.dart';
import 'package:eassist_tools_app/blocs/chatting/guestscrud_bloc.dart';
import 'package:eassist_tools_app/blocs/gallery/galleryeventcari_bloc.dart';
import 'package:eassist_tools_app/blocs/gallery/gallerymembercari_bloc.dart';
import 'package:eassist_tools_app/blocs/gallery/gallerytestimonycari_bloc.dart';
import 'package:eassist_tools_app/blocs/gen_aset_dashboard/asetdashboardcari_bloc.dart';
import 'package:eassist_tools_app/blocs/gen_aset_health/asethealthcari_bloc.dart';
import 'package:eassist_tools_app/blocs/gen_aset_mv/asetmvcari_bloc.dart';
import 'package:eassist_tools_app/blocs/gen_aset_par/asetparcari_bloc.dart';
import 'package:eassist_tools_app/blocs/gen_aset_ringkasan/asetringkasancari_bloc.dart';
import 'package:eassist_tools_app/blocs/gen_berita/berita1cari_bloc.dart';
import 'package:eassist_tools_app/blocs/gen_berita/berita2cari_bloc.dart';
import 'package:eassist_tools_app/blocs/gen_berita/berita3cari_bloc.dart';
import 'package:eassist_tools_app/blocs/gen_calmv/calmv1crud_bloc.dart';
import 'package:eassist_tools_app/blocs/gen_calmv/calmv1list_bloc.dart';
import 'package:eassist_tools_app/blocs/gen_calmv/calmv2form_bloc.dart';
import 'package:eassist_tools_app/blocs/gen_calmv/calmv3form_bloc.dart';
import 'package:eassist_tools_app/blocs/gen_cob_app/cobcari_bloc.dart';
import 'package:eassist_tools_app/blocs/gen_endors/endors1crud_bloc.dart';
import 'package:eassist_tools_app/blocs/gen_endors/endors1list_bloc.dart';
import 'package:eassist_tools_app/blocs/gen_profile/mrekan1crud_bloc.dart';
import 'package:eassist_tools_app/blocs/gen_profile/mrekancontactcrud_bloc.dart';
import 'package:eassist_tools_app/blocs/gen_profile/mrekangeneralcmpcrud_bloc.dart';
import 'package:eassist_tools_app/blocs/gen_profile/mrekangeneralidvcrud_bloc.dart';
import 'package:eassist_tools_app/blocs/gen_profile/mrekanpiccrud_bloc.dart';
import 'package:eassist_tools_app/blocs/gen_profile/mrekanpiclist_bloc.dart';
import 'package:eassist_tools_app/blocs/gen_promo/promo1cari_bloc.dart';
import 'package:eassist_tools_app/blocs/gen_promo/promo2cari_bloc.dart';
import 'package:eassist_tools_app/blocs/gen_review/reviewcari_bloc.dart';
import 'package:eassist_tools_app/blocs/gen_sppamv/sppa_download_polis_bloc.dart';
import 'package:eassist_tools_app/blocs/gen_sppamv/sppamvcrud_bloc.dart';
import 'package:eassist_tools_app/blocs/gen_sppamv/sppamvlist_bloc.dart';
import 'package:eassist_tools_app/blocs/gen_sppapar/sppaparcrud_bloc.dart';
import 'package:eassist_tools_app/blocs/gen_sppapar/sppaparlist_bloc.dart';
import 'package:eassist_tools_app/blocs/gen_status_aset/statusasetcari_bloc.dart';
import 'package:eassist_tools_app/blocs/gen_trslog/trslogcari_bloc.dart';
import 'package:eassist_tools_app/blocs/klaim/klaim1list_bloc.dart';
import 'package:eassist_tools_app/blocs/klaim/klaim2list_bloc.dart';
import 'package:eassist_tools_app/blocs/klaimrasio/klaimrasiocobcari_bloc.dart';
import 'package:eassist_tools_app/blocs/klaimrinci/groupcobcari_bloc.dart';
import 'package:eassist_tools_app/blocs/klaimrinci/mstatusrincicari_bloc.dart';
import 'package:eassist_tools_app/blocs/klaimringkas/klaimringkascari_bloc.dart';
import 'package:eassist_tools_app/blocs/klaimringkas/mstatusringkascari_bloc.dart';
import 'package:eassist_tools_app/blocs/login/change_password_bloc.dart';
import 'package:eassist_tools_app/blocs/login/emailverification_bloc.dart';
import 'package:eassist_tools_app/blocs/login/login_bloc.dart';
import 'package:eassist_tools_app/blocs/networkconnection/network_bloc.dart';
import 'package:eassist_tools_app/blocs/onboardmenu/onboardmenucari_bloc.dart';
import 'package:eassist_tools_app/blocs/payment/dnrekap2inv_bloc.dart';
import 'package:eassist_tools_app/blocs/payment/dnrekapcobcari_bloc.dart';
import 'package:eassist_tools_app/blocs/payment/dnsppacari_bloc.dart';
import 'package:eassist_tools_app/blocs/payment/dnsppamvcari_bloc.dart';
import 'package:eassist_tools_app/blocs/payment/invbayarvaform_bloc.dart';
import 'package:eassist_tools_app/blocs/payment/pay1crud_bloc.dart';
import 'package:eassist_tools_app/blocs/payment/pay1list_bloc.dart';
import 'package:eassist_tools_app/blocs/payment/pay2cari_bloc.dart';
import 'package:eassist_tools_app/blocs/payment/paymentmethodcari_bloc.dart';
import 'package:eassist_tools_app/blocs/profile/profile_download_foto_bloc.dart';
import 'package:eassist_tools_app/blocs/profile/profile_upload_foto_bloc.dart';
import 'package:eassist_tools_app/blocs/profile/profile_upload_ktp_bloc.dart';
import 'package:eassist_tools_app/blocs/progressindicator/progressindicator_bloc.dart';
import 'package:eassist_tools_app/blocs/regendors/regendors1form_bloc.dart';
import 'package:eassist_tools_app/blocs/regendors/regendorscari_bloc.dart';
import 'package:eassist_tools_app/blocs/regmv/regmv1crud_bloc.dart';
import 'package:eassist_tools_app/blocs/regmv/regmv1list_bloc.dart';
import 'package:eassist_tools_app/blocs/regmv/regmv2form_bloc.dart';
import 'package:eassist_tools_app/blocs/regmv/regmv3form_bloc.dart';
import 'package:eassist_tools_app/blocs/regmv/regmv4cari_bloc.dart';
import 'package:eassist_tools_app/blocs/regmv/regmv4form_bloc.dart';
import 'package:eassist_tools_app/blocs/regmv/regmv5cari_bloc.dart';
import 'package:eassist_tools_app/blocs/regmv/regmv5form_bloc.dart';
import 'package:eassist_tools_app/blocs/regmv/regmv6form_bloc.dart';
import 'package:eassist_tools_app/blocs/regmv/regmv7cari_bloc.dart';
import 'package:eassist_tools_app/blocs/regmv/regmv7form_bloc.dart';
import 'package:eassist_tools_app/blocs/regmv/regmv_download_foto_acc_bloc.dart';
import 'package:eassist_tools_app/blocs/regmv/regmv_download_foto_mobil_bloc.dart';
import 'package:eassist_tools_app/blocs/regmv/regmv_download_foto_stnk_bloc.dart';
import 'package:eassist_tools_app/blocs/regmv/regmv_upload_foto_acc_bloc.dart';
import 'package:eassist_tools_app/blocs/regmv/regmv_upload_foto_mobil_bloc.dart';
import 'package:eassist_tools_app/blocs/regmv/regmv_upload_stnk_bloc.dart';
import 'package:eassist_tools_app/blocs/regother/regother1crud_bloc.dart';
import 'package:eassist_tools_app/blocs/regother/regother1list_bloc.dart';
import 'package:eassist_tools_app/blocs/regpar/regpar1crud_bloc.dart';
import 'package:eassist_tools_app/blocs/regpar/regpar1list_bloc.dart';
import 'package:eassist_tools_app/blocs/regpar/regpar2form_bloc.dart';
import 'package:eassist_tools_app/blocs/regpar/regpar3form_bloc.dart';
import 'package:eassist_tools_app/blocs/regpar/regpar4form_bloc.dart';
import 'package:eassist_tools_app/blocs/regpar/regpar5form_bloc.dart';
import 'package:eassist_tools_app/blocs/regpar/regpar6cari_bloc.dart';
import 'package:eassist_tools_app/blocs/regpar/regpar6form_bloc.dart';
import 'package:eassist_tools_app/blocs/regpar/regpar_download_foto_object_bloc.dart';
import 'package:eassist_tools_app/blocs/regpar/regpar_upload_foto_object_bloc.dart';
import 'package:eassist_tools_app/blocs/regrenewal/regrenew1form_bloc.dart';
import 'package:eassist_tools_app/blocs/regrenewal/regrenewcari_bloc.dart';
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
import 'package:eassist_tools_app/repositories/calpar/calpar1crud_repository.dart';
import 'package:eassist_tools_app/repositories/calpar/calpar2form_repository.dart';
import 'package:eassist_tools_app/repositories/calpar/calpar3form_repository.dart';
import 'package:eassist_tools_app/repositories/calpar/calpar4form_repository.dart';
import 'package:eassist_tools_app/repositories/chatting/guestscrud_repository.dart';
import 'package:eassist_tools_app/repositories/gen_calmv/calmv1crud_repository.dart';
import 'package:eassist_tools_app/repositories/gen_calmv/calmv2form_repository.dart';
import 'package:eassist_tools_app/repositories/gen_calmv/calmv3form_repository.dart';
import 'package:eassist_tools_app/repositories/gen_endors/endors1crud_repository.dart';
import 'package:eassist_tools_app/repositories/gen_profile/mrekan1crud_repository.dart';
import 'package:eassist_tools_app/repositories/gen_profile/mrekancontactcrud_repository.dart';
import 'package:eassist_tools_app/repositories/gen_profile/mrekangeneralcmpcrud_repository.dart';
import 'package:eassist_tools_app/repositories/gen_profile/mrekangeneralidvcrud_repository.dart';
import 'package:eassist_tools_app/repositories/gen_profile/mrekanpiccrud_repository.dart';
import 'package:eassist_tools_app/repositories/gen_sppamv/download_polis_repository.dart';
import 'package:eassist_tools_app/repositories/gen_sppamv/sppamvcrud_repository.dart';
import 'package:eassist_tools_app/repositories/gen_sppapar/sppaparcrud_repository.dart';
import 'package:eassist_tools_app/repositories/login/change_password_repository.dart';
import 'package:eassist_tools_app/repositories/login/emailverification_repository.dart';
import 'package:eassist_tools_app/repositories/payment/invbayarvaform_repository.dart';
import 'package:eassist_tools_app/repositories/payment/pay1crud_repository.dart';
import 'package:eassist_tools_app/repositories/payment/paymentdn_repository.dart' show PaymentDnRepository;
import 'package:eassist_tools_app/repositories/profile/profile_ktp_repository.dart';
import 'package:eassist_tools_app/repositories/profile/userfoto_repository.dart';
import 'package:eassist_tools_app/repositories/regendors/regendors1form_repository.dart';
import 'package:eassist_tools_app/repositories/regmv/regmv1crud_repository.dart';
import 'package:eassist_tools_app/repositories/regmv/regmv2form_repository.dart';
import 'package:eassist_tools_app/repositories/regmv/regmv3form_repository.dart';
import 'package:eassist_tools_app/repositories/regmv/regmv4form_repository.dart';
import 'package:eassist_tools_app/repositories/regmv/regmv5form_repository.dart';
import 'package:eassist_tools_app/repositories/regmv/regmv6form_repository.dart';
import 'package:eassist_tools_app/repositories/regmv/regmv7form_repository.dart';
import 'package:eassist_tools_app/repositories/regmv/regmv_download_fotoacc_repository.dart';
import 'package:eassist_tools_app/repositories/regmv/regmv_download_fotomobil_repository.dart';
import 'package:eassist_tools_app/repositories/regmv/regmv_download_stnk_repository.dart';
import 'package:eassist_tools_app/repositories/regmv/regmv_upload_foto_acc_repository.dart';
import 'package:eassist_tools_app/repositories/regmv/regmv_upload_foto_mobil_repository.dart';
import 'package:eassist_tools_app/repositories/regmv/regmv_upload_stnk_repository.dart';
import 'package:eassist_tools_app/repositories/regother/regother1crud_repository.dart';
import 'package:eassist_tools_app/repositories/regpar/regpar1crud_repository.dart';
import 'package:eassist_tools_app/repositories/regpar/regpar2form_repository.dart';
import 'package:eassist_tools_app/repositories/regpar/regpar3form_repository.dart';
import 'package:eassist_tools_app/repositories/regpar/regpar4form_repository.dart';
import 'package:eassist_tools_app/repositories/regpar/regpar5form_repository.dart';
import 'package:eassist_tools_app/repositories/regpar/regpar6form_repository.dart';
import 'package:eassist_tools_app/repositories/regpar/regpar_download_fotoobject_repository.dart';
import 'package:eassist_tools_app/repositories/regpar/regpar_upload_fotoobject_repository.dart';
import 'package:eassist_tools_app/repositories/regrenewal/regrenew1form_repository.dart';
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
        BlocProvider(create: (context) => ReviewCariBloc()),
        BlocProvider(create: (context) => Berita1CariBloc()),
        BlocProvider(create: (context) => Berita2CariBloc()),
        BlocProvider(create: (context) => Berita3CariBloc()),
        BlocProvider(create: (context) => Promo1CariBloc()),
        BlocProvider(create: (context) => Promo2CariBloc()),
        BlocProvider(create:(context) => SppamvListBloc()),
        BlocProvider(create: (context) => SppamvCrudBloc(repository: SppamvCrudRepository())),
        BlocProvider(create: (context) => SppaparListBloc()),
        BlocProvider(create: (context) => SppaparCrudBloc(repository: SppaparCrudRepository())),
        BlocProvider(create: (context) => TrslogCariBloc()),        
        BlocProvider(create: (context) => Calmv1ListBloc()),
        BlocProvider(create: (context) => Calmv1CrudBloc(repository: Calmv1CrudRepository())),
        BlocProvider(create: (context) => Calmv2FormBloc(repository: Calmv2FormRepository())),
        BlocProvider(create: (context) => Calmv3FormBloc(repository: Calmv3FormRepository())),    
        BlocProvider(create: (context) => Regmv1ListBloc()),
        BlocProvider(create: (context) => Regmv1CrudBloc(repository: Regmv1CrudRepository())),
        BlocProvider(create: (context) => Regmv2FormBloc(repository: Regmv2FormRepository())),
        BlocProvider(create: (context) => Regmv3FormBloc(repository: Regmv3FormRepository())),
        BlocProvider(create: (context) => Regmv4FormBloc(repository: Regmv4FormRepository())),
        BlocProvider(create: (context) => Regmv5FormBloc(repository: Regmv5FormRepository())),
        BlocProvider(create: (context) => Regmv6FormBloc(repository: Regmv6FormRepository())),            
        BlocProvider(create: (context) => Regmv7FormBloc(repository: Regmv7FormRepository())),
        BlocProvider(create: (context) => RegmvUploadStnkBloc(repository: RegmvUploadStnkRepository())),    
        BlocProvider(create: (context) => RegmvUploadFotoMobilBloc(repository: RegmvUploadFotoMobilRepository())),  
        BlocProvider(create: (context) => RegmvUploadFotoAccBloc(repository: RegmvUploadFotoAccRepository())),
        BlocProvider(create: (context) => Regmv4CariBloc()),
        BlocProvider(create: (context) => RegmvDownloadFotoStnkBloc(repository: RegmvDownloadStnkRepository())),
        BlocProvider(create: (context) => Regmv5CariBloc()),
        BlocProvider(create: (context) => RegmvDownloadFotoMobilBloc(repository: RegmvDownloadFotoMobilRepository())),
        BlocProvider(create: (context) => Regmv7CariBloc()),
        BlocProvider(create: (context) => RegmvDownloadFotoAccBloc(repository: RegmvDownloadFotoAccRepository())),
        BlocProvider(create: (context) => Calpar1ListBloc()),
        BlocProvider(create: (context) => Calpar1CrudBloc(repository: Calpar1CrudRepository())),
        BlocProvider(create: (context) => Calpar2FormBloc( repository: Calpar2FormRepository())),
        BlocProvider(create: (context) => Calpar3FormBloc( repository: Calpar3FormRepository())),
        BlocProvider(create: (context) => Calpar4FormBloc( repository: Calpar4FormRepository())),
        BlocProvider(create: (context) => Regpar1ListBloc()),
        BlocProvider(create: (context) => Regpar1CrudBloc(repository: Regpar1CrudRepository())),
        BlocProvider(create: (context) => Regpar2FormBloc( repository: Regpar2FormRepository())),
        BlocProvider(create: (context) => Regpar3FormBloc( repository: Regpar3FormRepository())),
        BlocProvider(create: (context) => Regpar4FormBloc( repository: Regpar4FormRepository())),
        BlocProvider(create: (context) => Regpar5FormBloc( repository: Regpar5FormRepository())),
        BlocProvider(create: (context) => RegparUploadFotoObjectBloc(repository: RegparUploadFotoObjectRepository())),
        BlocProvider(create: (context) => RegparDownloadFotoObjectBloc(repository: RegparDownloadFotoObjectRepository())),
        BlocProvider(create: (context) => Regpar6CariBloc()),
        BlocProvider(create: (context) => Regpar6FormBloc(repository: Regpar6FormRepository())),
        BlocProvider(create: (context) => Regother1ListBloc()),
        BlocProvider(create: (context) => Regother1CrudBloc(repository: Regother1CrudRepository())),
        BlocProvider(create: (context) => DnrekapcobCariBloc()),
        BlocProvider(create: (context) => DnsppaCariBloc()),
        BlocProvider(create: (context) => DnsppamvCariBloc()),
        BlocProvider(create: (context) => PaymentMethodCariBloc(repository: PaymentDnRepository(api: PaymentDnAPI()))),
        BlocProvider(create: (context) => DnRekap2invBloc()),
        BlocProvider(create: (context) => InvbayarvaFormBloc(repository: InvbayarvaFormRepository())),
        BlocProvider(create: (context) => Pay1ListBloc()),
        BlocProvider(create: (context) => Pay1CrudBloc(repository: Pay1CrudRepository())),
        BlocProvider(create: (context) => Pay2CariBloc()),
        BlocProvider(create: (context) => MstatusringkasCariBloc()),
        BlocProvider(create: (context) => KlaimringkasCariBloc()),
        BlocProvider(create: (context) => MstatusrinciCariBloc()),
        BlocProvider(create: (context) => GroupcobCariBloc()),
        BlocProvider(create: (context) => KlaimrasiocobCariBloc()),
        BlocProvider(create:  (context) => SppaDownloadPolisBloc(repository: DownloadPolisRepository())),
        BlocProvider(create:  (context) => Endors1ListBloc()),
        BlocProvider(create: (context) => Endors1CrudBloc(repository: Endors1CrudRepository())),
        BlocProvider(create: (context) => RegendorsCariBloc()),
        BlocProvider(create: (context) => Regendors1FormBloc(repository: Regendors1FormRepository())),  
        BlocProvider(create: (context) => RegrenewCariBloc()),
        BlocProvider(create: (context) => Regrenew1FormBloc(repository: Regrenew1FormRepository()))

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
