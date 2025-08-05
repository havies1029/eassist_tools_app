import 'package:eassist_tools_app/widgets/form_error.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eassist_tools_app/blocs/simulmv/simulmvcrud_bloc.dart';
import 'package:intl/intl.dart';
import 'package:eassist_tools_app/common/thousand_separator_input_formatter.dart';

class SimulmvFormPremiPage extends StatefulWidget {
  final String viewMode;
  final String recordId;

  const SimulmvFormPremiPage(
      {super.key, required this.viewMode, required this.recordId});

  @override
  SimulmvCrudFormPageFormPremiState createState() =>
      SimulmvCrudFormPageFormPremiState();
}

class SimulmvCrudFormPageFormPremiState
    extends State<SimulmvFormPremiPage> {
  late SimulmvCrudBloc simulmvCrudBloc;
  final _formKey = GlobalKey<FormState>();
  var fieldPremiAddController = TextEditingController();
  var fieldPremiCascoController = TextEditingController();
  var fieldPremiTotalController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<SimulmvCrudBloc>();

    return BlocConsumer<SimulmvCrudBloc, SimulmvCrudState>(
      listener: (context, state) {
        if ((state.isLoaded || state.isCalculated) && state.record != null) {
          final f = NumberFormat.decimalPattern('id');
          fieldPremiAddController.text   = f.format(state.record!.premiAdd ?? 0);
          fieldPremiCascoController.text = f.format(state.record!.premiCasco ?? 0);
          fieldPremiTotalController.text = f.format(state.record!.premiTotal ?? 0);
        }
      },
      buildWhen: (p, c) =>
      p.isCalculated != c.isCalculated ||
          p.isLoaded != c.isLoaded ||
          p.errors != c.errors,
      builder: (context, state) {
        return Column(
          children: [
            // ✅ TANPA tombol
            _buildReadOnlyField('Premi Casco', fieldPremiCascoController),
            const SizedBox(height: 8),
            _buildReadOnlyField('Premi Tambahan', fieldPremiAddController),
            const SizedBox(height: 8),
            _buildReadOnlyField('Premi Total', fieldPremiTotalController),
            const SizedBox(height: 16),
            FormError(errors: state.errors ?? [], key: null,),
          ],
        );
      },
    );
  }

  Widget _buildReadOnlyField(String label, TextEditingController c) {
    return TextFormField(
      readOnly: true,
      textAlign: TextAlign.right,
      controller: c,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: label,
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }

  Widget buildFieldPremiAdd() {
    return TextFormField(
      keyboardType: TextInputType.number,
      inputFormatters: [ThousandsSeparatorInputFormatter()],
      controller: fieldPremiAddController,
      decoration: const InputDecoration(
        labelText: "Premi Tambahan",
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
      onChanged: (value) {
        if (value.isNotEmpty) {
          //removeError(error: kStringNullError);
        }
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          //addError(error: kStringNullError);
          return "";
        }
        return null;
      },
      textAlign: TextAlign.right,
    );
  }

  Widget buildFieldPremiCasco() {
    return TextFormField(
      keyboardType: TextInputType.number,
      inputFormatters: [ThousandsSeparatorInputFormatter()],
      controller: fieldPremiCascoController,
      decoration: const InputDecoration(
        labelText: "Premi Casco",
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
      onChanged: (value) {
        if (value.isNotEmpty) {
          //removeError(error: kStringNullError);
        }
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          //addError(error: kStringNullError);
          return "";
        }
        return null;
      },
      textAlign: TextAlign.right,
    );
  }

  Widget buildFieldPremiTotal() {
    return TextFormField(
      keyboardType: TextInputType.number,
      inputFormatters: [ThousandsSeparatorInputFormatter()],
      controller: fieldPremiTotalController,
      decoration: const InputDecoration(
        labelText: "Premi Total",
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
      onChanged: (value) {
        if (value.isNotEmpty) {
          //removeError(error: kStringNullError);
        }
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          //addError(error: kStringNullError);
          return "";
        }
        return null;
      },
      textAlign: TextAlign.right,
    );
  }
}
