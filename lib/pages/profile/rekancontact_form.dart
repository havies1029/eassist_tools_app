import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:eassist_tools_app/common/constants.dart';
import 'package:eassist_tools_app/widgets/form_error.dart';
import 'package:eassist_tools_app/blocs/profile/rekancontact_bloc.dart';
import 'package:eassist_tools_app/models/profile/rekancontact_model.dart';
import 'package:eassist_tools_app/models/combobox/combomkota_model.dart';
import 'package:eassist_tools_app/widgets/combobox/combomkota_widget.dart';
import 'package:eassist_tools_app/models/combobox/combompropinsi_model.dart';
import 'package:eassist_tools_app/widgets/combobox/combompropinsi_widget.dart';
import 'package:eassist_tools_app/models/combobox/comborkodepos_model.dart';
import 'package:eassist_tools_app/widgets/combobox/comborkodepos_widget.dart';

class RekanContactFormPage extends StatefulWidget {
	final String viewMode;
	final String recordId;

	const RekanContactFormPage({
		Key? key,
		required this.viewMode,
		required this.recordId,
	}) : super(key: key);

	@override
	RekanContactFormPageFormState createState() =>
			RekanContactFormPageFormState();
}

class RekanContactFormPageFormState extends State<RekanContactFormPage> {
	late RekanContactBloc rekanContactBloc;
	final _formKey = GlobalKey<FormState>();
	final List<String> errors = [];

	// Controller untuk semua TextFormField
	final TextEditingController fieldAlamat1Controller = TextEditingController();
	final TextEditingController fieldEmailController = TextEditingController();
	final TextEditingController fieldMrekan1IdController =
	TextEditingController();
	final TextEditingController fieldTelpController = TextEditingController();

	// Model untuk dropdown
	ComboMKotaModel? fieldComboMKota;
	ComboMPropinsiModel? fieldComboMPropinsi;
	ComboRKodeposModel? fieldComboRKodepos;

	// Flag apakah dalam mode edit?
	bool isEditingSection = false;

	@override
	void initState() {
		super.initState();
		// Delay kecil untuk memastikan BlocProvider sudah ter‐set up
		Future.delayed(const Duration(milliseconds: 500), () {
			loadData();
		});
	}

	@override
	void dispose() {
		fieldAlamat1Controller.dispose();
		fieldEmailController.dispose();
		fieldMrekan1IdController.dispose();
		fieldTelpController.dispose();
		super.dispose();
	}

	void loadData() {
		if (widget.viewMode == "ubah") {
			rekanContactBloc.add(
				RekanContactLihatEvent(recordId: widget.recordId),
			);
		}
	}

	@override
	Widget build(BuildContext context) {
		rekanContactBloc = BlocProvider.of<RekanContactBloc>(context);

		return BlocConsumer<RekanContactBloc, RekanContactState>(
			listener: (context, state) {
				if (state.isLoaded) {
					setState(() {
						if (state.record != null) {
							fieldAlamat1Controller.text = state.record!.alamat1;
							fieldEmailController.text = state.record!.email;
							fieldMrekan1IdController.text = state.record!.mrekan1Id;
							fieldTelpController.text = state.record!.telp;
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

										// Judul Form
										Text(
											"${widget.viewMode == "tambah" ? "Tambah" : "Ubah"} Kontak Perusahaan",
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

										// Container berpagar untuk semua field + tombol edit/check
										_buildSectionContainer(
											title: 'Kontak Perusahaan',
											children: [
												// Field Alamat
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

												// Field Email
												_buildLabelText('Email'),
												const SizedBox(height: 6),
												_buildStyledTextField(
													controller: fieldEmailController,
													hintText: 'contoh@mail.com',
													keyboardType: TextInputType.emailAddress,
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

												// Dropdown Provinsi
												_buildLabelText('Provinsi'),
												const SizedBox(height: 6),
												_buildStyledDropdown(
													child: buildFieldMpropinsiId(),
												),
												const SizedBox(height: 12),

												// Dropdown Kota
												_buildLabelText('Kota'),
												const SizedBox(height: 6),
												_buildStyledDropdown(
													child: buildFieldMkotaId(),
												),
												const SizedBox(height: 12),

												// Dropdown Kode Pos
												_buildLabelText('Kode Pos'),
												const SizedBox(height: 6),
												_buildStyledDropdown(
													child: buildFieldRkodeposId(),
												),
												const SizedBox(height: 12),

												// Field ID Rekan
												_buildLabelText('ID Rekan'),
												const SizedBox(height: 6),
												_buildStyledTextField(
													controller: fieldMrekan1IdController,
													hintText: 'Masukkan ID Rekan',
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

												// Field Telepon
												_buildLabelText('No. HP'),
												const SizedBox(height: 6),
												_buildStyledTextField(
													controller: fieldTelpController,
													hintText: '08xxxxxxxxxx',
													keyboardType: TextInputType.phone,
													inputFormatters: [FilteringTextInputFormatter.digitsOnly],
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

										// Daftar error jika ada
										FormError(
											errors: errors,
											key: null,
										),

										const SizedBox(height: 20),

										// Tombol Close & Save (opsional, tetap bisa dipakai)
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

	// Toggle edit / view
	void toggleEditSection() {
		setState(() {
			isEditingSection = !isEditingSection;
		});
	}

	// Container berpagar (border + radius) + judul + tombol edit/check
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
					// Judul + IconButton edit/check
					Row(
						children: [
							Expanded(
								child: Text(
									title,
									style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
								),
							),
							IconButton(
								icon: Icon(isEditingSection ? Icons.check : Icons.edit),
								onPressed: () {
									if (isEditingSection) {
										// Jika sudah dalam mode edit, klik centang => submit form
										onSaveForm();
									} else {
										// Jika belum edit, klik pensil => masuk mode edit
										toggleEditSection();
									}
								},
							),
						],
					),
					const SizedBox(height: 12),

					// Setiap child (field) dibungkus AbsorbPointer agar read‐only jika !isEditingSection
					for (var w in children)
						AbsorbPointer(
							absorbing: !isEditingSection,
							child: w,
						),
				],
			),
		);
	}

	// Label di atas TextFormField
	Widget _buildLabelText(String text) {
		return Text(
			text,
			style: const TextStyle(fontWeight: FontWeight.w600),
		);
	}

	// TextFormField style OutlineInputBorder radius 8, padding 12×10
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
				contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
			),
			validator: validator,
			onChanged: onChanged,
		);
	}

	// Wrapper agar dropdown terlihat seperti TextField (Outline + padding)
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

	// Tutup dialog
	void _dismissDialog() {
		Navigator.pop(context);
	}

	// Submit form: validasi + kirim event Bloc
	void onSaveForm() {
		if (_formKey.currentState!.validate()) {
			_formKey.currentState!.save();

			final RekanContactModel record = RekanContactModel(
				alamat1: fieldAlamat1Controller.text,
				email: fieldEmailController.text,
				mkotaId: fieldComboMKota?.mkotaId,
				mpropinsiId: fieldComboMPropinsi?.mpropinsiId,
				mrekan1Id: fieldMrekan1IdController.text,
				mrekancontact1Id: '',
				rkodeposId: fieldComboRKodepos?.rkodeposId,
				telp: fieldTelpController.text,
			);

			if (widget.viewMode == "tambah") {
				rekanContactBloc.add(RekanContactTambahEvent(record: record));
			} else if (widget.viewMode == "ubah") {
				record.mrekancontact1Id =
						rekanContactBloc.state.record!.mrekancontact1Id;
				rekanContactBloc.add(RekanContactUbahEvent(record: record));
			}

			// Setelah submit, langsung tutup dialog
			_dismissDialog();
		}
	}

	// Tambah pesan error jika belum ada
	void addError({required String error}) {
		if (!errors.contains(error)) {
			setState(() {
				errors.add(error);
			});
		}
	}

	// Hapus pesan error jika ada
	void removeError({required String error}) {
		if (errors.contains(error)) {
			setState(() {
				errors.remove(error);
			});
		}
	}

	// ================================================
	// HELPER BUILD FIELD ASLI (COPY PASTE DARI KODE AWAL)
	// ================================================
	//
	// Semua helper dropdown dan TextFormField Anda tetap sama persis:
	// buildFieldAlamat1(), buildFieldEmail(), buildFieldMkotaId(), dll.
	//

	Widget buildFieldAlamat1() {
		return TextFormField(
			keyboardType: TextInputType.multiline,
			minLines: 1,
			maxLines: 3,
			controller: fieldAlamat1Controller,
			decoration: const InputDecoration(
				labelText: "alamat1",
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

	Widget buildFieldEmail() {
		return TextFormField(
			keyboardType: TextInputType.multiline,
			minLines: 1,
			maxLines: 3,
			controller: fieldEmailController,
			decoration: const InputDecoration(
				labelText: "email",
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

	Widget buildFieldMkotaId() {
		return buildFieldComboMKota(
			labelText: 'mkotaId',
			initItem: fieldComboMKota,
			onChangedCallback: (value) {
				if (value != null) {
					removeError(
						error: "Field ComboMKota tidak boleh kosong.",
					);
					rekanContactBloc.add(ComboMKotaChangedEvent(comboMKota: value));
				}
			},
			onSaveCallback: (value) {
				if (value != null) {
					fieldComboMKota = value;
				}
			},
			validatorCallback: (value) {
				if (value == null) {
					addError(
						error: "Field ComboMKota tidak boleh kosong.",
					);
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
					removeError(
						error: "Field ComboMPropinsi tidak boleh kosong.",
					);
					rekanContactBloc
							.add(ComboMPropinsiChangedEvent(comboMPropinsi: value));
				}
			},
			onSaveCallback: (value) {
				if (value != null) {
					fieldComboMPropinsi = value;
				}
			},
			validatorCallback: (value) {
				if (value == null) {
					addError(
						error: "Field ComboMPropinsi tidak boleh kosong.",
					);
				}
			},
		);
	}

	Widget buildFieldMrekan1Id() {
		return TextFormField(
			controller: fieldMrekan1IdController,
			decoration: const InputDecoration(
				labelText: "mrekan1Id",
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

	Widget buildFieldRkodeposId() {
		return buildFieldComboRKodepos(
			labelText: 'rkodeposId',
			initItem: fieldComboRKodepos,
			onChangedCallback: (value) {
				if (value != null) {
					removeError(
						error: "Field ComboRKodepos tidak boleh kosong.",
					);
					rekanContactBloc.add(ComboRKodeposChangedEvent(comboRKodepos: value));
				}
			},
			onSaveCallback: (value) {
				if (value != null) {
					fieldComboRKodepos = value;
				}
			},
			validatorCallback: (value) {
				if (value == null) {
					addError(
						error: "Field ComboRKodepos tidak boleh kosong.",
					);
				}
			},
		);
	}

	Widget buildFieldTelp() {
		return TextFormField(
			keyboardType: TextInputType.multiline,
			minLines: 1,
			maxLines: 3,
			controller: fieldTelpController,
			decoration: const InputDecoration(
				labelText: "telp",
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
