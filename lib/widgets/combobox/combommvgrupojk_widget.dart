import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:eassist_tools_app/models/combobox/combommvgrupojk_model.dart';
import 'package:eassist_tools_app/repositories/combobox/combommvgrupojk_repository.dart';

DropdownSearch<ComboMMvgrupOjkModel> buildFieldComboMMvgrupOjk({
	required String labelText,
	GlobalKey<DropdownSearchState<ComboMMvgrupOjkModel>>? comboKey,
	ComboMMvgrupOjkModel? initItem,
	Function(ComboMMvgrupOjkModel?)? onChangedCallback,
	required Function(ComboMMvgrupOjkModel?) onSaveCallback,
	Function(ComboMMvgrupOjkModel?)? validatorCallback
	}) {
	return DropdownSearch<ComboMMvgrupOjkModel>(
		key: comboKey,
		selectedItem: initItem,
		decoratorProps: DropDownDecoratorProps(
			decoration: InputDecoration(
				hintText: '...',
				labelText: labelText,
			),
		),
			items: (filter, infiniteScrollProps) async {
				return ComboMMvgrupOjkRepository().getComboMMvgrupOjk();
			},
			suffixProps: const DropdownSuffixProps(clearButtonProps: ClearButtonProps(isVisible: false)),
			popupProps: const PopupPropsMultiSelection.modalBottomSheet(
				disableFilter: false,
				showSelectedItems: true,
				showSearchBox: false,
				itemBuilder: itemBuilderComboMMvgrupOjk,
			),
			compareFn: (item, sItem) => item.mmvgrupojkId == sItem.mmvgrupojkId,
			itemAsString: (item) {
				return item.grupNama;
			},
			onChanged: (value) {
				if (onChangedCallback != null) {
					onChangedCallback(value);
				}
			},
			onSaved: (value) {
				onSaveCallback(value);
			},
			validator: (value) {
				if (validatorCallback != null) {
					validatorCallback(value);
					if (value == null) {
						return "";
					}
				}
				return null;
			},
		);
}

Widget itemBuilderComboMMvgrupOjk(
	BuildContext context, ComboMMvgrupOjkModel item, bool isSelected, bool isDisabled) {
	return Container(
		margin: const EdgeInsets.symmetric(horizontal: 8),
		decoration: !isSelected
			? null
			: BoxDecoration(
				border: Border.all(color: Theme.of(context).primaryColor),
				borderRadius: BorderRadius.circular(5),
				color: Colors.white,
			),
		child: ListTile(
			selected: isSelected,
			title: Text(item.grupNama),
		),
	);
}
