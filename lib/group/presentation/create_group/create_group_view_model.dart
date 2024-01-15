import 'dart:io';

import 'package:beat_ecoprove/auth/domain/errors/domain_exception.dart';
import 'package:beat_ecoprove/core/helpers/form/form_field_values.dart';
import 'package:beat_ecoprove/core/helpers/form/form_view_model.dart';
import 'package:beat_ecoprove/group/contracts/register_group_request.dart';
import 'package:beat_ecoprove/group/domain/use-cases/register_group_use_case.dart';
import 'package:beat_ecoprove/group/domain/value_objects/group_description.dart';
import 'package:beat_ecoprove/group/domain/value_objects/group_name.dart';
import 'package:flutter/rendering.dart';
import 'package:image_picker/image_picker.dart';

class CreateGroupViewModel extends FormViewModel {
  static const defaultImage = "assets/default_avatar.png";
  final RegisterGroupUseCase _registerGroupUseCase;

  CreateGroupViewModel(
    this._registerGroupUseCase,
  ) {
    initializeFields([
      FormFieldValues.groupName,
      FormFieldValues.groupDescription,
      FormFieldValues.groupIsPublic,
      FormFieldValues.groupPicture,
    ]);
    setValue(FormFieldValues.groupName, "");
    setValue(FormFieldValues.groupDescription, "");
    setValue(FormFieldValues.groupPicture, XFile(defaultImage));
  }

  void setGroupName(String groupName) {
    try {
      setValue<String>(
          FormFieldValues.groupName, GroupName.create(groupName).toString());
    } on DomainException catch (e) {
      setError(FormFieldValues.groupName, e.message);
    }
  }

  void setGroupDescription(String groupDescription) {
    try {
      setValue<String>(FormFieldValues.groupDescription,
          GroupDescription.create(groupDescription).toString());
    } on DomainException catch (e) {
      setError(FormFieldValues.groupDescription, e.message);
    }
  }

  void getImageFromGallery() async {
    final picker = ImagePicker();
    XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setValue<XFile>(FormFieldValues.groupPicture, pickedFile);
    }
  }

  ImageProvider getGroupPicture() {
    if (getValue<XFile>(FormFieldValues.groupPicture).value!.path ==
        defaultImage) {
      return const AssetImage(defaultImage);
    }

    var groupImage =
        getValue<XFile>(FormFieldValues.groupPicture).value as XFile;

    return FileImage(File(groupImage.path));
  }

  void registerGroup() async {
    try {
      await _registerGroupUseCase.handle(RegisterGroupRequest(
        getValue(FormFieldValues.groupName).value ?? "",
        getValue(FormFieldValues.groupDescription).value ?? "",
        getValue(FormFieldValues.groupIsPublic).value ?? "",
        getValue(FormFieldValues.groupPicture).value ?? "",
      ));
    } catch (e) {
      print("$e");
    }

    notifyListeners();
  }
}
