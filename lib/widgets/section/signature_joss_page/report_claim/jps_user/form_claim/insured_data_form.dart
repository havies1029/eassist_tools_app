import 'package:flutter/material.dart';
import '../form_step_container.dart';

class InsuredDataForm extends StatefulWidget {
  const InsuredDataForm({super.key});

  @override
  State<InsuredDataForm> createState() => _InsuredDataFormState();
}

class _InsuredDataFormState extends State<InsuredDataForm> {
  String? selectedInsuranceType;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.zero,
      child: FormStepContainer(
        children: [
          // Section 1 - Data Tertanggung
          const _SectionTitle(title: 'Data Tertanggung'),
          const SizedBox(height: 24),

          // Form fields for personal data
          _buildPersonalDataFields(),

          const SizedBox(height: 40),

          // Section 2 - Informasi Polis
          const _SectionTitle(title: 'Informasi Polis'),

          const SizedBox(height: 24),

          // Form fields for policy data
          _buildPolicyDataFields(),

          const SizedBox(height: 40), // Bottom padding
        ],
      ),
    );
  }

  Widget _buildPersonalDataFields() {
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
                // Row 1: Nama Lengkap & Nomor KTP
                Row(
                  children: [
                    Expanded(
                      child: _InputField(label: 'Nama Lengkap'),
                    ),
                    SizedBox(width: fieldSpacing),
                    Expanded(
                      child: _InputField(label: 'Nomor KTP'),
                    ),
                  ],
                ),
                SizedBox(height: fieldSpacing),

                // Row 2: Email & No. Telp
                Row(
                  children: [
                    Expanded(
                      child: _InputField(label: 'Email'),
                    ),
                    SizedBox(width: fieldSpacing),
                    Expanded(
                      child: _InputField(label: 'No. Telp'),
                    ),
                  ],
                ),
                SizedBox(height: fieldSpacing),

                // Row 3: Alamat Lengkap (full width)
                _InputField(
                  label: 'Alamat Lengkap',
                  maxLines: 3,
                ),
              ] else ...[
                // Mobile layout - single column
                _InputField(label: 'Nama Lengkap'),
                SizedBox(height: fieldSpacing),
                _InputField(label: 'Nomor KTP'),
                SizedBox(height: fieldSpacing),
                _InputField(label: 'Email'),
                SizedBox(height: fieldSpacing),
                _InputField(label: 'No. Telp'),
                SizedBox(height: fieldSpacing),
                _InputField(
                  label: 'Alamat Lengkap',
                  maxLines: 3,
                ),
              ],
            ],
          ),
        );
      },
    );
  }

  Widget _buildPolicyDataFields() {
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
                // Row 1: Nomor Polis & Jenis Asuransi
                Row(
                  children: [
                    Expanded(
                      child: _InputField(label: 'Nomor Polis'),
                    ),
                    SizedBox(width: fieldSpacing),
                    Expanded(
                      child: _DropdownField(
                        label: '-- Pilih Jenis Asuransi --',
                        value: selectedInsuranceType,
                        onChanged: (value) {
                          setState(() {
                            selectedInsuranceType = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: fieldSpacing),

                // Row 2: Jenis Asuransi Lainnya (conditional)
                if (selectedInsuranceType == 'Lainnya') ...[
                  _InputField(
                    label: 'Jenis Asuransi Lainnya (Jika Dipilih Lainnya)',
                  ),
                  SizedBox(height: fieldSpacing),
                ],
              ] else ...[
                // Mobile layout
                _InputField(label: 'Nomor Polis'),
                SizedBox(height: fieldSpacing),
                _DropdownField(
                  label: '-- Pilih Jenis Asuransi --',
                  value: selectedInsuranceType,
                  onChanged: (value) {
                    setState(() {
                      selectedInsuranceType = value;
                    });
                  },
                ),
                SizedBox(height: fieldSpacing),
                if (selectedInsuranceType == 'Lainnya') ...[
                  _InputField(
                    label: 'Jenis Asuransi Lainnya (Jika Dipilih Lainnya)',
                  ),
                  SizedBox(height: fieldSpacing),
                ],
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

class _DropdownField extends StatefulWidget {
  final String label;
  final String? value;
  final ValueChanged<String?> onChanged;

  const _DropdownField({
    required this.label,
    this.value,
    required this.onChanged,
  });

  @override
  State<_DropdownField> createState() => _DropdownFieldState();
}

class _DropdownFieldState extends State<_DropdownField> {
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
          child: DropdownButtonFormField<String>(
            value: widget.value?.isEmpty == true ? null : widget.value,
            isExpanded: true,
            items: [
              const DropdownMenuItem(
                value: null,
                child: Text(
                  '-- Pilih Jenis Asuransi --',
                  style: TextStyle(fontSize: 14),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const DropdownMenuItem(
                value: 'Jiwa',
                child: Text(
                  'Asuransi Jiwa',
                  style: TextStyle(fontSize: 14),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const DropdownMenuItem(
                value: 'Kesehatan',
                child: Text(
                  'Asuransi Kesehatan',
                  style: TextStyle(fontSize: 14),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const DropdownMenuItem(
                value: 'Lainnya',
                child: Text(
                  'Lainnya',
                  style: TextStyle(fontSize: 14),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
            onChanged: widget.onChanged,
            style: const TextStyle(fontSize: 14, color: Colors.black87),
            decoration: InputDecoration(
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
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;

  const _SectionTitle({required this.title});

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
      child: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 16,
          color: Theme.of(context).primaryColor.withOpacity(0.9),
        ),
      ),
    );
  }
}