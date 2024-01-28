import 'package:async/async.dart';
import 'package:beat_ecoprove/core/config/global.dart';
import 'package:beat_ecoprove/core/domain/models/optionItem.dart';
import 'package:beat_ecoprove/core/helpers/form/form_field_values.dart';
import 'package:beat_ecoprove/core/view_model.dart';
import 'package:beat_ecoprove/core/widgets/application_background.dart';
import 'package:beat_ecoprove/core/widgets/compact_list_item_user.dart';
import 'package:beat_ecoprove/core/widgets/formatted_text_field/default_formatted_text_field.dart';
import 'package:beat_ecoprove/core/widgets/headers/group_header.dart';
import 'package:beat_ecoprove/core/widgets/overlay_widget_with_button.dart';
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

class GroupChatMembersForm extends StatefulWidget {
  final GroupParams params;

  const GroupChatMembersForm({
    super.key,
    required this.params,
  });

  @override
  State<GroupChatMembersForm> createState() => _GroupChatMembersFormState();
}

class _GroupChatMembersFormState extends State<GroupChatMembersForm> {
  late GroupChatMembersViewModel viewModel;
  late Modal _overlay;

  @override
  void initState() {
    super.initState();

    _overlay = Modal(
      top: 198,
      bottom: 198,
      left: 36,
      right: 36,
      action: () async => await viewModel.inviteToGroup(widget.params.groupId),
      titleModal: "Convidar para o grupo",
      buttonText: "Convidar",
    );
  }

  Widget createInviteCard() {
    return DefaultFormattedTextField(
      hintText: "Nome do utilizador",
      onChange: (name) => viewModel.setUserName(name),
      initialValue: viewModel.getValue(FormFieldValues.userName).value,
      errorMessage: viewModel.getValue(FormFieldValues.userName).error,
    );
  }

  @override
  Widget build(BuildContext context) {
    viewModel = ViewModel.of<GroupChatMembersViewModel>(context);
    final memo = AsyncMemoizer();

    return Scaffold(
      appBar: GroupHeader(
        title: widget.params.title,
        state: widget.params.state,
        numberMembers: widget.params.numberMembers.toString(),
      ),
      body: AppBackground(
        content: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
          ),
          child: FutureBuilder(
            future: memo.runOnce(
                () async => await viewModel.getDetails(widget.params.groupId)),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return const Center(
                    child: CircularProgressIndicator(
                      color: AppColor.primaryColor,
                    ),
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
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Text(
                                    viewModel.details.description,
                                    textAlign: TextAlign.center,
                                    style: AppText.subHeader,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 10,
                                  ),
                                ),
                              ],
                            ),
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
                                        "${widget.params.numberMembers} membros",
                                        style: AppText.subHeader,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                                InkWell(
                                  child: const Icon(
                                    Icons.add_rounded,
                                    color: AppColor.widgetSecondary,
                                  ),
                                  onTap: () async => await _overlay.create(
                                      context, createInviteCard()),
                                )
                              ],
                            ),
                            Column(
                              children: viewModel.details.members
                                  .map(
                                    (member) => Container(
                                      margin: const EdgeInsets.symmetric(
                                        vertical: 8,
                                      ),
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
                                              action: () async => {
                                                    await viewModel
                                                        .promoteMember(
                                                      member.id,
                                                      widget.params.groupId,
                                                    )
                                                  }),
                                          //TODO: CHANGE
                                          OptionItem(
                                              name:
                                                  'Sair do Grupo / Remover do Grupo',
                                              action: () async => {
                                                    await viewModel.leaveGroup(
                                                      member.id,
                                                      widget.params.groupId,
                                                    )
                                                  }),
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
