import 'package:flutter/material.dart';

import '../profile_individu/form_sections/section_identitas_rekening.dart';
import '../profile_individu/form_sections/section_informasi_klien.dart';
import '../profile_individu/form_sections/section_kontak_klien.dart';

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
          // --- Kontak Perusahaan ---
          Card(
            elevation: 2,
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SectionKontakKlien(isEditing: true, controllers: {}, toggleEdit: () {  },
              ),
            ),
          ),
          const SizedBox(height: 16),

          // --- General Information ---
          Card(
            elevation: 2,
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SectionInformasiKlien(isEditing: true, controllers: {}, toggleEdit: () {  },
              ),
            ),
          ),
          const SizedBox(height: 16),

          // --- Informasi Pajak ---
          Card(
            elevation: 2,
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SectionIdentitasRekening(isEditing: true, controllers: {}, toggleEdit: () {  },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTablet(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Pada tablet: dua kolom (Kontak + General), lalu Informasi Pajak di bawah
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SectionKontakKlien(isEditing: true, controllers: {}, toggleEdit: () {  },
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SectionInformasiKlien(isEditing: true, controllers: {}, toggleEdit: () {  },
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SectionIdentitasRekening(isEditing: true, controllers: {}, toggleEdit: () {  },
              ),
            ),
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
          // Kontak Perusahaan
          Expanded(
            child: Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SectionKontakKlien(isEditing: true, controllers: {}, toggleEdit: () {  },),
              ),
            ),
          ),
          const SizedBox(width: 16),

          // General Information
          Expanded(
            child: Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SectionInformasiKlien(isEditing: true, controllers: {}, toggleEdit: () {  },
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),

          // Informasi Pajak
          Expanded(
            child: Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SectionIdentitasRekening(isEditing: true, controllers: {}, toggleEdit: () {  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
