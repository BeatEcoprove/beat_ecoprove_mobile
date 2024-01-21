import 'package:async/async.dart';
import 'package:beat_ecoprove/core/config/global.dart';
import 'package:beat_ecoprove/core/domain/models/optionItem.dart';
import 'package:beat_ecoprove/core/view_model.dart';
import 'package:beat_ecoprove/core/widgets/application_background.dart';
import 'package:beat_ecoprove/core/widgets/compact_list_item_user.dart';
import 'package:beat_ecoprove/core/widgets/headers/group_header.dart';
import 'package:beat_ecoprove/group/presentation/group_chat_members/group_chat_members_view_model.dart';
import 'package:flutter/material.dart';

class GroupParams {
  final String groupId;
  final String title;
  final String state;
  final String numberMembers;

  GroupParams({
    required this.groupId,
    required this.title,
    required this.state,
    required this.numberMembers,
  });
}

class GroupChatMembersForm extends StatelessWidget {
  final GroupParams params;

  const GroupChatMembersForm({
    super.key,
    required this.params,
  });

  @override
  Widget build(BuildContext context) {
    final viewModel = ViewModel.of<GroupChatMembersViewModel>(context);
    final memo = AsyncMemoizer();

    return Scaffold(
      appBar: GroupHeader(
        title: params.title,
        state: params.state,
        numberMembers: params.numberMembers.toString(),
      ),
      body: AppBackground(
        content: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
          ),
          child: FutureBuilder(
            future: memo.runOnce(
                () async => await viewModel.getDetails(params.groupId)),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                default:
                  return Column(
                    children: [
                      SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 26,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    const Text(
                                      "Membros",
                                      style: AppText.titleToScrollSection,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(
                                      width: 6,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 5),
                                      child: Text(
                                        "${params.numberMembers} membros",
                                        style: AppText.subHeader,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                                const InkWell(
                                  child: Icon(
                                    Icons.add_rounded,
                                    color: AppColor.widgetSecondary,
                                  ),
                                )
                              ],
                            ),
                            Column(
                              children: viewModel.details.members
                                  .map(
                                    (member) => Container(
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 8),
                                      child: CompactListItemUser(
                                        title: member.username,
                                        userLevel: member.level,
                                        sustainablePoints:
                                            member.sustainabilityPoints,
                                        ecoScorePoints: member.ecoScorePoints,
                                        hasOptions: !viewModel.details.admins
                                            .any((e) => e.id == member.id),
                                        options: [
                                          OptionItem(
                                              name: 'Promover a líder',
                                              action: () {}),
                                          OptionItem(
                                              name: 'Remover do Grupo',
                                              action: () {}),
                                        ],
                                      ),
                                    ),
                                  )
                                  .toList(),
                            ),
                            const SizedBox(
                              height: 26,
                            ),
                            const Text(
                              "Administrador",
                              style: AppText.titleToScrollSection,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Column(
                              children: viewModel.details.admins
                                  .map(
                                    (admin) => Container(
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 8),
                                      child: CompactListItemUser.withoutOptions(
                                        title: admin.username,
                                        userLevel: admin.level,
                                        sustainablePoints:
                                            admin.sustainabilityPoints,
                                        ecoScorePoints: admin.ecoScorePoints,
                                      ),
                                    ),
                                  )
                                  .toList(),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
              }
            },
          ),
        ),
        type: AppBackgrounds.members,
      ),
    );
  }
}
