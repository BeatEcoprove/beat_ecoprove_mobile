import 'dart:io';

import 'package:beat_ecoprove/auth/domain/errors/domain_exception.dart';
import 'package:beat_ecoprove/core/helpers/form/form_field_values.dart';
import 'package:beat_ecoprove/core/helpers/form/form_view_model.dart';
import 'package:beat_ecoprove/core/helpers/http/errors/http_error.dart';
import 'package:beat_ecoprove/core/helpers/navigation/navigation_manager.dart';
import 'package:beat_ecoprove/core/locales/locale_context.dart';
import 'package:beat_ecoprove/core/providers/notification_provider.dart';
import 'package:beat_ecoprove/group/contracts/update_group_request.dart';
import 'package:beat_ecoprove/group/domain/use-cases/update_group_use_case.dart';
import 'package:beat_ecoprove/group/domain/value_objects/group_description.dart';
import 'package:beat_ecoprove/group/domain/value_objects/group_name.dart';
import 'package:beat_ecoprove/group/domain/value_objects/group_type.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditGroupViewModel extends FormViewModel {
  final INotificationProvider _notificationProvider;
  final UpdateGroupUseCase _updateGroupUseCase;
  final INavigationManager _navigationRouter;
  static const defaultImage = "assets/default_avatar.png";

  EditGroupViewModel(
    this._notificationProvider,
    this._updateGroupUseCase,
    this._navigationRouter,
  ) {
    initializeFields([
      FormFieldValues.groupName,
      FormFieldValues.groupDescription,
      FormFieldValues.groupPicture,
      FormFieldValues.groupIsPublic,
    ]);
    setValue(FormFieldValues.groupName, '');
    setValue(FormFieldValues.groupDescription, '');
    setValue(FormFieldValues.groupIsPublic, GroupType.public);
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

  Future updateGroup(String groupId) async {
    try {
      await _updateGroupUseCase.handle(UpdateGroupRequest(
        groupId,
        getValue(FormFieldValues.groupName).value ?? '',
        getValue(FormFieldValues.groupDescription).value ?? '',
        getValue(FormFieldValues.groupIsPublic).value ?? '',
        getValue(FormFieldValues.groupPicture).value ?? '',
      ));

      _notificationProvider.showNotification(
        LocaleContext.get().group_group_chat_edit_group_updated,
        type: NotificationTypes.success,
      );
      _navigationRouter.pop();
    } on HttpError catch (e) {
      _notificationProvider.showNotification(
        e.getError().title,
        type: NotificationTypes.error,
      );
    } catch (e) {
      print(e.toString());
    }
  }
}
