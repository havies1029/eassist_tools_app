import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:eassist_tools_app/models/combobox/combomwilayah_model.dart';
import 'package:eassist_tools_app/repositories/combobox/combomwilayah_repository.dart';

DropdownSearch<ComboMWilayahModel> buildFieldComboMWilayah({
	required String labelText,
	GlobalKey<DropdownSearchState<ComboMWilayahModel>>? comboKey,
	ComboMWilayahModel? initItem,
	Function(ComboMWilayahModel?)? onChangedCallback,
	required Function(ComboMWilayahModel?) onSaveCallback,
	Function(ComboMWilayahModel?)? validatorCallback
	}) {
	return DropdownSearch<ComboMWilayahModel>(
		key: comboKey,
		selectedItem: initItem,
		decoratorProps: DropDownDecoratorProps(
			decoration: InputDecoration(
				hintText: '...',
				labelText: labelText,
			),
		),
			items: (filter, infiniteScrollProps) async {
				return ComboMWilayahRepository().getComboMWilayah();
			},
			suffixProps: const DropdownSuffixProps(clearButtonProps: ClearButtonProps(isVisible: true)),
			popupProps: const PopupPropsMultiSelection.modalBottomSheet(
				disableFilter: false,
				showSelectedItems: true,
				showSearchBox: false,
				itemBuilder: itemBuilderComboMWilayah,
			),
			compareFn: (item, sItem) => item.mwilayahId == sItem.mwilayahId,
			itemAsString: (item) {
				return item.wilayahNama;
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

Widget itemBuilderComboMWilayah(
	BuildContext context, ComboMWilayahModel item, bool isSelected, bool isDisabled) {
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
			title: Text(item.wilayahNama),
		),
	);
}
