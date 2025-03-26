import 'package:eassist_tools_app/blocs/chatting/chatgroupcari_bloc.dart';
import 'package:eassist_tools_app/pages/groupchat/groupchat_page.dart';
import 'package:eassist_tools_app/widgets/mobiledesign_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GroupChatMainPage extends StatelessWidget {
  final String roomId;
  final String roomName;
  final String groupName;

  const GroupChatMainPage(
      {super.key,
      required this.roomId,
      required this.roomName,
      required this.groupName});

  @override
  Widget build(BuildContext context) {
    
    context.read<ChatGroupCariBloc>().add(ResetStateEvent());

    return MobileDesignWidget(
      child: Scaffold(
          appBar: AppBar(
            title: Text("$groupName - $roomName"),
          ),
          backgroundColor: Colors.grey[200],
          body: ChatPage(roomId: roomId)),
    );
  }
}
