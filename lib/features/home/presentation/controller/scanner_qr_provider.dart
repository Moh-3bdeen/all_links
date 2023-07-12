import 'dart:convert';
import 'dart:developer';

import 'package:all_links/core/constants/router_list.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ScannerQRProvider extends ChangeNotifier{

  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  bool flashStatus = false;

  checkScanResult(BuildContext context) async {
    if (result != null) {
      log('Barcode Type: ${describeEnum(result!.format)}   Data: ${result!.code}');
      await controller?.stopCamera();
      notifyListeners();
      Navigator.pushNamed(context, RouterList.userProfileScreen, arguments: jsonDecode(result!.code.toString()));
    }
  }

  changeFlashStatus() async {
    await controller?.toggleFlash();
    flashStatus = !flashStatus;
    notifyListeners();
  }

  setResult(Barcode newResult){
    result = newResult;
    notifyListeners();
  }

  setController(QRViewController newController){
    controller = newController;
    notifyListeners();
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

}