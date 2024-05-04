import 'package:beat_ecoprove/core/argument_view.dart';
import 'package:beat_ecoprove/core/config/global.dart';
import 'package:beat_ecoprove/core/domain/models/group_item.dart';
import 'package:beat_ecoprove/core/helpers/form/form_field_values.dart';
import 'package:beat_ecoprove/core/widgets/circular_button.dart';
import 'package:beat_ecoprove/core/widgets/formatted_text_field/default_formatted_text_field.dart';
import 'package:beat_ecoprove/core/widgets/headers/group_header.dart';
import 'package:beat_ecoprove/group/presentation/group_chat/group_chat_view_model.dart';
import 'package:beat_ecoprove/group/presentation/group_chat_members/group_chat_params.dart';
import 'package:flutter/material.dart';

class GroupChatView extends ArgumentView<GroupChatViewModel, GroupItem> {
  const GroupChatView({
    super.key,
    required super.viewModel,
    required super.args,
  });

  @override
  Widget build(BuildContext context, GroupChatViewModel viewModel) {
    const Radius borderRadius = Radius.circular(5);
    const lateralPadding = 38;
    double maxWidth = MediaQuery.of(context).size.width - lateralPadding;

    var params = GroupChatParams(
      groupId: args.id,
      title: args.name,
      state: args.isPublic == true ? "Público" : "Privado",
      numberMembers: args.membersCount.toString(),
    );

    return Scaffold(
      appBar: GroupHeader(
        onGoBackPress: () => viewModel.exitGroup(args.id),
        title: params.title,
        state: params.state,
        numberMembers: params.numberMembers,
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Padding(
              padding: const EdgeInsets.only(
                left: 16,
                right: 16,
                top: 16,
                bottom: 84,
              ),
              child: SingleChildScrollView(
                reverse: true,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: viewModel.messages),
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
              onPress: () => viewModel.goToChatMembers(args),
            ),
          ),
          // Positioned(
          //   top: 70,
          //   right: 20,
          //   child: CircularButton(
          //     height: 46,
          //     icon: const Icon(
          //       Icons.mode_edit_outline_outlined,
          //       color: AppColor.bottomNavigationBar,
          //     ),
          //     onPress: () async => viewModel.isLoading
          //         ? {}
          //         : await viewModel.updateGroup(args.id),
          //   ),
          // ),
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
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  SizedBox(
                    width: maxWidth - 100,
                    child: DefaultFormattedTextField(
                      controller: viewModel.chatTextController,
                      hintText: "Escreva a mensagem ...",
                      leftIcon: const Icon(Icons.mode_edit_outline_outlined),
                      initialValue:
                          viewModel.getValue(FormFieldValues.search).value,
                      errorMessage:
                          viewModel.getValue(FormFieldValues.search).error,
                      onChange: (value) => viewModel.setTextMessage(value),
                    ),
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  GestureDetector(
                    onTap: () => viewModel.thereAreErrors
                        ? {}
                        : {
                            viewModel.sendMessage(args.id),
                            FocusScope.of(context).requestFocus(FocusNode())
                          },
                    child: Container(
                      width: 52,
                      height: 50,
                      decoration: const BoxDecoration(
                        color: AppColor.widgetBackground,
                        borderRadius: BorderRadius.all(borderRadius),
                        boxShadow: [AppColor.defaultShadow],
                      ),
                      child: const Icon(
                        Icons.send_rounded,
                        size: 24,
                        color: AppColor.darkGrey,
                      ),
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
          ),
        ],
      ),
    );
  }
}
