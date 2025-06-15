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
          const _SectionTitle(
              icon: Icons.person_outline,
              title: 'Data Tertanggung'
          ),
          const SizedBox(height: 24),

          // Form fields for personal data
          _buildPersonalDataFields(),

          const SizedBox(height: 40),

          // Section 2 - Informasi Polis
          const _SectionTitle(
              icon: Icons.description_outlined,
              title: 'Informasi Polis'
          ),

          const SizedBox(height: 24),

          // Form fields for policy data
          _buildPolicyDataFields(),
        ],
      ),
    );
  }

  Widget _buildPersonalDataFields() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = MediaQuery.of(context).size.width;
        final availableWidth = constraints.maxWidth;
        final isWideScreen = availableWidth > 768;
        final isMobile = screenWidth <= 768;

        // Improved responsive spacing calculation
        final horizontalPadding = isMobile ? 12.0 : 24.0;
        final fieldSpacing = isMobile ? 12.0 : 20.0;

        return Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
          child: Column(
            children: [
              if (isWideScreen) ...[
                // Desktop/Tablet layout - Row format
                Row(
                  children: [
                    Expanded(
                      child: _InputField(
                        label: 'Nama Lengkap',
                        suffixIcon: Icons.person_outline,
                      ),
                    ),
                    SizedBox(width: fieldSpacing),
                    Expanded(
                      child: _InputField(
                        label: 'Nomor KTP',
                        suffixIcon: Icons.credit_card_outlined,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: fieldSpacing),

                Row(
                  children: [
                    Expanded(
                      child: _InputField(
                        label: 'Email',
                        suffixIcon: Icons.email_outlined,
                      ),
                    ),
                    SizedBox(width: fieldSpacing),
                    Expanded(
                      child: _InputField(
                        label: 'No. Telp',
                        suffixIcon: Icons.phone_outlined,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: fieldSpacing),

                _InputField(
                  label: 'Alamat Lengkap',
                  maxLines: 3,
                  suffixIcon: Icons.location_on_outlined,
                ),
              ] else ...[
                // Mobile layout - single column with better spacing
                _InputField(
                  label: 'Nama Lengkap',
                  suffixIcon: Icons.person_outline,
                ),
                SizedBox(height: fieldSpacing),

                _InputField(
                  label: 'Nomor KTP',
                  suffixIcon: Icons.credit_card_outlined,
                ),
                SizedBox(height: fieldSpacing),

                _InputField(
                  label: 'Email',
                  suffixIcon: Icons.email_outlined,
                ),
                SizedBox(height: fieldSpacing),

                _InputField(
                  label: 'No. Telp',
                  suffixIcon: Icons.phone_outlined,
                ),
                SizedBox(height: fieldSpacing),

                _InputField(
                  label: 'Alamat Lengkap',
                  maxLines: 3,
                  suffixIcon: Icons.location_on_outlined,
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
        final isWideScreen = availableWidth > 768;
        final isMobile = screenWidth <= 768;

        // Improved responsive spacing calculation
        final horizontalPadding = isMobile ? 12.0 : 24.0;
        final fieldSpacing = isMobile ? 12.0 : 20.0;

        return Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
          child: Column(
            children: [
              if (isWideScreen) ...[
                // Desktop/Tablet layout
                Row(
                  children: [
                    Expanded(
                      child: _InputField(
                        label: 'Nomor Polis',
                        suffixIcon: Icons.assignment_outlined,
                      ),
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

                if (selectedInsuranceType == 'Lainnya') ...[
                  _InputField(
                    label: 'Jenis Asuransi Lainnya (Jika Dipilih Lainnya)',
                    suffixIcon: Icons.category_outlined,
                  ),
                  SizedBox(height: fieldSpacing),
                ],
              ] else ...[
                // Mobile layout - single column
                _InputField(
                  label: 'Nomor Polis',
                  suffixIcon: Icons.assignment_outlined,
                ),
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
                    suffixIcon: Icons.category_outlined,
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
  final String? hintText;
  final String? prefixText;
  final IconData? suffixIcon;
  final int maxLines;

  const _InputField({
    required this.label,
    this.hintText,
    this.prefixText,
    this.suffixIcon,
    this.maxLines = 1,
  });

  @override
  State<_InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<_InputField> {
  bool _isHovered = false;
  bool _isFocused = false;
  final FocusNode _focusNode = FocusNode();

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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width <= 768;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: double.infinity,
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
          focusNode: _focusNode,
          maxLines: widget.maxLines,
          style: TextStyle(
            fontSize: isMobile ? 14 : 15,
            fontWeight: FontWeight.w400,
            color: Colors.black87,
          ),
          decoration: InputDecoration(
            labelText: widget.label,
            hintText: widget.hintText,
            prefixText: widget.prefixText,
            suffixIcon: widget.suffixIcon != null
                ? Icon(
              widget.suffixIcon,
              size: isMobile ? 18 : 20,
              color: _isFocused
                  ? Theme.of(context).primaryColor
                  : Colors.grey[500],
            )
                : null,
            labelStyle: TextStyle(
              fontSize: isMobile ? 13 : 14,
              fontWeight: FontWeight.w500,
              color: _isFocused
                  ? Theme.of(context).primaryColor
                  : Colors.grey[600],
            ),
            hintStyle: TextStyle(
              fontSize: isMobile ? 13 : 14,
              color: Colors.grey[400],
              fontWeight: FontWeight.w400,
            ),
            prefixStyle: TextStyle(
              fontSize: isMobile ? 14 : 15,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
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
              horizontal: isMobile ? 12 : 16,
              vertical: widget.maxLines > 1
                  ? (isMobile ? 12 : 16)
                  : (isMobile ? 12 : 14),
            ),
            alignLabelWithHint: widget.maxLines > 1,
            floatingLabelBehavior: FloatingLabelBehavior.auto,
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
  final FocusNode _focusNode = FocusNode();

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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width <= 768;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: double.infinity,
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
        child: DropdownButtonFormField<String>(
          focusNode: _focusNode,
          value: widget.value?.isEmpty == true ? null : widget.value,
          isExpanded: true,
          menuMaxHeight: 200,
          items: [
            const DropdownMenuItem(
              value: null,
              child: Text(
                '-- Pilih Jenis Asuransi --',
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey,
                  fontWeight: FontWeight.w400,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            DropdownMenuItem(
              value: 'Jiwa',
              child: Text(
                'Asuransi Jiwa',
                style: TextStyle(
                  fontSize: isMobile ? 14 : 15,
                  fontWeight: FontWeight.w400,
                  color: Colors.black87,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            DropdownMenuItem(
              value: 'Kesehatan',
              child: Text(
                'Asuransi Kesehatan',
                style: TextStyle(
                  fontSize: isMobile ? 14 : 15,
                  fontWeight: FontWeight.w400,
                  color: Colors.black87,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            DropdownMenuItem(
              value: 'Lainnya',
              child: Text(
                'Lainnya',
                style: TextStyle(
                  fontSize: isMobile ? 14 : 15,
                  fontWeight: FontWeight.w400,
                  color: Colors.black87,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
          onChanged: widget.onChanged,
          style: TextStyle(
            fontSize: isMobile ? 14 : 15,
            fontWeight: FontWeight.w400,
            color: Colors.black87,
          ),
          icon: Icon(
            Icons.arrow_drop_down,
            size: isMobile ? 18 : 20,
            color: _isFocused
                ? Theme.of(context).primaryColor
                : Colors.grey[500],
          ),
          decoration: InputDecoration(
            labelText: widget.label,
            labelStyle: TextStyle(
              fontSize: isMobile ? 13 : 14,
              fontWeight: FontWeight.w500,
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
              horizontal: isMobile ? 12 : 16,
              vertical: isMobile ? 12 : 14,
            ),
            floatingLabelBehavior: FloatingLabelBehavior.auto,
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
    final isMobile = MediaQuery.of(context).size.width <= 768;

    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(
        horizontal: isMobile ? 12 : 24,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 16 : 20,
        vertical: isMobile ? 12 : 16,
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
          SizedBox(width: isMobile ? 8 : 12),
          Flexible(
            child: Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: isMobile ? 14 : 16,
                color: Theme.of(context).primaryColor.withOpacity(0.9),
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}