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

  final AuthenticationProvider _authProvider;
  late final User _user;
  final String _color =
      '#FFF'; //TODO: Change (make a widget identical to the filter)

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
    setValue(FormFieldValues.clothColor, _color);
    setValue(
      FormFieldValues.clothImage,
      XFile(defaultImage),
    );
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

  void registerCloth() async {
    var clothName = getValue(FormFieldValues.clothName).value ?? "";
    var clothType = getValue(FormFieldValues.clothType).value ?? "";
    var clothSize = getValue(FormFieldValues.clothSize).value ?? "";
    var clothBrand = getValue(FormFieldValues.clothBrand).value ?? "";
    var clothColor = getValue(FormFieldValues.clothColor).value ?? "";
    var clothImage = getValue(FormFieldValues.clothImage).value ?? "";

    try {
      await _registerClothUseCase.handle(RegisterClothRequest(
        "e7bd7043-48d1-4c42-b5f3-ad7b1b586e5e",
        clothName,
        clothType,
        clothSize,
        clothBrand,
        clothColor,
        clothImage,
      )); //TODO: Change
    } catch (e) {
      print("$e");
    }

    notifyListeners();
  }
}
