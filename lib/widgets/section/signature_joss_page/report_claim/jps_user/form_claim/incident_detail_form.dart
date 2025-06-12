import 'package:flutter/material.dart';
import '../form_step_container.dart';

class IncidentDetailForm extends StatelessWidget {
  const IncidentDetailForm({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.zero,
      child: FormStepContainer(
        children: [
          const _SectionTitle(
              icon: Icons.report_problem_outlined,
              title: 'Detail Kejadian/Kerugian'
          ),
          const SizedBox(height: 24),

          // Form fields with responsive layout
          _buildFormFields(),

          const SizedBox(height: 40), // Bottom padding
        ],
      ),
    );
  }

  Widget _buildFormFields() {
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
                // Row 1: Tanggal Kejadian & Waktu
                Row(
                  children: [
                    Expanded(
                      child: _InputField(
                        label: 'Tanggal Kejadian',
                        hintText: 'hh/bb/tttt',
                        suffixIcon: Icons.calendar_today_outlined,
                      ),
                    ),
                    SizedBox(width: fieldSpacing),
                    Expanded(
                      child: _InputField(
                        label: 'Waktu',
                        hintText: 'hh:mm',
                        suffixIcon: Icons.access_time_outlined,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: fieldSpacing),

                // Row 2: Lokasi Kejadian & Estimasi Nilai Kerugian
                Row(
                  children: [
                    Expanded(
                      child: _InputField(
                        label: 'Lokasi Kejadian',
                        suffixIcon: Icons.location_on_outlined,
                      ),
                    ),
                    SizedBox(width: fieldSpacing),
                    Expanded(
                      child: _InputField(
                        label: 'Estimasi Nilai Kerugian',
                        hintText: 'Rp',
                        prefixText: 'Rp ',
                      ),
                    ),
                  ],
                ),
                SizedBox(height: fieldSpacing),

                // Row 3: Deskripsi Kejadian (full width)
                _InputField(
                  label: 'Deskripsi Kejadian',
                  maxLines: 4,
                  suffixIcon: Icons.description_outlined,
                ),
              ] else ...[
                // Mobile layout - single column
                _InputField(
                  label: 'Tanggal Kejadian',
                  hintText: 'hh/bb/tttt',
                  suffixIcon: Icons.calendar_today_outlined,
                ),
                SizedBox(height: fieldSpacing),
                _InputField(
                  label: 'Waktu',
                  hintText: 'hh:mm',
                  suffixIcon: Icons.access_time_outlined,
                ),
                SizedBox(height: fieldSpacing),
                _InputField(
                  label: 'Lokasi Kejadian',
                  suffixIcon: Icons.location_on_outlined,
                ),
                SizedBox(height: fieldSpacing),
                _InputField(
                  label: 'Estimasi Nilai Kerugian',
                  hintText: 'Rp',
                  prefixText: 'Rp ',
                ),
                SizedBox(height: fieldSpacing),
                _InputField(
                  label: 'Deskripsi Kejadian',
                  maxLines: 4,
                  suffixIcon: Icons.description_outlined,
                ),
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
        child: TextField(
          focusNode: _focusNode,
          maxLines: widget.maxLines,
          style: const TextStyle(
            fontSize: 15,
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
              size: 20,
              color: _isFocused
                  ? Theme.of(context).primaryColor
                  : Colors.grey[500],
            )
                : null,
            labelStyle: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: _isFocused
                  ? Theme.of(context).primaryColor
                  : Colors.grey[600],
            ),
            hintStyle: TextStyle(
              fontSize: 14,
              color: Colors.grey[400],
              fontWeight: FontWeight.w400,
            ),
            prefixStyle: TextStyle(
              fontSize: 15,
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
              horizontal: 16,
              vertical: widget.maxLines > 1 ? 16 : 14,
            ),
            alignLabelWithHint: widget.maxLines > 1,
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