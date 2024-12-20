// import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// import '../model/get_user_model.dart';
// import 'publics.dart';

// class Storages {
//   static const db = 'AffiliatorOwleo';
//   static const _secure = FlutterSecureStorage(
//     aOptions: AndroidOptions(
//       encryptedSharedPreferences: true,
//     ),
//     webOptions: WebOptions(dbName: db, publicKey: db),
//     iOptions: IOSOptions(
//       accessibility: KeychainAccessibility.first_unlock,
//     ),
//     mOptions: MacOsOptions(
//       accessibility: KeychainAccessibility.first_unlock,
//     ),
//   );
//   static final _controller = Publics.controller;
//   static Future<void> setUser(User user) async {
//     final users = await getUser;
//     await _secure.write(key: 'email', value: user.email ?? users.email);
//     await _secure.write(key: 'pass', value: user.pass ?? users.pass);
//     await _secure.write(key: 'token', value: user.token ?? users.token);
//     await _secure.write(key: 'isingat', value: user.isingat ?? users.isingat);
//     await _secure.write(
//         key: 'isdark', value: user.isdark ?? users.isdark ?? '0');
//     await _secure.write(
//         key: 'username', value: user.username ?? users.username);
//     await _secure.write(key: 'roles', value: user.roles ?? users.roles);
//     _controller.getUser.value = await getUser;
//     print(_controller.getUser.value.toJson());
//   }

//   static Future<User> get getUser async =>
//       User.fromJson(await _secure.readAll());
// }
