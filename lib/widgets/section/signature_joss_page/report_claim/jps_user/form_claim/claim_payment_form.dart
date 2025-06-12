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
        final isWideScreen = availableWidth > 600;
        final isMobile = screenWidth <= 600;

        // Calculate responsive spacing
        final horizontalPadding = isMobile ? 16.0 : 24.0;
        final fieldSpacing = isMobile ? 16.0 : 20.0;

        return Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
          child: Column(
            children: [
              if (isWideScreen) ...[
                // Row 1: Nama Bank & Nomor Rekening
                Row(
                  children: [
                    Expanded(
                      child: _InputField(label: 'Nama Bank'),
                    ),
                    SizedBox(width: fieldSpacing),
                    Expanded(
                      child: _InputField(label: 'Nomor Rekening'),
                    ),
                  ],
                ),
                SizedBox(height: fieldSpacing),

                // Row 2: Nama Pemilik Rekening (full width)
                _InputField(label: 'Nama Pemilik Rekening'),
              ] else ...[
                // Mobile layout - single column
                _InputField(label: 'Nama Bank'),
                SizedBox(height: fieldSpacing),
                _InputField(label: 'Nomor Rekening'),
                SizedBox(height: fieldSpacing),
                _InputField(label: 'Nama Pemilik Rekening'),
              ],
            ],
          ),
        );
      },
    );
  }
}

class _InputField extends StatefulWidget {
  final String label;
  final int maxLines;

  const _InputField({
    required this.label,
    this.maxLines = 1,
  });

  @override
  State<_InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<_InputField> {
  bool _isHovered = false;
  bool _isFocused = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
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
        child: Focus(
          onFocusChange: (focused) => setState(() => _isFocused = focused),
          child: TextField(
            maxLines: widget.maxLines,
            style: const TextStyle(fontSize: 14),
            decoration: InputDecoration(
              labelText: widget.label,
              labelStyle: TextStyle(
                fontSize: 14,
                color: _isFocused
                    ? Theme.of(context).primaryColor
                    : Colors.grey[600],
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
              filled: true,
              fillColor: _isFocused
                  ? Theme.of(context).primaryColor.withOpacity(0.05)
                  : _isHovered
                  ? Colors.grey.shade50
                  : Colors.white,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16,
                vertical: widget.maxLines > 1 ? 16 : 14,
              ),
              alignLabelWithHint: widget.maxLines > 1,
            ),
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
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width <= 600 ? 16 : 24,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
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
            size: 20,
            color: Theme.of(context).primaryColor.withOpacity(0.8),
          ),
          const SizedBox(width: 12),
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
              color: Theme.of(context).primaryColor.withOpacity(0.9),
            ),
          ),
        ],
      ),
    );
  }
}