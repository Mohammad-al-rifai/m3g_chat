import 'dart:convert';
import 'dart:io';

import 'package:encrypt/encrypt.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:m3g_chat/app/components/resources/constants_manager.dart';
import 'package:m3g_chat/app/components/widgets/toast_notification.dart';
import 'package:m3g_chat/app/encryption/create_h_mac.dart';
import 'package:m3g_chat/app/socket_io/socket_io.dart';
import 'package:mime/mime.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

import '../../../../app/encryption/aes.dart';
import '../../app/encryption/SignAndVerify.dart';
import '../../domain/models/all_user_chats.dart';
import '../../domain/models/chat_message_model.dart';
import '../../domain/models/get_chats_model.dart';
import '../../domain/models/hmac_model.dart';
import '../../domain/models/message_model.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({required this.uId, super.key});

  final String uId;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  HMacModel hmacModel = HMacModel();

  MessageModel messageModel = MessageModel(
    from: AppConstants.uId,
  );

  // ====================================================
  List<types.Message> _messages = [];
  final _user = types.User(id: AppConstants.uId);

  @override
  void initState() {
    super.initState();
    messageModel.to = widget.uId;
    // _loadMessages();
    getAllChats();
    receiveMessage();
    messageArrive();
    setState(() {});
  }

  sendMessage(String messageEncrypted) {
    // Level #1
    if (AppConstants.level == 1) {
      SocketIO.socket?.emit('msg', messageModel.toJson());
      hmacModel.from = AppConstants.uId;
      hmacModel.to = widget.uId;
      hmacModel.message = messageEncrypted;
      messageModel.mac = HMacAlgorithm.create(hmacModel.toJson());
    }
    // Level #2
    if (AppConstants.level == 2) {
      SocketIO.socket?.emit('msg-AES', messageModel.toJson());
      hmacModel.from = AppConstants.uId;
      hmacModel.to = widget.uId;
      hmacModel.message = messageEncrypted;
      messageModel.mac = HMacAlgorithm.create(hmacModel.toJson());
    }

    // Level #3
    if (AppConstants.level == 3) {
      SocketIO.socket?.emit('msg-PGB', messageModel.toJson());
      hmacModel.from = AppConstants.uId;
      hmacModel.to = widget.uId;
      hmacModel.message = messageEncrypted;
      messageModel.mac = HMacAlgorithm.create(hmacModel.toJson());
    }
    if (AppConstants.level == 4) {
      SocketIO.socket?.emit('msg-Rsa-Sign-Ver', messageModel.toJson());
      hmacModel.from = AppConstants.uId;
      hmacModel.to = widget.uId;
      hmacModel.message = messageEncrypted;
      messageModel.mac = HMacAlgorithm.create(hmacModel.toJson());
    }
  }

  getAllChats() {
    SocketIO.socket?.emit('get-Chat', {
      'userId': widget.uId,
    });
  }

  GetChatsModel getChatsModel = GetChatsModel();

  messageArrive() {
    SocketIO.socket?.on(
      'chat-message',
      (data) {
        getChatsModel = GetChatsModel.fromJson(data);
        getChatsModel.messages?.forEach((element) {
          final textMessage = types.TextMessage(
            author: types.User(id: element.from!.sId!),
            createdAt: DateTime.now().millisecondsSinceEpoch,
            id: const Uuid().v4(),
            text: element.message!,
          );
          _addMessage(textMessage);
        });
        print('Message Arrive Success');
        // setState(() {});
      },
    );
  }

  receiveMessage() {
    SocketIO.socket?.on('message', (data) {
      ChatMessageModel chatMessageModel = ChatMessageModel.fromJson(data);
      print(chatMessageModel.Verified);
      allChats[chatMessageModel.from?.sId]?.add(chatMessageModel);

      if (chatMessageModel.from?.sId == widget.uId) {
        String value = AESAlg.decryption(
          cipherText: base64.encode(decodeHexString(chatMessageModel.message!)),
        );
        final textMessage = types.TextMessage(
          author: types.User(id: widget.uId),
          createdAt: DateTime.now().millisecondsSinceEpoch,
          id: const Uuid().v4(),
          text: value,
        );
        if (AppConstants.level == 4) {
          if (chatMessageModel.Verified) {
            _addMessage(textMessage);
          } else {
            showToast(text: 'Message Not verified', state: ToastStates.ERROR);
          }
        } else {
          _addMessage(textMessage);
        }
      } else {
        showToast(
            text: 'New Message from ${chatMessageModel.from?.username}',
            state: ToastStates.SUCCESS);
      }
      print(data);
      print(allChats);
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(),
        body: Chat(
          messages: _messages,
          onAttachmentPressed: _handleAttachmentPressed,
          onMessageTap: _handleMessageTap,
          onPreviewDataFetched: _handlePreviewDataFetched,
          onSendPressed: _handleSendPressed,
          showUserAvatars: true,
          showUserNames: true,
          user: _user,
        ),
      );

  void _addMessage(types.Message message) {
    if (mounted) {
      // check whether the state object is in tree
      setState(() {
        // make changes here
        _messages.insert(0, message);
      });
    }
  }

  void _handleAttachmentPressed() {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) => SafeArea(
        child: SizedBox(
          height: 144,
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
        try {
          final index =
              _messages.indexWhere((element) => element.id == message.id);
          final updatedMessage =
              (_messages[index] as types.FileMessage).copyWith(
            isLoading: true,
          );

          setState(() {
            _messages[index] = updatedMessage;
          });

          final client = http.Client();
          final request = await client.get(Uri.parse(message.uri));
          final bytes = request.bodyBytes;
          final documentsDir = (await getApplicationDocumentsDirectory()).path;
          localPath = '$documentsDir/${message.name}';

          if (!File(localPath).existsSync()) {
            final file = File(localPath);
            await file.writeAsBytes(bytes);
          }
        } finally {
          final index =
              _messages.indexWhere((element) => element.id == message.id);
          final updatedMessage =
              (_messages[index] as types.FileMessage).copyWith(
            isLoading: null,
          );

          setState(() {
            _messages[index] = updatedMessage;
          });
        }
      }

      await OpenFilex.open(localPath);
    }
  }

  void _handlePreviewDataFetched(
    types.TextMessage message,
    types.PreviewData previewData,
  ) {
    final index = _messages.indexWhere((element) => element.id == message.id);
    final updatedMessage = (_messages[index] as types.TextMessage).copyWith(
      previewData: previewData,
    );

    setState(() {
      _messages[index] = updatedMessage;
    });
  }

  void _handleSendPressed(types.PartialText message) {
    final textMessage = types.TextMessage(
      author: _user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: const Uuid().v4(),
      text: message.text,
    );
    if (AppConstants.level == 4) {
      messageModel.signature = Rsa.sign(message.text);
      print(Rsa.keys.publicKey.toString());
      messageModel.pubKey = Rsa.keys.publicKey.toString();
    }
    messageModel.message =
        AESAlg.base64ToHex(AESAlg.encryption(plainText: message.text));
    print('This Is :${messageModel.message}');

    print(messageModel.message);
    setState(() {
      sendMessage(messageModel.message.toString());
      print('Message Was Sent Success');
    });

    _addMessage(textMessage);
  }

  void _loadMessages() async {
    final response = await rootBundle.loadString('assets/messages.json');
    final messages = (jsonDecode(response) as List)
        .map((e) => types.Message.fromJson(e as Map<String, dynamic>))
        .toList();

    setState(() {
      _messages = messages;
    });
  }
}
