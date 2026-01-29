import 'package:eassist_tools_app/blocs/authentication/authentication_bloc.dart';
import 'package:eassist_tools_app/pages/about_jps/action_about_section.dart';
import 'package:eassist_tools_app/pages/aset/aset_main.dart';
import 'package:eassist_tools_app/pages/asettracking/asettrackcari_main.dart';
import 'package:eassist_tools_app/pages/calpar/calpar1list_main.dart';
import 'package:eassist_tools_app/pages/find_insurance/find_section_insurance.dart';
import 'package:eassist_tools_app/pages/find_insurance/floating_buttons_insurance.dart';
import 'package:eassist_tools_app/pages/gen_aset_dashboard/asetdashboardcari_main.dart';
import 'package:eassist_tools_app/pages/gen_aset_health/asethealthcari_main.dart';
import 'package:eassist_tools_app/pages/gen_aset_mv/asetmvcari_main.dart';
import 'package:eassist_tools_app/pages/gen_aset_par/asetparcari_main.dart';
import 'package:eassist_tools_app/pages/gen_aset_ringkasan/asetringkasancari_main.dart';
import 'package:eassist_tools_app/pages/gen_berita/berita_main.dart';
import 'package:eassist_tools_app/pages/gen_calmv/calmv1list_main.dart';
import 'package:eassist_tools_app/pages/gen_cob_app/cobcari_main.dart';
import 'package:eassist_tools_app/pages/gen_endors/endors1list_main.dart';
import 'package:eassist_tools_app/pages/gen_profile/mrekanpiclist_main.dart';
import 'package:eassist_tools_app/pages/gen_profile/test_profile_page.dart';
import 'package:eassist_tools_app/pages/gen_promo/promo1cari_main.dart';
import 'package:eassist_tools_app/pages/gen_review/reviewcari_main.dart';
import 'package:eassist_tools_app/pages/gen_sppamv/sppamvlist_main.dart';
import 'package:eassist_tools_app/pages/gen_sppapar/sppaparlist_main.dart';
import 'package:eassist_tools_app/pages/gen_status_aset/statusasetcari_main.dart';
import 'package:eassist_tools_app/pages/gen_trslog/trslogcari_main.dart';
import 'package:eassist_tools_app/pages/heropage/fixed_nambar_overlay.dart';
import 'package:eassist_tools_app/pages/klaim/klaim1list_main.dart';
import 'package:eassist_tools_app/pages/klaimrasio/klaimrasiocari_main.dart';
import 'package:eassist_tools_app/pages/klaimrinci/klaimrincicari_main.dart';
import 'package:eassist_tools_app/pages/klaimringkas/klaimringkascari_main.dart';
import 'package:eassist_tools_app/pages/payment/dnrekapcobcari_list.dart';
import 'package:eassist_tools_app/pages/payment/pay1list_main.dart';
import 'package:eassist_tools_app/pages/payment/rinciansoa_page.dart';
import 'package:eassist_tools_app/pages/regendors/regendorslist_main.dart';
import 'package:eassist_tools_app/pages/regmv/regmv1list_main.dart';
import 'package:eassist_tools_app/pages/regother/regother1list_main.dart';
import 'package:eassist_tools_app/pages/regpar/regpar1list_main.dart';
import 'package:eassist_tools_app/pages/regreaktif/regreaktifcari_main.dart';
import 'package:eassist_tools_app/pages/regrenewal/regrenewcari_main.dart';
import 'package:eassist_tools_app/widgets/section/carousel_section.dart';
import 'package:eassist_tools_app/widgets/section/client_section.dart';
import 'package:eassist_tools_app/widgets/section/feature_section.dart';
import 'package:eassist_tools_app/widgets/section/footer_section.dart';
import 'package:eassist_tools_app/widgets/section/testimonial_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';

class HeroPage extends StatefulWidget {
  const HeroPage({super.key});

  @override
  State<HeroPage> createState() => _HeroPageState();
}

class _HeroPageState extends State<HeroPage> {
  @override
  void initState() {
    super.initState();

    /*
    // Memastikan dialog dipanggil setelah frame pertama selesai dirender
    WidgetsBinding.instance.addPostFrameCallback((_) {
      CustomPopupsLoginUser.showLoginDialog(context);
    });
    */
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          final bool isMobile = constraints.maxWidth < 768;
          return Stack(
            children: [
              // Layer 1: Background (Image untuk non-mobile, hijau untuk mobile)
              Positioned.fill(
                child: isMobile
                    ? Container(
                        color: Colors.white) // hijau full-screen
                    : Image.asset(
                        'assets/images/bg-home.jpg',
                        fit: BoxFit.cover,
                        alignment: const Alignment(0, 3),
                        cacheWidth: 1440,
                        cacheHeight: 800,
                      ),
              ),

              // Layer 2: Konten scrollable
              Positioned.fill(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.only(top: 88), // ruang untuk navbar
                  child: Column(
                    children: [
                      TextButton(
                          onPressed: () async {
                            const List<String> scopes = <String>[
                              'email',
                            ];
                            GoogleSignIn googleSignIn = GoogleSignIn(
                              // Optional clientId
                              serverClientId: '217496566954-tiqmna993j1a943i9d86chpas0ipktle.apps.googleusercontent.com',
                              scopes: scopes,
                            );
                            await googleSignIn.signOut();
                            context.read<AuthenticationBloc>().add(LoggedOut());
                          },
                          child: Text("Logout",
                              style: TextStyle(color: Colors.white))),
                      TextButton(
                          onPressed: () {
                            context
                                .read<AuthenticationBloc>()
                                .add(RequireRegisterClient(requiredFrom: 'hero_page'));
                          },
                          child: Text("Register Client",
                              style: TextStyle(color: Colors.white))),
                      BlocBuilder<AuthenticationBloc, AuthenticationState>(
                          builder: (context, state) {
                        if (state is AuthenticationAuthenticated) {
                          if (state.user.userType == "C") {
                            return Text(
                                'Nama : ${state.user.nama ?? "???"}');
                          }
                        }
                        return Container();
                      }),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    Calmv1ListMainPage()),
                          );
                          
                        },
                        child: Text("Simulasi MV"),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    Calpar1ListMainPage()),
                          );
                        },
                        child: Text("Simulasi PAR"),
                      ),
                      BlocBuilder<AuthenticationBloc, AuthenticationState>(
                          builder: (context, state) {
                        if (state is AuthenticationAuthenticated) {
                          if (state.user.userType == "C") {
                            return TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          TestProfilePage()),
                                );
                              },
                              child: Text("Form Profile"),
                            );
                          }
                        }
                        return Container();
                      }),
                      BlocBuilder<AuthenticationBloc, AuthenticationState>(
                          builder: (context, state) {
                        if (state is AuthenticationAuthenticated) {
                          if (state.user.userType == "C") {
                            return Column(
                              children: [

                                TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              RegEndorsListMainPage()),
                                    );
                                  },
                                  child: Text("Registrasi Endorsement"),
                                ),
                                
                                TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              KlaimringkascariMainPage()),
                                    );
                                  },
                                  child: Text("Ringkasan Claim"),
                                ),

                                TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              KlaimRinciCariMainPage()),
                                    );
                                  },
                                  child: Text("Rincian Claim"),
                                ),

                                TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              KlaimRasioCariMainPage()),
                                    );
                                  },
                                  child: Text("Klaim Rasio"),
                                ),

                                TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              Regmv1ListMainPage()),
                                    );
                                  },
                                  child: Text("Registrasi MV"),
                                ),
                                
                                TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              Regpar1ListMainPage()),
                                    );
                                  },
                                  child: Text("Registrasi PAR"),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Regother1ListMainPage()),
                                    );
                                  },
                                  child: Text("Registrasi Other"),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => DnrekapcobCariPage()),
                                    );
                                  },
                                  child: Text("Payment : Ringkasan Outstanding"),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => RincianSoaPage()),
                                    );
                                  },
                                  child: Text("Payment : Rincian Outstanding"),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Pay1ListMainPage()),
                                    );
                                  },
                                  child: Text("List Payment"),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              MRekanPicListMainPage()),
                                    );
                                  },
                                  child: Text("Form Profile PIC"),
                                ),
                                
                                //PaymentMethodsCariListPage
                                TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              CobCariMainPage()),
                                    );
                                  },
                                  child: Text("List COB"),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const AsetDashboardCariMainPage()),
                                    );
                                  },
                                  child: Text("List Aset Dashboard"),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const AsetRingkasanCariMainPage()),
                                    );
                                  },
                                  child: Text("List Ringkasan Aset"),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const AsetParCariMainPage()),
                                    );
                                  },
                                  child: Text("List Aset Properti"),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const AsetMVCariMainPage()),
                                    );
                                  },
                                  child: Text("List Aset MV"),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const AsettrackCariMainPage()),
                                    );
                                  },
                                  child: Text("Tacking Aset MV"),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const StatusasetcariMain()),
                                    );
                                  },
                                  child: Text("List Status Aset"),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const AsetHealthCariMainPage()),
                                    );
                                  },
                                  child: Text("List Aset Kesehatan"),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const Endors1ListMainPage()),
                                    );
                                  },
                                  child: Text("List Endorsement"),
                                ),

                                TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const RegRenewCariMainPage()),
                                    );
                                  },
                                  child: Text("List Renewal"),
                                ),

                                TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const RegReaktifCariMainPage()),
                                    );
                                  },
                                  child: Text("List RegReaktif"),
                                ),
                                
                                TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const ReviewCariMainPage()),
                                    );
                                  },
                                  child: Text("List Review"),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const AsetMainPage()),
                                    );
                                  },
                                  child: Text("Form Aset"),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const BeritaMainPage(jenis: 1)),
                                    );
                                  },
                                  child: Text("Berita Utama"),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const Promo1cariMainPage()),
                                    );
                                  },
                                  child: Text("Promo"),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const SppamvListMainPage()),
                                    );
                                  },
                                  child: Text("List SPPA MV"),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const SppaparListMainPage()),
                                    );
                                  },
                                  child: Text("List SPPA PAR"),
                                ),
                                 TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const Klaim1ListMainPage()),
                                    );
                                  },
                                  child: Text("List Klaim"),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const TrslogcariMain()),
                                    );
                                  },
                                  child: Text("List Log Transaksi"),
                                ),
                              ],
                            );
                          }
                        }
                        return Container();
                      }),
                      
                      HeroSection(constraints: constraints),
                      FloatingButtons(constraints: constraints),
                      ActionSection(constraints: constraints),
                      CarouselSection(constraints: constraints),
                      FeatureSection(constraints: constraints),
                      TestimonialSection(constraints: constraints),
                      ClientSection(constraints: constraints),
                      FooterSection(constraints: constraints),
                    ],
                  ),
                ),
              ),

              // Layer 3: Navbar overlay di atas semua
              const FixedNavbarOverlay(),
            ],
          );
        },
      ),
    );
  }
}
