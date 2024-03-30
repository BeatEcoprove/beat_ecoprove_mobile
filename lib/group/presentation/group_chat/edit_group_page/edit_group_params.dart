import 'package:beat_ecoprove/group/contracts/group_details_result.dart';

class EditGroupParams {
  final List<String> adminId;
  final GroupDetailsResult group;

  EditGroupParams({
    required this.adminId,
    required this.group,
  });
}
