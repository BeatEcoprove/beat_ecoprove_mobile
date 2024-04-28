import 'dart:io';

import 'package:beat_ecoprove/auth/domain/errors/domain_exception.dart';
import 'package:beat_ecoprove/auth/domain/value_objects/postal_code.dart';
import 'package:beat_ecoprove/core/helpers/form/form_field_values.dart';
import 'package:beat_ecoprove/core/helpers/form/form_view_model.dart';
import 'package:beat_ecoprove/core/helpers/http/errors/http_badrequest_error.dart';
import 'package:beat_ecoprove/core/helpers/navigation/navigation_manager.dart';
import 'package:beat_ecoprove/core/providers/notification_provider.dart';
import 'package:beat_ecoprove/service_provider/stores/contracts/register_store_request.dart';
import 'package:beat_ecoprove/service_provider/stores/domain/use-cases/register_store_use_case.dart';
import 'package:beat_ecoprove/service_provider/stores/domain/value_objects/store_number_port.dart';
import 'package:beat_ecoprove/service_provider/stores/domain/value_objects/store_street.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_picker/image_picker.dart';

class CreateStoreViewModel extends FormViewModel {
  final INotificationProvider _notificationProvider;
  static const defaultImage = "assets/default_avatar.png";
  final RegisterStoreUseCase _registerStoreUseCase;
  final INavigationManager _navigationRouter;

  CreateStoreViewModel(
    this._notificationProvider,
    this._registerStoreUseCase,
    this._navigationRouter,
  ) {
    initializeFields([
      FormFieldValues.groupPicture,
      FormFieldValues.storeCountry,
      FormFieldValues.storeLocality,
      FormFieldValues.storeStreet,
      FormFieldValues.storePostalCode,
      FormFieldValues.storeNumberPort,
    ]);
    setValue(FormFieldValues.groupPicture, XFile(defaultImage));
    //TODO: CHANGE
    setValue(FormFieldValues.storeCountry, "Portugal");
    setValue(FormFieldValues.storeLocality, "Lisboa");
  }

  void setStoreStreet(String storeStreet) {
    try {
      setValue<String>(FormFieldValues.storeStreet,
          StoreStreet.create(storeStreet).toString());
    } on DomainException catch (e) {
      setError(FormFieldValues.storeStreet, e.message);
    }
  }

  void setStorePostalCode(String storePostalCode) {
    try {
      setValue<String>(FormFieldValues.storePostalCode,
          PostalCode.create(storePostalCode).toString());
    } on DomainException catch (e) {
      setError(FormFieldValues.storePostalCode, e.message);
    }
  }

  void setStoreNumberPort(String storeNumberPort) {
    try {
      setValue<String>(FormFieldValues.storeNumberPort,
          StoreNumberPort.create(storeNumberPort).toString());
    } on DomainException catch (e) {
      setError(FormFieldValues.storeNumberPort, e.message);
    }
  }

  void getImageFromGallery() async {
    final picker = ImagePicker();
    XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setValue<XFile>(FormFieldValues.groupPicture, pickedFile);
    }
  }

  ImageProvider getStorePicture() {
    if (getValue<XFile>(FormFieldValues.groupPicture).value!.path ==
        defaultImage) {
      return const AssetImage(defaultImage);
    }

    var groupImage =
        getValue<XFile>(FormFieldValues.groupPicture).value as XFile;

    return FileImage(File(groupImage.path));
  }

  Future registerStore() async {
    try {
      await _registerStoreUseCase.handle(RegisterStoreRequest(
        getValue(FormFieldValues.groupPicture).value ?? "",
        getValue(FormFieldValues.storeCountry).value ?? "",
        getValue(FormFieldValues.storeLocality).value ?? "",
        getValue(FormFieldValues.storeStreet).value ?? "",
        getValue(FormFieldValues.storePostalCode).value ?? "",
        getValue(FormFieldValues.storeNumberPort).value ?? "",
      ));

      _navigationRouter.pop();

      _notificationProvider.showNotification(
        "Loja criado com sucesso!",
        type: NotificationTypes.success,
      );
    } on HttpBadRequestError catch (e) {
      _notificationProvider.showNotification(
        e.getError().title,
        type: NotificationTypes.error,
      );
    } catch (e) {
      print("$e");

      _notificationProvider.showNotification(
        e.toString(),
        type: NotificationTypes.error,
      );
    }
  }
}
