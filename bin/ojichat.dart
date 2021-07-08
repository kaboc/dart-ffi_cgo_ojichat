import 'dart:ffi';
import 'dart:io' show Platform;
import 'package:ffi/ffi.dart';
import 'package:path/path.dart' as path;

import 'library/generated_bindings.dart';

OjiChat openOjiChat() {
  final filename = 'libojichat.$_libExt';
  final lib = DynamicLibrary.open(_libPath(filename));
  return OjiChat(lib);
}

String _libPath(String filename) {
  final scriptPath = path.fromUri(Platform.script.path);
  return path.join(path.dirname(scriptPath), 'library', filename);
}

String get _libExt {
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

Pointer<Int8> stringToPointer(String string) {
  return string.toNativeUtf8().cast<Int8>();
}

String pointerToString(Pointer<Int8> pointer) {
  return pointer.cast<Utf8>().toDartString();
}
