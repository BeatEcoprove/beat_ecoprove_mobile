import 'package:beat_ecoprove/auth/contracts/common/auth_result.dart';
import 'package:beat_ecoprove/auth/contracts/refresh_tokens_request.dart';
import 'package:beat_ecoprove/auth/contracts/sign_in/sign_in_personal_request.dart';
import 'package:beat_ecoprove/auth/contracts/sign_in/sing_in_enterprise_request.dart';
import 'package:beat_ecoprove/auth/domain/value_objects/address.dart';
import 'package:beat_ecoprove/auth/services/authentication_service.dart';
import 'package:beat_ecoprove/auth/services/registration_service.dart';
import 'package:beat_ecoprove/core/domain/entities/user.dart';
import 'package:beat_ecoprove/core/helpers/json_decoder.dart';
import 'package:beat_ecoprove/core/helpers/tokens.dart';
import 'package:beat_ecoprove/core/providers/auth/authentication_provider.dart';
import 'package:beat_ecoprove/core/use_case.dart';
import 'package:beat_ecoprove/client/profile/contracts/register_profile_request.dart';
import 'package:beat_ecoprove/client/profile/services/profile_service.dart';

class RegisterProfileUseCase
    implements UseCase<RegisterProfileRequest, Future> {
  final ProfileService _profileService;
  final AuthenticationService _authenticationService;
  final RegistrationService _registrationService;
  final AuthenticationProvider _authenticationProvider;

  RegisterProfileUseCase(this._profileService, this._authenticationService,
      this._registrationService, this._authenticationProvider);

  @override
  Future handle(RegisterProfileRequest request) async {
    AuthResult tokens;

    try {
      tokens = await _profileService.registerProfile();

      // Get Token value to populate the User Object
      Map<String, dynamic> decodedToken = JwtDecoder.decode(tokens.accessToken);

      var profileId = decodedToken[Tokens.profileId];

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

      _authenticationService.refreshTokens(RefreshTokensRequest(
          refreshToken: _authenticationProvider.refreshToken));
    } catch (e) {
      rethrow;
    }
  }
}
