import 'package:flutter/material.dart';
import '../form_step_container.dart';

class ClaimPaymentForm extends StatelessWidget {
  const ClaimPaymentForm({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.zero,
      child: FormStepContainer(
        children: [
          const _SectionTitle(
            icon: Icons.account_balance,
            title: 'Informasi Bank untuk Pembayaran Klaim',
          ),
          const SizedBox(height: 24),

          _buildBankDataFields(),
        ],
      ),
    );
  }

  Widget _buildBankDataFields() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = MediaQuery.of(context).size.width;
        final availableWidth = constraints.maxWidth;
        final isWideScreen = availableWidth > 768;
        final isTablet = availableWidth > 600 && availableWidth <= 768;
        final isMobile = availableWidth <= 600;

        // Enhanced responsive spacing with better mobile handling
        double getHorizontalPadding() {
          if (isMobile) return 12.0;
          if (isTablet) return 20.0;
          return 24.0;
        }

        double getFieldSpacing() {
          if (isMobile) return 16.0;
          if (isTablet) return 18.0;
          return 20.0;
        }

        double getRowSpacing() {
          if (isMobile) return 12.0;
          return 16.0;
        }

        final horizontalPadding = getHorizontalPadding();
        final fieldSpacing = getFieldSpacing();
        final rowSpacing = getRowSpacing();

        return Container(
          width: double.infinity,
          constraints: BoxConstraints(
            maxWidth: double.infinity,
            minWidth: 0,
          ),
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (isWideScreen) ...[
                // Desktop layout - 2 columns for bank name and account number
                _buildTwoColumnRow([
                  _InputField(
                    label: 'Nama Bank',
                    hintText: 'Pilih atau ketik nama bank',
                    suffixIcon: Icons.keyboard_arrow_down_outlined,
                  ),
                  _InputField(
                    label: 'Nomor Rekening',
                    hintText: 'Masukkan nomor rekening',
                    keyboardType: TextInputType.number,
                    suffixIcon: Icons.account_balance_wallet_outlined,
                  ),
                ], rowSpacing),
                SizedBox(height: fieldSpacing),

                // Full width for account holder name
                _InputField(
                  label: 'Nama Pemilik Rekening',
                  hintText: 'Nama sesuai dengan rekening bank',
                  suffixIcon: Icons.person_outline,
                ),
              ] else if (isTablet) ...[
                // Tablet layout - 2 columns for bank name and account number
                _buildTwoColumnRow([
                  _InputField(
                    label: 'Nama Bank',
                    hintText: 'Pilih atau ketik nama bank',
                    suffixIcon: Icons.keyboard_arrow_down_outlined,
                  ),
                  _InputField(
                    label: 'Nomor Rekening',
                    hintText: 'Masukkan nomor rekening',
                    keyboardType: TextInputType.number,
                    suffixIcon: Icons.account_balance_wallet_outlined,
                  ),
                ], rowSpacing),
                SizedBox(height: fieldSpacing),

                _InputField(
                  label: 'Nama Pemilik Rekening',
                  hintText: 'Nama sesuai dengan rekening bank',
                  suffixIcon: Icons.person_outline,
                ),
              ] else ...[
                // Mobile layout - single column with enhanced spacing
                _InputField(
                  label: 'Nama Bank',
                  hintText: 'Pilih atau ketik nama bank',
                  suffixIcon: Icons.keyboard_arrow_down_outlined,
                ),
                SizedBox(height: fieldSpacing),

                _InputField(
                  label: 'Nomor Rekening',
                  hintText: 'Masukkan nomor rekening',
                  keyboardType: TextInputType.number,
                  suffixIcon: Icons.account_balance_wallet_outlined,
                ),
                SizedBox(height: fieldSpacing),

                _InputField(
                  label: 'Nama Pemilik Rekening',
                  hintText: 'Nama sesuai dengan rekening bank',
                  suffixIcon: Icons.person_outline,
                ),
              ],
              // Add bottom padding for better mobile experience
              SizedBox(height: isMobile ? 20 : 16),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTwoColumnRow(List<Widget> children, double spacing) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: children[0],
          ),
          SizedBox(width: spacing),
          Expanded(
            child: children[1],
          ),
        ],
      ),
    );
  }
}

class _InputField extends StatefulWidget {
  final String label;
  final String? hintText;
  final IconData? suffixIcon;
  final int maxLines;
  final TextInputType? keyboardType;

  const _InputField({
    required this.label,
    this.hintText,
    this.suffixIcon,
    this.maxLines = 1,
    this.keyboardType,
  });

  @override
  State<_InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<_InputField> {
  bool _isHovered = false;
  bool _isFocused = false;
  final FocusNode _focusNode = FocusNode();
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width <= 600;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        constraints: const BoxConstraints(
          minHeight: 48, // Ensure minimum touch target
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          boxShadow: _isHovered || _isFocused
              ? [
            BoxShadow(
              color: Theme.of(context).primaryColor.withOpacity(0.1),
              blurRadius: 6,
              offset: const Offset(0, 2),
            )
          ]
              : null,
        ),
        child: TextField(
          controller: _controller,
          focusNode: _focusNode,
          maxLines: widget.maxLines,
          keyboardType: widget.keyboardType,
          textInputAction: TextInputAction.next,
          style: TextStyle(
            fontSize: isMobile ? 16 : 15, // Prevent zoom on iOS
            fontWeight: FontWeight.w400,
            color: Colors.black87,
          ),
          decoration: InputDecoration(
            labelText: widget.label,
            hintText: widget.hintText,
            suffixIcon: widget.suffixIcon != null
                ? Icon(
              widget.suffixIcon,
              size: isMobile ? 22 : 20,
              color: _isFocused
                  ? Theme.of(context).primaryColor
                  : Colors.grey[500],
            )
                : null,
            labelStyle: TextStyle(
              fontSize: isMobile ? 14 : 13,
              fontWeight: FontWeight.w500,
              color: _isFocused
                  ? Theme.of(context).primaryColor
                  : Colors.grey[600],
            ),
            hintStyle: TextStyle(
              fontSize: isMobile ? 14 : 13,
              color: Colors.grey[400],
              fontWeight: FontWeight.w400,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: Theme.of(context).primaryColor,
                width: 2,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.red, width: 1),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.red, width: 2),
            ),
            filled: true,
            fillColor: _isFocused
                ? Theme.of(context).primaryColor.withOpacity(0.05)
                : _isHovered
                ? Colors.grey.shade50
                : Colors.white,
            contentPadding: EdgeInsets.symmetric(
              horizontal: isMobile ? 14 : 16,
              vertical: widget.maxLines > 1
                  ? (isMobile ? 14 : 16)
                  : (isMobile ? 16 : 14),
            ),
            alignLabelWithHint: widget.maxLines > 1,
            isDense: false,
          ),
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final IconData icon;
  final String title;

  const _SectionTitle({required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width <= 600;

    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(
        horizontal: isMobile ? 12 : 24,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 16 : 20,
        vertical: isMobile ? 14 : 16,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withOpacity(0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Theme.of(context).primaryColor.withOpacity(0.2),
        ),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            size: isMobile ? 18 : 20,
            color: Theme.of(context).primaryColor.withOpacity(0.8),
          ),
          SizedBox(width: isMobile ? 10 : 12),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: isMobile ? 15 : 16,
                color: Theme.of(context).primaryColor.withOpacity(0.9),
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
          ),
        ],
      ),
    );
  }
}