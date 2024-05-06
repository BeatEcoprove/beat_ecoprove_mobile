import 'package:flutter/material.dart';

abstract class ChatListItem extends StatelessWidget {
  final String userName;
  final String messageText;
  final DateTime sendAt;

  const ChatListItem({
    super.key,
    required this.userName,
    required this.messageText,
    required this.sendAt,
  });
}
