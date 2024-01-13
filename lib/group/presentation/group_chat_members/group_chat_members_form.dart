import 'package:beat_ecoprove/core/config/global.dart';
import 'package:beat_ecoprove/core/view_model.dart';
import 'package:beat_ecoprove/core/widgets/application_background.dart';
import 'package:beat_ecoprove/core/widgets/chat/chat_message_text.dart';
import 'package:beat_ecoprove/core/widgets/circular_button.dart';
import 'package:beat_ecoprove/core/widgets/compact_list_item_user.dart';
import 'package:beat_ecoprove/core/widgets/formatted_text_field/default_formatted_text_field.dart';
import 'package:beat_ecoprove/core/widgets/headers/group_header.dart';
import 'package:beat_ecoprove/group/presentation/group_chat_members/group_chat_members_view_model.dart';
import 'package:flutter/material.dart';

class GroupChatMembersForm extends StatelessWidget {
  const GroupChatMembersForm({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = ViewModel.of<GroupChatMembersViewModel>(context);
    const Radius borderRadius = Radius.circular(5);
    const lateralPadding = 38;
    double maxWidth = MediaQuery.of(context).size.width - lateralPadding;

    return Scaffold(
      appBar: const GroupHeader(
        goBack: "/chat",
        title: "Grupos",
        state: "Privado",
        numberMembers: "3",
      ),
      body: AppBackground(
        content: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
          ),
          child: Column(
            children: [
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 26,
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              "Membros",
                              style: AppText.titleToScrollSection,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(
                              width: 6,
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 5),
                              //TODO: CHANGE
                              child: Text(
                                "3 membros",
                                style: AppText.subHeader,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        InkWell(
                          child: Icon(
                            Icons.add_rounded,
                            color: AppColor.widgetSecondary,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 12),
                    //TODO: CHANGE
                    CompactListItemUser(
                      title: "Diogo Assunção",
                      userLevel: 15,
                      sustainablePoints: 50,
                      ecoScorePoints: 50,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    CompactListItemUser(
                      title: "David Braga",
                      userLevel: 10,
                      sustainablePoints: 10,
                      ecoScorePoints: 100,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    CompactListItemUser(
                      title: "Zé Cabra",
                      userLevel: 100,
                      sustainablePoints: 500,
                      ecoScorePoints: 1000,
                    ),
                    const SizedBox(
                      height: 26,
                    ),
                    const Text(
                      "Administrador",
                      style: AppText.titleToScrollSection,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 12),
                    CompactListItemUser(
                      title: "Diogo Assunção",
                      userLevel: 15,
                      sustainablePoints: 50,
                      ecoScorePoints: 50,
                      hasOptions: false,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        type: AppBackgrounds.members,
      ),
    );
  }
}
