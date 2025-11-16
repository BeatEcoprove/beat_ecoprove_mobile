import 'dart:io';

import 'package:beat_ecoprove/auth/domain/errors/domain_exception.dart';
import 'package:beat_ecoprove/client/clothing/contracts/register_brand_request.dart';
import 'package:beat_ecoprove/client/clothing/domain/use-cases/register_brand_use_case.dart';
import 'package:beat_ecoprove/client/clothing/routes.dart';
import 'package:beat_ecoprove/core/helpers/form/form_field_values.dart';
import 'package:beat_ecoprove/core/helpers/form/form_view_model.dart';
import 'package:beat_ecoprove/core/helpers/http/errors/http_error.dart';
import 'package:beat_ecoprove/core/helpers/navigation/navigation_manager.dart';
import 'package:beat_ecoprove/core/locales/locale_context.dart';
import 'package:beat_ecoprove/core/providers/notification_provider.dart';
import 'package:beat_ecoprove/client/register_cloth/domain/value_objects/cloth_name.dart';
import 'package:beat_ecoprove/dependency_injection.dart';
import 'package:beat_ecoprove/home/presentation/main_skeleton/main_skeleton_view_model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CreateBrandViewModel extends FormViewModel {
  static const defaultImage = "assets/default_avatar.png";

  final INotificationProvider _notificationProvider;
  final INavigationManager _navigationRouter;

  final CreateBrandUseCase _createBrandUseCase;

  CreateBrandViewModel(
    this._notificationProvider,
    this._navigationRouter,
    this._createBrandUseCase,
  ) {
    initializeFields([
      FormFieldValues.brandName,
      FormFieldValues.brandImage,
    ]);
    setValue(FormFieldValues.brandImage, XFile(defaultImage));
  }

  void setBrandName(String brandName) {
    try {
      setValue<String>(
          FormFieldValues.brandName, ClothName.create(brandName).toString());
    } on DomainException catch (e) {
      setError(FormFieldValues.brandName, e.message);
    }
  }

  void getImageFromGallery() async {
    final picker = ImagePicker();
    XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setValue<XFile>(FormFieldValues.brandImage, pickedFile);
    }
  }

  ImageProvider getBrandImage() {
    if (getValue<XFile>(FormFieldValues.brandImage).value!.path ==
        defaultImage) {
      return const AssetImage(defaultImage);
    }

    var brandImage = getValue<XFile>(FormFieldValues.brandImage).value as XFile;

    return FileImage(File(brandImage.path));
  }

  Future registerBrand() async {
    var mainSkeleton = DependencyInjection.locator<MainSkeletonViewModel>();

    try {
      await _createBrandUseCase.handle(RegisterBrandRequest(
        getValue(FormFieldValues.brandName).value ?? "",
        getValue(FormFieldValues.brandImage).value ?? "",
      ));

      mainSkeleton.setIndex(1);
      _navigationRouter.push(ClothingRoutes.closet);

      _notificationProvider.showNotification(
        LocaleContext.get().core_brands_create_brand_created,
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

    _navigationRouter.pop();
    notifyListeners();
  }
}
