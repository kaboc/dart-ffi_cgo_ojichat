import 'dart:ffi';
import 'dart:io';
import 'package:ffi/ffi.dart';
import 'package:meta/meta.dart';
import 'package:path/path.dart' as path;

typedef _Func = Pointer<Utf8> Function(Pointer<Utf8>);

class OjiChat {
  OjiChat();

  static String get _libDirPath {
    final scriptPath = path.fromUri(Platform.script.path);
    return path.dirname(scriptPath);
  }

  static String get _libExt {
    if (Platform.isWindows) {
      return 'dll';
    }
    if (Platform.isMacOS) {
      return 'dylib';
    }
    if (Platform.isLinux) {
      return 'so';
    }

    throw Exception('Unsupported platform.');
  }

  static String hello({@required String name}) {
    // ライブラリのパスは絶対パスかカレントディレクトリからの
    // 相対パスでないと動作しないみたい
    // カレントディレクトりは変わり得るので、実行するスクリプトの
    // 絶対パスをを取得して使う
    final lib = DynamicLibrary.open('$_libDirPath/libojichat.$_libExt');
    final getMessage = lib.lookupFunction<_Func, _Func>('getMessage');

    final message = getMessage(Utf8.toUtf8(name));
    return Utf8.fromUtf8(message);
  }
}
