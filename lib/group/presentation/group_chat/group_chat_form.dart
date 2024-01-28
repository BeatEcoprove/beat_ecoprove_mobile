import 'package:beat_ecoprove/auth/widgets/scroll_handler.dart';
import 'package:beat_ecoprove/core/config/global.dart';
import 'package:beat_ecoprove/core/domain/models/group_item.dart';
import 'package:beat_ecoprove/core/helpers/form/form_field_values.dart';
import 'package:beat_ecoprove/core/view_model.dart';
import 'package:beat_ecoprove/core/widgets/circular_button.dart';
import 'package:beat_ecoprove/core/widgets/formatted_text_field/default_formatted_text_field.dart';
import 'package:beat_ecoprove/core/widgets/headers/group_header.dart';
import 'package:beat_ecoprove/group/presentation/group_chat/group_chat_view_model.dart';
import 'package:beat_ecoprove/group/presentation/group_chat_members/group_chat_members_form.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class GroupChatForm extends StatefulWidget {
  final GroupItem groupItem;

  const GroupChatForm({super.key, required this.groupItem});

  @override
  State<GroupChatForm> createState() => _GroupChatFormState();
}

class _GroupChatFormState extends State<GroupChatForm> {
  @override
  Widget build(BuildContext context) {
    final viewModel = ViewModel.of<GroupChatViewModel>(context);
    final goRouter = GoRouter.of(context);
    const Radius borderRadius = Radius.circular(5);
    const lateralPadding = 38;
    double maxWidth = MediaQuery.of(context).size.width - lateralPadding;

    var params = GroupParams(
      groupId: widget.groupItem.id,
      title: widget.groupItem.name,
      state: widget.groupItem.isPublic == true ? "Público" : "Privado",
      numberMembers: widget.groupItem.membersCount.toString(),
    );

    return Scaffold(
      appBar: GroupHeader(
        title: params.title,
        state: params.state,
        numberMembers: params.numberMembers,
      ),
      body: FutureBuilder(
        future: viewModel.initGroupConnection(widget.groupItem.id),
        builder: (context, snapshot) => Stack(
          children: [
            Positioned.fill(
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 16, right: 16, top: 16, bottom: 84),
                child: ScrollHandler(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: viewModel.messages,
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
            Positioned(
              top: 70,
              right: 20,
              child: CircularButton(
                height: 46,
                icon: const Icon(
                  Icons.mode_edit_outline_outlined,
                  color: AppColor.bottomNavigationBar,
                ),
                onPress: () async => viewModel.isLoading
                    ? {}
                    : await viewModel.updateGroup(widget.groupItem.id),
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
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    SizedBox(
                      width: maxWidth - 100,
                      child: DefaultFormattedTextField(
                        hintText: "Escreve a tua mensagem...",
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
                          : viewModel.sendMessage(widget.groupItem.id),
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
      ),
    );
  }
}
