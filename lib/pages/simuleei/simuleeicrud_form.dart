import 'package:eassist_tools_app/blocs/simulmv/simulmvcrud_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eassist_tools_app/common/constants.dart';
import 'package:eassist_tools_app/widgets/form_error.dart';
import 'package:eassist_tools_app/blocs/simuleei/simuleeicrud_bloc.dart';
import 'package:eassist_tools_app/models/simuleei/simuleeicrud_model.dart';
import 'package:eassist_tools_app/models/combobox/combormatauang_model.dart';
import 'package:eassist_tools_app/widgets/combobox/combormatauang_widget.dart';
import 'package:intl/intl.dart';
import 'package:eassist_tools_app/common/thousand_separator_input_formatter.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:quick_input_formatters/quick_input_formatters.dart';

class SimuleeiCrudFormPage extends StatefulWidget {
  final String viewMode;
  final String recordId;

  const SimuleeiCrudFormPage(
      {super.key, required this.viewMode, required this.recordId});

  @override
  SimuleeiCrudFormPageFormState createState() =>
      SimuleeiCrudFormPageFormState();
}

class SimuleeiCrudFormPageFormState extends State<SimuleeiCrudFormPage> {
  late SimuleeiCrudBloc simuleeiCrudBloc;
  final _formKey = GlobalKey<FormState>();
  var fieldCoverBulanController = TextEditingController();
  var fieldRateController = TextEditingController();
  ComboRMatauangModel? fieldComboRMatauang;
  final comboRMatauangKey =
      GlobalKey<DropdownSearchState<ComboRMatauangModel>>();
  var fieldTsiController = TextEditingController();
  var fieldPremiController = TextEditingController();
  String currDesc = "IDR";

  @override
  Widget build(BuildContext context) {
    simuleeiCrudBloc = BlocProvider.of<SimuleeiCrudBloc>(context);
    return BlocConsumer<SimuleeiCrudBloc, SimuleeiCrudState>(
      builder: (context, state) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 40.0, right: 40.0, top: 8.0),
            child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Flexible(
                          flex: 1,
                          child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: buildFieldCoverBulan()),
                        ),
                        Flexible(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(),
                          ),
                        ),
                      ],
                    ),
                    //buildFieldCoverBulan(),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Flexible(
                          flex: 1,
                          child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: buildFieldCurrency()),
                        ),
                        Flexible(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    buildFieldTSI(),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Flexible(
                          flex: 1,
                          child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: buildFieldRate()),
                        ),
                        Flexible(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    buildFieldPremi(),
                    const SizedBox(height: 25),
                    FormError(
                      errors: state.errors ?? [],
                      key: null,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.3,
                          height: 60,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 30.0),
                            child: ElevatedButton(
                              onPressed: () {
                                simuleeiCrudBloc
                                    .add(SimuleeiCrudInitValueEvent());
                              },
                              child: const Text(
                                'Reset',
                                style: TextStyle(fontSize: 13.0),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.3,
                          height: 60,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 30.0),
                            child: ElevatedButton(
                              onPressed: () {
                                simuleeiCrudBloc.add(HitungPremiEEIEvent());
                              },
                              child: const Text(
                                'Hitung',
                                style: TextStyle(fontSize: 13.0),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                )),
          ),
        );
      },
      listener: (context, state) {
        if (state.isLoaded) {
          if (state.record != null) {
            fieldCoverBulanController.text =
                state.record!.coverBulan.toString();
            fieldRateController.text =
                NumberFormat("###.00").format(state.record!.rate);
            fieldTsiController.text =
                NumberFormat("#,###").format(state.record!.tsi);
            currDesc = state.record!.currDesc ?? "IDR";
            fieldPremiController.text = 
                NumberFormat("#,###").format(state.record!.premi);
          }
          fieldComboRMatauang = state.comboRMatauang;
        }
      },
    );
  }

  Widget buildFieldCoverBulan() {
    return TextFormField(
      keyboardType: TextInputType.number,
      inputFormatters: [ThousandsSeparatorInputFormatter()],
      controller: fieldCoverBulanController,
      decoration: const InputDecoration(
        labelText: "Lama Cover",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixText: " bulan",
      ),
      onChanged: (value) {
        simuleeiCrudBloc
            .add(FieldBulanChangedEvent(bulan: int.tryParse(value) ?? 0));
      },
      textAlign: TextAlign.right,
    );
  }

  Widget buildFieldCurrency() {
    return buildFieldComboRMatauang(
      comboKey: comboRMatauangKey,
      labelText: 'Curr',
      initItem: fieldComboRMatauang,
      onChangedCallback: (value) {
        if (value != null) {
          simuleeiCrudBloc
              .add(ComboRMatauangChangedEvent(comboRMatauang: value));
        }
      },
      onSaveCallback: (value) {},
    );
  }

  Widget buildFieldTSI() {
    return TextFormField(
      keyboardType: TextInputType.number,
      inputFormatters: [ThousandsSeparatorInputFormatter()],
      controller: fieldTsiController,
      decoration: InputDecoration(
          labelText: "TSI",
          floatingLabelBehavior: FloatingLabelBehavior.always,
          prefixText: currDesc),
      onChanged: (value) {
        value = value.replaceAll(",", "");
        debugPrint("buildFieldTSI : $value");
        simuleeiCrudBloc
            .add(FieldTSIChangedEvent(tsi: double.tryParse(value) ?? 0));
      },
      textAlign: TextAlign.right,
    );
  }

  Widget buildFieldRate() {
    return TextFormField(
      readOnly: true,
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        DecimalTextInputFormatter(2)
      ],
      controller: fieldRateController,
      decoration: const InputDecoration(
        labelText: "Rate",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixText: " %",
      ),
      onChanged: (value) {
        simuleeiCrudBloc
            .add(FieldRateChangedEvent(rate: double.tryParse(value) ?? 0));
      },
      textAlign: TextAlign.right,
    );
  }

  Widget buildFieldPremi() {
    return TextFormField(
      readOnly: true,
      keyboardType: TextInputType.number,
      inputFormatters: [ThousandsSeparatorInputFormatter()],
      controller: fieldPremiController,
      decoration: InputDecoration(
          labelText: "Premi",
          floatingLabelBehavior: FloatingLabelBehavior.always,
          prefixText: currDesc),
      onChanged: (value) {},
      textAlign: TextAlign.right,
    );
  }
}
