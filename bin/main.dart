import 'ojichat.dart';

void main(List<String> args) {
  if (args.isEmpty) {
    print('あなたの名前を渡してください。');
    return;
  }

  final ojiChat = openOjiChat();
  final ptr = stringToPointer(args[0]);
  final message = ojiChat.getMessage(ptr);

  print(pointerToString(message));
}
