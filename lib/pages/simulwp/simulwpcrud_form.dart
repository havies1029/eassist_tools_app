import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eassist_tools_app/widgets/form_error.dart';
import 'package:eassist_tools_app/blocs/simulwp/simulwpcrud_bloc.dart';
import 'package:eassist_tools_app/models/combobox/combormatauang_model.dart';
import 'package:eassist_tools_app/widgets/combobox/combormatauang_widget.dart';
import 'package:intl/intl.dart';
import 'package:eassist_tools_app/common/thousand_separator_input_formatter.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:quick_input_formatters/quick_input_formatters.dart';

class SimulwpCrudFormPage extends StatefulWidget {
  final String viewMode;
  final String recordId;

  const SimulwpCrudFormPage(
      {super.key, required this.viewMode, required this.recordId});

  @override
  SimulwpCrudFormPageFormState createState() => SimulwpCrudFormPageFormState();
}

class SimulwpCrudFormPageFormState extends State<SimulwpCrudFormPage> {
  late SimulwpCrudBloc simulwpCrudBloc;
  final _formKey = GlobalKey<FormState>();
  var fieldCoverBulanController = TextEditingController();
  var fieldPlafondController = TextEditingController();
  var fieldPremiController = TextEditingController();
  var fieldRateController = TextEditingController();
  ComboRMatauangModel? fieldComboRMatauang;
  final comboRMatauangKey =
      GlobalKey<DropdownSearchState<ComboRMatauangModel>>();
  var fieldUsiaController = TextEditingController();
  String currDesc = "IDR";

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 500), () {
      loadData();
    });
  }

  @override
  Widget build(BuildContext context) {
    simulwpCrudBloc = BlocProvider.of<SimulwpCrudBloc>(context);
    return BlocConsumer<SimulwpCrudBloc, SimulwpCrudState>(
      builder: (context, state) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
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
                            child: buildFieldMataUang(),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Flexible(
                          flex: 1,
                          child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: buildFieldUsia()),
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
                    Row(
                      children: [
                        Flexible(
                          flex: 3,
                          child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: buildFieldPlafond()),
                        ),
                        Flexible(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Flexible(
                          flex: 2,
                          child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: buildFieldRate()),
                        ),
                        Flexible(
                          flex: 5,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: buildFieldPremi(),
                          ),
                        ),
                      ],
                    ),
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
                                loadData();
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
                                simulwpCrudBloc.add(HitungPremiWpEvent());
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
            fieldPlafondController.text =
                NumberFormat("#,###").format(state.record!.plafond);
            fieldPremiController.text =
                NumberFormat("#,###").format(state.record!.premi);
            fieldRateController.text =
                NumberFormat("###.00").format(state.record!.rate);
            fieldUsiaController.text = state.record!.usia.toString();
            currDesc = state.record!.currDesc ?? "IDR";
          }
          fieldComboRMatauang = state.comboRMatauang;
        }
      },
    );
  }

  void loadData() {
    simulwpCrudBloc.add(SimulWpCrudInitValueEvent());
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
        simulwpCrudBloc
            .add(FieldBulanChangedEvent(bulan: int.tryParse(value) ?? 0));
      },
      textAlign: TextAlign.right,
    );
  }

  Widget buildFieldMataUang() {
    return buildFieldComboRMatauang(
      comboKey: comboRMatauangKey,
      labelText: 'Mata Uang',
      initItem: fieldComboRMatauang,
      onChangedCallback: (value) {
        if (value != null) {}
      },
      onSaveCallback: (value) {},
    );
  }

  Widget buildFieldPlafond() {
    return TextFormField(
      keyboardType: TextInputType.number,
      inputFormatters: [ThousandsSeparatorInputFormatter()],
      controller: fieldPlafondController,
      decoration: InputDecoration(
          labelText: "Plafond",
          floatingLabelBehavior: FloatingLabelBehavior.always,
          prefixText: currDesc,
          suffixText: ",000,000"),
      onChanged: (value) {
        value = value.replaceAll(",", "");
        simulwpCrudBloc.add(
            FieldPlafondChangedEvent(plafond: double.tryParse(value) ?? 0));
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
      onChanged: (value) {},
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

  Widget buildFieldUsia() {
    return TextFormField(
      keyboardType: TextInputType.number,
      inputFormatters: [ThousandsSeparatorInputFormatter()],
      controller: fieldUsiaController,
      decoration: InputDecoration(
          labelText: "Usia",
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixText: " tahun"),
      onChanged: (value) {
        simulwpCrudBloc
            .add(FieldUsiaChangedEvent(usia: int.tryParse(value) ?? 0));
      },
      textAlign: TextAlign.right,
    );
  }
}
