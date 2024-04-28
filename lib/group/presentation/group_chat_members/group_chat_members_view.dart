import 'package:beat_ecoprove/core/argument_view.dart';
import 'package:beat_ecoprove/core/config/global.dart';
import 'package:beat_ecoprove/core/domain/models/optionItem.dart';
import 'package:beat_ecoprove/core/helpers/form/form_field_values.dart';
import 'package:beat_ecoprove/core/widgets/application_background.dart';
import 'package:beat_ecoprove/core/widgets/compact_list_item/compact_list_item_footer/with_options_footer/with_options_footer.dart';
import 'package:beat_ecoprove/core/widgets/compact_list_item/compact_list_item_footer/without_options_footer/without_options_footer.dart';
import 'package:beat_ecoprove/core/widgets/compact_list_item/compact_list_item_header/profile_header.dart';
import 'package:beat_ecoprove/core/widgets/compact_list_item/compact_list_item_root.dart';
import 'package:beat_ecoprove/core/widgets/floating_button.dart';
import 'package:beat_ecoprove/core/widgets/formatted_text_field/default_formatted_text_field.dart';
import 'package:beat_ecoprove/core/widgets/headers/group_header.dart';
import 'package:beat_ecoprove/group/presentation/group_chat_members/group_chat_members_view_model.dart';
import 'package:beat_ecoprove/group/presentation/group_chat_members/group_chat_params.dart';
import 'package:flutter/material.dart';

class GroupChatMembersView
    extends ArgumentView<GroupChatMembersViewModel, GroupChatParams> {
  const GroupChatMembersView({
    super.key,
    required super.viewModel,
    required super.args,
  });

  Widget createInviteCard() {
    return DefaultFormattedTextField(
      hintText: "Nome do utilizador",
      onChange: (name) => viewModel.setUserName(name),
      initialValue: viewModel.getValue(FormFieldValues.userName).value,
      errorMessage: viewModel.getValue(FormFieldValues.userName).error,
    );
  }

  @override
  Widget build(BuildContext context, GroupChatMembersViewModel viewModel) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: GroupHeader(
        title: args.title,
        state: args.state,
        numberMembers: args.numberMembers.toString(),
      ),
      body: AppBackground(
        content: Stack(
          children: [
            const SizedBox(
              height: double.infinity,
              width: double.infinity,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              child: SizedBox(
                height: double.infinity,
                child: SingleChildScrollView(
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
                                  "${args.numberMembers} membros",
                                  style: AppText.subHeader,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Column(
                        children: viewModel.details.members
                            .map(
                              (member) => Container(
                                margin: const EdgeInsets.symmetric(
                                  vertical: 8,
                                ),
                                child:
                                    (!viewModel.isCreator &&
                                            !viewModel.isAdmin &&
                                            viewModel.user.id != member.id)
                                        ? CompactListItemRoot(
                                            height: HeightCard.height88,
                                            padding: PaddingCard.padding0,
                                            items: [
                                              ProfileHeader(
                                                title: member.username,
                                                userLevel: member.level,
                                                sustainablePoints:
                                                    member.sustainabilityPoints,
                                                ecoScorePoints:
                                                    member.ecoScorePoints,
                                              ),
                                              const WithoutOptionsFooter()
                                            ],
                                          )
                                        : CompactListItemRoot(
                                            height: HeightCard.height88,
                                            padding: PaddingCard.padding0,
                                            items: [
                                              ProfileHeader(
                                                title: member.username,
                                                userLevel: member.level,
                                                sustainablePoints:
                                                    member.sustainabilityPoints,
                                                ecoScorePoints:
                                                    member.ecoScorePoints,
                                              ),
                                              (member.id !=
                                                      viewModel
                                                          .details.creator.id)
                                                  ? WithOptionsFooter(
                                                      options: [
                                                        if (viewModel.user.id !=
                                                            member.id)
                                                          OptionItem(
                                                              name: viewModel
                                                                      .details
                                                                      .admins
                                                                      .any((e) =>
                                                                          e.id ==
                                                                          member
                                                                              .id)
                                                                  ? 'Despromover'
                                                                  : 'Promover',
                                                              action:
                                                                  () async => {
                                                                        viewModel.details.admins.any((e) =>
                                                                                e.id ==
                                                                                member.id)
                                                                            ? await viewModel.despromoveMember(
                                                                                member.id,
                                                                                args.groupId,
                                                                              )
                                                                            : await viewModel.promoteMember(
                                                                                member.id,
                                                                                args.groupId,
                                                                              )
                                                                      }),
                                                        OptionItem(
                                                            name: viewModel.user
                                                                        .id !=
                                                                    member.id
                                                                ? 'Remover do Grupo'
                                                                : 'Sair do Grupo',
                                                            action: () async =>
                                                                {
                                                                  await viewModel
                                                                      .leaveGroup(
                                                                    member.id,
                                                                    args.groupId,
                                                                  )
                                                                }),
                                                      ],
                                                    )
                                                  : const WithoutOptionsFooter(),
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
                        "Administradores",
                        style: AppText.titleToScrollSection,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Column(
                        children: viewModel.details.admins
                            .map(
                              (admin) => Container(
                                margin: const EdgeInsets.symmetric(vertical: 8),
                                child: (!viewModel.isCreator &&
                                        !viewModel.isAdmin &&
                                        viewModel.user.id != admin.id)
                                    ? CompactListItemRoot(
                                        height: HeightCard.height88,
                                        padding: PaddingCard.padding0,
                                        items: [
                                          ProfileHeader(
                                            title: admin.username,
                                            userLevel: admin.level,
                                            sustainablePoints:
                                                admin.sustainabilityPoints,
                                            ecoScorePoints:
                                                admin.ecoScorePoints,
                                          ),
                                          const WithoutOptionsFooter(),
                                        ],
                                      )
                                    : CompactListItemRoot(
                                        height: HeightCard.height88,
                                        padding: PaddingCard.padding0,
                                        items: [
                                          ProfileHeader(
                                            title: admin.username,
                                            userLevel: admin.level,
                                            sustainablePoints:
                                                admin.sustainabilityPoints,
                                            ecoScorePoints:
                                                admin.ecoScorePoints,
                                          ),
                                          (viewModel.details.creator.id !=
                                                  admin.id)
                                              ? WithOptionsFooter(
                                                  options: [
                                                    if (viewModel.user.id !=
                                                        admin.id)
                                                      OptionItem(
                                                        name: 'Despromover',
                                                        action: () async => {
                                                          await viewModel
                                                              .despromoveMember(
                                                            admin.id,
                                                            args.groupId,
                                                          ),
                                                        },
                                                      ),
                                                    OptionItem(
                                                      name: viewModel.user.id !=
                                                              admin.id
                                                          ? 'Remover do Grupo'
                                                          : 'Sair do Grupo',
                                                      action: () async => {
                                                        await viewModel
                                                            .leaveGroup(
                                                          admin.id,
                                                          args.groupId,
                                                        ),
                                                      },
                                                    ),
                                                  ],
                                                )
                                              : const WithoutOptionsFooter(),
                                        ],
                                      ),
                              ),
                            )
                            .toList(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            if (viewModel.isMember)
              Positioned(
                bottom: 36,
                right: 26,
                child: FloatingButton(
                  color: AppColor.darkGreen,
                  dimension: 64,
                  icon: const Icon(
                    size: 34,
                    Icons.add_circle_outline_rounded,
                    color: AppColor.widgetBackground,
                  ),
                  onPressed: () async => viewModel.navigateSearchUsers(),
                ),
              ),
          ],
        ),
        type: AppBackgrounds.members,
      ),
    );
  }
}
