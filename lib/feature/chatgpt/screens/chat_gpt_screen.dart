
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_app_bar.dart';
import 'package:mighty_school/common/widget/custom_snackbar.dart';
import 'package:mighty_school/feature/chatgpt/logic/chat_gpt_controller.dart';
import 'package:mighty_school/feature/chatgpt/models/ai_message.dart';
import 'package:mighty_school/util/app_constants.dart';
import 'package:mighty_school/util/dimensions.dart';

class ChatGptScreen extends StatefulWidget {
  const ChatGptScreen({super.key});

  @override
  State<ChatGptScreen> createState() => _ChatGptScreenState();
}

class _ChatGptScreenState extends State<ChatGptScreen> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  bool isEmpty = false;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _initializeChat();
  }

  void _initializeAnimations() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _animationController.forward();
  }

  void _initializeChat() {
    Future.delayed(const Duration(milliseconds: 200), () {
      Get.find<ChatGptController>().initOpenAISdk();
      Get.find<ChatGptController>().clearMessage();
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            const CustomAppBar(title: "AI Assistant"),
            Expanded(child: _buildChatArea()),
            _buildInputArea(),
          ],
        ),
      ),
    );
  }

  Widget _buildChatArea() {
    return GetBuilder<ChatGptController>(
      builder: (chatGptController) {
        List<AIMessage>? aiMessages = chatGptController.aiMessages;
        
        if (aiMessages == null || aiMessages.isEmpty) {
          return _buildWelcomeScreen();
        }

        return FadeTransition(
          opacity: _fadeAnimation,
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
            itemCount: aiMessages.length,
            itemBuilder: (context, index) {
              final message = aiMessages[index];
              return AnimatedContainer(
                duration: Duration(milliseconds: 300 + (index * 50)),
                curve: Curves.easeOutBack,
                child: message.isBot 
                  ? _buildBotMessage(message.message)
                  : _buildUserMessage(message.message),
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildWelcomeScreen() {
    return Center(child: FadeTransition(opacity: _fadeAnimation,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Container(padding: const EdgeInsets.all(Dimensions.paddingSizeDefault * 2),
              decoration: BoxDecoration(color: Theme.of(context).primaryColor.withValues(alpha: 0.1), shape: BoxShape.circle),
              child: Icon(Icons.smart_toy_outlined, size: 60, color: Theme.of(context).primaryColor),),
            const SizedBox(height: Dimensions.paddingSizeDefault),
            Text(
              "AI Assistant",
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
            ),
            const SizedBox(height: Dimensions.paddingSizeSmall),
            Text(
              "Ask me anything! I'm here to help.",
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).hintColor,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUserMessage(String? message) {
    return Container(
      margin: const EdgeInsets.only(
        bottom: Dimensions.paddingSizeDefault,
        left: Dimensions.paddingSizeDefault * 2,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Flexible(
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: Dimensions.paddingSizeDefault,
                vertical: Dimensions.paddingSizeSmall,
              ),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(4),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context).primaryColor.withValues(alpha: 0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Text(
                message ?? 'User Message',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(width: Dimensions.paddingSizeSmall),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.person,
              size: 20,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBotMessage(String? message) {
    return Container(
      margin: const EdgeInsets.only(
        bottom: Dimensions.paddingSizeDefault,
        right: Dimensions.paddingSizeDefault * 2,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              shape: BoxShape.circle,
              border: Border.all(
                color: Theme.of(context).primaryColor.withValues(alpha: 0.3),
              ),
            ),
            child: Icon(
              Icons.smart_toy,
              size: 20,
              color: Theme.of(context).primaryColor,
            ),
          ),
          const SizedBox(width: Dimensions.paddingSizeSmall),
          Flexible(
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: Dimensions.paddingSizeDefault,
                vertical: Dimensions.paddingSizeSmall,
              ),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                  bottomLeft: Radius.circular(4),
                  bottomRight: Radius.circular(20),
                ),
                border: Border.all(
                  color: Theme.of(context).dividerColor.withValues(alpha: 0.3),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Stack(
                children: [
                  MarkdownBody(
                    data: message ?? "Thinking...",
                    selectable: true,
                    styleSheetTheme: MarkdownStyleSheetBaseTheme.material,
                    styleSheet: MarkdownStyleSheet(
                      codeblockDecoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.grey[800]
                            : Colors.grey[100],
                      ),
                      code: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontFamily: 'monospace',
                        backgroundColor: Colors.transparent,
                      ),
                      p: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                  if (message != null)
                    Positioned(
                      bottom: -4,
                      right: -4,
                      child: InkWell(
                        onTap: () {
                          Clipboard.setData(ClipboardData(text: message));
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Copied to clipboard"),
                              duration: Duration(seconds: 1),
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                        },
                        borderRadius: BorderRadius.circular(16),
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: Theme.of(context).hintColor.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Icon(
                            Icons.copy_rounded,
                            size: 16,
                            color: Theme.of(context).hintColor,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputArea() {
    return Container(
      padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: GetBuilder<ChatGptController>(
        builder: (chatGptController) {
          return Row(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(
                      color: Theme.of(context).dividerColor.withValues(alpha: 0.3),
                    ),
                  ),
                  child: TextField(
                    controller: chatGptController.getTextInput(),
                    onSubmitted: (text) => _sendMessage(chatGptController),
                    onChanged: (val) {
                      setState(() {
                        isEmpty = val.isNotEmpty;
                      });
                    },
                    maxLines: null,
                    style: Theme.of(context).textTheme.bodyMedium,
                    decoration: InputDecoration(
                      hintText: "ask_anything".tr,
                      hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).hintColor,
                      ),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: Dimensions.paddingSizeDefault,
                        vertical: Dimensions.paddingSizeSmall,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: Dimensions.paddingSizeSmall),
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                child: InkWell(
                  onTap: () => _sendMessage(chatGptController),
                  borderRadius: BorderRadius.circular(25),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: isEmpty 
                          ? Theme.of(context).primaryColor
                          : Theme.of(context).disabledColor,
                      shape: BoxShape.circle,
                      boxShadow: isEmpty ? [
                        BoxShadow(
                          color: Theme.of(context).primaryColor.withValues(alpha: 0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ] : null,
                    ),
                    child: const Icon(
                      Icons.send_rounded,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  void _sendMessage(ChatGptController controller) {
    if (AppConstants.demo) {
      showCustomSnackBar(AppConstants.demoModeMessage);
      return;
    }
    
    if (controller.getTextInput().text.isNotEmpty) {
      controller.sendWithPrompt();
      setState(() {
        isEmpty = false;
      });
    }
  }
}
