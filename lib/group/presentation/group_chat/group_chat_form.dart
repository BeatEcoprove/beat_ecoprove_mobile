import 'package:beat_ecoprove/core/config/global.dart';
import 'package:beat_ecoprove/core/domain/models/group_item.dart';
import 'package:beat_ecoprove/core/view_model.dart';
import 'package:beat_ecoprove/core/widgets/chat/chat_message_text.dart';
import 'package:beat_ecoprove/core/widgets/circular_button.dart';
import 'package:beat_ecoprove/core/widgets/formatted_text_field/default_formatted_text_field.dart';
import 'package:beat_ecoprove/core/widgets/headers/group_header.dart';
import 'package:beat_ecoprove/group/presentation/group_chat/group_chat_view_model.dart';
import 'package:beat_ecoprove/group/presentation/group_chat_members/group_chat_members_form.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class GroupChatForm extends StatelessWidget {
  final GroupItem groupItem;

  const GroupChatForm({super.key, required this.groupItem});

  @override
  Widget build(BuildContext context) {
    final viewModel = ViewModel.of<GroupChatViewModel>(context);
    final goRouter = GoRouter.of(context);
    const Radius borderRadius = Radius.circular(5);
    const lateralPadding = 38;
    double maxWidth = MediaQuery.of(context).size.width - lateralPadding;

    var params = GroupParams(
        groupId: groupItem.id,
        title: groupItem.name,
        state: groupItem.isPublic == true ? "Público" : "Privado",
        numberMembers: groupItem.membersCount.toString());

    return Scaffold(
      appBar: GroupHeader(
        title: params.title,
        state: params.state,
        numberMembers: params.numberMembers,
      ),
      body: Stack(
        children: [
          const Positioned.fill(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
                child: Column(
                  verticalDirection: VerticalDirection.up,
                  children: [
                    ChatMessageText(),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 12,
            right: 20,
            child: CircularButton(
              height: 46,
              icon: const Icon(
                Icons.people_alt_rounded,
                color: AppColor.bottomNavigationBar,
              ),
              onPress: () => goRouter.push("/members", extra: params),
            ),
          ),
          // const Positioned(
          //   top: 70,
          //   right: 20,
          //   child: CircularButton(
          //     height: 46,
          //     icon: Icon(
          //       Icons.military_tech_rounded,
          //       color: AppColor.bottomNavigationBar,
          //     ),
          //   ),
          // ),
          Positioned(
            bottom: 20,
            right: 20,
            child: Row(
              children: [
                SizedBox(
                  width: maxWidth - 54,
                  child: const DefaultFormattedTextField(
                    hintText: "Mensagem",
                    leftIcon: Icon(Icons.mode_edit_outline_outlined),
                  ),
                ),
                const SizedBox(
                  width: 4,
                ),
                Container(
                  width: 52,
                  height: 50,
                  decoration: const BoxDecoration(
                    color: AppColor.widgetBackground,
                    borderRadius: BorderRadius.all(borderRadius),
                    boxShadow: [AppColor.defaultShadow],
                  ),
                  child: const Icon(
                    Icons.add_rounded,
                    size: 24,
                    color: AppColor.widgetSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
