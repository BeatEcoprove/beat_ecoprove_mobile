import 'package:beat_ecoprove/core/helpers/http/http_auth_client.dart';
import 'package:beat_ecoprove/core/helpers/http/http_methods.dart';
import 'package:beat_ecoprove/group/contracts/groups_result.dart';
import 'package:beat_ecoprove/group/contracts/register_group_request.dart';

class GroupService {
  final HttpAuthClient _httpClient;

  GroupService(this._httpClient);

  Future<GroupsResult> getGroups() async {
    return GroupsResult.fromJson(await _httpClient.makeRequestJson(
      method: HttpMethods.get,
      path: "groups?page=1&pageSize=10",
      expectedCode: 200,
    ));
  }

  Future registerGroup(RegisterGroupRequest request) async {
    await _httpClient.makeRequestMultiPart(
      method: HttpMethods.post,
      path: "groups",
      body: request,
      expectedCode: 200,
    );
  }
}
