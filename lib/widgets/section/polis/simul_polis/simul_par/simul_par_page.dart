import 'package:eassist_tools_app/widgets/section/polis/simul_polis/simul_par/simul_form/simulparcrud_form_coverv2.dart';
import 'package:eassist_tools_app/widgets/section/polis/simul_polis/simul_par/simul_form/simulparcrud_form_si.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:eassist_tools_app/blocs/simulpar/simulparcrud_bloc.dart';
import 'package:eassist_tools_app/widgets/section/polis/simul_polis/simul_par/simul_form/simulparcrud_form_bangunan.dart';
import 'package:eassist_tools_app/widgets/section/polis/simul_polis/simul_par/simul_form/simulparcrud_form_premi.dart';


class SimulParPage extends StatefulWidget {
  const SimulParPage({super.key});

  @override
  State<SimulParPage> createState() => _SimulParPageState();
}

class _SimulParPageState extends State<SimulParPage> {
  final _formKey = GlobalKey<FormState>();
  static const _fontFamily = 'Satoshi-Regular';

  @override
  void initState() {
    super.initState();
    context.read<SimulparCrudBloc>().add(SimulPARCrudInitValueEvent());
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final responsive = ResponsiveHelper(constraints);

        return BlocBuilder<SimulparCrudBloc, SimulparCrudState>(
          builder: (context, state) {
            return Container(
              color: Colors.white,
              child: SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                child: Center(
                  child: Container(
                    width: responsive.maxWidth,
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: responsive.sectionSpacing),
                          _buildHeader(responsive),
                          SizedBox(height: responsive.sectionSpacing),

                          _buildSectionHeader('Informasi Bangunan', responsive),
                          const SimulparFormBangunanPage(viewMode: 'tambah', recordId: ''),
                          SizedBox(height: responsive.sectionSpacing),

                          _buildSectionHeader('Sum Insured', responsive),
                          const SimulparFormSumInsuredPage(viewMode: 'tambah', recordId: ''),
                          SizedBox(height: responsive.sectionSpacing),

                          _buildSectionHeader('Rate', responsive),
                          const SimulparFormCoverV2Page(viewMode: 'tambah', recordId: ''),
                          SizedBox(height: responsive.sectionSpacing),

                          // 🔘 Tombol Hitung (trigger kalkulasi)
                          Align(
                            alignment: Alignment.centerLeft,
                            child: ElevatedButton.icon(
                              icon: const Icon(Icons.calculate),
                              label: const Text('Hitung Premi'),
                              onPressed: () {
                                context.read<SimulparCrudBloc>().add(HitungPremiPAREvent());
                              },
                            ),
                          ),

                          SizedBox(height: responsive.sectionSpacing),

                          // 🔽 Tampilkan "Perhitungan Premi" hanya setelah kalkulasi/loaded
                          BlocBuilder<SimulparCrudBloc, SimulparCrudState>(
                            buildWhen: (p, c) =>
                            p.isLoaded != c.isLoaded ||
                                p.isGroupFieldPremiChanged != c.isGroupFieldPremiChanged ||
                                p.errors != c.errors,
                            builder: (context, s) {
                              final showPremi = s.isGroupFieldPremiChanged || s.isLoaded;
                              if (!showPremi) return const SizedBox.shrink();

                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _buildSectionHeader('Perhitungan Premi', responsive),
                                  const SimulparFormPremiPage(viewMode: 'tambah', recordId: ''),
                                  SizedBox(height: responsive.bottomPadding),
                                ],
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildHeader(ResponsiveHelper responsive) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(18),
      child: Container(
        width: double.infinity,
        height: responsive.headerHeight,
        color: const Color(0xFF91C050),
        child: Stack(
          children: [
            Positioned(
              bottom: 0,
              right: 0,
              child: SvgPicture.asset(
                'assets/images/frame_polis.svg',
                width: responsive.headerIconSize,
                height: responsive.headerIconSize,
                fit: BoxFit.contain,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: responsive.horizontalPadding,
                top: responsive.headerTextTop,
                right: responsive.horizontalPadding,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Simulasi Polis Properti',
                    style: TextStyle(
                      fontSize: responsive.headerTitleSize,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontFamily: _fontFamily,
                    ),
                  ),
                  SizedBox(height: responsive.headerSubtitleSpacing),
                  Text(
                    'Isi data bangunan, perlindungan, dan cek hasil preminya.',
                    style: TextStyle(
                      fontSize: responsive.headerSubtitleSize,
                      color: Colors.white.withOpacity(0.9),
                      fontFamily: _fontFamily,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, ResponsiveHelper responsive) {
    return Row(
      children: [
        Container(
          width: 4,
          height: responsive.sectionHeaderSize + 4,
          margin: const EdgeInsets.only(right: 10),
          decoration: BoxDecoration(
            color: const Color(0xFF8BC34A),
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        Text(
          title,
          style: TextStyle(
            fontSize: responsive.sectionHeaderSize,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

}

class ResponsiveHelper {
  final BoxConstraints constraints;

  ResponsiveHelper(this.constraints);

  bool get isMobile => constraints.maxWidth < 768;
  bool get isTablet => constraints.maxWidth >= 768 && constraints.maxWidth < 992;
  bool get isDesktop => constraints.maxWidth >= 992;

  double get horizontalPadding => constraints.maxWidth > 1200
      ? 48
      : isTablet
      ? 36
      : 24;

  double get maxWidth => constraints.maxWidth > 1200
      ? 1200
      : isTablet
      ? constraints.maxWidth * 0.95
      : constraints.maxWidth * 0.9;

  double get headerHeight => isMobile ? 130 : isTablet ? 150 : 160;
  double get headerTitleSize => isMobile ? 24 : isTablet ? 28 : 32;
  double get headerSubtitleSize => isMobile ? 13 : isTablet ? 14 : 15;
  double get headerTextTop => isMobile ? 36 : 45;
  double get headerSubtitleSpacing => isMobile ? 6 : 8;
  double get headerIconSize => isMobile ? 90 : 110;
  double get bottomPadding => isMobile ? 32 : 40;
  double get sectionSpacing => isMobile ? 24 : isTablet ? 28 : 32;
  double get sectionHeaderSize => isMobile ? 16 : isTablet ? 17 : 18;
}
