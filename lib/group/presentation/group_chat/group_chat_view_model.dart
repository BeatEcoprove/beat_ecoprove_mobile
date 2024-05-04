import 'package:beat_ecoprove/auth/domain/errors/domain_exception.dart';
import 'package:beat_ecoprove/core/domain/entities/user.dart';
import 'package:beat_ecoprove/core/domain/models/group_item.dart';
import 'package:beat_ecoprove/core/helpers/form/form_field_values.dart';
import 'package:beat_ecoprove/core/helpers/form/form_view_model.dart';
import 'package:beat_ecoprove/core/helpers/http/errors/http_badrequest_error.dart';
import 'package:beat_ecoprove/core/helpers/navigation/navigation_manager.dart';
import 'package:beat_ecoprove/core/providers/auth/authentication_provider.dart';
import 'package:beat_ecoprove/core/providers/groups/group_manager.dart';
import 'package:beat_ecoprove/core/providers/notification_provider.dart';
import 'package:beat_ecoprove/core/providers/websockets/single_ws_notifier.dart';
import 'package:beat_ecoprove/core/widgets/chat/chat_item_root.dart';
import 'package:beat_ecoprove/core/widgets/chat/content/chat_message_item.dart';
import 'package:beat_ecoprove/group/domain/use-cases/get_details_use_case.dart';
import 'package:beat_ecoprove/group/presentation/group_chat/edit_group_page/edit_group_params.dart';
import 'package:beat_ecoprove/group/presentation/group_chat_members/group_chat_params.dart';
import 'package:beat_ecoprove/group/routes.dart';
import 'package:beat_ecoprove/group/services/group_service.dart';
import 'package:flutter/material.dart';

class GroupChatViewModel extends FormViewModel<GroupItem> {
  final INotificationProvider _notificationProvider;
  final IWCNotifier _sessionWsNotifier;
  final GroupService _groupService;

  final AuthenticationProvider _authProvider;
  final GetDetailsUseCase _getDetailsUseCase;
  final INavigationManager _navigationRouter;
  final GroupManager _groupManager;
  final List<ChatItemRoot> messages = [];
  late bool isLoading = false;
  late bool hasConnectionActive = false;
  late final User _user;

  late final TextEditingController chatTextController;

  GroupChatViewModel(
    this._notificationProvider,
    this._authProvider,
    this._getDetailsUseCase,
    this._navigationRouter,
    this._sessionWsNotifier,
    this._groupManager,
    this._groupService,
  ) {
    _user = _authProvider.appUser;
    initializeFields([
      FormFieldValues.search,
    ]);

    chatTextController = TextEditingController(
      text: getValue(FormFieldValues.search).value ?? "",
    );
  }

  @override
  void initSync() async {
    _groupManager.addListener(handleGroupMessage);

    if (arg != null) {
      _sessionWsNotifier.enterGroup(arg!.id);
      await initGroupConnection(arg!.id);
    }
  }

  void handleGroupMessage() {
    var recentMessage = _groupManager.getMessage();

    addMessage(
      ChatItemRoot(
        userIsSender: recentMessage.senderId == _user.id,
        avatarUrl: recentMessage.avatarPicture,
        createdAt: DateTime.now(),
        items: [
          ChatMessageItem(
            userName: recentMessage.username,
            messageText: recentMessage.message,
            sendAt: DateTime.now(),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    _groupManager.removeListener(handleGroupMessage);
    super.dispose();
  }

  User get user => _user;

  void addMessage(ChatItemRoot message) {
    messages.add(message);
    notifyListeners();
  }

  Future initGroupConnection(String groupId) async {
    var fetchChatMessages = await _groupService.getMessages(groupId);

    messages.clear();
    var mapMessages = fetchChatMessages.messages.map((message) {
      return ChatItemRoot(
        userIsSender: message.senderId == _user.id,
        avatarUrl: message.avatarPicture,
        createdAt: message.createdAt,
        items: [
          ChatMessageItem(
            userName: message.username,
            messageText: message.content,
            sendAt: message.createdAt,
          )
        ],
      );
    });

    messages.addAll(mapMessages);
    messages.sort((a, b) => a.createdAt.compareTo(b.createdAt));
    notifyListeners();
  }

  void exitGroup(String groupId) {
    _sessionWsNotifier.exitGroup(groupId);
  }

  void setTextMessage(String text) {
    try {
      setValue(FormFieldValues.search, text);
    } on DomainException catch (e) {
      setError(FormFieldValues.search, e.message);
    }
  }

  void sendMessage(String groupId) {
    try {
      var text = getValue(FormFieldValues.search).value ?? "";

      if (text.isEmpty) {
        throw DomainException("Digite uma mensagem");
      }

      _sessionWsNotifier.sendMessageOnGroup(groupId, text);
    } on DomainException catch (e) {
      _notificationProvider.showNotification(
        e.message,
        type: NotificationTypes.error,
      );
    }

    clearChatText();
  }

  void clearChatText() {
    setValue(FormFieldValues.search, "");
    chatTextController.clear();
  }

  Future updateGroup(String groupId) async {
    try {
      isLoading = true;
      var groupDetails = await _getDetailsUseCase.handle(groupId);

      List<String> adminsIds = groupDetails.admins.map((e) => e.id).toList();

      adminsIds.add(groupDetails.creator.id);

      await _navigationRouter.pushAsync(
        GroupRoutes.update,
        extras: EditGroupParams(
          group: groupDetails,
          adminId: adminsIds,
        ),
      );
    } on HttpBadRequestError catch (e) {
      _notificationProvider.showNotification(
        e.getError().title,
        type: NotificationTypes.error,
      );
    } catch (e) {
      print("$e");

      _notificationProvider.showNotification(
        e.toString(),
        type: NotificationTypes.error,
      );
    }
    isLoading = false;
  }

  void goToChatMembers(GroupItem arguments) => _navigationRouter.push(
        GroupRoutes.members,
        extras: GroupChatParams(
          groupId: arguments.id,
          title: arguments.name,
          state: arguments.isPublic ? "Publico" : "Privado",
          numberMembers: arguments.membersCount.toString(),
        ),
      );
}
