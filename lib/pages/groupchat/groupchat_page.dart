import 'dart:async';
import 'dart:io';

import 'package:eassist_tools_app/blocs/chatting/chatgroupcari_bloc.dart';
import 'package:eassist_tools_app/blocs/chatting/chatgroupcrud_bloc.dart';
import 'package:eassist_tools_app/common/app_data.dart';
import 'package:eassist_tools_app/common/constants.dart';
import 'package:eassist_tools_app/models/chatting/groupchat_model.dart';
import 'package:eassist_tools_app/widgets/my_colors.dart';
import 'package:eassist_tools_app/widgets/my_text.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

class ChatPage extends StatefulWidget {
  final String roomId;
  const ChatPage({super.key, required this.roomId});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late ChatGroupCariBloc chatCariBloc;
  late Timer timer;

  final _user = types.User(
    id: AppData.user.username!,
  );

  @override
  void initState() {
    super.initState();
    
    Future.delayed(const Duration(milliseconds: 500), () {
      refreshData(widget.roomId);
    });
    
    timer = Timer.periodic(Duration(seconds: AppData.chatRefresh), (timer) {
      refreshData(widget.roomId);
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  void _addMessage(types.Message message) {
    late GroupchatModel msg;

    debugPrint("_user : ${_user.toString()}");
    if (message.type.name == "text") {
      debugPrint("text");
      types.TextMessage txtMsg = message as types.TextMessage;
      msg = GroupchatModel(
          roomId: widget.roomId,
          id: txtMsg.id,
          createdAt: txtMsg.createdAt,
          text: txtMsg.text,
          type: txtMsg.type.name);

      BlocProvider.of<ChatGroupCrudBloc>(context)
          .add(AddTextChatGroupEvent(chatmsg: msg));
    } else if (message.type.name == "file") {
      //debugPrint("file");
      types.FileMessage fileMsg = message as types.FileMessage;
      msg = GroupchatModel(
          roomId: widget.roomId,
          id: fileMsg.id,
          createdAt: fileMsg.createdAt,
          mimeType: fileMsg.mimeType,
          size: fileMsg.size,
          uri: fileMsg.uri,
          name: fileMsg.name,
          type: fileMsg.type.name);

      BlocProvider.of<ChatGroupCrudBloc>(context)
          .add(AddAttachmentChatGroupEvent(chatmsg: msg));
    } else if (message.type.name == "image") {
      //debugPrint("image");
      types.ImageMessage imgMsg = message as types.ImageMessage;
      msg = GroupchatModel(
          roomId: widget.roomId,
          id: imgMsg.id,
          createdAt: imgMsg.createdAt,
          height: imgMsg.height,
          width: imgMsg.width,
          size: imgMsg.size,
          uri: imgMsg.uri,
          name: imgMsg.name,
          type: imgMsg.type.name);

      BlocProvider.of<ChatGroupCrudBloc>(context)
          .add(AddAttachmentChatGroupEvent(chatmsg: msg));
    }
  }

  void _handleAttachmentPressed() {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) => SafeArea(
        child: SizedBox(
          height: 192,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  _handleImageSelection();
                },
                child: const Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text('Photo'),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  _handleCameraSelection();
                },
                child: const Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text('Camera'),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  _handleFileSelection();
                },
                child: const Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text('File'),
                ),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text('Cancel'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleFileSelection() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.any,
    );

    if (result != null && result.files.single.path != null) {
      final message = types.FileMessage(
        author: _user,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        id: const Uuid().v4(),
        mimeType: lookupMimeType(result.files.single.path!),
        name: result.files.single.name,
        size: result.files.single.size,
        uri: result.files.single.path!,
      );

      _addMessage(message);
    }
  }

  void _handleCameraSelection() async {
    final result = await ImagePicker().pickImage(
      imageQuality: 70,
      maxWidth: 1440,
      source: ImageSource.camera,
    );

    if (result != null) {
      final bytes = await result.readAsBytes();
      final image = await decodeImageFromList(bytes);

      final message = types.ImageMessage(
        author: _user,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        height: image.height.toDouble(),
        id: const Uuid().v4(),
        name: result.name,
        size: bytes.length,
        uri: result.path,
        width: image.width.toDouble(),
      );

      _addMessage(message);
    }
  }

  void _handleImageSelection() async {
    final result = await ImagePicker().pickImage(
      imageQuality: 70,
      maxWidth: 1440,
      source: ImageSource.gallery,
    );

    if (result != null) {
      final bytes = await result.readAsBytes();
      final image = await decodeImageFromList(bytes);

      final message = types.ImageMessage(
        author: _user,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        height: image.height.toDouble(),
        id: const Uuid().v4(),
        name: result.name,
        size: bytes.length,
        uri: result.path,
        width: image.width.toDouble(),
      );

      _addMessage(message);
    }
  }

  void _handleMessageTap(BuildContext _, types.Message message) async {
    if (message is types.FileMessage) {
      var localPath = message.uri;

      if (message.uri.startsWith('http')) {
        final client = http.Client();

        final request = await client.get(Uri.parse(message.uri),
            headers: AppData.httpHeaders);

        final bytes = request.bodyBytes;
        final documentsDir = (await getApplicationDocumentsDirectory()).path;
        localPath = '$documentsDir/${message.name}';

        if (!File(localPath).existsSync()) {
          //debugPrint("existsSync -> lewat");
          final file = File(localPath);
          await file.writeAsBytes(bytes);
        }
      }

      await OpenFilex.open(localPath);
    }
  }

  void _handlePreviewDataFetched(
    types.TextMessage message,
    types.PreviewData previewData,
  ) {
    debugPrint("_handlePreviewDataFetched ?????*** cek ***??????");
  }

  void _handleSendPressed(types.PartialText message) {
    final textMessage = types.TextMessage(
      author: _user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: const Uuid().v4(),
      text: message.text,
    );

    _addMessage(textMessage);
  }

  @override
  Widget build(BuildContext context) {
    chatCariBloc = BlocProvider.of<ChatGroupCariBloc>(context);

    return MultiBlocListener(
      listeners: [
        BlocListener<ChatGroupCrudBloc, ChatGroupCrudState>(
            listenWhen: (previous, current) {
          return current.isSaved;
        }, listener: (context, state) {
          if (state.isSaved) {
            chatCariBloc.add(RefreshChatGroupCariEvent(
                hal: chatCariBloc.state.hal, roomId: widget.roomId));
          }
        }),
    /*
        BlocListener<NetworkBloc, NetworkState>(
          listener: (context, state) {
            if (state is NetworkFailure) {
              notifyNetworkStatus(context, "No Internet Connection");
            } else if (state is NetworkSuccess) {
              notifyNetworkStatus(context, "You're Connected to Internet");
            }
          },
          listenWhen: (previous, current) {
            return (previous != current);
          },
        )
    */
      ],
      child: BlocConsumer<ChatGroupCariBloc, ChatGroupCariState>(
          builder: (context, state) {
            return Scaffold(
              backgroundColor: Colors.grey[200],
              body: Chat(
                imageHeaders: AppData.httpHeaders,
                messages: state.items,
                onAttachmentPressed: _handleAttachmentPressed,
                onMessageTap: _handleMessageTap,
                onPreviewDataFetched: _handlePreviewDataFetched,
                onSendPressed: _handleSendPressed,
                showUserAvatars: true,
                showUserNames: true,
                user: _user,
                onEndReached: _handleEndReached,
                onEndReachedThreshold: 1,
                isLastPage: state.hasReachedMax,
                theme: const DefaultChatTheme(
                  seenIcon: Text(
                    'read',
                    style: TextStyle(
                      fontSize: 10.0,
                    ),
                  ),
                ),
              ),
            );
          },
          buildWhen: (previous, current) {
            return (current.status == ListStatus.success);
            //return (current.hal > previous.hal);
          },
          listener: (context, state) {}),
    );
  }

  void refreshData(String roomId) {
    debugPrint("ChatPage -> refreshData");
    chatCariBloc.add(RefreshChatGroupCariEvent(hal: 0, roomId: roomId));
  }

  void notifyNetworkStatus(BuildContext context, message) {
    showModalBottomSheet<void>(
        context: context,
        builder: (BuildContext context) => SafeArea(
              child: Text(message,
                  style: MyText.bodyLarge(context)!
                      .copyWith(color: MyColors.grey_80)),
            ));
  }

  Future<void> _handleEndReached() async {
    debugPrint("_handleEndReached");

    //debugPrint("_handleEndReached #10 -> DateTime : ${DateTime.now()}");

    DateTime lastFetch = chatCariBloc.state.lastFetch;    
    int diffSecond = 100;
    
    debugPrint("_handleEndReached #20 -> lastFetch : $lastFetch");
    var diff = DateTime.now().difference(lastFetch);
    diffSecond = diff.inSeconds;
        
    debugPrint("_handleEndReached #25 -> diffSecond : $diffSecond");

    if (diffSecond > 3) {      
      //debugPrint("_handleEndReached #10 -> DateTime : ${DateTime.now()}");

      int currPage = chatCariBloc.state.hal;
      chatCariBloc
        .add(FetchChatGroupCariEvent(hal: currPage + 1, roomId: widget.roomId, lastFetch: DateTime.now()));
    }
  }
}
