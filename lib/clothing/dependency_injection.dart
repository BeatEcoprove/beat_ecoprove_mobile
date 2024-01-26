import 'package:beat_ecoprove/clothing/domain/use-cases/add_cloths_bucket_use_case.dart';
import 'package:beat_ecoprove/clothing/domain/use-cases/change_bucket_name_use_case.dart';
import 'package:beat_ecoprove/clothing/domain/use-cases/get_buckets_use_case.dart';
import 'package:beat_ecoprove/clothing/domain/use-cases/remove_cloth_from_bucket_use_case.dart';
import 'package:beat_ecoprove/clothing/presentation/closet/clothing_view_model.dart';
import 'package:beat_ecoprove/clothing/presentation/info_card/info_bucket/change_name/change_bucket_name_view_model.dart';
import 'package:beat_ecoprove/clothing/presentation/info_card/info_bucket/info_bucket_view_model.dart';
import 'package:beat_ecoprove/clothing/presentation/info_card/info_cloth/info_cloth_view_model.dart';
import 'package:beat_ecoprove/clothing/presentation/info_card/services/info_cloth_services_view_model.dart';
import 'package:beat_ecoprove/clothing/services/action_service.dart';
import 'package:beat_ecoprove/clothing/services/action_service_proxy.dart';
import 'package:beat_ecoprove/clothing/services/closet_service.dart';
import 'package:beat_ecoprove/clothing/services/closet_service_proxy.dart';
import 'package:beat_ecoprove/clothing/services/outfit_service.dart';
import 'package:beat_ecoprove/clothing/domain/use-cases/delete_card_use_case.dart';
import 'package:beat_ecoprove/clothing/domain/use-cases/get_closet_use_case.dart';
import 'package:beat_ecoprove/clothing/domain/use-cases/mark_cloth_as_daily_use_use_case.dart';
import 'package:beat_ecoprove/clothing/domain/use-cases/register_bucket_use_case.dart';
import 'package:beat_ecoprove/clothing/domain/use-cases/unmark_cloth_as_daily_use_use_case.dart';
import 'package:beat_ecoprove/core/helpers/http/http_auth_client.dart';
import 'package:beat_ecoprove/core/providers/auth/authentication_provider.dart';
import 'package:beat_ecoprove/core/providers/notification_provider.dart';
import 'package:beat_ecoprove/dependency_injection.dart';
import 'package:beat_ecoprove/profile/domain/use-cases/get_nested_profiles_use_case.dart';
import 'package:beat_ecoprove/register_cloth/domain/use-cases/get_brands_use_case.dart';
import 'package:beat_ecoprove/register_cloth/domain/use-cases/get_colors_use_case.dart';
import 'package:beat_ecoprove/routes.dart';
import 'package:get_it/get_it.dart';

extension ClothingDependencyInjection on DependencyInjection {
  void _addServices(GetIt locator) {
    var httpClient = locator<HttpAuthClient>();

    locator.registerFactory(() => ClosetService(httpClient));
    locator.registerFactory(() => OutfitService(httpClient));
    locator.registerFactory(() => ActionService(httpClient));
  }

  void _addUseCases(GetIt locator) {
    locator.registerSingleton(ClosetServiceProxy(locator<HttpAuthClient>()));
    var clothingService = locator<ClosetServiceProxy>();
    var outfitService = locator<OutfitService>();

    locator.registerSingleton(ActionServiceProxy(locator<HttpAuthClient>()));
    locator.registerSingleton(GetClosetUseCase(clothingService));
    locator.registerSingleton(MarkClothAsDailyUseUseCase(outfitService));
    locator.registerSingleton(UnMarkClothAsDailyUseUseCase(outfitService));
    locator.registerSingleton(DeleteCardUseCase(clothingService));
    locator.registerSingleton(RegisterBucketUseCase(clothingService));
    locator.registerSingleton(RemoveClothFromBucketUseCase(clothingService));
    locator.registerSingleton(ChangeBucketNameUseCase(clothingService));
    locator.registerSingleton(AddClothsBucketUseCase(clothingService));
    locator.registerSingleton(GetBucketsUseCase(clothingService));
    locator.registerSingleton(GetColorsUseCase(clothingService));
    locator.registerSingleton(GetBrandsUseCase(clothingService));
  }

  void _addViewModels(GetIt locator) {
    var router = locator<AppRouter>();
    var authProvider = locator<AuthenticationProvider>();
    var notificationProvider = locator<NotificationProvider>();
    var getClosetUseCase = locator<GetClosetUseCase>();
    var markClothAsDailyUseUseCase = locator<MarkClothAsDailyUseUseCase>();
    var unMarkClothAsDailyUseUseCase = locator<UnMarkClothAsDailyUseUseCase>();
    var deleteCardUseCase = locator<DeleteCardUseCase>();
    var registerBucketUseCase = locator<RegisterBucketUseCase>();
    var removeClothFromBucketUseCase = locator<RemoveClothFromBucketUseCase>();
    var changeBucketNameUseCase = locator<ChangeBucketNameUseCase>();
    var addClothBucketUseCase = locator<AddClothsBucketUseCase>();
    var getBucketsUseCase = locator<GetBucketsUseCase>();
    var getColorsUseCase = locator<GetColorsUseCase>();
    var getBrandsUseCase = locator<GetBrandsUseCase>();
    var getNestedProfilesUseCase = locator<GetNestedProfilesUseCase>();

    locator.registerFactory(() => ClothingViewModel(
          notificationProvider,
          authProvider,
          getClosetUseCase,
          markClothAsDailyUseUseCase,
          unMarkClothAsDailyUseUseCase,
          deleteCardUseCase,
          registerBucketUseCase,
          addClothBucketUseCase,
          getColorsUseCase,
          getBrandsUseCase,
          getNestedProfilesUseCase,
          router.appRouter,
        ));
    locator.registerFactory(() => InfoClothServiceViewModel(
          notificationProvider,
          router.appRouter,
          locator<ActionServiceProxy>(),
          getBucketsUseCase,
          addClothBucketUseCase,
          registerBucketUseCase,
        ));
    locator.registerFactory(() => InfoClothViewModel(
          notificationProvider,
          markClothAsDailyUseUseCase,
          unMarkClothAsDailyUseUseCase,
        ));
    locator.registerFactory(() => InfoBucketViewModel(
          notificationProvider,
          removeClothFromBucketUseCase,
          unMarkClothAsDailyUseUseCase,
        ));
    locator.registerFactory(() => ChangeBucketNameViewModel(
          notificationProvider,
          router.appRouter,
          changeBucketNameUseCase,
        ));
  }

  void addCloset() {
    GetIt locator = DependencyInjection.locator;

    _addServices(locator);
    _addUseCases(locator);
    _addViewModels(locator);
  }
}
