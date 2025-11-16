import 'package:beat_ecoprove/auth/contracts/common/auth_result.dart';
import 'package:beat_ecoprove/auth/contracts/profile_result.dart';
import 'package:beat_ecoprove/auth/contracts/sign_in/sign_in_personal_request.dart';
import 'package:beat_ecoprove/auth/contracts/sign_in/sing_in_enterprise_request.dart';
import 'package:beat_ecoprove/auth/domain/value_objects/address.dart';
import 'package:beat_ecoprove/auth/domain/value_objects/phone.dart';
import 'package:beat_ecoprove/auth/services/registration_service.dart';
import 'package:beat_ecoprove/core/domain/entities/consumer.dart';
import 'package:beat_ecoprove/core/domain/entities/employee.dart';
import 'package:beat_ecoprove/core/domain/entities/organization.dart';
import 'package:beat_ecoprove/core/domain/entities/user.dart';
import 'package:beat_ecoprove/core/domain/models/store.dart';
import 'package:beat_ecoprove/core/helpers/json_decoder.dart';
import 'package:beat_ecoprove/core/helpers/tokens.dart';
import 'package:beat_ecoprove/core/providers/auth/authentication.dart';
import 'package:beat_ecoprove/core/providers/auth/authentication_provider.dart';
import 'package:beat_ecoprove/core/providers/auth/pre_authentication.dart';
import 'package:beat_ecoprove/core/providers/auth/refresh_profile.dart';
import 'package:beat_ecoprove/core/services/storage_service.dart';
import 'package:beat_ecoprove/core/use_case.dart';
import 'package:beat_ecoprove/client/profile/contracts/register_profile_request.dart';
import 'package:beat_ecoprove/client/profile/services/profile_service.dart';

class RegisterProfileUseCase
    implements UseCase<RegisterProfileRequest, Future> {
  final ProfileService _profileService;
  final RegistrationService _registrationService;
  final AuthenticationProvider _authenticationProvider;

  RegisterProfileUseCase(this._profileService, this._registrationService,
      this._authenticationProvider);

  @override
  Future handle(RegisterProfileRequest request) async {
    AuthResult tokens;

    try {
      tokens = await _profileService.registerProfile();

      //FIXME: Alter delay time
      await Future.delayed(const Duration(seconds: 2));

      // Get Token value to populate the User Object
      Map<String, dynamic> decodedToken = JwtDecoder.decode(tokens.accessToken);

      var profileId = decodedToken[Tokens.profileId];

      _authenticationProvider
          .preAuthenticate(PreAuthentication(accessToken: tokens.accessToken));

      switch (_authenticationProvider.appUser!.type) {
        case UserType.consumer:
          await _registrationService.createClient(
            SignInPersonalRequest(
              profileId: profileId,
              firstName: request.profileName.split(' ')[0],
              lastName: request.profileName.split(' ')[1],
              displayName: request.profileUserName,
              birthDate: request.profileBirthDate,
              gender: request.profileGender,
              phone: _authenticationProvider.appUser!.phoneNumber,
            ),
          );
          break;
        case UserType.organization:
          await _registrationService.createOrganization(
            SignInEnterpriseRequest(
                profileId: profileId,
                firstName: request.profileName.split(' ')[0],
                lastName: request.profileName.split(' ')[1],
                displayName: request.profileUserName,
                phone: _authenticationProvider.appUser!.phoneNumber,
                address: Address.empty(),
                country: ''),
          );
          break;
        default:
          await _registrationService.createClient(
            SignInPersonalRequest(
              profileId: profileId,
              firstName: request.profileName.split(' ')[0],
              lastName: request.profileName.split(' ')[1],
              displayName: request.profileUserName,
              birthDate: request.profileBirthDate,
              gender: request.profileGender,
              phone: _authenticationProvider.appUser!.phoneNumber,
            ),
          );
      }
    } catch (e) {
      rethrow;
    }

    await _authenticateUser();
  }

  Future<void> _authenticateUser() async {
    AuthResult tokens;
    FinishProfileResult profileData;

    String refreshToken =
        await StorageService.getValue(Store.refreshToken) ?? '';

    Map<String, dynamic> decodedToken = JwtDecoder.decode(refreshToken);

    RefreshProfile refreshProfile;
    try {
      refreshProfile = await _authenticationProvider.refreshProfile(
        AuthResult(refreshToken, refreshToken),
        profileId: decodedToken[Tokens.profileId],
      );

      profileData = refreshProfile.profile;
      tokens = refreshProfile.tokens;
    } catch (e) {
      rethrow;
    }

    // Authenticates the use on the app
    _authenticationProvider.authenticate(
      Authentication(
        accessToken: tokens.accessToken,
        refreshToken: tokens.refreshToken,
        user: switch (UserType.getOf(decodedToken[Tokens.role])) {
          UserType.consumer => Consumer(
              id: profileData.id,
              name: profileData.username,
              avatarUrl: profileData.avatarUrl,
              level: profileData.level.toString(),
              levelPercent: profileData.levelPercentage.toString(),
              sustainablePoints: profileData.sustainabilityPoints.toString(),
              ecoScore: profileData.ecoScorePoints.toString(),
              ecoCoins: profileData.ecoCoins.toString(),
              xp: profileData.xp.toString(),
              nextLevelXp: profileData.nextLevelUp.toString(),
              phoneNumber: Phone.create(
                  profileData.phoneCountry, profileData.phoneNumber),
            ),
          UserType.organization => Organization(
              id: profileData.id,
              name: profileData.username,
              avatarUrl: profileData.avatarUrl,
              level: profileData.level.toString(),
              levelPercent: profileData.levelPercentage.toString(),
              sustainablePoints: profileData.sustainabilityPoints.toString(),
              ecoScore: profileData.ecoScorePoints.toString(),
              ecoCoins: profileData.ecoCoins.toString(),
              xp: profileData.xp.toString(),
              nextLevelXp: profileData.nextLevelUp.toString(),
              phoneNumber: Phone.create(
                  profileData.phoneCountry, profileData.phoneNumber),
            ),
          UserType.employee => Employee(
              id: profileData.id,
              name: profileData.username,
              avatarUrl: profileData.avatarUrl,
              level: profileData.level.toString(),
              levelPercent: profileData.levelPercentage.toString(),
              sustainablePoints: profileData.sustainabilityPoints.toString(),
              ecoScore: profileData.ecoScorePoints.toString(),
              ecoCoins: profileData.ecoCoins.toString(),
              xp: profileData.xp.toString(),
              nextLevelXp: profileData.nextLevelUp.toString(),
              phoneNumber: Phone.create(
                  profileData.phoneCountry, profileData.phoneNumber),
              // FIXME: change when open service providers
              workerType: EmployeeType.getOf(decodedToken[Tokens.role]),
              storeId: decodedToken[Tokens.storeId],
            ),
        },
      ),
    );
  }
}
