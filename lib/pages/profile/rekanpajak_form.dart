import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:eassist_tools_app/common/constants.dart';
import 'package:eassist_tools_app/widgets/form_error.dart';
import 'package:eassist_tools_app/blocs/profile/rekanpajak_bloc.dart';
import 'package:eassist_tools_app/models/profile/rekanpajak_model.dart';
import 'package:eassist_tools_app/models/combobox/combomkota_model.dart';
import 'package:eassist_tools_app/widgets/combobox/combomkota_widget.dart';
import 'package:eassist_tools_app/models/combobox/combompropinsi_model.dart';
import 'package:eassist_tools_app/widgets/combobox/combompropinsi_widget.dart';
import 'package:eassist_tools_app/models/combobox/comborkodepos_model.dart';
import 'package:eassist_tools_app/widgets/combobox/comborkodepos_widget.dart';

class RekanPajakFormPage extends StatefulWidget {
	final String viewMode;
	final String recordId;

	const RekanPajakFormPage({
		Key? key,
		required this.viewMode,
		required this.recordId,
	}) : super(key: key);

	@override
	RekanPajakFormPageFormState createState() => RekanPajakFormPageFormState();
}

class RekanPajakFormPageFormState extends State<RekanPajakFormPage> {
	late RekanPajakBloc rekanPajakBloc;
	final _formKey = GlobalKey<FormState>();
	final List<String> errors = [];

	// Controllers & models
	final TextEditingController fieldAlamat1Controller = TextEditingController();
	final TextEditingController fieldNpwpNoController = TextEditingController();
	ComboMKotaModel? fieldComboMKota;
	ComboMPropinsiModel? fieldComboMPropinsi;
	ComboRKodeposModel? fieldComboRKodepos;

	// Edit-mode flag
	bool isEditingSection = false;

	@override
	void initState() {
		super.initState();
		Future.delayed(const Duration(milliseconds: 500), () {
			loadData();
		});
	}

	@override
	void dispose() {
		fieldAlamat1Controller.dispose();
		fieldNpwpNoController.dispose();
		super.dispose();
	}

	void loadData() {
		if (widget.viewMode == "ubah") {
			rekanPajakBloc.add(
				RekanPajakLihatEvent(recordId: widget.recordId),
			);
		}
	}

	@override
	Widget build(BuildContext context) {
		rekanPajakBloc = BlocProvider.of<RekanPajakBloc>(context);

		return BlocConsumer<RekanPajakBloc, RekanPajakState>(
			listener: (context, state) {
				if (state.isLoaded) {
					setState(() {
						if (state.record != null) {
							fieldAlamat1Controller.text = state.record!.alamat1;
							fieldNpwpNoController.text = state.record!.npwpNo;
						}
						fieldComboMKota = state.comboMKota;
						fieldComboMPropinsi = state.comboMPropinsi;
						fieldComboRKodepos = state.comboRKodepos;
					});
				}
			},
			builder: (context, state) {
				return Dialog(
					shape:
					RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
					child: SingleChildScrollView(
						child: Padding(
							padding: const EdgeInsets.all(12.0),
							child: Form(
								key: _formKey,
								child: Column(
									children: [
										const SizedBox(height: 10),
										Text(
											"${widget.viewMode == "tambah" ? "Tambah" : "Ubah"} Informasi Pajak",
											style: const TextStyle(
												fontSize: 20.0,
												color: Color(0xffff6101),
												fontWeight: FontWeight.w600,
												fontFamily: 'Hind',
												fontStyle: FontStyle.italic,
												decoration: TextDecoration.underline,
											),
										),
										const SizedBox(height: 20),
										_buildSectionContainer(
											title: 'Informasi Pajak',
											children: [
												// Alamat
												_buildLabelText('Alamat'),
												const SizedBox(height: 6),
												_buildStyledTextField(
													controller: fieldAlamat1Controller,
													hintText: 'Masukkan alamat lengkap',
													keyboardType: TextInputType.multiline,
													maxLines: 2,
													validator: (value) {
														if (value == null || value.isEmpty) {
															addError(error: kStringNullError);
															return "";
														}
														return null;
													},
													onChanged: (value) {
														if (value.isNotEmpty) {
															removeError(error: kStringNullError);
														}
													},
												),
												const SizedBox(height: 12),

												// Dropdown: Kota
												_buildLabelText('Kota'),
												const SizedBox(height: 6),
												_buildStyledDropdown(
													child: buildFieldMkotaId(),
												),
												const SizedBox(height: 12),

												// Dropdown: Propinsi
												_buildLabelText('Propinsi'),
												const SizedBox(height: 6),
												_buildStyledDropdown(
													child: buildFieldMpropinsiId(),
												),
												const SizedBox(height: 12),

												// NPWP No
												_buildLabelText('NPWP No'),
												const SizedBox(height: 6),
												_buildStyledTextField(
													controller: fieldNpwpNoController,
													hintText: 'Masukkan NPWP',
													keyboardType: TextInputType.text,
													validator: (value) {
														if (value == null || value.isEmpty) {
															addError(error: kStringNullError);
															return "";
														}
														return null;
													},
													onChanged: (value) {
														if (value.isNotEmpty) {
															removeError(error: kStringNullError);
														}
													},
												),
												const SizedBox(height: 12),

												// Dropdown: Kode Pos
												_buildLabelText('Kode Pos'),
												const SizedBox(height: 6),
												_buildStyledDropdown(
													child: buildFieldRkodeposId(),
												),

												const SizedBox(height: 20),
											],
										),

										// Display errors
										FormError(
											errors: errors,
											key: null,
										),
										const SizedBox(height: 20),

										// Optional Close / Save buttons
										Row(
											mainAxisAlignment: MainAxisAlignment.spaceAround,
											children: [
												SizedBox(
													width: MediaQuery.of(context).size.width * 0.3,
													height: 50,
													child: ElevatedButton(
														onPressed: () {
															_dismissDialog();
														},
														child: const Text(
															'Close',
															style: TextStyle(fontSize: 13.0),
														),
													),
												),
												SizedBox(
													width: MediaQuery.of(context).size.width * 0.3,
													height: 50,
													child: ElevatedButton(
														onPressed: () {
															onSaveForm();
														},
														child: const Text(
															'Save',
															style: TextStyle(fontSize: 13.0),
														),
													),
												),
											],
										),
									],
								),
							),
						),
					),
				);
			},
		);
	}

	// Toggle edit / submit
	void toggleEditSection() {
		setState(() {
			isEditingSection = !isEditingSection;
		});
	}

	// Container with border, title, and edit/check icon
	Widget _buildSectionContainer({
		required String title,
		required List<Widget> children,
	}) {
		return Container(
			padding: const EdgeInsets.all(16),
			decoration: BoxDecoration(
				border: Border.all(color: Colors.grey.shade300),
				borderRadius: BorderRadius.circular(12),
			),
			child: Column(
				crossAxisAlignment: CrossAxisAlignment.start,
				children: [
					// Title + IconButton
					Row(
						children: [
							Expanded(
								child: Text(
									title,
									style:
									const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
								),
							),
							IconButton(
								icon: Icon(isEditingSection ? Icons.check : Icons.edit),
								onPressed: () {
									if (isEditingSection) {
										onSaveForm(); // Submit when editing
									} else {
										toggleEditSection(); // Enter edit mode
									}
								},
							),
						],
					),
					const SizedBox(height: 12),
					// Wrap children with AbsorbPointer to enforce read-only
					for (var w in children)
						AbsorbPointer(
							absorbing: !isEditingSection,
							child: w,
						),
				],
			),
		);
	}

	// Label text above input
	Widget _buildLabelText(String text) {
		return Text(
			text,
			style: const TextStyle(fontWeight: FontWeight.w600),
		);
	}

	// Styled TextFormField (outline + padding)
	Widget _buildStyledTextField({
		required TextEditingController controller,
		required String hintText,
		TextInputType keyboardType = TextInputType.text,
		int maxLines = 1,
		List<TextInputFormatter>? inputFormatters,
		String? Function(String?)? validator,
		void Function(String)? onChanged,
	}) {
		return TextFormField(
			controller: controller,
			readOnly: !isEditingSection,
			keyboardType: keyboardType,
			maxLines: maxLines,
			inputFormatters: inputFormatters,
			decoration: InputDecoration(
				hintText: hintText,
				border: OutlineInputBorder(
					borderRadius: BorderRadius.circular(8),
				),
				contentPadding:
				const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
			),
			validator: validator,
			onChanged: onChanged,
		);
	}

	// Wrapper so dropdown looks like a TextField
	Widget _buildStyledDropdown({required Widget child}) {
		return Container(
			padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
			decoration: BoxDecoration(
				border: Border.all(color: Colors.grey.shade400),
				borderRadius: BorderRadius.circular(8),
			),
			child: child,
		);
	}

	// Close dialog
	void _dismissDialog() {
		Navigator.pop(context);
	}

	// Submit form: validate + send Bloc event
	void onSaveForm() {
		if (_formKey.currentState!.validate()) {
			_formKey.currentState!.save();

			final RekanPajakModel record = RekanPajakModel(
				alamat1: fieldAlamat1Controller.text,
				mkotaId: fieldComboMKota?.mkotaId,
				mpropinsiId: fieldComboMPropinsi?.mpropinsiId,
				mrekanpajakId: '',
				npwpNo: fieldNpwpNoController.text,
				rkodeposId: fieldComboRKodepos?.rkodeposId,
			);

			if (widget.viewMode == "tambah") {
				rekanPajakBloc.add(RekanPajakTambahEvent(record: record));
			} else if (widget.viewMode == "ubah") {
				record.mrekanpajakId = rekanPajakBloc.state.record!.mrekanpajakId;
				rekanPajakBloc.add(RekanPajakUbahEvent(record: record));
			}

			// Close dialog after saving
			_dismissDialog();
		}
	}

	// Add error message
	void addError({required String error}) {
		if (!errors.contains(error)) {
			setState(() {
				errors.add(error);
			});
		}
	}

	// Remove error message
	void removeError({required String error}) {
		if (errors.contains(error)) {
			setState(() {
				errors.remove(error);
			});
		}
	}

	// ================================================
	// HELPERS: Build original dropdown fields unchanged
	// ================================================
	Widget buildFieldMkotaId() {
		return buildFieldComboMKota(
			labelText: 'mkotaId',
			initItem: fieldComboMKota,
			onChangedCallback: (value) {
				if (value != null) {
					removeError(error: "Field ComboMKota tidak boleh kosong.");
					rekanPajakBloc.add(ComboMKotaChangedEvent(comboMKota: value));
				}
			},
			onSaveCallback: (value) {
				if (value != null) {
					fieldComboMKota = value;
				}
			},
			validatorCallback: (value) {
				if (value == null) {
					addError(error: "Field ComboMKota tidak boleh kosong.");
				}
			},
		);
	}

	Widget buildFieldMpropinsiId() {
		return buildFieldComboMPropinsi(
			labelText: 'mpropinsiId',
			initItem: fieldComboMPropinsi,
			onChangedCallback: (value) {
				if (value != null) {
					removeError(error: "Field ComboMPropinsi tidak boleh kosong.");
					rekanPajakBloc.add(ComboMPropinsiChangedEvent(comboMPropinsi: value));
				}
			},
			onSaveCallback: (value) {
				if (value != null) {
					fieldComboMPropinsi = value;
				}
			},
			validatorCallback: (value) {
				if (value == null) {
					addError(error: "Field ComboMPropinsi tidak boleh kosong.");
				}
			},
		);
	}

	Widget buildFieldRkodeposId() {
		return buildFieldComboRKodepos(
			labelText: 'rkodeposId',
			initItem: fieldComboRKodepos,
			onChangedCallback: (value) {
				if (value != null) {
					removeError(error: "Field ComboRKodepos tidak boleh kosong.");
					rekanPajakBloc.add(ComboRKodeposChangedEvent(comboRKodepos: value));
				}
			},
			onSaveCallback: (value) {
				if (value != null) {
					fieldComboRKodepos = value;
				}
			},
			validatorCallback: (value) {
				if (value == null) {
					addError(error: "Field ComboRKodepos tidak boleh kosong.");
				}
			},
		);
	}
}
