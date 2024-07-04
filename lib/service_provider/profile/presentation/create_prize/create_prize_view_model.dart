import 'dart:io';

import 'package:beat_ecoprove/auth/domain/errors/domain_exception.dart';
import 'package:beat_ecoprove/core/helpers/form/form_field_values.dart';
import 'package:beat_ecoprove/core/helpers/form/form_view_model.dart';
import 'package:beat_ecoprove/core/helpers/http/errors/http_error.dart';
import 'package:beat_ecoprove/core/helpers/navigation/navigation_manager.dart';
import 'package:beat_ecoprove/core/providers/notification_provider.dart';
import 'package:beat_ecoprove/service_provider/profile/contracts/register_advert_request.dart';
import 'package:beat_ecoprove/service_provider/profile/domain/use-cases/register_prize_use_case.dart';
import 'package:beat_ecoprove/service_provider/profile/domain/value_objects/description.dart';
import 'package:beat_ecoprove/service_provider/profile/domain/value_objects/title.dart';
import 'package:beat_ecoprove/service_provider/profile/presentation/create_prize/create_prize_params.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_picker/image_picker.dart';

class CreatePrizeViewModel extends FormViewModel<CreatePrizeParams> {
  final INotificationProvider _notificationProvider;

  static const defaultImage = "assets/default_avatar.png";
  final RegisterAdvertUseCase _registerAdvertUseCase;
  final INavigationManager _navigationRouter;

  CreatePrizeViewModel(
    this._notificationProvider,
    this._registerAdvertUseCase,
    this._navigationRouter,
  ) {
    initializeFields([
      FormFieldValues.title,
      FormFieldValues.description,
      FormFieldValues.beginAt,
      FormFieldValues.endAt,
      FormFieldValues.picture,
      FormFieldValues.quantityItem,
    ]);

    setValue(FormFieldValues.quantityItem, '0');
    setValue(FormFieldValues.beginAt, DateTime.now());
    setValue(
        FormFieldValues.endAt, DateTime.now().add(const Duration(days: 1)));
    setValue(FormFieldValues.picture, XFile(defaultImage));
  }

  void setTitle(String title) {
    try {
      setValue<String>(
          FormFieldValues.title, TitleInput.create(title).toString());
    } on DomainException catch (e) {
      setError(FormFieldValues.title, e.message);
    }
  }

  void setDescription(String description) {
    try {
      setValue<String>(FormFieldValues.description,
          DescriptionInput.create(description).toString());
    } on DomainException catch (e) {
      setError(FormFieldValues.description, e.message);
    }
  }

  void setBeginDate(DateTime date) {
    setValue(FormFieldValues.beginAt, date);
  }

  void setEndDate(DateTime date) {
    setValue(FormFieldValues.endAt, date);
  }

  void setQuantityItem(String quantity) {
    setValue(FormFieldValues.quantityItem, quantity);
  }

  void getImageFromGallery() async {
    final picker = ImagePicker();
    XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setValue<XFile>(FormFieldValues.picture, pickedFile);
    }
  }

  ImageProvider getPicture() {
    if (getValue<XFile>(FormFieldValues.picture).value!.path == defaultImage) {
      return const AssetImage(defaultImage);
    }

    var image = getValue<XFile>(FormFieldValues.picture).value as XFile;

    return FileImage(File(image.path));
  }

  Future registerAdvert() async {
    try {
      RegisterAdvertRequest request;

      switch (arg!.type) {
        case "voucher":
          request = RegisterAdvertVoucherRequest(
            getValue(FormFieldValues.title).value ?? "",
            getValue(FormFieldValues.description).value ?? "",
            getValue(FormFieldValues.beginAt).value ?? "",
            getValue(FormFieldValues.endAt).value ?? "",
            getValue(FormFieldValues.picture).value ?? "",
            arg!.type,
            int.parse(getValue(FormFieldValues.quantityItem).value),
          );
          break;
        default:
          request = RegisterAdvertRequest(
            getValue(FormFieldValues.title).value ?? "",
            getValue(FormFieldValues.description).value ?? "",
            getValue(FormFieldValues.beginAt).value ?? "",
            getValue(FormFieldValues.endAt).value ?? "",
            getValue(FormFieldValues.picture).value ?? "",
            arg!.type,
          );
      }

      await _registerAdvertUseCase.handle(request);

      _notificationProvider.showNotification(
        "Prémio criado com sucesso!",
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
