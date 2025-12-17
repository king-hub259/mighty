import 'dart:async';
import 'dart:io';
import 'package:http/http.dart';
import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_snackbar.dart';
import 'package:mighty_school/feature/chatgpt/models/ai_message.dart';
import 'package:mighty_school/util/app_constants.dart';

class ChatGptController extends GetxController implements GetxService{

   OpenAI? _openAI;
  void initOpenAISdk() async {
    _openAI = OpenAI.instance.build(token: AppConstants.chatGptApiKey, apiUrl: 'https://api.openai.com/v1/', enableLog: true,
        baseOption: HttpSetup(receiveTimeout: const Duration(seconds: 30),
            connectTimeout: const Duration(seconds: 30), sendTimeout: const Duration(seconds: 30)));
  }



   final _txtInput = TextEditingController();
   TextEditingController getTextInput() => _txtInput;
   void closeTextInput() {
     getTextInput().clear();
   }


   void clearMessage() {
     list = [];
   }

   CancelData? mCancel;
   void onCancel(CancelData cancelData) {
     mCancel = cancelData;
   }

   void handleError(Object error, StackTrace t, EventSink<dynamic> eventSink) {

     isBot = true;
     showStopButton = false;
     aiMessages = list;
     if (error is OpenAIAuthError) {
       showCustomSnackBar('Authentication Error');
     }
     if (error is OpenAIRateLimitError) {
        showCustomSnackBar('Rate Limit Error');
     }
     if (error is OpenAIServerError) {
        showCustomSnackBar('Server Error');
     }
   }

    List<AIMessage>? aiMessages;
    bool? isBot;
    bool? showStopButton;
   List<AIMessage> list = [];
   void sendWithPrompt({String? aiCoverLetter}) async {
     list.add(AIMessage(isBot: false, message: aiCoverLetter?? getTextInput().value.text));
     isBot = false;
      showStopButton = true;
      aiMessages = list;
     final request = ChatCompleteText(
         model:  Gpt4ChatModel(),
         messages: [
           Messages(role: Role.user, content: aiCoverLetter?? getTextInput().value.text).toJson(),
         ],
         maxToken: 400);

     getTextInput().text = "";

     _openAI?.onChatCompletionSSE(request: request, onCancel: onCancel)
         .transform(StreamTransformer.fromHandlers(handleError: handleError))
         .listen((it) {
       AIMessage? message;
       list.removeWhere((element) {
         if (element.id == '${it.id}') {
           message = element;
           return true;
         }
         return false;
       });

       ///+= message
       String msg = '${message?.message ?? ""}${it.choices.last.message?.content ?? ""}';
       list.add(AIMessage(isBot: true, id: '${it.id}', message: msg));
        aiMessages = list;
        isBot = true;
        showStopButton = true;

     }, onDone: () {
        aiMessages = list;
        isBot = true;
        showStopButton = false;
     });
   }

   void downloadImage(String url,
       {required Function() success,
         required Function(String message) error}) async {
     try {
       final response = await get(Uri.parse(url));

       /// Get temporary directory
       const path = "/storage/emulated/0/Download";
       final createDirect = Directory("$path/openai");
       if (await createDirect.exists()) {
       } else {
         await createDirect.create(recursive: true);
       }

       /// Create an image name
       var filename = '$path/${DateTime.now().microsecondsSinceEpoch}.png';

       /// Save to filesystem
       final file = File(filename);
       await file.writeAsBytes(response.bodyBytes);
       if (await file.exists()) {
         success();
       }
     } catch (err) {
       error('path have problem.');
     }
   }




}