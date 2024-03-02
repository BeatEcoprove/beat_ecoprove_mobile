import 'package:beat_ecoprove/core/config/global.dart';
import 'package:beat_ecoprove/core/presentation/list_view/list_details_view.dart';
import 'package:beat_ecoprove/core/widgets/compact_list_item.dart';
import 'package:beat_ecoprove/core/widgets/floating_button.dart';
import 'package:beat_ecoprove/core/widgets/step_by_step/circle.dart';
import 'package:beat_ecoprove/core/providers/notifications/notification.dart'
    as custom_notification;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

typedef CustomNotification = custom_notification.Notification;

class NotificationModal extends StatelessWidget {
  const NotificationModal({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class NotificationView extends StatefulWidget {
  final List<CustomNotification> notifications;
  final String notificationCount;

  NotificationView({super.key, required this.notifications})
      : notificationCount = notifications.length.toString();

  @override
  State<NotificationView> createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
  // List<Widget> _renderCards(GoRouter goRouter, List<GroupItem> notifications) {
  //   return notifications
  //       .map(
  //         (e) => Container(
  //           margin: const EdgeInsets.symmetric(
  //             vertical: 4,
  //           ),
  //           child: CompactListItem.withoutOptions(
  //             widget: Container(),
  //             title: e.name,
  //             subTitle: "",
  //           ),
  //         ),
  //       )
  //       .toList();
  // }

  @override
  Widget build(BuildContext context) {
    final GoRouter goRouter = GoRouter.of(context);

    return Stack(
      children: [
        FloatingButton(
          onPressed: () {
            // goRouter.push(
            //   "/list_details",
            //   extra: ListDetailsViewParams(
            //       title: "Convites",
            //       onSearch: (searchTerm) async {
            //         // await viewModel.getGroups(100, searchTerm);

            //         return _renderCards(
            //           goRouter,
            //           widget.notifications,
            //         );
            //       }),
            // );
            var notification = widget.notifications.first;
            print(notification);
            notification.handle(notification);
          },
          color: AppColor.buttonBackground,
          dimension: 49,
          icon: const Icon(
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
    );
  }
}
