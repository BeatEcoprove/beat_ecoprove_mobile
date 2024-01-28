import 'package:beat_ecoprove/auth/domain/errors/domain_exception.dart';
import 'package:beat_ecoprove/core/domain/entities/user.dart';
import 'package:beat_ecoprove/core/helpers/form/form_field_values.dart';
import 'package:beat_ecoprove/core/helpers/form/form_view_model.dart';
import 'package:beat_ecoprove/core/helpers/http/errors/http_badrequest_error.dart';
import 'package:beat_ecoprove/core/providers/auth/authentication_provider.dart';
import 'package:beat_ecoprove/core/providers/groups/group_manager.dart';
import 'package:beat_ecoprove/core/providers/notification_provider.dart';
import 'package:beat_ecoprove/core/providers/websockets/group_ws_notifier.dart';
import 'package:beat_ecoprove/core/widgets/chat/chat_message_text.dart';
import 'package:beat_ecoprove/group/domain/use-cases/get_details_use_case.dart';
import 'package:beat_ecoprove/group/presentation/group_chat/edit_group_page/edit_group_view.dart';
import 'package:beat_ecoprove/group/services/group_service.dart';
import 'package:go_router/go_router.dart';

class GroupChatViewModel extends FormViewModel {
  final NotificationProvider _notificationProvider;
  final GroupWSNotifier _groupWSNotifier;
  final GroupService _groupService;

  final AuthenticationProvider _authProvider;
  final GetDetailsUseCase _getDetailsUseCase;
  final GoRouter _navigationRouter;
  final GroupManager _groupManager;
  final List<ChatMessageText> messages = [];
  late bool isLoading = false;
  late final User _user;

  GroupChatViewModel(
    this._notificationProvider,
    this._authProvider,
    this._getDetailsUseCase,
    this._navigationRouter,
    this._groupWSNotifier,
    this._groupManager,
    this._groupService,
  ) {
    _user = _authProvider.appUser;
    initializeFields([
      FormFieldValues.search,
    ]);

    _groupManager.addListener(handleGroupMessage);
  }

  void handleGroupMessage() {
    messages.clear();
    var mapMessages = _groupManager.messages.map((message) {
      return ChatMessageText(
        messageText: message.message,
        createdAt: DateTime.now(),
      );
    });

    messages.addAll(mapMessages);
    notifyListeners();
  }

  @override
  void dispose() {
    _groupManager.removeListener(handleGroupMessage);
    super.dispose();
  }

  User get user => _user;

  Future initGroupConnection(String groupId) async {
    _groupWSNotifier.listen(groupId);
    var fetchChatMessages = await _groupService.getMessages(groupId);

    messages.clear();
    var mapMessages = fetchChatMessages.messages.map((message) {
      return ChatMessageText(
        messageText: message.content,
        createdAt: message.createdAt,
      );
    });

    messages.addAll(mapMessages);
    messages.sort((a, b) => a.createdAt.compareTo(b.createdAt));
    notifyListeners();
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

      _groupWSNotifier.sendGroupMessage(groupId, text);
    } on DomainException catch (e) {
      _notificationProvider.showNotification(
        e.message,
        type: NotificationTypes.error,
      );
    }
  }

  Future updateGroup(String groupId) async {
    try {
      isLoading = true;
      var groupDetails = await _getDetailsUseCase.handle(groupId);

      List<String> adminsIds = groupDetails.admins.map((e) => e.id).toList();

      adminsIds.add(groupDetails.creator.id);

      await _navigationRouter.push(
        "/update",
        extra: UpdateGroupParams(
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
}
