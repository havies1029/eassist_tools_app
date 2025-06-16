import 'package:flutter/material.dart';

import '../profile_individu/form_sections/mrekan_general_idv_form_body.dart';
import '../profile_individu/form_sections/mrekan_pajak_form_body.dart';
import '../profile_individu/form_sections/mrekan_bank_form_body.dart';
import '../profile_individu/form_sections/mrekan_general_cmp_form_body.dart';
import '../profile_individu/form_sections/mrekan_contact.dart';

class ProfileIndividuFormSection extends StatelessWidget {
  final Map<String, bool> editSection;
  final Map<String, TextEditingController> controllers;
  final void Function(String sectionKey) toggleEdit;

  const ProfileIndividuFormSection({
    Key? key,
    required this.editSection,
    required this.controllers,
    required this.toggleEdit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double maxWidth = MediaQuery.of(context).size.width;
    final bool isMobile = maxWidth < 768;
    final bool isTablet = maxWidth >= 768 && maxWidth < 1024;

    if (isMobile) return _buildMobile(context);
    if (isTablet) return _buildTablet(context);
    return _buildDesktop(context);
  }

  Widget _buildMobile(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // --- General Individu ---
          _buildCard(MRekanGeneralIdvFormBody(viewMode: 'tambah', recordId: '')),

          // --- General Contact ---
          _buildCard(MRekanContactFormBody()),
          const SizedBox(height: 16),
          // --- Informasi Rekening ---
          _buildCard(MRekanBankFormBody(viewMode: 'tambah', recordId: '')),
          const SizedBox(height: 16),

          const SizedBox(height: 16),
          // --- Informasi Pajak ---
          _buildCard(MRekanPajakFormBody(viewMode: 'tambah', recordId: '')),

        ],
      ),
    );
  }

  Widget _buildTablet(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _buildCard(MRekanGeneralIdvFormBody(viewMode: 'tambah', recordId: '')),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildCard(MRekanContactFormBody()),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildCard(MRekanBankFormBody(viewMode: 'tambah', recordId: '')),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildCard(MRekanPajakFormBody(viewMode: 'tambah', recordId: '')),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDesktop(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: _buildCard(MRekanGeneralIdvFormBody(viewMode: 'tambah', recordId: '')),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: _buildCard(MRekanContactFormBody()),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              children: [
                _buildCard(MRekanBankFormBody(viewMode: 'tambah', recordId: '')),
                const SizedBox(height: 16),
                _buildCard(MRekanPajakFormBody(viewMode: 'tambah', recordId: '')),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCard(Widget child) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: child,
      ),
    );
  }
}