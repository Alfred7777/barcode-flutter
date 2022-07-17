import 'package:flutter/material.dart';
import 'package:flutter_qr_bar_scanner/qr_bar_scanner_camera.dart';

class BarcodeScanner extends StatefulWidget {
  const BarcodeScanner({Key? key}) : super(key: key);

  @override
  State<BarcodeScanner> createState() => BarcodeScannerState();
}

class BarcodeScannerState extends State<BarcodeScanner> {
  bool _camState = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.grey.shade100,
        backgroundColor: Colors.blueGrey.shade900,
        title: const Text('Skaner Barkodów'),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(
            Icons.arrow_back,
          ),
        ),
      ),
      backgroundColor: Colors.blueGrey.shade800,
      body: Column(
        children: <Widget>[
          Expanded(
            child: _camState
                ? QRBarScannerCamera(
                    qrCodeCallback: (code) {
                      setState(() {
                        _camState = false;
                      });

                      AlertDialog alert = AlertDialog(
                        title: const Text("Zapisać Barkod?"),
                        content: Text("Odczytany barkod: $code"),
                        actions: [
                          TextButton(
                            child: const Text("Odrzuć"),
                            onPressed: () {
                              Navigator.of(context).pop();
                              setState(() {
                                _camState = true;
                              });
                            },
                          ),
                          TextButton(
                            child: const Text("Zapisz"),
                            onPressed: () {
                              Navigator.of(context).pop();
                              Navigator.of(context).pop(code);
                            },
                          ),
                        ],
                      );

                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return alert;
                        },
                      );
                    },
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 12.0,
                            ),
                            child: Stack(
                              children: <Widget>[
                                Text(
                                  'Zeskanuj barkod',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 24,
                                    fontWeight: FontWeight.w600,
                                    foreground: Paint()
                                      ..style = PaintingStyle.stroke
                                      ..strokeWidth = 4
                                      ..color = Colors.blueGrey.shade900,
                                  ),
                                ),
                                Text(
                                  'Zeskanuj barkod',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 24,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.grey.shade100,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: 250,
                            width: 250,
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              border: Border.all(
                                color: Colors.grey.shade100,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(32.0),
                            ),
                          ),
                        ],
                      ),
                    ),
                    notStartedBuilder: (context) {
                      return Container();
                    },
                  )
                : Container(),
          ),
        ],
      ),
    );
  }
}
