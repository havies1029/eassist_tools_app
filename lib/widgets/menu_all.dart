import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eassist_tools_app/blocs/home/home_bloc.dart';
import 'constants.dart';
import 'menu_item_button.dart' as customWidgets;
import 'header_section.dart';
import 'my_colors.dart';

class MenuAllWidget extends StatelessWidget {
  const MenuAllWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.grey_3,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              HeaderSection(),
              SizedBox(height: 24),
              Divider(thickness: 1, color: MyColors.grey_10),
              SizedBox(height: 32),
              MenuGrid(),
            ],
          ),
        ),
      ),
    );
  }
}

class MenuGrid extends StatefulWidget {
  const MenuGrid({super.key});

  @override
  MenuGridState createState() => MenuGridState();
}

class MenuGridState extends State<MenuGrid> {
  @override
  Widget build(BuildContext context) {
    final HomeBloc homeBloc = BlocProvider.of<HomeBloc>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('JPS Calculator'),
        _buildMenuGrid(menuItems, homeBloc),
        const SizedBox(height: 28),
        const Divider(thickness: 1, color: MyColors.grey_10),
        const SizedBox(height: 28),
        _buildSectionTitle('Claim Services'),
        _buildMenuGrid(claimServices, homeBloc),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    final words = title.split(' ');
    final firstWord = words.first;
    final rest = words.sublist(1).join(' ');

    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0, left: 16.0),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: '$firstWord ',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: MyColors.secondaryBlue,
              ),
            ),
            TextSpan(
              text: rest,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: MyColors.primaryOrange,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuGrid(List<Map<String, String>> items, HomeBloc homeBloc) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: items.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        // Menyesuaikan jumlah kolom dan aspect ratio agar cell lebih tinggi
        crossAxisCount: MediaQuery.of(context).size.width > 600 ? 4 : 3,
        crossAxisSpacing: 12,
        mainAxisSpacing: 16,
        childAspectRatio: 0.8,
      ),
      itemBuilder: (context, index) {
        final menuid = items[index]["menuid"]!;
        String label = items[index]["label"]!;

        // Sisipkan newline sebelum kata terakhir untuk tiga item khusus
        if (menuid == "simulmb" || menuid == "simuleei" || menuid == "simulcar") {
          int lastSpace = label.lastIndexOf(" ");
          if (lastSpace != -1) {
            label = "${label.substring(0, lastSpace)}\n${label.substring(lastSpace + 1)}";
          }
        }

        return InkWell(
          onTap: () {
            switch (menuid) {
              case 'simulpar':
                homeBloc.add(SimulPARPageActiveEvent());
                break;
              case 'simulflexas':
                homeBloc.add(SimulFlexasPageActiveEvent());
                break;
              case 'simulmv':
                homeBloc.add(SimulMVPageActiveEvent());
                break;
              case 'simuleei':
                homeBloc.add(SimulEEIPageActiveEvent());
                break;
              case 'simulcargo':
                homeBloc.add(SimulCARGOPageActiveEvent());
                break;
              case 'simulgit':
                homeBloc.add(SimulGITPageActiveEvent());
                break;
              case 'simulgis':
                homeBloc.add(SimulGISPageActiveEvent());
                break;
              case 'simulbon':
                homeBloc.add(SimulBONPageActiveEvent());
                break;
              case 'simulwp':
                homeBloc.add(SimulWPPageActiveEvent());
                break;
              case 'simulcar':
                homeBloc.add(SimulCARPageActiveEvent());
                break;
              case 'simultree':
                homeBloc.add(SimulTREEPageActiveEvent());
                break;
              case 'simulmb':
                homeBloc.add(SimulMBPageActiveEvent());
                break;
              case 'klaimtrack':
                homeBloc.add(TrackKlaimPageActiveEvent());
                break;
              default:
                homeBloc.add(HomePageActiveEvent());
                break;
            }
          },
          child: customWidgets.MenuItemButton(
            imagePath: items[index]["image"]!,
            label: label,
          ),
        );
      },
    );
  }
}

class _AnimatedTile extends StatefulWidget {
  final VoidCallback onTap;
  final String label;
  final String imagePath;

  const _AnimatedTile({
    required this.onTap,
    required this.label,
    required this.imagePath,
  });

  @override
  State<_AnimatedTile> createState() => _AnimatedTileState();
}

class _AnimatedTileState extends State<_AnimatedTile>
    with SingleTickerProviderStateMixin {
  double _scale = 1.0;

  void _onTapDown(_) => setState(() => _scale = 0.95);
  void _onTapUp(_) => setState(() => _scale = 1.0);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: () => setState(() => _scale = 1.0),
      child: AnimatedScale(
        scale: _scale,
        duration: const Duration(milliseconds: 100),
        child: Material(
          color: MyColors.primaryYellow,
          borderRadius: BorderRadius.circular(16),
          elevation: 3,
          shadowColor: Colors.black.withOpacity(0.05),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  widget.imagePath,
                  height: 32,
                  fit: BoxFit.contain,
                  color: Colors.black87,
                ),
                const SizedBox(height: 6),
                Text(
                  widget.label,
                  style: const TextStyle(
                    fontSize: 11.5,
                    fontWeight: FontWeight.w600,
                    height: 1.3,
                    letterSpacing: 0.2,
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.center,
                  softWrap: true,
                  overflow: TextOverflow.visible,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
