class AIMessage {
  final String? id;
  final bool isBot;
  String? message;

  AIMessage({this.id, this.isBot = true, this.message});
}
