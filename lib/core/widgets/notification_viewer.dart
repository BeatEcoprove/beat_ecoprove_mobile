import 'package:beat_ecoprove/core/config/global.dart';
import 'package:beat_ecoprove/core/domain/models/buttonItem.dart';
import 'package:beat_ecoprove/core/helpers/navigation/navigation_manager.dart';
import 'package:beat_ecoprove/core/presentation/list_view/list_details_params.dart';
import 'package:beat_ecoprove/core/presentation/list_view/list_details_view_model.dart';
import 'package:beat_ecoprove/core/providers/notifications/notification.dart';
import 'package:beat_ecoprove/core/routes.dart';
import 'package:beat_ecoprove/core/widgets/compact_list_item/compact_list_item_footer/with_buttons_footer/with_buttons_footer.dart';
import 'package:beat_ecoprove/core/widgets/compact_list_item/compact_list_item_header/text_header.dart';
import 'package:beat_ecoprove/core/widgets/compact_list_item/compact_list_item_root.dart';
import 'package:beat_ecoprove/core/widgets/floating_button.dart';
import 'package:beat_ecoprove/core/widgets/step_by_step/circle.dart';
import 'package:beat_ecoprove/dependency_injection.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NotificationModal extends StatelessWidget {
  const NotificationModal({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class NotificationView extends StatefulWidget {
  final List<GroupNotification> notifications;
  final String notificationCount;

  NotificationView({super.key, required this.notifications})
      : notificationCount = notifications.length.toString();

  @override
  State<NotificationView> createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
  List<Widget> _renderCards(
    GoRouter goRouter,
    List<GroupNotification> notifications,
    ListDetailsViewModel viewModel,
    String searchTerm,
  ) {
    return notifications
        .where((invite) =>
            invite.title.toLowerCase().contains(searchTerm.toLowerCase()))
        .map(
          (e) => Container(
            margin: const EdgeInsets.symmetric(
              vertical: 4,
            ),
            child: CompactListItemRoot(
              items: [
                TextHeader(
                  title: e.title,
                  subTitle: e.message,
                  widthFooter: 40,
                ),
                WithButtonsFooter(options: [
                  ButtonItem(
                    icon: const Icon(
                      Icons.check,
                      color: AppColor.darkGreen,
                    ),
                    action: () async {
                      await e.handleAccept(e);
                      widget.notifications.remove(e);
                      viewModel.refresh();
                    },
                  ),
                  ButtonItem(
                    icon: const Icon(
                      Icons.close_rounded,
                      color: AppColor.endSession,
                    ),
                    action: () async {
                      await e.handleDenied(e);
                      widget.notifications.remove(e);
                      viewModel.refresh();
                    },
                  ),
                ]),
              ],
            ),
          ),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final GoRouter goRouter = GoRouter.of(context);

    return InkWell(
      onTap: () {
        DependencyInjection.locator<INavigationManager>().push(
          CoreRoutes.listDetails,
          extras: ListDetailsViewParams(
            title: "Convites",
            onSearch: (searchTerm, vm) async {
              return _renderCards(
                goRouter,
                widget.notifications,
                vm,
                searchTerm,
              );
            },
          ),
        );
      },
      child: Stack(
        children: [
          const FloatingButton(
            color: AppColor.buttonBackground,
            dimension: 49,
            icon: Icon(
              size: 29,
              Icons.notifications_none_rounded,
              color: AppColor.widgetBackground,
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: Circle(
              height: 25,
              isFull: true,
              child: Text(
                widget.notificationCount,
                style: const TextStyle(
                  color: AppColor.widgetBackground,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
