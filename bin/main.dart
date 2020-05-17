import 'ojichat.dart';

void main(List<String> args) {
  if (args.isEmpty) {
    print('あなたの名前を渡してください。');
    return;
  }

  final message = OjiChat.hello(name: args[0]);
  print(message);
}
