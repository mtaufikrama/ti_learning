import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:mime/mime.dart';

import '../../type_data.dart';
import '../widget/index.dart';

enum PasswordStrength {
  Lemah,
  Sedang,
  Kuat,
}

class MyFX {
  static String generateRandomString(int length) {
    const characters =
        'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    Random random = Random();
    return String.fromCharCodes(Iterable.generate(
      length,
      (_) => characters.codeUnitAt(random.nextInt(characters.length)),
    ));
  }

  static bool cekSpasiDanKarakterKhusus(String data) {
    return !RegExp(r'[\s\W]').hasMatch(data);
  }

  static String linkGmaps(double latitude, double longitude) {
    return "http://www.google.com/maps/place/$latitude,$longitude";
  }

  static Future<String?> xfile2Blob(XFile? file) async {
    if (file == null) {
      return null;
    }
    const maxSize = 2 * 1024 * 1024;
    final sizeFile = await file.length();
    String? text;
    if (sizeFile < maxSize) {
      final base64foto = base64Encode(await file.readAsBytes());
      final mimeType = file.mimeType ?? '';
      text = 'data:$mimeType;base64,$base64foto';
    }
    return text;
  }

  static Future<String> xfile2Base64(XFile file) async {
    const maxSize = 2 * 1024 * 1024;
    final sizeFile = await file.length();
    String text = '';
    if (sizeFile < maxSize) {
      text = base64Encode(await file.readAsBytes());
    }
    return text;
  }

  static String formatCurrency(int value) {
    NumberFormat currencyFormat =
        NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);
    return currencyFormat.format(value.toDouble());
  }

  static String getExtensionFromMimeType(String mimeType) {
    switch (mimeType) {
      case 'image/jpeg':
        return '.jpg';
      case 'image/png':
        return '.png';
      case 'image/gif':
        return '.gif';
      case 'image/webp':
        return '.webp';
      case 'video/mp4':
        return '.mp4';
      case 'video/avi':
        return '.avi';
      case 'application/pdf':
        return '.pdf';
      case 'application/msword':
        return '.doc';
      case 'application/vnd.openxmlformats-officedocument.wordprocessingml.document':
        return '.docx';
      case 'application/vnd.ms-excel':
        return '.xls';
      case 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet':
        return '.xlsx';
      case 'text/plain':
        return '.txt';
      case 'application/zip':
        return '.zip';
      // Tambahkan MIME type lain sesuai kebutuhan
      default:
        return '';
    }
  }

  static String getExtensionFromUint8List(Uint8List fileBytes) {
    // Deteksi MIME type dari byte array menggunakan mime package
    String? mimeType = lookupMimeType('', headerBytes: fileBytes);

    // Mapping MIME type ke ekstensi
    if (mimeType != null) {
      return getExtensionFromMimeType(mimeType);
    } else {
      return '';
    }
  }

  static Future<String> getExtensionFromBlobUrl(String blobUrl) async {
    final dio = Dio();
    try {
      final response = await dio.get(blobUrl);

      if (response.statusCode == 200) {
        final contentType = response.headers.map;
        print('MIME Type: $contentType');

        final fileExtension =
            MyFX.getExtensionFromMimeType(contentType['content-type']!.first);
        print('File Extension: $fileExtension');
      } else {
        print('Failed to load file, Status Code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching blob: $error');
    }
    return '';
  }

  static void showModalPickFile(void Function(List<XFile> files) onfile,
      {required KategoriPickFile pickFile, int? quality}) async {
    final isWeb = GetPlatform.isWeb || GetPlatform.isWindows;
    print(isWeb);
    final picker = ImagePicker();
    showModalBottomSheet(
      context: Get.context!,
      enableDrag: true,
      showDragHandle: true,
      builder: (context) {
        return Column(
          children: [
            if (pickFile != KategoriPickFile.VIDEO &&
                pickFile != KategoriPickFile.VIDEOS &&
                !isWeb)
              ListTile(
                leading: const Icon(Icons.camera),
                title: const Text("Capture Photo"),
                onTap: () async {
                  final xfile = await picker.pickImage(
                      source: ImageSource.camera, imageQuality: quality ?? 75);
                  if (xfile != null) {
                    onfile([xfile]);
                    Get.back();
                  }
                },
              ),
            if (pickFile != KategoriPickFile.IMAGE &&
                pickFile != KategoriPickFile.IMAGES &&
                !isWeb)
              ListTile(
                leading: const Icon(Icons.videocam_rounded),
                title: const Text("Capture Video"),
                onTap: () async {
                  final xfile = await picker.pickVideo(
                    source: ImageSource.camera,
                    maxDuration: const Duration(minutes: 1),
                  );
                  if (xfile != null) {
                    onfile([xfile]);
                    Get.back();
                  }
                },
              ),
            if (pickFile == KategoriPickFile.IMAGE ||
                pickFile == KategoriPickFile.VIDEO)
              ListTile(
                leading: const Icon(Icons.filter),
                title: const Text("Gallery"),
                onTap: () async {
                  XFile? xfile;
                  if (pickFile == KategoriPickFile.IMAGE) {
                    xfile = await picker.pickImage(
                      source: ImageSource.gallery,
                      imageQuality: quality ?? 75,
                    );
                  } else {
                    xfile = await picker.pickVideo(
                      source: ImageSource.gallery,
                    );
                  }
                  if (xfile != null) {
                    onfile([xfile]);
                    Get.back();
                  }
                },
              ),
            if (pickFile == KategoriPickFile.IMAGES)
              ListTile(
                leading: const Icon(Icons.filter),
                title: const Text("Gallery"),
                onTap: () async {
                  final xfiles = await picker.pickMultiImage(
                    imageQuality: quality ?? 75,
                  );
                  if (xfiles.isNotEmpty) {
                    onfile(xfiles);
                    Get.back();
                  }
                },
              ),
            if (pickFile == KategoriPickFile.IMAGE_AND_VIDEO)
              ListTile(
                leading: const Icon(Icons.filter),
                title: const Text("Gallery"),
                onTap: () async {
                  final xfile = await picker.pickMedia(
                    imageQuality: quality ?? 75,
                  );
                  if (xfile != null) {
                    onfile([xfile]);
                    Get.back();
                  }
                },
              ),
            if (pickFile == KategoriPickFile.IMAGES_AND_VIDEOS)
              ListTile(
                leading: const Icon(Icons.filter),
                title: const Text("Gallery"),
                onTap: () async {
                  final xfiles = await picker.pickMultipleMedia(
                    imageQuality: quality ?? 75,
                  );
                  if (xfiles.isNotEmpty) {
                    onfile(xfiles);
                    Get.back();
                  }
                },
              ),
          ],
        );
      },
    );
  }

  // static String buildBarcode(
  //   Barcode bc,
  //   String data, {
  //   String? filename,
  //   double? width,
  //   double? height,
  //   double? fontHeight,
  // }) {
  //   /// Create the Barcode
  //   final svg = bc.toSvg(
  //     data,
  //     width: width ?? 200,
  //     height: height ?? 80,
  //     fontHeight: fontHeight,
  //   );

  //   // Save the image
  //   filename ??= bc.name.replaceAll(RegExp(r'\s'), '-').toLowerCase();
  //   io.File('$filename.svg').writeAsStringSync(svg);
  //   String svgContent = io.File('$filename.svg').readAsStringSync();
  //   String base64String = base64Encode(utf8.encode(svgContent));
  //   print(base64String);
  //   return base64String;
  // }

  static void get loading {
    Get.dialog(
      Center(
        child: SizedBox(
          height: 100,
          width: 100,
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: MyWidget.media(
                'assets/logo.png',
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
      ),
    );
  }

  static double responsiveDouble(
    BuildContext context, {
    required double mobile,
    required double desktop,
    double? tablet,
    double? iOS,
    double? macOS,
  }) {
    final orientation = context.orientation;
    final width = context.width;

    if (GetPlatform.isWeb ||
        GetPlatform.isLinux ||
        GetPlatform.isMacOS ||
        GetPlatform.isWindows) {
      if (orientation == Orientation.landscape) {
        return tablet ?? desktop;
      } else {
        if (width <= 850.toDouble()) {
          return mobile;
        } else if (width <= 1100.toDouble()) {
          return tablet ?? desktop;
        } else {
          return desktop;
        }
      }
    } else {
      if (GetPlatform.isAndroid) {
        if (orientation == Orientation.landscape) {
          return tablet ?? desktop;
        } else {
          return mobile;
        }
      } else if (GetPlatform.isIOS) {
        if (orientation == Orientation.landscape) {
          return macOS ?? tablet ?? iOS ?? desktop;
        } else {
          return iOS ?? mobile;
        }
      } else {
        return mobile;
      }
    }
  }

  static String securityEmail(String email) {
    int posSimbolAt = email.indexOf("@");
    if (posSimbolAt != -1) {
      String username = email.substring(0, posSimbolAt);
      String domain = email.substring(posSimbolAt);
      email = '**${username.substring(username.length - 2)}$domain';
    }
    return email;
  }

  static PasswordStrength checkPasswordStrength(String password) {
    // Cek panjang kata sandi
    if (password.length < 8) {
      return PasswordStrength.Lemah;
    }

    // Cek apakah kata sandi mengandung huruf besar dan kecil
    bool hasUppercase = password.contains(RegExp(r'[A-Z]'));
    bool hasLowercase = password.contains(RegExp(r'[a-z]'));

    if (hasUppercase && hasLowercase) {
      // Cek apakah kata sandi mengandung angka
      bool hasDigit = password.contains(RegExp(r'[0-9]'));
      if (hasDigit) {
        // Cek apakah kata sandi mengandung karakter khusus
        bool hasSpecialChar =
            password.contains(RegExp(r'[!@#\$%^&*(),.?":{}|<>]'));
        if (hasSpecialChar) {
          return PasswordStrength.Kuat;
        } else {
          return PasswordStrength.Sedang;
        }
      } else {
        return PasswordStrength.Lemah;
      }
    } else {
      return PasswordStrength.Lemah;
    }
  }
}
