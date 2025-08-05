import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eassist_tools_app/blocs/simulmv/simulmvcrud_bloc.dart';
import 'package:intl/intl.dart';
import 'package:eassist_tools_app/common/thousand_separator_input_formatter.dart';
import 'package:string_validator/string_validator.dart';
import 'package:eassist_tools_app/widgets/checkbox_widget.dart';
import 'package:quick_input_formatters/quick_input_formatters.dart';

class SimulmvFormOpsiPage extends StatefulWidget {
  final String viewMode;
  final String recordId;

  const SimulmvFormOpsiPage(
      {super.key, required this.viewMode, required this.recordId});

  @override
  SimulmvCrudFormPageFormOpsiState createState() =>
      SimulmvCrudFormPageFormOpsiState();
}

class SimulmvCrudFormPageFormOpsiState extends State<SimulmvFormOpsiPage> {
  late SimulmvCrudBloc simulmvCrudBloc;
  final _formKey = GlobalKey<FormState>();
  final List<String> errors = [];
  var fieldAwController = TextEditingController();
  var fieldIsEqController = TextEditingController();
  var fieldIsFloodController = TextEditingController();
  var fieldIsSrccController = TextEditingController();
  var fieldIsTerrorismController = TextEditingController();
  var fieldPadController = TextEditingController();
  var fieldPapController = TextEditingController();
  var fieldPllController = TextEditingController();
  var fieldTplController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    simulmvCrudBloc = BlocProvider.of<SimulmvCrudBloc>(context);

    return BlocConsumer<SimulmvCrudBloc, SimulmvCrudState>(
      builder: (context, state) {
        return SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(height: 10),

                // 4 checkbox: EQ, Flood, SRCC, Terrorism → otomatis wrap
                LayoutBuilder(
                  builder: (context, constraints) {
                    const spacing = 8.0;
                    // Atur breakpoint & jumlah kolom sesuai kebutuhan
                    final isMobile = constraints.maxWidth < 600;
                    final crossAxisCount = isMobile ? 2 : 4;

                    // Hitung lebar item agar pas per baris & rapi saat wrap
                    final itemWidth =
                        (constraints.maxWidth - (crossAxisCount - 1) * spacing) / crossAxisCount;

                    return Wrap(
                      spacing: spacing,     // jarak antar item dalam baris
                      runSpacing: 10,       // jarak antar baris
                      children: [
                        SizedBox(width: itemWidth, child: buildFieldIsEQ()),
                        SizedBox(width: itemWidth, child: buildFieldIsFlood()),
                        SizedBox(width: itemWidth, child: buildFieldIsSRCC()),
                        SizedBox(width: itemWidth, child: buildFieldIsTerrorism()),
                      ],
                    );
                  },
                ),

                const SizedBox(height: 20),

                // Row: Passenger Liability & PA Driver
                Row(
                  children: [
                    Flexible(flex: 1, child: buildFieldPLL()),
                    const SizedBox(width: 8),
                    Flexible(flex: 1, child: buildFieldPAD()),
                  ],
                ),

                const SizedBox(height: 10),

                // Row: TPL & PAP
                Row(
                  children: [
                    Flexible(flex: 1, child: buildFieldTPL()),
                    const SizedBox(width: 8),
                    Flexible(flex: 1, child: buildFieldPAP()),
                  ],
                ),

                const SizedBox(height: 10),

                // Row: Authorized Workshop (kiri saja)
                Row(
                  children: [
                    Flexible(flex: 1, child: buildFieldAW()),
                    const SizedBox(width: 8),
                    const Flexible(flex: 1, child: SizedBox.shrink()),
                  ],
                ),

                const SizedBox(height: 10),
              ],
            ),
          ),
        );
      },
      listener: (context, state) {
        if ((state.isLoaded) || (state.isFieldOpsiChanged)) {
          if (state.record != null) {
            fieldAwController.text = NumberFormat.decimalPattern().format(state.record!.aw);
            fieldIsEqController.text = state.record!.isEq.toString();
            fieldIsFloodController.text = state.record!.isFlood.toString();
            fieldIsSrccController.text = state.record!.isSrcc.toString();
            fieldIsTerrorismController.text = state.record!.isTerrorism.toString();
            fieldPadController.text = NumberFormat("#,###").format(state.record!.pad);
            fieldPapController.text = NumberFormat("#,###").format(state.record!.pap);
            fieldPllController.text = NumberFormat("#,###").format(state.record!.pll);
            fieldTplController.text = NumberFormat("#,###").format(state.record!.tpl);
          }
        }
      },
    );
  }



  Widget buildFieldAW() {
    return TextFormField(
      keyboardType: TextInputType.numberWithOptions(
        decimal: true,
      ),
      controller: fieldAwController,
      decoration: const InputDecoration(
        labelText: "Authorized Workshop",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixText: " %",
      ),
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        DecimalTextInputFormatter(2)
      ],
      onChanged: (value) {
        simulmvCrudBloc
            .add(FieldAWChangedEvent(awRate: double.tryParse(value) ?? 0));
      },
      textAlign: TextAlign.right,
    );
  }

  Widget buildFieldIsEQ() {
    return CheckboxWidget(
        leftLabel: "",
        rightLabel: "EQ",
        initialValue: toBoolean(fieldIsEqController.text),
        callback: (value) {
          simulmvCrudBloc.add(CheckboxIsEQChangedEvent(isChecked: value));
        });
  }

  Widget buildFieldIsFlood() {
    return CheckboxWidget(
        leftLabel: "",
        rightLabel: "Flood",
        initialValue: toBoolean(fieldIsFloodController.text),
        callback: (value) {
          simulmvCrudBloc.add(CheckboxIsFloodChangedEvent(isChecked: value));
        });
  }

  Widget buildFieldIsSRCC() {
    return CheckboxWidget(
        leftLabel: "",
        rightLabel: "SRCC",
        initialValue: toBoolean(fieldIsSrccController.text),
        callback: (value) {
          simulmvCrudBloc.add(CheckboxIsRSCCChangedEvent(isChecked: value));
        });
  }

  Widget buildFieldIsTerrorism() {
    return CheckboxWidget(
        leftLabel: "",
        rightLabel: "Terrorism",
        initialValue: toBoolean(fieldIsTerrorismController.text),
        callback: (value) {
          simulmvCrudBloc
              .add(CheckboxIsTerrorismChangedEvent(isChecked: value));
        });
  }

  Widget buildFieldPAD() {
    return TextFormField(
      keyboardType: TextInputType.number,
      inputFormatters: [ThousandsSeparatorInputFormatter()],
      controller: fieldPadController,
      decoration: const InputDecoration(
        labelText: "PA Driver",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixText: ",000,000,-",
      ),
      onChanged: (value) {
        simulmvCrudBloc
            .add(FieldPADChangedEvent(pad: double.tryParse(value) ?? 0));
      },
      textAlign: TextAlign.right,
    );
  }

  Widget buildFieldPAP() {
    return TextFormField(
      keyboardType: TextInputType.number,
      inputFormatters: [ThousandsSeparatorInputFormatter()],
      controller: fieldPapController,
      decoration: const InputDecoration(
        labelText: "PA Passenger",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixText: ",000,000,-",
      ),
      onChanged: (value) {
        simulmvCrudBloc
            .add(FieldPAPChangedEvent(pap: double.tryParse(value) ?? 0));
      },
      textAlign: TextAlign.right,
    );
  }

  Widget buildFieldPLL() {
    return TextFormField(
      keyboardType: TextInputType.number,
      inputFormatters: [ThousandsSeparatorInputFormatter()],
      controller: fieldPllController,
      decoration: const InputDecoration(
        labelText: "Passenger Liability",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixText: ",000,000,-",
      ),
      onChanged: (value) {
        simulmvCrudBloc
            .add(FieldPLLChangedEvent(pll: double.tryParse(value) ?? 0));
      },
      textAlign: TextAlign.right,
    );
  }

  Widget buildFieldTPL() {
    return TextFormField(
      keyboardType: TextInputType.number,
      inputFormatters: [ThousandsSeparatorInputFormatter()],
      controller: fieldTplController,
      decoration: const InputDecoration(
        labelText: "TPL",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixText: ",000,000,-",
      ),
      onChanged: (value) {
        simulmvCrudBloc
            .add(FieldTPLChangedEvent(tpl: double.tryParse(value) ?? 0));
      },
      textAlign: TextAlign.right,
    );
  }
}
