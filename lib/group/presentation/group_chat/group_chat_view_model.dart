import 'package:beat_ecoprove/auth/domain/errors/domain_exception.dart';
import 'package:beat_ecoprove/client/clothing/domain/use-cases/get_clothes_use_case%20.dart';
import 'package:beat_ecoprove/core/domain/entities/user.dart';
import 'package:beat_ecoprove/core/domain/models/group_item.dart';
import 'package:beat_ecoprove/core/domain/models/optionItem.dart';
import 'package:beat_ecoprove/core/helpers/form/form_field_values.dart';
import 'package:beat_ecoprove/core/helpers/form/form_view_model.dart';
import 'package:beat_ecoprove/core/helpers/http/errors/http_error.dart';
import 'package:beat_ecoprove/core/helpers/navigation/navigation_manager.dart';
import 'package:beat_ecoprove/core/presentation/list_view/list_details_params.dart';
import 'package:beat_ecoprove/core/providers/auth/authentication_provider.dart';
import 'package:beat_ecoprove/core/providers/groups/group_borrow_accept_message.dart';
import 'package:beat_ecoprove/core/providers/groups/group_borrowchat_message.dart';
import 'package:beat_ecoprove/core/providers/groups/group_chat_message.dart';
import 'package:beat_ecoprove/core/providers/groups/group_manager.dart';
import 'package:beat_ecoprove/core/providers/notification_provider.dart';
import 'package:beat_ecoprove/core/providers/websockets/single_ws_notifier.dart';
import 'package:beat_ecoprove/core/routes.dart';
import 'package:beat_ecoprove/core/widgets/chat/chat_item_root.dart';
import 'package:beat_ecoprove/core/widgets/chat/content/chat_message_item.dart';
import 'package:beat_ecoprove/core/widgets/chat/content/chat_trade_item.dart';
import 'package:beat_ecoprove/core/widgets/compact_list_item/compact_list_item_header/image_title_subtitle_header.dart';
import 'package:beat_ecoprove/core/widgets/compact_list_item/compact_list_item_root.dart';
import 'package:beat_ecoprove/core/widgets/present_image.dart';
import 'package:beat_ecoprove/core/widgets/server_image.dart';
import 'package:beat_ecoprove/group/contracts/chat_borrow_result.dart';
import 'package:beat_ecoprove/group/contracts/chat_message_result.dart';
import 'package:beat_ecoprove/group/contracts/register_trade_request.dart';
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
  final GetClothesUseCase _getClothesUseCase;
  final INavigationManager _navigationRouter;
  final GroupManager _groupManager;
  final List<ChatItemRoot> messages = [];
  late bool isLoading = false;
  late bool hasConnectionActive = false;
  late final User? _user;

  late final TextEditingController chatTextController;

  final List<OptionItem> messageOptions = [
    OptionItem(
      name: "Denunciar Utilizador",
      action: () => {},
    ),
    OptionItem(
      name: "Denunciar Mensagem",
      action: () => {},
    ),
  ];

  GroupChatViewModel(
    this._notificationProvider,
    this._authProvider,
    this._getDetailsUseCase,
    this._getClothesUseCase,
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

    if (recentMessage is GroupChatMessage) {
      return addMessage(_messageBody(recentMessage));
    }

    handleBorrowAcceptedRequest(recentMessage as GroupBorrowAcceptMessage);
  }

  void handleBorrowAcceptedRequest(GroupBorrowAcceptMessage recentMessage) {
    var index = messages.indexWhere((message) =>
        message.messageId == recentMessage.messageId &&
        message.items.first is ChatTradeItem);

    var foundMessage = messages.elementAt(index);
    var content = foundMessage.items.elementAt(0) as ChatTradeItem;
    messages.removeAt(index);

    addMessage(ChatItemRoot(
      userIsSender: foundMessage.userIsSender,
      avatarUrl: foundMessage.avatarUrl,
      createdAt: foundMessage.createdAt,
      items: [
        ChatTradeItem(
          userName: content.userName,
          messageText: content.messageText,
          sendAt: content.sendAt,
          clothImage: content.clothImage,
          clothName: content.clothName,
          clothBrand: content.clothBrand,
          clothColor: content.clothColor,
          clothSize: content.clothSize,
          clothEcoScore: content.clothEcoScore,
          isBlocked: true,
        )
      ],
      messageId: foundMessage.messageId,
    ));
  }

  @override
  void dispose() {
    _groupManager.removeListener(handleGroupMessage);
    super.dispose();
  }

  User? get user => _user;

  void addMessage(ChatItemRoot message) {
    messages.add(message);
    notifyListeners();
  }

  ChatItemRoot _messageBody(dynamic message) {
    switch (message.runtimeType) {
      case GroupChatMessage:
      case ChatMessageResult:
        return ChatItemRoot(
          userIsSender: message.senderId == _user?.id,
          avatarUrl: message.avatarPicture,
          createdAt: message.createdAt,
          options: messageOptions,
          items: [
            ChatMessageItem(
              userName: message.username,
              messageText: message.content,
              sendAt: message.createdAt,
            )
          ],
          messageId: message.messageId,
        );

      case GroupBorrowChatMessage:
      case ChatBorrowResult:
        return ChatItemRoot(
          userIsSender: message.senderId == _user?.id,
          avatarUrl: message.avatarPicture,
          createdAt: message.createdAt,
          options: messageOptions,
          items: [
            ChatTradeItem(
              userName: message.username,
              messageText: message.content,
              sendAt: message.createdAt,
              clothImage: message.clothAvatar,
              clothName: message.clothTitle,
              clothBrand: message.clothBrand,
              clothColor: message.clothColor,
              clothSize: message.clothSize,
              clothEcoScore: message.clothEcoScore,
              isBlocked: message.isAccepted,
            ),
          ],
          click: () async => await handleTradeOffer(message),
          messageId: message.messageId,
        );
      default:
        return ChatItemRoot(
          userIsSender: message.senderId == _user?.id,
          avatarUrl: message.avatarPicture,
          createdAt: message.createdAt,
          options: messageOptions,
          items: [
            ChatMessageItem(
              userName: message.username,
              messageText: message.content,
              sendAt: message.createdAt,
            )
          ],
          messageId: message.messageId,
        );
    }
  }

  Future handleTradeOffer(dynamic message) async {
    try {
      await _groupService.makeTrade(
        RegisterTradeRequest(
          message.groupId,
          message.messageId,
          _user?.id ?? '',
        ),
      );

      _notificationProvider.showNotification(
        "Troca realizada com sucesso!",
        type: NotificationTypes.success,
      );
    } on HttpError catch (e) {
      _notificationProvider.showNotification(
        e.getError().title,
        type: NotificationTypes.error,
      );
    } catch (e) {
      print(e.toString());
    }
  }

  Future initGroupConnection(String groupId) async {
    var fetchChatMessages = await _groupService.getMessages(groupId);

    messages.clear();
    var mapMessages = fetchChatMessages.messages.map(
      (message) {
        return _messageBody(message);
      },
    );

    messages.addAll(mapMessages);
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

  void sendTradeOffer(String groupId) {
    _navigationRouter.push(
      CoreRoutes.listDetails,
      extras: ListDetailsViewParams(
        title: "Selecione uma Roupa para trocar",
        onSearch: (searchTerm, vm) async {
          var clothes =
              await _getClothesUseCase.handle(GetClothesUseCaseRequest());

          return clothes
              .where((cloth) =>
                  cloth.title.toLowerCase().contains(searchTerm.toLowerCase()))
              .map(
            (cloth) {
              return Container(
                margin: const EdgeInsets.symmetric(vertical: 4),
                child: CompactListItemRoot(
                  click: () => {
                    _prepareTradeOffer(cloth.id, groupId),
                    _navigationRouter.pop(),
                  },
                  items: [
                    ImageTitleSubtitleHeader(
                      widget: PresentImage(
                        path: ServerImage(cloth.child),
                      ),
                      title: cloth.title,
                      subTitle: cloth.brand!,
                    ),
                  ],
                ),
              );
            },
          ).toList();
        },
      ),
    );
  }

  void _prepareTradeOffer(String clothId, String groupId) {
    try {
      _sessionWsNotifier.sendTradeOfferOnGroup(
        groupId,
        "Alguém quer trocar esta peça de roupa?",
        clothId,
      );
    } on DomainException catch (e) {
      _notificationProvider.showNotification(
        e.message,
        type: NotificationTypes.error,
      );
    }
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
    } on HttpError catch (e) {
      _notificationProvider.showNotification(
        e.getError().title,
        type: NotificationTypes.error,
      );
    } catch (e) {
      print(e.toString());
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
