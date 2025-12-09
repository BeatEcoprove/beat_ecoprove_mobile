import 'package:beat_ecoprove/auth/domain/errors/domain_exception.dart';
import 'package:beat_ecoprove/client/clothing/domain/use-cases/get_clothes_use_case%20.dart';
import 'package:beat_ecoprove/client/profile/services/profile_service.dart';
import 'package:beat_ecoprove/core/domain/entities/user.dart';
import 'package:beat_ecoprove/core/domain/models/card_item.dart';
import 'package:beat_ecoprove/core/domain/models/chat.dart';
import 'package:beat_ecoprove/core/domain/models/optionItem.dart';
import 'package:beat_ecoprove/core/helpers/form/form_field_values.dart';
import 'package:beat_ecoprove/core/helpers/form/form_view_model.dart';
import 'package:beat_ecoprove/core/helpers/http/errors/http_error.dart';
import 'package:beat_ecoprove/core/helpers/navigation/navigation_manager.dart';
import 'package:beat_ecoprove/core/locales/locale_context.dart';
import 'package:beat_ecoprove/core/presentation/list_view/list_details_params.dart';
import 'package:beat_ecoprove/core/providers/auth/authentication_provider.dart';
import 'package:beat_ecoprove/core/providers/groups/group_borrow_accept_message.dart';
import 'package:beat_ecoprove/core/providers/groups/group_borrowchat_message.dart';
import 'package:beat_ecoprove/core/providers/groups/group_chat_message.dart';
import 'package:beat_ecoprove/core/providers/groups/group_manager.dart';
import 'package:beat_ecoprove/core/providers/notification_provider.dart';
import 'package:beat_ecoprove/core/providers/websockets/phoenix_ws_notifier.dart';
import 'package:beat_ecoprove/core/routes.dart';
import 'package:beat_ecoprove/core/widgets/chat/chat_item_root.dart';
import 'package:beat_ecoprove/core/widgets/chat/content/chat_message_item.dart';
import 'package:beat_ecoprove/core/widgets/chat/content/chat_trade_item.dart';
import 'package:beat_ecoprove/core/widgets/compact_list_item/compact_list_item_header/image_title_subtitle_header.dart';
import 'package:beat_ecoprove/core/widgets/compact_list_item/compact_list_item_root.dart';
import 'package:beat_ecoprove/core/widgets/present_image.dart';
import 'package:beat_ecoprove/core/widgets/server_image.dart';
import 'package:beat_ecoprove/dependency_injection.dart';
import 'package:beat_ecoprove/group/contracts/chat_borrow_result.dart';
import 'package:beat_ecoprove/group/contracts/chat_message_result.dart';
import 'package:beat_ecoprove/group/contracts/group_details_result.dart';
import 'package:beat_ecoprove/group/contracts/register_trade_request.dart';
import 'package:beat_ecoprove/group/presentation/group_chat/edit_group_page/edit_group_params.dart';
import 'package:beat_ecoprove/group/presentation/group_chat_members/group_chat_params.dart';
import 'package:beat_ecoprove/group/routes.dart';
import 'package:beat_ecoprove/group/services/group_service.dart';
import 'package:flutter/material.dart';

class GroupChatViewModel extends FormViewModel<GroupChatParams> {
  final INotificationProvider _notificationProvider;
  final IPhoenixWsNotifier _sessionWsNotifier;
  final GroupService _groupService;

  final AuthenticationProvider _authProvider;
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
      name: LocaleContext.get().group_group_chat_report_user,
      action: () => {},
    ),
    OptionItem(
      name: LocaleContext.get().group_group_chat_report_msg,
      action: () => {},
    ),
  ];

  final List<CardItem> clothesToTrade = [];

  GroupChatViewModel(
    this._notificationProvider,
    this._authProvider,
    this._getClothesUseCase,
    this._navigationRouter,
    IPhoenixWsNotifier sessionWsNotifier,
    this._groupManager,
    this._groupService,
  ) : _sessionWsNotifier = sessionWsNotifier {
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
      _sessionWsNotifier.joinGroup(arg!.groupDetailsResult.id);
      await initGroupConnection(arg!.groupDetailsResult.id);
    }
  }

  void handleGroupMessage() async {
    var recentMessage = _groupManager.getMessage();

    if (recentMessage == null) {
      return;
    }

    if (recentMessage is GroupChatMessage) {
      try {
        final senderData = await DependencyInjection.locator<ProfileService>()
            .getProfileDataById([recentMessage.senderId]);

        final enrichedMessage = EnrichedGroupChatMessage(
          messageId: recentMessage.messageId,
          senderId: recentMessage.senderId,
          content: recentMessage.content,
          createdAt: recentMessage.createdAt,
          groupId: recentMessage.groupId,
          type: recentMessage.type,
          username: senderData.profiles.first.username,
          avatarPicture: senderData.profiles.first.avatarUrl,
        );

        return addMessage(_messageBody(enrichedMessage));
      } catch (e) {
        print(e.toString());
      }
    }

    if (recentMessage is GroupBorrowChatMessage) {
      try {
        final senderData = await DependencyInjection.locator<ProfileService>()
            .getProfileDataById([recentMessage.senderId]);

        final enrichedMessage = EnrichedGroupBorrowChatMessage(
          messageId: recentMessage.messageId,
          senderId: recentMessage.senderId,
          content: recentMessage.content,
          createdAt: recentMessage.createdAt,
          groupId: recentMessage.groupId,
          type: recentMessage.type,
          username: senderData.profiles.first.username,
          avatarPicture: senderData.profiles.first.avatarUrl,
          clothAvatar: recentMessage.clothAvatar,
          clothTitle: recentMessage.clothTitle,
          clothBrand: recentMessage.clothBrand,
          clothColor: recentMessage.clothColor,
          clothSize: recentMessage.clothSize,
          clothEcoScore: recentMessage.clothEcoScore,
        );

        return addMessage(_messageBody(enrichedMessage));
      } catch (e) {
        print(e.toString());
      }
    }

    if (recentMessage is GroupBorrowAcceptMessage) {
      return handleBorrowAcceptedRequest(recentMessage);
    }
  }

  void handleBorrowAcceptedRequest(GroupBorrowAcceptMessage recentMessage) {
    var index = messages.indexWhere((message) =>
        message.messageId == recentMessage.messageId &&
        message.items.first is ChatTradeItem);

    var foundMessage = messages.elementAt(index);
    var content = foundMessage.items.elementAt(0) as ChatTradeItem;

    messages[index] = ChatItemRoot(
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
      options: foundMessage.options,
      click: foundMessage.click,
    );

    notifyListeners();
  }

  @override
  void dispose() {
    _groupManager.removeListener(handleGroupMessage);
    chatTextController.dispose();
    super.dispose();
  }

  User? get user => _user;

  void addMessage(ChatItemRoot message) {
    final existingIndex = messages.indexWhere(
      (m) => m.messageId == message.messageId,
    );

    if (existingIndex != -1) {
      return;
    }

    messages.add(message);
    notifyListeners();
  }

  ChatItemRoot _messageBody(dynamic message) {
    switch (message.runtimeType) {
      case EnrichedGroupChatMessage:
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

      case EnrichedGroupBorrowChatMessage:
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
              isBlocked:
                  message is ChatBorrowResult ? message.isAccepted : false,
            ),
          ],
          click: () async => await handleTradeOffer(message),
          messageId: message.messageId,
        );

      default:
        return ChatItemRoot(
          userIsSender: false,
          avatarUrl: '',
          createdAt: DateTime.now(),
          options: messageOptions,
          items: [
            ChatMessageItem(
              userName: 'Unknown',
              messageText: 'Unknown message type',
              sendAt: DateTime.now(),
            )
          ],
          messageId: 'unknown',
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
        LocaleContext.get().group_group_chat_exchange_done,
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
    _sessionWsNotifier.leaveGroup(groupId);
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
        throw DomainException(LocaleContext.get().group_group_chat_add_msg);
      }

      _sessionWsNotifier.sendTextMessage(groupId, text);
      clearChatText();
    } on DomainException catch (e) {
      _notificationProvider.showNotification(
        e.message,
        type: NotificationTypes.error,
      );
    }
  }

  Future<void> getClothesToTrade(int page, int pageSize, String search) async {
    Map<String, String> param = {};

    param.addAll({search: "search"});

    try {
      clothesToTrade.clear();

      var result = await _getClothesUseCase.handle(
        GetClothesUseCaseRequest(
          page: page,
          pageSize: pageSize,
          params: param,
        ),
      );

      clothesToTrade.addAll(result);
    } on HttpError catch (e) {
      _notificationProvider.showNotification(
        e.getError().title,
        type: NotificationTypes.error,
      );
    } catch (e) {
      print(e.toString());
    }

    notifyListeners();
  }

  List<Widget> _renderCards(List<CardItem> clothes, String groupId) {
    return clothes
        .map(
          (e) => Container(
            margin: const EdgeInsets.symmetric(vertical: 4),
            child: CompactListItemRoot(
              click: () => {
                _prepareTradeOffer(e.id, groupId),
                _navigationRouter.pop(),
              },
              items: [
                ImageTitleSubtitleHeader(
                  widget: PresentImage(
                    path: ServerImage(e.child),
                  ),
                  title: e.title,
                  subTitle: e.brand!,
                ),
              ],
            ),
          ),
        )
        .toList();
  }

  void sendTradeOffer(String groupId, BuildContext context) {
    _navigationRouter.push(
      CoreRoutes.listDetails,
      extras: ListDetailsViewParams(
        title: LocaleContext.get().group_group_chat_select_cloth,
        numberMaxItemsPage:
            (MediaQuery.sizeOf(context).height.ceil() / 70).ceil() + 2,
        onSearchPagination: (searchTerm, vm, page, pageSize) async {
          await getClothesToTrade(page, pageSize, searchTerm);

          return _renderCards(clothesToTrade, groupId);
        },
      ),
    );
  }

  void _prepareTradeOffer(String clothId, String groupId) {
    try {
      _sessionWsNotifier.sendTradeOfferOnGroup(
        groupId,
        LocaleContext.get().group_group_chat_ask_trade_cloth,
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

      List<String> adminsIds =
          arg!.groupDetailsResult.admins!.profiles.map((e) => e.id).toList();

      adminsIds.add(arg!.groupDetailsResult.creator.id);

      await _navigationRouter.pushAsync(
        GroupRoutes.update,
        extras: EditGroupParams(
          group: arg!.groupDetailsResult,
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

  void goToChatMembers(GroupDetailsResult arguments) => _navigationRouter.push(
        GroupRoutes.members,
        extras: GroupChatParams(
          groupDetailsResult: arguments,
        ),
      );
}
