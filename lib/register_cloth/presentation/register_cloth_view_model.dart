import 'dart:io';

import 'package:beat_ecoprove/auth/domain/errors/domain_exception.dart';
import 'package:beat_ecoprove/core/domain/entities/user.dart';
import 'package:beat_ecoprove/core/helpers/form/form_field_values.dart';
import 'package:beat_ecoprove/core/helpers/form/form_view_model.dart';
import 'package:beat_ecoprove/core/providers/auth/authentication_provider.dart';
import 'package:beat_ecoprove/register_cloth/contracts/register_cloth_request.dart';
import 'package:beat_ecoprove/register_cloth/domain/use-cases/register_cloth_use_case.dart';
import 'package:beat_ecoprove/register_cloth/domain/value_objects/cloth_brand.dart';
import 'package:beat_ecoprove/register_cloth/domain/value_objects/cloth_name.dart';
import 'package:beat_ecoprove/register_cloth/domain/value_objects/cloth_size.dart';
import 'package:beat_ecoprove/register_cloth/domain/value_objects/cloth_type.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class RegisterClothViewModel extends FormViewModel {
  static const defaultImage = "assets/default_avatar.png";
  final RegisterClothUseCase _registerClothUseCase;

  late final User _user;
  final AuthenticationProvider _authProvider;

  late Map<String, dynamic> _selectedFilter = {};

  RegisterClothViewModel(
    this._authProvider,
    this._registerClothUseCase,
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
    setValue(FormFieldValues.clothType, ClothType.getAllTypes().firstOrNull);
    setValue(FormFieldValues.clothSize, ClothSize.getAllTypes().firstOrNull);
    setValue(FormFieldValues.clothBrand, ClothBrand.getAllTypes().firstOrNull);
    setValue(FormFieldValues.clothColor,
        _selectedFilter.values.firstOrNull ?? "FF000000");
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

  bool haveThisFilter(String filter) => _selectedFilter.containsKey(filter);

  Map<String, dynamic> get allSelectedFilters => _selectedFilter;

  void changeFilterSelection(Map<String, dynamic> filters) {
    _selectedFilter = filters;
    setValue(FormFieldValues.clothColor, _selectedFilter.values.firstOrNull);

    notifyListeners();
  }

  void registerCloth() async {
    try {
      await _registerClothUseCase.handle(RegisterClothRequest(
        "ffae08fb-5777-4f56-a938-34b23c80a2c3",
        getValue(FormFieldValues.clothName).value ?? "",
        getValue(FormFieldValues.clothType).value ?? "",
        getValue(FormFieldValues.clothSize).value ?? "",
        getValue(FormFieldValues.clothBrand).value ?? "",
        getValue(FormFieldValues.clothColor).value ?? "FF000000",
        getValue(FormFieldValues.clothImage).value ?? "",
      )); //TODO: Change Person Id
    } catch (e) {
      print("$e");
    }

    notifyListeners();
  }
}
