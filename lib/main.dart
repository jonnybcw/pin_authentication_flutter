import 'dart:convert';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive/hive.dart';
import 'package:pin_authentication_flutter/config/hive_config.dart';
import 'package:pin_authentication_flutter/modules/menu/menu_screen.dart';

Future<void> main() async {
  Bloc.transformer = sequential<dynamic>();
  await HiveConfig.init();

  const FlutterSecureStorage secureStorage = FlutterSecureStorage();
  String? encryptionKey = await secureStorage.read(key: 'encryptionKey');
  if (encryptionKey == null) {
    List<int> key = Hive.generateSecureKey();
    await secureStorage.write(
      key: 'encryptionKey',
      value: base64UrlEncode(key),
    );
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      title: 'PIN Auth',
      home: MenuScreen(),
      theme: CupertinoThemeData(
        primaryColor: CupertinoColors.black,
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
