import 'package:flutter/material.dart';

class DialogBtnModel {
  String btnText;
  String? argTabFunction;
  Function(String)? onTapFunction;

  DialogBtnModel(
      {required this.btnText, this.argTabFunction, this.onTapFunction});

  factory DialogBtnModel.fromJson(Map<String, dynamic> data) {
    return DialogBtnModel(
        btnText: data['btnText'] ?? '',
        argTabFunction: data['argTabFunction'],
        onTapFunction: data['onTapFunction']);
  }

  Map<String, dynamic> toJson() => {
        'btnText': btnText,
        'argTabFunction': argTabFunction,
        'onTapFunction': onTapFunction.toString()
      };
}

class ShowDialogWidget extends StatefulWidget {
  final String dialogTitle;
  final String dialogMessage;
  final List<DialogBtnModel> listBtn;

  const ShowDialogWidget({super.key, required this.listBtn, required this.dialogTitle, required this.dialogMessage});

  @override
  ShowDialogWidgetState createState() => ShowDialogWidgetState();
}

class ShowDialogWidgetState extends State<ShowDialogWidget> {

  @override
  Widget build(BuildContext context) {
    List<Widget> listBtn = genListBtn();
    AlertDialog alert = AlertDialog(
      title: Text(widget.dialogTitle),
      content: Text(widget.dialogMessage),
      actions: <Widget>[...listBtn],
    );

    return alert;
  }

  List<Widget> genListBtn() {
    List<Widget> listBtn = [];
    for (DialogBtnModel btn in widget.listBtn) {
      listBtn.add(TextButton(
          onPressed: () {
            if (btn.onTapFunction != null) {
              btn.onTapFunction!(btn.argTabFunction!);
            }            
            Navigator.pop(context, btn.btnText);
          },
          child: Text(btn.btnText)));
    }

    return listBtn;
  }
}
