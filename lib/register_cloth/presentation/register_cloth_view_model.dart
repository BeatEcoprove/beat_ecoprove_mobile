import 'dart:io';

import 'package:beat_ecoprove/auth/domain/errors/domain_exception.dart';
import 'package:beat_ecoprove/core/domain/entities/user.dart';
import 'package:beat_ecoprove/core/domain/models/brand_item.dart';
import 'package:beat_ecoprove/core/domain/models/color_item.dart';
import 'package:beat_ecoprove/core/domain/models/filter_row.dart';
import 'package:beat_ecoprove/core/helpers/form/form_field_values.dart';
import 'package:beat_ecoprove/core/helpers/form/form_view_model.dart';
import 'package:beat_ecoprove/core/providers/auth/authentication_provider.dart';
import 'package:beat_ecoprove/register_cloth/contracts/register_cloth_request.dart';
import 'package:beat_ecoprove/register_cloth/domain/use-cases/get_brands_use_case.dart';
import 'package:beat_ecoprove/register_cloth/domain/use-cases/get_colors_use_case.dart';
import 'package:beat_ecoprove/register_cloth/domain/use-cases/register_cloth_use_case.dart';
import 'package:beat_ecoprove/register_cloth/domain/value_objects/cloth_name.dart';
import 'package:beat_ecoprove/register_cloth/domain/value_objects/cloth_size.dart';
import 'package:beat_ecoprove/register_cloth/domain/value_objects/cloth_type.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class RegisterClothViewModel extends FormViewModel {
  static const defaultImage = "assets/default_avatar.png";
  final RegisterClothUseCase _registerClothUseCase;
  final GetColorsUseCase _getColorsUseCase;
  final GetBrandsUseCase _getBrandsUseCase;

  late final User _user;
  final AuthenticationProvider _authProvider;

  late Map<String, dynamic> _selectedFilter = {};

  RegisterClothViewModel(
    this._authProvider,
    this._registerClothUseCase,
    this._getColorsUseCase,
    this._getBrandsUseCase,
  ) {
    _user = _authProvider.appUser;
    initializeFields([
      FormFieldValues.clothName,
      FormFieldValues.clothType,
      FormFieldValues.clothSize,
      FormFieldValues.clothBrand,
      FormFieldValues.clothColor,
      FormFieldValues.clothImage,
    ]);
    setValue(FormFieldValues.clothType,
        ClothType.getAllTypes().firstOrNull?.displayValue);
    setValue(FormFieldValues.clothSize, ClothSize.getAllTypes().firstOrNull);
    //TODO: Change
    setValue(FormFieldValues.clothBrand, "Salsa");
    setValue(FormFieldValues.clothColor,
        _selectedFilter.keys.firstOrNull ?? "FF000000");
    setValue(FormFieldValues.clothImage, XFile(defaultImage));
  }

  User get user => _user;

  void setClothName(String clothName) {
    try {
      setValue<String>(
          FormFieldValues.clothName, ClothName.create(clothName).toString());
    } on DomainException catch (e) {
      setError(FormFieldValues.clothName, e.message);
    }
  }

  void getImageFromGallery() async {
    final picker = ImagePicker();
    XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setValue<XFile>(FormFieldValues.clothImage, pickedFile);
    }
  }

  ImageProvider getClothImage() {
    if (getValue<XFile>(FormFieldValues.clothImage).value!.path ==
        defaultImage) {
      return const AssetImage(defaultImage);
    }

    var clothImage = getValue<XFile>(FormFieldValues.clothImage).value as XFile;

    return FileImage(File(clothImage.path));
  }

  Future<List<String>> getAllBrands() async {
    List<BrandItem> brandResult = [];
    List<String> brands = [];

    try {
      brandResult = await _getBrandsUseCase.handle();
    } catch (e) {
      print("$e");
    }

    for (var brand in brandResult) {
      brands.add(brand.name);
    }

    return brands;
  }

  Future<List<FilterRow>> getAllColors() async {
    List<ColorItem> colors = [];
    List<FilterButtonItem> colorItems = [];

    try {
      colors = await _getColorsUseCase.handle();
    } catch (e) {
      print("$e");
    }

    for (var color in colors) {
      colorItems.add(FilterButtonItem(
        text: color.name,
        value: color.hex,
        backgroundColor: Color(
          int.parse(
            color.hex,
            radix: 16,
          ),
        ),
        dimension: 50,
        tag: "color",
      ));
    }

    return [FilterRow(options: colorItems, isCircular: true)];
  }

  bool haveThisFilter(String filter) => _selectedFilter.containsKey(filter);

  Map<String, dynamic> get allSelectedFilters => _selectedFilter;

  void changeFilterSelection(Map<String, dynamic> filters) {
    Map<String, String> colors = {};

    for (var (value as Map<String, String>) in filters.values) {
      colors.addAll(value);
    }

    _selectedFilter = colors;
    setValue(FormFieldValues.clothColor, _selectedFilter.keys.firstOrNull);

    notifyListeners();
  }

  void registerCloth() async {
    try {
      await _registerClothUseCase.handle(RegisterClothRequest(
        getValue(FormFieldValues.clothName).value ?? "",
        ClothType.getOf(getValue(FormFieldValues.clothType).value).value,
        getValue(FormFieldValues.clothSize).value ?? "",
        getValue(FormFieldValues.clothBrand).value ?? "",
        getValue(FormFieldValues.clothColor).value ?? "FF000000",
        getValue(FormFieldValues.clothImage).value ?? "",
      ));
    } catch (e) {
      print("$e");
    }

    // notifyListeners();
  }
}
