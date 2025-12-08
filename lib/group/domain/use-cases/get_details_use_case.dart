import 'package:beat_ecoprove/auth/contracts/public_profile_result.dart';
import 'package:beat_ecoprove/client/profile/services/profile_service.dart';
import 'package:beat_ecoprove/core/use_case.dart';
import 'package:beat_ecoprove/group/contracts/group_details_result.dart';
import 'package:beat_ecoprove/group/services/group_service.dart';

class GetDetailsUseCase implements UseCase<String, Future<GroupDetailsResult>> {
  final GroupService _groupService;
  final ProfileService _profileService;

  GetDetailsUseCase(this._groupService, this._profileService);

  @override
  Future<GroupDetailsResult> handle(String groupId) async {
    GroupDetailsResult groupDetails;

    try {
      groupDetails = await _groupService.getGroupDetails(groupId);
    } catch (e) {
      rethrow;
    }

    try {
      groupDetails.members = await _getProfilesDetails(groupDetails.membersIds);
      groupDetails.admins = await _getProfilesDetails(groupDetails.adminsIds);
    } catch (e) {
      rethrow;
    }

    return groupDetails;
  }

  Future<PublicProfilesResult> _getProfilesDetails(List<dynamic> ids) async {
    return await _profileService.getProfileDataById(ids);
  }
}
