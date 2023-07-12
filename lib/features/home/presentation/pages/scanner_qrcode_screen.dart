import 'dart:developer';
import 'package:all_links/features/home/presentation/controller/scanner_qr_provider.dart';
import 'package:all_links/core/constants/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ScannerQRCodeScreen extends StatelessWidget {
  const ScannerQRCodeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ScannerQRProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: kBackgroundColor,
            leading: IconButton(
              onPressed: () {
                provider.dispose();
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
            ),
            actions: [
              IconButton(
                onPressed: () async {
                  await provider.controller?.flipCamera();
                },
                icon: const Icon(
                  CupertinoIcons.switch_camera_solid,
                  color: Colors.black,
                ),
              ),
              IconButton(
                onPressed: () {
                  provider.changeFlashStatus();
                },
                icon: Icon(
                  provider.flashStatus ? Icons.flash_off : Icons.flash_on,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          body: Column(
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  "Put the َQR inside the frame",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                  ),
                ),
              ),
              Expanded(
                child: QRView(
                  key: provider.qrKey,
                  onQRViewCreated: (QRViewController controller) {
                    _onQRViewCreated(controller, context);
                  },
                  overlay: QrScannerOverlayShape(
                    borderColor: kMainColorLight,
                    borderRadius: 8,
                    borderLength: 30,
                    borderWidth: 10,
                    cutOutSize: MediaQuery.of(context).size.height < 400
                        ? 250.0
                        : 300.0,
                  ),
                  onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _onQRViewCreated(QRViewController controller, BuildContext context) {
    Provider.of<ScannerQRProvider>(context, listen: false)
        .setController(controller);
    controller.scannedDataStream.listen((scanData) {
      Provider.of<ScannerQRProvider>(context, listen: false)
          .setResult(scanData);
      Provider.of<ScannerQRProvider>(context, listen: false).checkScanResult();
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No Permission!!')),
      );
    }
  }
}
