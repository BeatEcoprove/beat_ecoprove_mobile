import 'package:beat_ecoprove/client/clothing/domain/use-cases/add_cloths_bucket_use_case.dart';
import 'package:beat_ecoprove/client/clothing/domain/use-cases/change_bucket_name_use_case.dart';
import 'package:beat_ecoprove/client/clothing/domain/use-cases/get_buckets_use_case.dart';
import 'package:beat_ecoprove/client/clothing/domain/use-cases/get_cloth_history_use_case.dart';
import 'package:beat_ecoprove/client/clothing/domain/use-cases/get_clothes_use_case%20.dart';
import 'package:beat_ecoprove/client/clothing/domain/use-cases/remove_cloth_from_bucket_use_case.dart';
import 'package:beat_ecoprove/client/clothing/presentation/closet/clothing_view.dart';
import 'package:beat_ecoprove/client/clothing/presentation/closet/clothing_view_model.dart';
import 'package:beat_ecoprove/client/clothing/presentation/info_card/info_bucket/change_name/change_bucket_name_parms.dart';
import 'package:beat_ecoprove/client/clothing/presentation/info_card/info_bucket/change_name/change_bucket_name_view.dart';
import 'package:beat_ecoprove/client/clothing/presentation/info_card/info_bucket/change_name/change_bucket_name_view_model.dart';
import 'package:beat_ecoprove/client/clothing/presentation/info_card/info_bucket/info_bucket_params.dart';
import 'package:beat_ecoprove/client/clothing/presentation/info_card/info_bucket/info_bucket_view_model.dart';
import 'package:beat_ecoprove/client/clothing/presentation/info_card/info_bucket/info_cloth_view.dart';
import 'package:beat_ecoprove/client/clothing/presentation/info_card/info_cloth/info_cloth_parms.dart';
import 'package:beat_ecoprove/client/clothing/presentation/info_card/info_cloth/info_cloth_view.dart';
import 'package:beat_ecoprove/client/clothing/presentation/info_card/info_cloth/info_cloth_view_model.dart';
import 'package:beat_ecoprove/client/clothing/presentation/info_card/services/info_cloth_service_view.dart';
import 'package:beat_ecoprove/client/clothing/presentation/info_card/services/info_cloth_service_view_model.dart';
import 'package:beat_ecoprove/client/clothing/presentation/info_card/services/info_cloth_service_params.dart';
import 'package:beat_ecoprove/client/clothing/services/action_service.dart';
import 'package:beat_ecoprove/client/clothing/services/action_service_proxy.dart';
import 'package:beat_ecoprove/client/clothing/services/closet_service.dart';
import 'package:beat_ecoprove/client/clothing/services/cloth_service.dart';
import 'package:beat_ecoprove/client/clothing/services/outfit_service.dart';
import 'package:beat_ecoprove/client/clothing/domain/use-cases/delete_card_use_case.dart';
import 'package:beat_ecoprove/client/clothing/domain/use-cases/get_closet_use_case.dart';
import 'package:beat_ecoprove/client/clothing/domain/use-cases/mark_cloth_as_daily_use_use_case.dart';
import 'package:beat_ecoprove/client/clothing/domain/use-cases/register_bucket_use_case.dart';
import 'package:beat_ecoprove/client/clothing/domain/use-cases/unmark_cloth_as_daily_use_use_case.dart';
import 'package:beat_ecoprove/core/helpers/http/http_auth_client.dart';
import 'package:beat_ecoprove/core/helpers/navigation/navigation_manager.dart';
import 'package:beat_ecoprove/core/providers/auth/authentication_provider.dart';
import 'package:beat_ecoprove/core/providers/closet/bucket_info_manager.dart';
import 'package:beat_ecoprove/core/providers/notification_provider.dart';
import 'package:beat_ecoprove/core/providers/static_values_provider.dart';
import 'package:beat_ecoprove/core/services/country_codes_service.dart';
import 'package:beat_ecoprove/core/services/geo_api_service.dart';
import 'package:beat_ecoprove/dependency_injection.dart';
import 'package:beat_ecoprove/client/profile/domain/use-cases/get_nested_profiles_use_case.dart';
import 'package:beat_ecoprove/client/register_cloth/domain/use-cases/get_brands_use_case.dart';
import 'package:beat_ecoprove/client/register_cloth/domain/use-cases/get_colors_use_case.dart';
import 'package:get_it/get_it.dart';

extension ClothingDependencyInjection on DependencyInjection {
  void _addServices(GetIt locator) {
    var httpClient = locator<HttpAuthClient>();

    locator.registerFactory(
      () => ClosetService(httpClient),
    );

    locator.registerFactory(
      () => ClothService(httpClient),
    );

    locator.registerFactory(
      () => OutfitService(httpClient),
    );

    locator.registerFactory(
      () => ActionService(httpClient),
    );

    locator.registerSingleton<IBucketInfoManager<String>>(
      BucketInfoManager(),
    );
  }

  void _addUseCases(GetIt locator) {
    var clothingService = locator<ClosetService>();
    var outfitService = locator<OutfitService>();
    var clothService = locator<ClothService>();

    locator.registerSingleton(ActionServiceProxy(
      locator<HttpAuthClient>(),
    ));
    locator.registerSingleton(
      GetClosetUseCase(clothingService),
    );

    locator.registerSingleton(
      GetClothesUseCase(clothingService),
    );

    locator.registerSingleton(
      MarkClothAsDailyUseUseCase(outfitService),
    );

    locator.registerSingleton(
      UnMarkClothAsDailyUseUseCase(outfitService),
    );

    locator.registerSingleton(
      DeleteCardUseCase(clothingService),
    );

    locator.registerSingleton(
      RegisterBucketUseCase(clothingService),
    );

    locator.registerSingleton(
      RemoveClothFromBucketUseCase(clothingService),
    );

    locator.registerSingleton(
      ChangeBucketNameUseCase(clothingService),
    );

    locator.registerSingleton(
      AddClothsBucketUseCase(clothingService),
    );

    locator.registerSingleton(
      GetBucketsUseCase(clothingService),
    );

    locator.registerSingleton(
      GetColorsUseCase(clothingService),
    );

    locator.registerSingleton(
      GetBrandsUseCase(clothingService),
    );

    locator.registerSingleton(
      GetClothHistoryUseCase(clothService),
    );

    locator.registerSingleton(
      StaticValuesProvider(
        locator<AuthenticationProvider>(),
        locator<GetColorsUseCase>(),
        locator<GetBrandsUseCase>(),
        locator<CountryCodesService>(),
        locator<GeoApiService>(),
      ),
    );
  }

  void _addViewModels(GetIt locator) {
    var bucketInfoManager = locator<IBucketInfoManager<String>>();
    var router = locator<INavigationManager>();
    var notificationProvider = locator<INotificationProvider>();
    var markClothAsDailyUseUseCase = locator<MarkClothAsDailyUseUseCase>();
    var unMarkClothAsDailyUseUseCase = locator<UnMarkClothAsDailyUseUseCase>();
    var removeClothFromBucketUseCase = locator<RemoveClothFromBucketUseCase>();
    var changeBucketNameUseCase = locator<ChangeBucketNameUseCase>();
    var getClothHistoryUseCase = locator<GetClothHistoryUseCase>();
    locator<GetBrandsUseCase>();

    locator.registerFactory(
      () => InfoClothServiceViewModelAlt(
        bucketInfoManager,
        notificationProvider,
        router,
        locator<RegisterBucketUseCase>(),
        locator<AddClothsBucketUseCase>(),
        locator<GetBucketsUseCase>(),
        locator<DeleteCardUseCase>(),
        locator<ActionService>(),
        locator<ClosetService>(),
      ),
    );

    locator.registerFactory(
      () => InfoClothViewModel(
        router,
        notificationProvider,
        markClothAsDailyUseUseCase,
        unMarkClothAsDailyUseUseCase,
        getClothHistoryUseCase,
        locator<ActionService>(),
      ),
    );

    locator.registerFactory(
      () => InfoBucketViewModel(
        bucketInfoManager,
        notificationProvider,
        removeClothFromBucketUseCase,
        unMarkClothAsDailyUseUseCase,
        router,
      ),
    );

    locator.registerFactory(
      () => ChangeBucketNameViewModel(
        notificationProvider,
        router,
        changeBucketNameUseCase,
      ),
    );

    locator.registerFactory(
      () => ClothingViewModel(
        locator<AuthenticationProvider>(),
        locator<GetClosetUseCase>(),
        locator<INotificationProvider>(),
        locator<GetNestedProfilesUseCase>(),
        locator<StaticValuesProvider>(),
        locator<MarkClothAsDailyUseUseCase>(),
        locator<UnMarkClothAsDailyUseUseCase>(),
        locator<INavigationManager>(),
        locator<DeleteCardUseCase>(),
        locator<RegisterBucketUseCase>(),
        locator<AddClothsBucketUseCase>(),
      ),
    );
  }

  void _addView(GetIt locator) {
    locator.registerFactoryParam<InfoClothView, InfoClothParams, void>(
      (params, _) => InfoClothView(
        viewModel: locator<InfoClothViewModel>(),
        args: params,
      ),
    );

    locator.registerFactoryParam<InfoClothServiceViewAlt, InfoClothServiceParms,
        void>(
      (params, _) => InfoClothServiceViewAlt(
        viewModel: locator<InfoClothServiceViewModelAlt>(),
        args: params,
      ),
    );

    locator.registerFactoryParam<InfoBucketView, InfoBucketParams, void>(
      (params, _) => InfoBucketView(
        DependencyInjection.locator<IBucketInfoManager<String>>(),
        DependencyInjection.locator<INavigationManager>(),
        viewModel: locator<InfoBucketViewModel>(),
        args: params,
      ),
    );

    locator.registerFactoryParam<ChangeBucketNameView, ChangeBucketNameParams,
        void>(
      (params, _) => ChangeBucketNameView(
        viewModel: locator<ChangeBucketNameViewModel>(),
        args: params,
      ),
    );

    locator.registerFactory(
      () => ClothingView(
        viewModel: locator<ClothingViewModel>(),
      ),
    );
  }

  void addCloset() {
    GetIt locator = DependencyInjection.locator;

    _addServices(locator);
    _addUseCases(locator);
    _addViewModels(locator);
    _addView(locator);
  }
}
