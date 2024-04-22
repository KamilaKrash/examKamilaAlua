import 'package:application/screens/qr/qr_bloc/qr_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRScanner extends StatefulWidget {
  const QRScanner({super.key});
  @override
  QRScannerState createState() => QRScannerState();
}

class QRScannerState extends State<QRScanner> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  
  static QRViewController? _controllerr;

  static QRViewController? get getController => _controllerr;

  final QrBloc qrBloc = QrBloc();

  @override
  void dispose() {
    _controllerr?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'QR Сканнер',
          style: TextStyle(
            color: Colors.white
          ),
        ),
        centerTitle: false,
        backgroundColor: Colors.black,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.35,
            child: Stack(
              children: [
                QRView(
                  overlay: QrScannerOverlayShape(
                    borderColor: Colors.green,
                    borderRadius: 10,
                    borderLength: 30,
                    borderWidth: 10,
                    cutOutHeight: 150,
                    cutOutWidth: 300,
                  ),
                  key: qrKey,
                  onQRViewCreated: _onQRViewCreated,
                ),
                Positioned(
                  bottom: 16,
                  right: 16,
                  child: IconButton(
                    icon: const Icon(
                      Icons.flash_on,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      setState(() {
                        _controllerr?.toggleFlash();
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),

          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6,vertical: 12),
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 231, 149, 25)
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Наведите камеру на QR-код',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16, 
                    fontFamily: "Montserrat",
                    fontWeight: FontWeight.w600, 
                    color: Colors.white
                  )
                ),

                const SizedBox(width: 10),

                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: SizedBox(
                    height: 80,
                    child: Image.asset(
                      'assets/qr_scan.gif',
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 10),
          
          BlocBuilder<QrBloc,QrState>(
            bloc: qrBloc,
            builder:(context, state) {
              if (state is QrStateInitial) {
                return const SizedBox();
              } else if (state is QrStateScanned) {
                // return Text("QRCODE: ${state.qrcode}");
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6,vertical: 12),
                  decoration: const BoxDecoration(
                    color: Colors.green
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Успешно отсканировано:',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14, 
                          fontFamily: "Montserrat",
                          fontWeight: FontWeight.w600, 
                          color: Colors.white
                        )
                      ),

                      const SizedBox(width: 10),

                      Text(
                        state.qrcode,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 26, 
                          fontFamily: "Jersey25",
                          fontWeight: FontWeight.w600, 
                          color: Colors.white
                        )
                      ),
                    ],
                  ),
                );
              }
              return const Text("Error");
            },
          ),
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    _controllerr = controller;
    _controllerr?.scannedDataStream.listen((scanData) {
      if (scanData.code?.isNotEmpty == true) {
        HapticFeedback.mediumImpact();
        qrBloc.add(ScanEvent(qrcode: scanData.code!));
      }
    });
  }
}

