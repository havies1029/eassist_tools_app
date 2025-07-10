import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

enum ActionButtonModuleType { polis, asset }

enum ActionButtonType {
  tambahPolis,
  endorse,
  perpanjang,
  unduh,
  share,
  hapus,
  refresh,
  tambahAset,
}

class ActionButtonSection extends StatelessWidget {
  final BoxConstraints constraints;
  final ActionButtonModuleType moduleType;

  const ActionButtonSection({
    super.key,
    required this.constraints,
    required this.moduleType,
  });

  bool get isMobile => constraints.maxWidth < 768;
  bool get isTablet => constraints.maxWidth >= 768 && constraints.maxWidth < 992;

  double get horizontalPadding => constraints.maxWidth > 1200
      ? 15
      : constraints.maxWidth > 992
      ? 12
      : isTablet
      ? 10
      : 7;

  double get maxWidth => constraints.maxWidth > 1200
      ? 1200
      : isTablet
      ? constraints.maxWidth * 0.95
      : constraints.maxWidth * 0.9;

  static const Map<ActionButtonType, Map<String, dynamic>> _buttonConfig = {
    ActionButtonType.tambahPolis: {
      'icon': 'assets/icons/tambah_polis.svg',
      'label': 'Tambah Polis',
      'color': Color(0xFF007AFF),
    },
    ActionButtonType.endorse: {
      'icon': 'assets/icons/endorse.svg',
      'label': 'Endorse',
      'color': Color(0xFFFFC728),
    },
    ActionButtonType.perpanjang: {
      'icon': 'assets/icons/perpanjang_polis.svg',
      'label': 'Perpanjang Polis',
      'color': Color(0xFFFAA232),
    },
    ActionButtonType.unduh: {
      'icon': 'assets/icons/unduh.svg',
      'label': 'Unduh data',
      'color': Color(0xFF00CC4B),
    },
    ActionButtonType.share: {
      'icon': 'assets/icons/share.svg',
      'label': '',
      'color': Color(0xFF5C5FFF),
    },
    ActionButtonType.hapus: {
      'icon': 'assets/icons/hapus.svg',
      'label': '',
      'color': Color(0xFFFF0000),
    },
    ActionButtonType.refresh: {
      'icon': 'assets/icons/refresh.svg',
      'label': 'Perbarui',
      'color': Color(0xFF00BFEF),
    },
    ActionButtonType.tambahAset: {
      'icon': 'assets/icons/tambah_polis.svg',
      'label': 'Tambah Aset',
      'color': Color(0xFF007AFF),
    },
  };

  Widget _buildButton(ActionButtonType type) {
    final config = _buttonConfig[type]!;
    return _ActionButton(
      imageAsset: config['icon'],
      label: config['label'],
      color: config['color'],
      isMobile: isMobile,
    );
  }

  Widget _buildButtonsGroup(List<ActionButtonType> types) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: types.map(_buildButton).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: double.infinity,
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: maxWidth),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 15),
            child: moduleType == ActionButtonModuleType.asset
                ? _buildAssetLayout()
                : _buildPolisLayout(),
          ),
        ),
      ),
    );
  }

  Widget _buildPolisLayout() {
    if (isMobile) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SearchBox(isMobile: isMobile, hintText: 'Cari Polis'),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildButtonsGroup([ActionButtonType.tambahPolis, ActionButtonType.endorse]),
              _buildButtonsGroup([
                ActionButtonType.perpanjang,
                ActionButtonType.unduh,
                ActionButtonType.share,
              ]),
            ],
          ),
          const SizedBox(height: 12),
          Align(
            alignment: Alignment.centerLeft,
            child: _buildButton(ActionButtonType.hapus),
          ),
        ],
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          flex: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildButtonsGroup([ActionButtonType.tambahPolis, ActionButtonType.endorse]),
              const SizedBox(height: 12),
              Align(
                alignment: Alignment.centerLeft,
                child: _buildButton(ActionButtonType.hapus),
              ),
            ],
          ),
        ),
        Flexible(
          flex: 3,
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            alignment: WrapAlignment.start,
            children: [
              ...[
                ActionButtonType.perpanjang,
                ActionButtonType.unduh,
                ActionButtonType.share,
              ].map(_buildButton),
              _SearchBox(isMobile: false, hintText: 'Cari Polis'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAssetLayout() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildButtonsGroup([
              ActionButtonType.tambahAset,
              ActionButtonType.refresh,
            ]),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                ...[
                  ActionButtonType.unduh,
                  ActionButtonType.share,
                ].map(_buildButton),
                _SearchBox(isMobile: isMobile, hintText: 'Cari Aset'),
              ],
            ),
          ],
        ),
        const SizedBox(height: 12),
        Align(
          alignment: Alignment.centerLeft,
          child: _buildButton(ActionButtonType.hapus),
        ),
      ],
    );
  }
}

class _ActionButton extends StatelessWidget {
  final String imageAsset;
  final String label;
  final Color color;
  final bool isMobile;

  const _ActionButton({
    required this.imageAsset,
    required this.label,
    required this.color,
    required this.isMobile,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: Colors.white,
        padding: isMobile ? EdgeInsets.zero : const EdgeInsets.symmetric(horizontal: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(isMobile ? 4 : 6),
        ),
        elevation: 0,
        fixedSize: isMobile ? const Size(40, 36) : const Size.fromHeight(40),
        visualDensity: VisualDensity.compact,
        minimumSize: isMobile ? const Size(40, 36) : null,
      ),
      child: isMobile
          ? SvgPicture.asset(
        imageAsset,
        width: 19,
        height: 19,
        colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
      )
          : Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            imageAsset,
            width: 18,
            height: 18,
            colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
          ),
          if (label.isNotEmpty) ...[
            const SizedBox(width: 8),
            Text(
              label,
              style: const TextStyle(
                fontFamily: 'Satoshi',
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _SearchBox extends StatefulWidget {
  final bool isMobile;
  final String hintText;

  const _SearchBox({super.key, required this.isMobile, required this.hintText});

  @override
  State<_SearchBox> createState() => _SearchBoxState();
}

class _SearchBoxState extends State<_SearchBox> {
  final FocusNode _focusNode = FocusNode();
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _focusNode.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double targetWidth = widget.isMobile ? double.infinity : 500;
    final double targetHeight = widget.isMobile ? 32 : 40;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: targetWidth,
      height: targetHeight,
      padding: EdgeInsets.symmetric(horizontal: widget.isMobile ? 5 : 8),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFF79AB43), width: 1),
        borderRadius: BorderRadius.circular(widget.isMobile ? 8 : 10),
      ),
      child: Row(
        children: [
          Icon(Icons.search, color: Colors.black, size: widget.isMobile ? 23 : 24),
          const SizedBox(width: 8),
          Flexible(
            child: TextField(
              controller: _controller,
              focusNode: _focusNode,
              decoration: InputDecoration(
                hintText: widget.hintText,
                hintStyle: TextStyle(color: Colors.grey, fontSize: widget.isMobile ? 15 : 16),
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.zero,
              ),
              style: TextStyle(fontSize: widget.isMobile ? 15 : 16),
            ),
          ),
        ],
      ),
    );
  }
}