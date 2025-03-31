import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eassist_tools_app/widgets/form_error.dart';
import 'package:eassist_tools_app/blocs/simulcargo/simulcargocrud_bloc.dart';
import 'package:eassist_tools_app/models/combobox/combommop_model.dart';
import 'package:eassist_tools_app/widgets/combobox/combommop_widget.dart';
import 'package:eassist_tools_app/models/combobox/combomconveydetail_model.dart';
import 'package:eassist_tools_app/widgets/combobox/combomconveydetail_widget.dart';
// import 'package:eassist_tools_app/models/combobox/combommop_model.dart';
// import 'package:eassist_tools_app/widgets/combobox/combommop_widget.dart';
import 'package:intl/intl.dart';
import 'package:eassist_tools_app/common/thousand_separator_input_formatter.dart';
import 'package:dropdown_search/dropdown_search.dart';
// import 'package:eassist_tools_app/common/thousand_separator_input_formatter.dart';
import 'package:quick_input_formatters/quick_input_formatters.dart';
import '../../models/combobox/combomconveyby_model.dart';
import '../../models/combobox/combormatauang_model.dart';
import '../../widgets/combobox/combomconveyby_widget.dart';
import '../../widgets/combobox/combormatauang_widget.dart';


class SimulcargoCrudFormPage extends StatefulWidget {
  final String viewMode;
  final String recordId;

  const SimulcargoCrudFormPage({super.key, required this.viewMode, required this.recordId});

  @override
  SimulcargoCrudFormPageFormState createState() => SimulcargoCrudFormPageFormState();
}

class SimulcargoCrudFormPageFormState extends State<SimulcargoCrudFormPage> {

  late SimulcargoCrudBloc simulcargoCrudBloc;
  final _formKey = GlobalKey<FormState>();
  final List<String> errors = [];
  ComboRMatauangModel? fieldComboRMatauang;
  ComboMMopModel? fieldComboMMop;
  ComboMConveybyModel? fieldComboMConveyBy;
  final comboMMopKey = GlobalKey<DropdownSearchState<ComboMMopModel>>();
  final comboMConveyByKey =
  GlobalKey<DropdownSearchState<ComboMConveybyModel>>();
  ComboMConveyDetailModel? fieldComboMConveyDetail;
  final comboMConveyDetailKey =
  GlobalKey<DropdownSearchState<ComboMConveyDetailModel>>();
  var fieldPremiController = TextEditingController();
  var fieldRateController = TextEditingController();
  var fieldTsiController = TextEditingController();
  var fieldUpliftPersenController = TextEditingController();
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
    simulcargoCrudBloc = BlocProvider.of<SimulcargoCrudBloc>(context);
    return BlocConsumer<SimulcargoCrudBloc, SimulcargoCrudState>(
      builder: (context, state) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    buildFieldMop(),
                    const SizedBox(height: 10),
                    buildFieldConveyBy(),
                    const SizedBox(height: 10),
                    buildFieldConveyDetail(),
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
                    buildFieldTsi(),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Flexible(
                          flex: 1,
                          child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: buildFieldUplift()),
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
                                simulcargoCrudBloc.add(HitungPremiCargoEvent());
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
            fieldPremiController.text =
                NumberFormat("#,###").format(state.record!.premi);
            fieldRateController.text =
                NumberFormat("###.00").format(state.record!.rate);
            fieldTsiController.text =
                NumberFormat("#,###").format(state.record!.tsi);
            fieldUpliftPersenController.text =
                NumberFormat("#,###").format(state.record!.upliftPersen);
            currDesc = state.record!.currDesc ?? "IDR";
          }
          fieldComboMMop = state.comboMMop;
          fieldComboMConveyDetail = state.comboMConveyDetail;
          fieldComboMConveyBy = state.comboMConveyBy;
          fieldComboRMatauang = state.comboRMatauang;
        }
      },
    );
  }

  void loadData() {
    comboMMopKey.currentState?.clear();
    comboMConveyByKey.currentState?.clear();
    comboMConveyDetailKey.currentState?.clear();
    simulcargoCrudBloc.add(SimulCargoCrudInitValueEvent());
  }

  Widget buildFieldMop() {
    return buildFieldComboMMop(
      comboKey: comboMMopKey,
      labelText: 'MOP',
      initItem: fieldComboMMop,
      onChangedCallback: (value) {
        if (value != null) {
          comboMConveyByKey.currentState?.clear();
          comboMConveyDetailKey.currentState?.clear();
          simulcargoCrudBloc.add(ComboMMopChangedEvent(comboMMop: value));
        }
      },
      onSaveCallback: (value) {},
    );
  }

  Widget buildFieldConveyBy() {
    return buildFieldComboMConveyby(
        comboKey: comboMConveyByKey,
        labelText: 'Convey By',
        initItem: fieldComboMConveyBy,
        mopId: fieldComboMMop?.mmopId ?? "",
        onChangedCallback: (value) {
          if (value != null) {
            comboMConveyDetailKey.currentState?.clear();
            simulcargoCrudBloc
                .add(ComboMConveyByChangedEvent(comboMConveyBy: value));
          }
        },
        onSaveCallback: (value) {});
  }

  Widget buildFieldConveyDetail() {
    return buildFieldComboMConveyDetail(
      comboKey: comboMConveyDetailKey,
      labelText: 'Convey Detail',
      initItem: fieldComboMConveyDetail,
      mopId: fieldComboMMop?.mmopId ?? "",
      conveyById: fieldComboMConveyBy?.mconveybyId ?? "",
      onChangedCallback: (value) {
        if (value != null) {
          simulcargoCrudBloc
              .add(ComboMConveyDetailChangedEvent(comboMConveyDetail: value));
        }
      },
      onSaveCallback: (value) {
        if (value != null) {
          fieldComboMConveyDetail = value;
        }
      },
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
        prefixText: currDesc,
      ),
      onChanged: (value) {},
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

  Widget buildFieldTsi() {
    return TextFormField(
      keyboardType: TextInputType.number,
      inputFormatters: [ThousandsSeparatorInputFormatter()],
      controller: fieldTsiController,
      decoration: InputDecoration(
        labelText: "TSI",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        prefixText: currDesc,
      ),
      onChanged: (value) {
        value = value.replaceAll(",", "");
        debugPrint("buildFieldTSI : $value");
        simulcargoCrudBloc
            .add(FieldTSIChangedEvent(tsi: double.tryParse(value) ?? 0));
      },
      textAlign: TextAlign.right,
    );
  }

  Widget buildFieldUplift() {
    return TextFormField(
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        DecimalTextInputFormatter(2)
      ],
      controller: fieldUpliftPersenController,
      decoration: const InputDecoration(
        labelText: "Uplift",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixText: " %",
      ),
      onChanged: (value) {
        simulcargoCrudBloc.add(FieldUpliftPersenChangedEvent(uplift: double.tryParse(value)??0));
      },
      textAlign: TextAlign.right,
    );
  }

  Widget buildFieldCurrency() {
    return buildFieldComboRMatauang(
      labelText: 'Curr',
      initItem: fieldComboRMatauang,
      onChangedCallback: (value) {
        if (value != null) {
          simulcargoCrudBloc
              .add(ComboRMatauangChangedEvent(comboRMatauang: value));
        }
      },
      onSaveCallback: (value) {},
    );
  }
}
