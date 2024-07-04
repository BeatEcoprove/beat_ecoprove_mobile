import 'dart:io';

import 'package:beat_ecoprove/auth/domain/errors/domain_exception.dart';
import 'package:beat_ecoprove/auth/domain/value_objects/postal_code.dart';
import 'package:beat_ecoprove/core/helpers/form/form_field_values.dart';
import 'package:beat_ecoprove/core/helpers/form/form_view_model.dart';
import 'package:beat_ecoprove/core/helpers/http/errors/http_error.dart';
import 'package:beat_ecoprove/core/helpers/navigation/navigation_manager.dart';
import 'package:beat_ecoprove/core/providers/notification_provider.dart';
import 'package:beat_ecoprove/core/providers/static_values_provider.dart';
import 'package:beat_ecoprove/service_provider/stores/contracts/register_store_request.dart';
import 'package:beat_ecoprove/service_provider/stores/domain/use-cases/register_store_use_case.dart';
import 'package:beat_ecoprove/service_provider/stores/domain/value_objects/store_number_port.dart';
import 'package:beat_ecoprove/service_provider/stores/domain/value_objects/store_street.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_picker/image_picker.dart';

class CreateStoreViewModel extends FormViewModel {
  final StaticValuesProvider _staticValuesProvider;
  final INotificationProvider _notificationProvider;
  static const defaultImage = "assets/default_avatar.png";
  final RegisterStoreUseCase _registerStoreUseCase;
  final INavigationManager _navigationRouter;

  final Map<String, List<String>> _countries = {};

  CreateStoreViewModel(
    this._staticValuesProvider,
    this._notificationProvider,
    this._registerStoreUseCase,
    this._navigationRouter,
  ) {
    initializeFields([
      FormFieldValues.groupPicture,
      FormFieldValues.name,
      FormFieldValues.storeCountry,
      FormFieldValues.storeLocality,
      FormFieldValues.storeStreet,
      FormFieldValues.storePostalCode,
      FormFieldValues.storeNumberPort,
    ]);
    setValue(FormFieldValues.groupPicture, XFile(defaultImage));
    _countries.addAll(_staticValuesProvider.countryParishes);
    setValue(FormFieldValues.storeCountry, _countries.keys.first);
    setValue(FormFieldValues.storeLocality, getLocalities().first);
  }

  List<String> get countries => _countries.keys.toList();

  List<String> getLocalities() {
    String chosenCountry = getValue(FormFieldValues.storeCountry).value!;

    if (chosenCountry.isNotEmpty) {
      return _countries[chosenCountry]!;
    }

    return _countries.values.first;
  }

  void setStoreName(String storeName) {
    try {
      setValue<String>(FormFieldValues.name, storeName);
    } on DomainException catch (e) {
      setError(FormFieldValues.name, e.message);
    }
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
        getValue(FormFieldValues.name).value ?? "",
        getValue(FormFieldValues.storeCountry).value ?? "",
        getValue(FormFieldValues.storeLocality).value ?? "",
        getValue(FormFieldValues.storeStreet).value ?? "",
        getValue(FormFieldValues.storePostalCode).value ?? "",
        getValue(FormFieldValues.storeNumberPort).value ?? "",
      ));

      await _staticValuesProvider.fetchAuthorizedValues();

      _navigationRouter.pop();

      _notificationProvider.showNotification(
        "Loja criado com sucesso!",
        type: NotificationTypes.success,
      );
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
