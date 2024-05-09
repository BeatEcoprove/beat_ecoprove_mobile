import 'package:beat_ecoprove/core/config/global.dart';
import 'package:beat_ecoprove/core/domain/models/group_item.dart';
import 'package:beat_ecoprove/core/helpers/form/form_field_values.dart';
import 'package:beat_ecoprove/core/view.dart';
import 'package:beat_ecoprove/core/widgets/application_background.dart';
import 'package:beat_ecoprove/core/widgets/compact_list_item/compact_list_item_footer/without_options_footer/with_text_footer.dart';
import 'package:beat_ecoprove/core/widgets/compact_list_item/compact_list_item_header/image_title_subtitle_header.dart';
import 'package:beat_ecoprove/core/widgets/compact_list_item/compact_list_item_root.dart';
import 'package:beat_ecoprove/core/widgets/floating_button.dart';
import 'package:beat_ecoprove/core/widgets/headers/standard_header.dart';
import 'package:beat_ecoprove/core/widgets/line.dart';
import 'package:beat_ecoprove/core/widgets/notification_viewer.dart';
import 'package:beat_ecoprove/core/widgets/server_image.dart';
import 'package:beat_ecoprove/group/presentation/group_index/group_view_model.dart';
import 'package:flutter/material.dart';

class GroupView extends LinearView<GroupViewModel> {
  const GroupView({
    super.key,
    required super.viewModel,
  });

  @override
  Widget build(BuildContext context, GroupViewModel viewModel) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: StandardHeader.searchBar(
        title: "Grupos",
        sustainablePoints: viewModel.user?.sustainablePoints ?? 0,
        hasSustainablePoints: false,
        hasSettings: false,
        onChange: (search) => viewModel.setSearch(search),
        initialValue: '',
        errorMessage: viewModel.getValue(FormFieldValues.search).error,
      ),
      body: AppBackground(
        content: Stack(
          children: [
            SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 26,
                      ),
                      child: Column(
                        children: [
                          if (viewModel.privateGroups.isNotEmpty)
                            ...renderPrivateGroups(viewModel),
                          const SizedBox(
                            height: 26,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Grupos Globais",
                                style: AppText.titleToScrollSection,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Container(
                                margin: const EdgeInsets.only(right: 12),
                                child: GestureDetector(
                                  child: const Text(
                                    "Ver Mais",
                                    textAlign: TextAlign.center,
                                    style: AppText.underlineStyle,
                                  ),
                                  onTap: () =>
                                      viewModel.goToPublicList(_renderCards),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          viewModel.publicGroups.isEmpty && viewModel.isFetching
                              ? const Center(
                                  child: CircularProgressIndicator(
                                    color: AppColor.darkGreen,
                                  ),
                                )
                              : Column(
                                  children: _renderCards(
                                    viewModel.publicGroups,
                                  ),
                                ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 16,
              right: 26,
              child: FloatingButton(
                color: AppColor.darkGreen,
                dimension: 64,
                icon: const Icon(
                  size: 34,
                  Icons.add_circle_outline_rounded,
                  color: AppColor.widgetBackground,
                ),
                onPressed: () async => await viewModel.createGroup(),
              ),
            ),
            Positioned(
              bottom: 78,
              right: 9,
              child: NotificationView(
                notifications: viewModel.notifications,
              ),
            )
          ],
        ),
        type: AppBackgrounds.members,
      ),
    );
  }

  List<Widget> _renderCards(List<GroupItem> groups) {
    return groups
        .map(
          (e) => Container(
            margin: const EdgeInsets.symmetric(
              vertical: 4,
            ),
            child: CompactListItemRoot(
              click: () async => await viewModel.gotToChatGroup(e),
              items: [
                ImageTitleSubtitleHeader(
                  isCircular: true,
                  widget: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image(
                      image: ServerImage(e.avatarPicture),
                      fit: BoxFit.cover,
                    ),
                  ),
                  title: e.name,
                  subTitle: "${e.membersCount} membros",
                ),
                WithTextFooter(text: e.isPublic ? "Público" : "Privado"),
              ],
            ),
          ),
        )
        .toList();
  }

  renderPrivateGroups(GroupViewModel viewModel) {
    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "Meus Grupos",
            style: AppText.titleToScrollSection,
            overflow: TextOverflow.ellipsis,
          ),
          Container(
            margin: const EdgeInsets.only(right: 12),
            child: GestureDetector(
              child: const Text(
                "Ver Mais",
                textAlign: TextAlign.center,
                style: AppText.underlineStyle,
              ),
              onTap: () => viewModel.goToMyGroupsList(_renderCards),
            ),
          )
        ],
      ),
      const SizedBox(
        height: 12,
      ),
      Column(
        children: _renderCards(
          viewModel.privateGroups,
        ),
      ),
      const SizedBox(
        height: 26,
      ),
      const Line(
        width: 200,
        color: AppColor.separatedLine,
      ),
    ];
  }
}
