import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:eassist_tools_app/common/constants.dart';
import 'package:eassist_tools_app/widgets/form_error.dart';
import 'package:eassist_tools_app/blocs/profile/rekangeneral_bloc.dart';
import 'package:eassist_tools_app/models/profile/rekangeneral_model.dart';
import 'package:eassist_tools_app/models/combobox/combombentukcst_model.dart';
import 'package:eassist_tools_app/widgets/combobox/combombentukcst_widget.dart';
import 'package:eassist_tools_app/models/combobox/combombidang_model.dart';
import 'package:eassist_tools_app/widgets/combobox/combombidang_widget.dart';
import 'package:eassist_tools_app/models/combobox/combomtipecst_model.dart';
import 'package:eassist_tools_app/widgets/combobox/combomtipecst_widget.dart';
import 'package:eassist_tools_app/models/combobox/combomtitle_model.dart';
import 'package:eassist_tools_app/widgets/combobox/combomtitle_widget.dart';

class RekanGeneralFormPage extends StatefulWidget {
	final String viewMode;
	final String recordId;

	const RekanGeneralFormPage({
		Key? key,
		required this.viewMode,
		required this.recordId,
	}) : super(key: key);

	@override
	RekanGeneralFormPageFormState createState() =>
			RekanGeneralFormPageFormState();
}

class RekanGeneralFormPageFormState extends State<RekanGeneralFormPage> {
	late RekanGeneralBloc rekanGeneralBloc;
	final _formKey = GlobalKey<FormState>();
	final List<String> errors = [];

	// Dropdown models
	ComboMBentukCstModel? fieldComboMBentukCst;
	ComboMBidangModel? fieldComboMBidang;
	ComboMTipeCstModel? fieldComboMTipeCst;
	ComboMTitleModel? fieldComboMTitle;

	// Text controller
	final TextEditingController fieldRekanNamaController =
	TextEditingController();

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
		fieldRekanNamaController.dispose();
		super.dispose();
	}

	void loadData() {
		if (widget.viewMode == "ubah") {
			rekanGeneralBloc.add(
				RekanGeneralLihatEvent(recordId: widget.recordId),
			);
		}
	}

	@override
	Widget build(BuildContext context) {
		rekanGeneralBloc = BlocProvider.of<RekanGeneralBloc>(context);

		return BlocConsumer<RekanGeneralBloc, RekanGeneralState>(
			listener: (context, state) {
				if (state.isLoaded) {
					setState(() {
						if (state.record != null) {
							fieldRekanNamaController.text = state.record!.rekanNama;
						}
						fieldComboMBentukCst = state.comboMBentukCst;
						fieldComboMBidang = state.comboMBidang;
						fieldComboMTipeCst = state.comboMTipeCst;
						fieldComboMTitle = state.comboMTitle;
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
											"${widget.viewMode == "tambah" ? "Tambah" : "Ubah"} General Information",
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
											title: 'General Information',
											children: [
												// Bentuk Customer Dropdown
												_buildLabelText('Bentuk Customer'),
												const SizedBox(height: 6),
												_buildStyledDropdown(
													child: buildFieldMbentukcstId(),
												),
												const SizedBox(height: 12),

												// Bidang Dropdown
												_buildLabelText('Bidang'),
												const SizedBox(height: 6),
												_buildStyledDropdown(
													child: buildFieldMbidangId(),
												),
												const SizedBox(height: 12),

												// Tipe Customer Dropdown
												_buildLabelText('Tipe Customer'),
												const SizedBox(height: 6),
												_buildStyledDropdown(
													child: buildFieldMtipecstId(),
												),
												const SizedBox(height: 12),

												// Title Dropdown
												_buildLabelText('Title'),
												const SizedBox(height: 6),
												_buildStyledDropdown(
													child: buildFieldMtitleId(),
												),
												const SizedBox(height: 12),

												// Nama Rekan Text Field
												_buildLabelText('Nama Rekan'),
												const SizedBox(height: 6),
												_buildStyledTextField(
													controller: fieldRekanNamaController,
													hintText: 'Masukkan nama rekan',
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
												const SizedBox(height: 20),
											],
										),

										// Display errors
										FormError(
											errors: errors,
											key: null,
										),
										const SizedBox(height: 20),

										// Close & Save buttons (optional)
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

	// Toggle edit / submit via icon
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
										onSaveForm(); // Submit when in edit mode
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

			final RekanGeneralModel record = RekanGeneralModel(
				mbentukcstId: fieldComboMBentukCst?.mbentukcstId,
				mbidangId: fieldComboMBidang?.mbidangId,
				mrekan1Id: '',
				mtipecstId: fieldComboMTipeCst?.mtipecustId, // <— Corrected property
				mtitleId: fieldComboMTitle?.mtitleId,
				rekanNama: fieldRekanNamaController.text,
			);

			if (widget.viewMode == "tambah") {
				rekanGeneralBloc.add(RekanGeneralTambahEvent(record: record));
			} else if (widget.viewMode == "ubah") {
				record.mrekan1Id = rekanGeneralBloc.state.record!.mrekan1Id;
				rekanGeneralBloc.add(RekanGeneralUbahEvent(record: record));
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
	// HELPERS: Build fields exactly as original (omit comboKey)
	// ================================================
	Widget buildFieldMbentukcstId() {
		return buildFieldComboMBentukCst(
			labelText: 'mbentukcstId',
			initItem: fieldComboMBentukCst,
			onChangedCallback: (value) {
				if (value != null) {
					removeError(error: "Field ComboMBentukCst tidak boleh kosong.");
					rekanGeneralBloc
							.add(ComboMBentukCstChangedEvent(comboMBentukCst: value));
				}
			},
			onSaveCallback: (value) {
				if (value != null) {
					fieldComboMBentukCst = value;
				}
			},
			validatorCallback: (value) {
				if (value == null) {
					addError(error: "Field ComboMBentukCst tidak boleh kosong.");
				}
			},
		);
	}

	Widget buildFieldMbidangId() {
		return buildFieldComboMBidang(
			labelText: 'mbidangId',
			initItem: fieldComboMBidang,
			onChangedCallback: (value) {
				if (value != null) {
					removeError(error: "Field ComboMBidang tidak boleh kosong.");
					rekanGeneralBloc
							.add(ComboMBidangChangedEvent(comboMBidang: value));
				}
			},
			onSaveCallback: (value) {
				if (value != null) {
					fieldComboMBidang = value;
				}
			},
			validatorCallback: (value) {
				if (value == null) {
					addError(error: "Field ComboMBidang tidak boleh kosong.");
				}
			},
		);
	}

	Widget buildFieldMtipecstId() {
		return buildFieldComboMTipeCst(
			labelText: 'mtipecstId',
			initItem: fieldComboMTipeCst,
			onChangedCallback: (value) {
				if (value != null) {
					removeError(error: "Field ComboMTipeCst tidak boleh kosong.");
					rekanGeneralBloc
							.add(ComboMTipeCstChangedEvent(comboMTipeCst: value));
				}
			},
			onSaveCallback: (value) {
				if (value != null) {
					fieldComboMTipeCst = value;
				}
			},
			validatorCallback: (value) {
				if (value == null) {
					addError(error: "Field ComboMTipeCst tidak boleh kosong.");
				}
			},
		);
	}

	Widget buildFieldMtitleId() {
		return buildFieldComboMTitle(
			labelText: 'mtitleId',
			initItem: fieldComboMTitle,
			onChangedCallback: (value) {
				if (value != null) {
					removeError(error: "Field ComboMTitle tidak boleh kosong.");
					rekanGeneralBloc.add(ComboMTitleChangedEvent(comboMTitle: value));
				}
			},
			onSaveCallback: (value) {
				if (value != null) {
					fieldComboMTitle = value;
				}
			},
			validatorCallback: (value) {
				if (value == null) {
					addError(error: "Field ComboMTitle tidak boleh kosong.");
				}
			},
		);
	}

	Widget buildFieldRekanNama() {
		return TextFormField(
			keyboardType: TextInputType.multiline,
			minLines: 1,
			maxLines: 3,
			controller: fieldRekanNamaController,
			decoration: const InputDecoration(
				labelText: "rekanNama",
				floatingLabelBehavior: FloatingLabelBehavior.always,
			),
			onChanged: (value) {
				if (value.isNotEmpty) {
					removeError(error: kStringNullError);
				}
			},
			validator: (value) {
				if (value == null || value.isEmpty) {
					addError(error: kStringNullError);
					return "";
				}
				return null;
			},
		);
	}
}
