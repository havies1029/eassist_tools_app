// claim_stepper.dart (Revisi dengan step base lengkap dan file form modular)
import 'package:flutter/material.dart';
import '../../../../../pages/hero_client_page/hero_user_main.dart';
import 'form_claim/instruction_form.dart';
import 'form_claim/insured_data_form.dart';
import 'form_claim/incident_detail_form.dart';
import 'form_claim/claim_payment_form.dart';
import 'form_claim/supporting_documents_form.dart';

const _primaryColor = Color(0xFF79AB43);

class ClaimStepper extends StatefulWidget {
  const ClaimStepper({super.key});

  @override
  State<ClaimStepper> createState() => _ClaimStepperState();
}

class _ClaimStepperState extends State<ClaimStepper> {
  int currentStep = 0;

  final List<Widget> steps = const [
    InstructionForm(),
    InsuredDataForm(),
    IncidentDetailForm(),
    ClaimPaymentForm(),
    SupportingDocumentsForm(),
  ];

  final List<String> titles = [
    'Petunjuk',
    'Data Tertanggung',
    'Detail Kejadian',
    'Pembayaran Klaim',
    'Data Pendukung',
  ];

  final List<String> subtitles = [
    'Memahami Informasi',
    'Mengisi Data Pribadi',
    'Mengisi Data Kejadian',
    'Mengisi Data Bank',
    'Mengisi Data Pendukung',
  ];

  void next() {
    if (currentStep < steps.length - 1) {
      setState(() => currentStep++);
    }
  }

  void back() {
    if (currentStep > 0) {
      setState(() => currentStep--);
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final formWidth = constraints.maxWidth - 48;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 16),
            _StepIndicator(
              currentStep: currentStep,
              titles: titles,
              subtitles: subtitles,
              totalWidth: formWidth,
            ),
            const SizedBox(height: 24),

            // ⬇️ Perubahan dimulai dari sini
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (child, animation) => SizeTransition(
                sizeFactor: animation,
                child: child,
              ),
              child: Padding(
                key: ValueKey(currentStep), // penting untuk animasi bekerja
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: steps[currentStep],
              ),
            ),

            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (currentStep > 0)
                      OutlinedButton.icon(
                        onPressed: back,
                        icon: const Icon(Icons.arrow_back, color: Colors.orange, size: 20), // font size icon
                        label: const Text(
                          "Kembali",
                          style: TextStyle(color: Colors.orange, fontSize: 20), // font size teks
                        ),
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Colors.orange),
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12), // radius 12 utk Kembali
                          ),
                        ),
                      ),
                    if (currentStep < steps.length - 1)
                      ElevatedButton.icon(
                        onPressed: next,
                        icon: const Icon(Icons.arrow_forward, size: 20), // font size icon
                        label: const Text(
                          "Lanjut",
                          style: TextStyle(fontSize: 20), // font size teks
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _primaryColor,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8), // radius 8 utk Lanjut
                          ),
                        ),
                      ),
                    if (currentStep == steps.length - 1)
                      ElevatedButton(
                        onPressed: () {
                          // Navigasi ke HeroUserMain setelah selesai
                          Future.delayed(const Duration(milliseconds: 500), () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (_) => const HeroUserMain()),
                            );
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _primaryColor,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Text(
                              "Selesai",
                              style: TextStyle(fontSize: 20),
                            ),
                            SizedBox(width: 8),
                            Icon(Icons.check, size: 20),
                          ],
                        ),
                      ),
                  ]
              ),
            ),
          ],
        );
      },
    );
  }
}

class _StepIndicator extends StatelessWidget {
  final int currentStep;
  final List<String> titles;
  final List<String> subtitles;
  final double totalWidth;

  const _StepIndicator({
    required this.currentStep,
    required this.titles,
    required this.subtitles,
    required this.totalWidth,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;
    const _textColor = Colors.black87;
    if (isMobile) {
      // ✅ Mobile-style stepper seperti gambar
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: List.generate(titles.length, (index) {
            final isActive = index == currentStep;
            final isPassed = index < currentStep;

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: isActive ? _primaryColor : Colors.grey.shade400,
                        width: 2,
                      ),
                    ),
                    child: Center(
                      child: isActive
                          ? Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _primaryColor,
                        ),
                      )
                          : const SizedBox.shrink(),
                    ),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    width: 100,
                    child: Column(
                      children: [
                        Text(
                          titles[index],
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                            color: _textColor,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          subtitles[index],
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 11,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
      );
    } else {
      // Desktop stepper tetap pakai versi lama
      final stepItemWidth = 100.0;
      final totalConnectors = titles.length - 1;
      final totalStepWidth = stepItemWidth * titles.length;
      final totalConnectorWidth = totalWidth - totalStepWidth;
      final connectorWidth = totalConnectors > 0
          ? (totalConnectorWidth / totalConnectors).clamp(8.0, 100.0)
          : 30.0;

      return Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: totalWidth),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(titles.length * 2 - 1, (index) {
              if (index.isEven) {
                final stepIndex = index ~/ 2;
                final isActive = stepIndex == currentStep;
                final isPassed = stepIndex < currentStep;
                return _StepItem(
                  index: stepIndex,
                  title: titles[stepIndex],
                  subtitle: subtitles[stepIndex],
                  isActive: isActive,
                  isPassed: isPassed,
                );
              } else {
                final isPassed = ((index - 1) ~/ 2) < currentStep;
                return _StepConnector(
                  isPassed: isPassed,
                  width: connectorWidth,
                );
              }
            }),
          ),
        ),
      );
    }
  }
}



class _StepItem extends StatelessWidget {
  final int index;
  final String title;
  final String subtitle;
  final bool isActive;
  final bool isPassed;

  const _StepItem({
    required this.index,
    required this.title,
    required this.subtitle,
    required this.isActive,
    required this.isPassed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isPassed || isActive ? _primaryColor : Colors.grey.shade300,
            border: Border.all(
              color: isPassed || isActive ? _primaryColor : Colors.grey.shade400,
              width: 2,
            ),
          ),
          child: Center(
            child: isPassed
                ? const Icon(
              Icons.check,
              color: Colors.white,
              size: 20,
            )
                : isActive
                ? Container(
              width: 8,
              height: 8,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
            )
                : Text(
              '${index + 1}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade600,
                fontSize: 16.97,
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          width: 100,
          child: Column(
            children: [
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12.73,
                  color: isPassed || isActive ? _primaryColor : Colors.grey.shade600,
                ),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 10,
                  color: isPassed || isActive ? Colors.grey.shade700 : Colors.grey.shade500,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _StepConnector extends StatelessWidget {
  final bool isPassed;
  final double width;

  const _StepConnector({
    required this.isPassed,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        width: width,
        height: 2,
        color: isPassed ? _primaryColor : Colors.grey.shade400,
      ),
    );
  }
}
