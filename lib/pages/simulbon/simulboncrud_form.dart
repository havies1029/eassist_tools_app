import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eassist_tools_app/common/constants.dart';
import 'package:eassist_tools_app/widgets/form_error.dart';
import 'package:eassist_tools_app/blocs/simulbon/simulboncrud_bloc.dart';
import 'package:eassist_tools_app/models/simulbon/simulboncrud_model.dart';
import 'package:eassist_tools_app/models/combobox/combormatauang_model.dart';
import 'package:eassist_tools_app/widgets/combobox/combormatauang_widget.dart';
import 'package:intl/intl.dart';
import 'package:eassist_tools_app/common/thousand_separator_input_formatter.dart';
import 'package:string_validator/string_validator.dart';
import 'package:eassist_tools_app/widgets/checkbox_widget.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:quick_input_formatters/quick_input_formatters.dart';

class SimulbonCrudFormPage extends StatefulWidget {
  final String viewMode;
  final String recordId;

  const SimulbonCrudFormPage(
      {super.key, required this.viewMode, required this.recordId});

  @override
  SimulbonCrudFormPageFormState createState() =>
      SimulbonCrudFormPageFormState();
}

class SimulbonCrudFormPageFormState extends State<SimulbonCrudFormPage> {
  late SimulbonCrudBloc simulbonCrudBloc;
  final _formKey = GlobalKey<FormState>();
  var fieldCarNilaiController = TextEditingController();
  var fieldCarPersenController = TextEditingController();
  var fieldCoverBulanController = TextEditingController();
  var fieldIsCarController = TextEditingController();
  var fieldIsPelaksanaanController = TextEditingController();
  var fieldIsPemeliharaanController = TextEditingController();
  var fieldIsPenawaranController = TextEditingController();
  var fieldIsUangmukaController = TextEditingController();
  var fieldKontrakNilaiController = TextEditingController();
  var fieldPelaksanaanNilaiController = TextEditingController();
  var fieldPelaksanaanPersenController = TextEditingController();
  var fieldPemeliharaanNilaiController = TextEditingController();
  var fieldPemeliharaanPersenController = TextEditingController();
  var fieldPenawaranNilaiController = TextEditingController();
  var fieldPenawaranPersenController = TextEditingController();
  var fieldPremiCarController = TextEditingController();
  var fieldPremiPelaksanaanController = TextEditingController();
  var fieldPremiPemeliharaanController = TextEditingController();
  var fieldPremiPenawaranController = TextEditingController();
  var fieldPremiUangmukaController = TextEditingController();
  var fieldRateBondController = TextEditingController();
  var fieldRateCarController = TextEditingController();
  ComboRMatauangModel? fieldComboRMatauang;
  final comboRMatauangKey =
      GlobalKey<DropdownSearchState<ComboRMatauangModel>>();
  var fieldUangmukaNilaiController = TextEditingController();
  var fieldUangmukaPersenController = TextEditingController();
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
    simulbonCrudBloc = BlocProvider.of<SimulbonCrudBloc>(context);
    return BlocConsumer<SimulbonCrudBloc, SimulbonCrudState>(
      builder: (context, state) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const SizedBox(height: 10),
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
                    buildFieldKontrakNilai(),
                    const SizedBox(height: 20),
                    SizedBox(
                      child: InputDecorator(
                          decoration: InputDecoration(
                            labelText: 'Jaminan Pelaksanaan',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          child: Column(
                            children: [
                              buildFieldIsPelaksanaan(),
                              Row(
                                children: [
                                  Flexible(
                                    flex: 2,
                                    child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: buildFieldPelaksanaanPersen()),
                                  ),
                                  Flexible(
                                    flex: 5,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: buildFieldPelaksanaanNilai(),
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
                                        child: buildFieldRatePelaksanaan()),
                                  ),
                                  Flexible(
                                    flex: 5,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: buildFieldPremiPelaksanaan(),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                            ],
                          )),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      child: InputDecorator(
                          decoration: InputDecoration(
                            labelText: 'Jaminan Pemeliharaan',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          child: Column(
                            children: [
                              buildFieldIsPemeliharaan(),
                              Row(
                                children: [
                                  Flexible(
                                    flex: 2,
                                    child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: buildFieldPemeliharaanPersen()),
                                  ),
                                  Flexible(
                                    flex: 5,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: buildFieldPemeliharaanNilai(),
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
                                        child: buildFieldRatePemeliharaan()),
                                  ),
                                  Flexible(
                                    flex: 5,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: buildFieldPremiPemeliharaan(),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                            ],
                          )),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      child: InputDecorator(
                          decoration: InputDecoration(
                            labelText: 'Jaminan Uang Muka',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          child: Column(
                            children: [
                              buildFieldIsUangMuka(),
                              Row(
                                children: [
                                  Flexible(
                                    flex: 2,
                                    child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: buildFieldUangMukaPersen()),
                                  ),
                                  Flexible(
                                    flex: 5,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: buildFieldUangMukaNilai(),
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
                                        child: buildFieldRateUangMuka()),
                                  ),
                                  Flexible(
                                    flex: 5,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: buildFieldPremiUangMuka(),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                            ],
                          )),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      child: InputDecorator(
                          decoration: InputDecoration(
                            labelText: 'Jaminan Penawaran',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          child: Column(
                            children: [
                              buildFieldIsPenawaran(),
                              Row(
                                children: [
                                  Flexible(
                                    flex: 2,
                                    child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: buildFieldPenawaranPersen()),
                                  ),
                                  Flexible(
                                    flex: 5,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: buildFieldPenawaranNilai(),
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
                                        child: buildFieldRatePenawaran()),
                                  ),
                                  Flexible(
                                    flex: 5,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: buildFieldPremiPenawaran(),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                            ],
                          )),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      child: InputDecorator(
                          decoration: InputDecoration(
                            labelText: 'CAR / EAR',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          child: Column(
                            children: [
                              buildFieldIsCar(),
                              Row(
                                children: [
                                  Flexible(
                                    flex: 2,
                                    child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: buildFieldCarPersen()),
                                  ),
                                  Flexible(
                                    flex: 5,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: buildFieldCarNilai(),
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
                                        child: buildFieldRateCAR()),
                                  ),
                                  Flexible(
                                    flex: 5,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: buildFieldPremiCAR(),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                            ],
                          )),
                    ),
                    const SizedBox(height: 25),
                    FormError(
                      errors: state.errors??[],
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
                                simulbonCrudBloc.add(HitungPremiBonEvent());
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
            fieldCarNilaiController.text =
                NumberFormat("#,###").format(state.record!.carNilai);
            fieldCarPersenController.text =
                NumberFormat("###.00").format(state.record!.carPersen);
            fieldCoverBulanController.text =
                state.record!.coverBulan.toString();
            fieldIsCarController.text = state.record!.isCar.toString();
            fieldIsPelaksanaanController.text =
                state.record!.isPelaksanaan.toString();
            fieldIsPemeliharaanController.text =
                state.record!.isPemeliharaan.toString();
            fieldIsPenawaranController.text =
                state.record!.isPenawaran.toString();
            fieldIsUangmukaController.text =
                state.record!.isUangmuka.toString();
            fieldKontrakNilaiController.text =
                NumberFormat("#,###").format(state.record!.kontrakNilai);
            fieldPelaksanaanNilaiController.text =
                NumberFormat("#,###").format(state.record!.pelaksanaanNilai);
            fieldPelaksanaanPersenController.text =
                NumberFormat("###.00").format(state.record!.pelaksanaanPersen);
            fieldPemeliharaanNilaiController.text =
                NumberFormat("#,###").format(state.record!.pemeliharaanNilai);
            fieldPemeliharaanPersenController.text =
                NumberFormat("###.00").format(state.record!.pemeliharaanPersen);
            fieldPenawaranNilaiController.text =
                NumberFormat("#,###").format(state.record!.penawaranNilai);
            fieldPenawaranPersenController.text =
                NumberFormat("###.00").format(state.record!.penawaranPersen);
            fieldPremiCarController.text =
                NumberFormat("#,###").format(state.record!.premiCar);
            fieldPremiPelaksanaanController.text =
                NumberFormat("#,###").format(state.record!.premiPelaksanaan);
            fieldPremiPemeliharaanController.text =
                NumberFormat("#,###").format(state.record!.premiPemeliharaan);
            fieldPremiPenawaranController.text =
                NumberFormat("#,###").format(state.record!.premiPenawaran);
            fieldPremiUangmukaController.text =
                NumberFormat("#,###").format(state.record!.premiUangmuka);
            fieldRateBondController.text =
                NumberFormat("###.00").format(state.record!.rateBond);
            fieldRateCarController.text =
                NumberFormat("###.00").format(state.record!.rateCar);
            fieldUangmukaNilaiController.text =
                NumberFormat("#,###").format(state.record!.uangmukaNilai);
            fieldUangmukaPersenController.text =
                NumberFormat("###.00").format(state.record!.uangmukaPersen);

            currDesc = state.record!.currDesc ?? "IDR";
          }
          fieldComboRMatauang = state.comboRMatauang;
        }
      },
    );
  }

  void loadData() {
    simulbonCrudBloc.add(SimulBonCrudInitValueEvent());
  }

  Widget buildFieldCarNilai() {
    return TextFormField(
      keyboardType: TextInputType.number,
      inputFormatters: [ThousandsSeparatorInputFormatter()],
      controller: fieldCarNilaiController,
      decoration: InputDecoration(
        labelText: "Nilai",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        prefixText: currDesc,
      ),
      onChanged: (value) {},
      textAlign: TextAlign.right,
    );
  }

  Widget buildFieldCarPersen() {
    return TextFormField(
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        DecimalTextInputFormatter(2)
      ],
      controller: fieldCarPersenController,
      decoration: const InputDecoration(
        labelText: "carPersen",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixText: " %",
      ),
      onChanged: (value) {
        simulbonCrudBloc.add(
            FieldCarPersenChangedEvent(persen: double.tryParse(value) ?? 0));
      },
      textAlign: TextAlign.right,
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
        simulbonCrudBloc
            .add(FieldLamaCoverChangedEvent(lama: int.tryParse(value) ?? 0));
      },
      textAlign: TextAlign.right,
    );
  }

  Widget buildFieldIsCar() {
    return CheckboxWidget(
        leftLabel: "",
        rightLabel: "Ya",
        initialValue: toBoolean(fieldIsCarController.text),
        callback: (value) {
          simulbonCrudBloc.add(FieldIsCarChangedEvent(ya: value));
        });
  }

  Widget buildFieldIsPelaksanaan() {
    return CheckboxWidget(
        leftLabel: "",
        rightLabel: "Ya",
        initialValue: toBoolean(fieldIsPelaksanaanController.text),
        callback: (value) {
          simulbonCrudBloc.add(FieldIsPelaksanaanChangedEvent(ya: value));
        });
  }

  Widget buildFieldIsPemeliharaan() {
    return CheckboxWidget(
        leftLabel: "",
        rightLabel: "Ya",
        initialValue: toBoolean(fieldIsPemeliharaanController.text),
        callback: (value) {
          simulbonCrudBloc.add(FieldIsPemeliharaanChangedEvent(ya: value));
        });
  }

  Widget buildFieldIsPenawaran() {
    return CheckboxWidget(
        leftLabel: "",
        rightLabel: "Ya",
        initialValue: toBoolean(fieldIsPenawaranController.text),
        callback: (value) {
          simulbonCrudBloc.add(FieldIsPenawaranChangedEvent(ya: value));
        });
  }

  Widget buildFieldIsUangMuka() {
    return CheckboxWidget(
        leftLabel: "",
        rightLabel: "Ya",
        initialValue: toBoolean(fieldIsUangmukaController.text),
        callback: (value) {
          simulbonCrudBloc.add(FieldIsUangMukaChangedEvent(ya: value));
        });
  }

  Widget buildFieldKontrakNilai() {
    return TextFormField(
      keyboardType: TextInputType.number,
      inputFormatters: [ThousandsSeparatorInputFormatter()],
      controller: fieldKontrakNilaiController,
      decoration: InputDecoration(
        labelText: "Nilai Kontrak",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        prefixText: currDesc,
      ),
      onChanged: (value) {
        value = value.replaceAll(",", "");
        simulbonCrudBloc.add(FieldNilaiKontrakChangedEvent(
            nilaiKontrak: double.tryParse(value) ?? 0));
      },
      textAlign: TextAlign.right,
    );
  }

  Widget buildFieldPelaksanaanNilai() {
    return TextFormField(
      readOnly: true,
      keyboardType: TextInputType.number,
      inputFormatters: [ThousandsSeparatorInputFormatter()],
      controller: fieldPelaksanaanNilaiController,
      decoration: InputDecoration(
        labelText: "Nilai",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        prefixText: currDesc,
      ),
      onChanged: (value) {},
      textAlign: TextAlign.right,
    );
  }

  Widget buildFieldPelaksanaanPersen() {
    return TextFormField(
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        DecimalTextInputFormatter(2)
      ],
      controller: fieldPelaksanaanPersenController,
      decoration: const InputDecoration(
        labelText: "(%)",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixText: " %",
      ),
      onChanged: (value) {
        simulbonCrudBloc.add(FieldPelaksanaanPersenChangedEvent(
            persen: double.tryParse(value) ?? 0));
      },
      textAlign: TextAlign.right,
    );
  }

  Widget buildFieldPemeliharaanNilai() {
    return TextFormField(
      keyboardType: TextInputType.number,
      inputFormatters: [ThousandsSeparatorInputFormatter()],
      controller: fieldPemeliharaanNilaiController,
      decoration: InputDecoration(
        labelText: "Nilai",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        prefixText: currDesc,
      ),
      onChanged: (value) {},
      textAlign: TextAlign.right,
    );
  }

  Widget buildFieldPemeliharaanPersen() {
    return TextFormField(
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        DecimalTextInputFormatter(2)
      ],
      controller: fieldPemeliharaanPersenController,
      decoration: const InputDecoration(
        labelText: "(%)",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixText: " %",
      ),
      onChanged: (value) {
        simulbonCrudBloc.add(FieldPemeliharaanPersenChangedEvent(
            persen: double.tryParse(value) ?? 0));
      },
      textAlign: TextAlign.right,
    );
  }

  Widget buildFieldPenawaranNilai() {
    return TextFormField(
      keyboardType: TextInputType.number,
      inputFormatters: [ThousandsSeparatorInputFormatter()],
      controller: fieldPenawaranNilaiController,
      decoration: InputDecoration(
        labelText: "Nilai",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        prefixText: currDesc,
      ),
      onChanged: (value) {},
      textAlign: TextAlign.right,
    );
  }

  Widget buildFieldPenawaranPersen() {
    return TextFormField(
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        DecimalTextInputFormatter(2)
      ],
      controller: fieldPenawaranPersenController,
      decoration: const InputDecoration(
        labelText: "(%)",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixText: " %",
      ),
      onChanged: (value) {
        simulbonCrudBloc.add(FieldPenawaranPersenChangedEvent(
            persen: double.tryParse(value) ?? 0));
      },
      textAlign: TextAlign.right,
    );
  }

  Widget buildFieldPremiCAR() {
    return TextFormField(
      keyboardType: TextInputType.number,
      inputFormatters: [ThousandsSeparatorInputFormatter()],
      controller: fieldPremiCarController,
      decoration: InputDecoration(
        labelText: "Premi",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        prefixText: currDesc,
      ),
      onChanged: (value) {},
      textAlign: TextAlign.right,
    );
  }

  Widget buildFieldPremiPelaksanaan() {
    return TextFormField(
      readOnly: true,
      keyboardType: TextInputType.number,
      inputFormatters: [ThousandsSeparatorInputFormatter()],
      controller: fieldPremiPelaksanaanController,
      decoration: InputDecoration(
        labelText: "Premi",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        prefixText: currDesc,
      ),
      onChanged: (value) {},
      textAlign: TextAlign.right,
    );
  }

  Widget buildFieldPremiPemeliharaan() {
    return TextFormField(
      readOnly: true,
      keyboardType: TextInputType.number,
      inputFormatters: [ThousandsSeparatorInputFormatter()],
      controller: fieldPremiPemeliharaanController,
      decoration: InputDecoration(
        labelText: "Premi",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        prefixText: currDesc,
      ),
      onChanged: (value) {},
      textAlign: TextAlign.right,
    );
  }

  Widget buildFieldPremiPenawaran() {
    return TextFormField(
      readOnly: true,
      keyboardType: TextInputType.number,
      inputFormatters: [ThousandsSeparatorInputFormatter()],
      controller: fieldPremiPenawaranController,
      decoration: InputDecoration(
        labelText: "Premi",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        prefixText: currDesc,
      ),
      onChanged: (value) {},
      textAlign: TextAlign.right,
    );
  }

  Widget buildFieldPremiUangMuka() {
    return TextFormField(
      readOnly: true,
      keyboardType: TextInputType.number,
      inputFormatters: [ThousandsSeparatorInputFormatter()],
      controller: fieldPremiUangmukaController,
      decoration: InputDecoration(
        labelText: "Premi",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        prefixText: currDesc,
      ),
      onChanged: (value) {},
      textAlign: TextAlign.right,
    );
  }

  Widget buildFieldMataUang() {
    return buildFieldComboRMatauang(
      comboKey: comboRMatauangKey,
      labelText: 'Mata Uang',
      initItem: fieldComboRMatauang,
      onChangedCallback: (value) {
        if (value != null) {
          simulbonCrudBloc
              .add(ComboRMatauangChangedEvent(comboRMatauang: value));
        }
      },
      onSaveCallback: (value) {},
    );
  }

  Widget buildFieldUangMukaNilai() {
    return TextFormField(
      readOnly: true,
      keyboardType: TextInputType.number,
      inputFormatters: [ThousandsSeparatorInputFormatter()],
      controller: fieldUangmukaNilaiController,
      decoration: InputDecoration(
        labelText: "Nilai",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        prefixText: currDesc,
      ),
      onChanged: (value) {},
      textAlign: TextAlign.right,
    );
  }

  Widget buildFieldUangMukaPersen() {
    return TextFormField(
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        DecimalTextInputFormatter(2)
      ],
      controller: fieldUangmukaPersenController,
      decoration: const InputDecoration(
        labelText: "(%)",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixText: " %",
      ),
      onChanged: (value) {
        simulbonCrudBloc.add(FieldUangMukaPersenChangedEvent(
            persen: double.tryParse(value) ?? 0));
      },
      textAlign: TextAlign.right,
    );
  }

  Widget buildFieldRatePelaksanaan() {
    return TextFormField(
      readOnly: true,
      keyboardType: TextInputType.number,
      inputFormatters: [ThousandsSeparatorInputFormatter()],
      controller: fieldRateBondController,
      decoration: const InputDecoration(
        labelText: "Rate",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixText: " %",
      ),
      onChanged: (value) {},
      textAlign: TextAlign.right,
    );
  }

  Widget buildFieldRatePemeliharaan() {
    return TextFormField(
      readOnly: true,
      keyboardType: TextInputType.number,
      inputFormatters: [ThousandsSeparatorInputFormatter()],
      controller: fieldRateBondController,
      decoration: const InputDecoration(
        labelText: "Rate",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixText: " %",
      ),
      onChanged: (value) {},
      textAlign: TextAlign.right,
    );
  }

  Widget buildFieldRatePenawaran() {
    return TextFormField(
      readOnly: true,
      keyboardType: TextInputType.number,
      inputFormatters: [ThousandsSeparatorInputFormatter()],
      controller: fieldRateBondController,
      decoration: const InputDecoration(
        labelText: "Rate",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixText: " %",
      ),
      onChanged: (value) {},
      textAlign: TextAlign.right,
    );
  }

  Widget buildFieldRateUangMuka() {
    return TextFormField(
      readOnly: true,
      keyboardType: TextInputType.number,
      inputFormatters: [ThousandsSeparatorInputFormatter()],
      controller: fieldRateBondController,
      decoration: const InputDecoration(
        labelText: "Rate",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixText: " %",
      ),
      onChanged: (value) {},
      textAlign: TextAlign.right,
    );
  }

  Widget buildFieldRateCAR() {
    return TextFormField(
      readOnly: true,
      keyboardType: TextInputType.number,
      inputFormatters: [ThousandsSeparatorInputFormatter()],
      controller: fieldRateCarController,
      decoration: const InputDecoration(
        labelText: "Rate",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixText: " %",
      ),
      onChanged: (value) {},
      textAlign: TextAlign.right,
    );
  }
}
