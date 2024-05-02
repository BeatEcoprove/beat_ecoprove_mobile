import 'package:beat_ecoprove/auth/services/authentication_service.dart';
import 'package:beat_ecoprove/client/profile/presentation/change_profile/change_profile_view.dart';
import 'package:beat_ecoprove/client/profile/presentation/change_profile/params_page/params_page_params.dart';
import 'package:beat_ecoprove/client/profile/presentation/change_profile/params_page/params_profile_view.dart';
import 'package:beat_ecoprove/client/profile/presentation/create_profile/create_profile_view.dart';
import 'package:beat_ecoprove/client/profile/presentation/prizes/prizes_view.dart';
import 'package:beat_ecoprove/client/profile/presentation/profile/profile_view.dart';
import 'package:beat_ecoprove/client/profile/presentation/settings/send_feedback/send_feedback_view.dart';
import 'package:beat_ecoprove/client/profile/presentation/settings/settings_view.dart';
import 'package:beat_ecoprove/client/profile/presentation/trade_points/trade_points_view.dart';
import 'package:beat_ecoprove/core/helpers/http/http_auth_client.dart';
import 'package:beat_ecoprove/core/helpers/navigation/navigation_manager.dart';
import 'package:beat_ecoprove/core/providers/auth/authentication_provider.dart';
import 'package:beat_ecoprove/core/providers/notification_provider.dart';
import 'package:beat_ecoprove/dependency_injection.dart';
import 'package:beat_ecoprove/client/profile/domain/use-cases/delete_profile_use_case.dart';
import 'package:beat_ecoprove/client/profile/domain/use-cases/get_nested_profiles_use_case.dart';
import 'package:beat_ecoprove/client/profile/domain/use-cases/promote_profile_use_case.dart';
import 'package:beat_ecoprove/client/profile/domain/use-cases/register_profile_use_case.dart';
import 'package:beat_ecoprove/client/profile/domain/use-cases/send_feedback_use_case.dart';
import 'package:beat_ecoprove/client/profile/domain/use-cases/trade_points_use_case.dart';
import 'package:beat_ecoprove/client/profile/presentation/change_profile/change_profile_view_model.dart';
import 'package:beat_ecoprove/client/profile/presentation/change_profile/params_page/params_profile_view_model.dart';
import 'package:beat_ecoprove/client/profile/presentation/create_profile/create_profile_view_model.dart';
import 'package:beat_ecoprove/client/profile/presentation/prizes/prizes_view_model.dart';
import 'package:beat_ecoprove/client/profile/presentation/profile/profile_view_model.dart';
import 'package:beat_ecoprove/client/profile/presentation/settings/send_feedback/send_feedback_view_model.dart';
import 'package:beat_ecoprove/client/profile/presentation/settings/settings_view_model.dart';
import 'package:beat_ecoprove/client/profile/presentation/trade_points/trade_points_view_model.dart';
import 'package:beat_ecoprove/client/profile/services/exchange_service.dart';
import 'package:beat_ecoprove/client/profile/services/feedback_service.dart';
import 'package:beat_ecoprove/client/profile/services/profile_service.dart';
import 'package:get_it/get_it.dart';

extension ProfileDependencyInjection on DependencyInjection {
  void _addServices(GetIt locator) {
    var httpClient = locator<HttpAuthClient>();

    locator.registerFactory(() => ProfileService(httpClient));
    locator.registerFactory(() => ExchangeService(httpClient));
    locator.registerFactory(() => FeedbackService(httpClient));
  }

  void _addUseCases(GetIt locator) {
    var profileService = locator<ProfileService>();
    var exchangeService = locator<ExchangeService>();
    var feedbackService = locator<FeedbackService>();

    locator.registerSingleton(RegisterProfileUseCase(profileService));
    locator.registerSingleton(GetNestedProfilesUseCase(profileService));
    locator.registerSingleton(DeleteProfileUseCase(profileService));
    locator.registerSingleton(PromoteProfileUseCase(profileService));
    locator.registerSingleton(TradePointsUseCase(exchangeService));
    locator.registerSingleton(SendFeedbackUseCase(feedbackService));
  }

  void _addViewModels(GetIt locator) {
    var authenticationService = locator<AuthenticationService>();
    var notificationProvider = locator<INotificationProvider>();
    var authProvider = locator<AuthenticationProvider>();
    var router = locator<INavigationManager>();
    var getNestedProfilesUseCase = locator<GetNestedProfilesUseCase>();
    var createProfilesUseCase = locator<RegisterProfileUseCase>();
    var deleteProfileUseCase = locator<DeleteProfileUseCase>();
    var promoteProfileUseCase = locator<PromoteProfileUseCase>();
    var tradePointsUseCase = locator<TradePointsUseCase>();
    var sendFeedbackUseCase = locator<SendFeedbackUseCase>();

    locator.registerFactory(
      () => ProfileViewModel(
        authProvider,
        router,
      ),
    );

    locator.registerFactory(
      () => SettingsViewModel(
        authProvider,
        router,
      ),
    );

    locator.registerFactory(
      () => SendFeedbackViewModel(
        notificationProvider,
        authProvider,
        sendFeedbackUseCase,
        router,
      ),
    );

    locator.registerFactory(
      () => PrizesViewModel(
        authProvider,
        locator<INavigationManager>(),
      ),
    );

    locator.registerFactory(
      () => TradePointsViewModel(
        router,
        notificationProvider,
        authProvider,
        tradePointsUseCase,
      ),
    );

    locator.registerFactory(
      () => ChangeProfileViewModel(
        notificationProvider,
        authProvider,
        router,
        getNestedProfilesUseCase,
        deleteProfileUseCase,
        locator<AuthenticationService>(),
      ),
    );

    locator.registerFactory(
      () => CreateProfileViewModel(
        notificationProvider,
        router,
        createProfilesUseCase,
        authenticationService,
      ),
    );

    locator.registerFactory(
      () => ParamsProfileViewModel(
        notificationProvider,
        authProvider,
        authenticationService,
        router,
        promoteProfileUseCase,
      ),
    );
  }

  void _addViews(GetIt locator) {
    locator.registerFactory(
      () => ProfileView(
        viewModel: locator<ProfileViewModel>(),
      ),
    );

    locator.registerFactory(
      () => TradePointsView(
        viewModel: locator<TradePointsViewModel>(),
      ),
    );

    locator.registerFactory(
      () => PrizesView(
        viewModel: locator<PrizesViewModel>(),
      ),
    );

    locator.registerFactory(
      () => CreateProfileView(
        viewModel: locator<CreateProfileViewModel>(),
      ),
    );

    locator.registerFactory(
      () => SettingsView(
        viewModel: locator<SettingsViewModel>(),
      ),
    );

    locator.registerFactory(
      () => SendFeedbackView(
        viewModel: locator<SendFeedbackViewModel>(),
      ),
    );

    locator.registerFactory(
      () => ChangeProfileView(
        viewModel: locator<ChangeProfileViewModel>(),
      ),
    );

    locator.registerFactoryParam<ParamsProfileView, PageParams, void>(
      (params, _) => ParamsProfileView(
        viewModel: locator<ParamsProfileViewModel>(),
        args: params,
      ),
    );
  }

  void addProfile() {
    GetIt locator = DependencyInjection.locator;

    _addServices(locator);
    _addUseCases(locator);
    _addViewModels(locator);
    _addViews(locator);
  }
}
