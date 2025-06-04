import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eassist_tools_app/common/constants.dart';
import 'package:eassist_tools_app/widgets/form_error.dart';
import 'package:eassist_tools_app/blocs/chatting/messagescrud_bloc.dart';
import 'package:eassist_tools_app/models/chatting/messagescrud_model.dart';
import 'package:intl/intl.dart';
import 'package:eassist_tools_app/common/thousand_separator_input_formatter.dart';
import 'package:date_field/date_field.dart';


class MessagesCrudFormPage extends StatefulWidget {
	final String viewMode;
	final String recordId;

	const MessagesCrudFormPage({super.key, required this.viewMode, required this.recordId});

	@override
	MessagesCrudFormPageFormState createState() => MessagesCrudFormPageFormState();
}

class MessagesCrudFormPageFormState extends State<MessagesCrudFormPage> {
	late MessagesCrudBloc messagesCrudBloc;
	final _formKey = GlobalKey<FormState>();
	final List<String> errors = [];
	var fieldContentController = TextEditingController();
	var fieldCreatedAtController = TextEditingController(text: DateTime.now().toIso8601String());
	var fieldMessageTypeController = TextEditingController();
	var fieldSenderTypeController = TextEditingController();

	@override
	void initState() {
		super.initState();
		Future.delayed(const Duration(milliseconds: 500), () {
			loadData();
		});
	}

	@override
	Widget build(BuildContext context) {
		messagesCrudBloc = BlocProvider.of<MessagesCrudBloc>(context);
		return BlocConsumer<MessagesCrudBloc, MessagesCrudState>(
			builder: (context, state) {
				return Dialog(
					shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
					child: SingleChildScrollView(
						child: Padding(
							padding: const EdgeInsets.all(8.0),
							child: Form(
								key: _formKey,
								child: Column(
									children: [
										const SizedBox(height: 10),
										Text(
											"${widget.viewMode == "tambah" ? "Tambah" : "Ubah"} Chatting",
											style: const TextStyle(
												fontSize: 20.0,
												color: Color(0xffff6101),
												fontWeight: FontWeight.w600,
												fontFamily: 'Hind',
												fontStyle: FontStyle.italic,
												decoration: TextDecoration.underline,
											),
										),
										const SizedBox(height: 25),
										buildFieldChatbotResponseId(),
										buildFieldContent(),
										buildFieldCreatedAt(),
										buildFieldGuestId(),
										buildFieldMessageType(),
										buildFieldSenderId(),
										buildFieldSenderType(),
										buildFieldTicketId(),
										const SizedBox(height: 25),
										FormError(
											errors: errors,
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
																_dismissDialog();
															},
															child: const Text(
																'Close',
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
																onSaveForm();
															},
															child: const Text(
																'Save',
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
					));
				},
				listener: (context, state) {
					if (state.isLoaded) {
						if (state.record != null){
							fieldContentController.text = state.record!.content;
							fieldCreatedAtController.text = state.record!.createdAt.toIso8601String();
							fieldMessageTypeController.text = state.record!.messageType;
							fieldSenderTypeController.text = state.record!.senderType;
						}
					}
				},
			);
		}
	void loadData() {
		if (widget.viewMode == "ubah") {
		messagesCrudBloc.add(
			MessagesCrudLihatEvent(recordId: widget.recordId));
		}
	}

	Widget buildFieldChatbotResponseId(){
		return TextFormField(
			keyboardType: TextInputType.number,
			inputFormatters: [ThousandsSeparatorInputFormatter()],
		);
	}

	Widget buildFieldContent(){
		return TextFormField(
			controller: fieldContentController,
			decoration: const InputDecoration(
				labelText: "content",
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

	Widget buildFieldCreatedAt(){
		return DateTimeFormField(
			mode: DateTimeFieldPickerMode.date,
			dateFormat: DateFormat('dd/MM/yyyy'),
			initialValue: DateTime.tryParse(fieldCreatedAtController.text),
			decoration: const InputDecoration(
				labelText: "createdAt",
				floatingLabelBehavior: FloatingLabelBehavior.always,
			),
			onChanged: (value) {
				if (value != null) {
				removeError(error: kStringNullError);
					fieldCreatedAtController.text = value.toIso8601String();
				}
			},
			validator: (value) {
				if (value == null) {
					addError(error: kStringNullError);
					return "";
				}
				return null;
			},
		);
	}

	Widget buildFieldGuestId(){
		return TextFormField(
		);
	}

	Widget buildFieldMessageType(){
		return TextFormField(
			controller: fieldMessageTypeController,
			decoration: const InputDecoration(
				labelText: "messageType",
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

	Widget buildFieldSenderId(){
		return TextFormField(
		);
	}

	Widget buildFieldSenderType(){
		return TextFormField(
			controller: fieldSenderTypeController,
			decoration: const InputDecoration(
				labelText: "senderType",
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

	Widget buildFieldTicketId(){
		return TextFormField(
		);
	}

	void _dismissDialog() {
		Navigator.pop(context);
	}

	void onSaveForm() {
		if (_formKey.currentState!.validate()) {
			_formKey.currentState!.save();
			MessagesCrudModel record = MessagesCrudModel(
				content: fieldContentController.text,
				createdAt: DateTime.parse(fieldCreatedAtController.text),
				id: '',
				messageType: fieldMessageTypeController.text,
				senderType: fieldSenderTypeController.text,
			);
			if (widget.viewMode == "tambah") {
				messagesCrudBloc.add(MessagesCrudTambahEvent(record: record));
			} else if (widget.viewMode == "ubah") {
				record.id = messagesCrudBloc.state.record!.id;
				messagesCrudBloc.add(MessagesCrudUbahEvent(record: record));
			}
			_dismissDialog();
		}
	}

	void addError({required String error}) {
		if (!errors.contains(error)){
			setState(() {
				errors.add(error);
			});
		}
	}

	void removeError({required String error}) {
		if (errors.contains(error)){
			setState(() {
				errors.remove(error);
			});
		}
	}

}
