import 'dart:io';

import 'package:fkpmobile/blocs/qrcode/qrcode_bloc.dart';
import 'package:fkpmobile/screens/pages/contactPage.dart';
import 'package:fkpmobile/screens/pages/tempPage.dart';
import 'package:fkpmobile/screens/widgets/buttons/popButton.dart';
import 'package:fkpmobile/theme/colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ScanCodePage extends StatefulWidget {
  const ScanCodePage({Key? key}) : super(key: key);

  @override
  State<ScanCodePage> createState() => _ScanCodePageState();
}

class _ScanCodePageState extends State<ScanCodePage> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;
  bool flash = false;

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
    //   return BlocConsumer<QrcodeBloc, QrcodeState>(
    //     listener: (context, state) {
    //       // TODO: implement listener
    //     },
    //     builder: (context, state) {
    //       return Scaffold(
    //         appBar: AppBar(
    //           title: Text(state.toString()),
    //         ),
    //       );
    //     },
    //   );
    // }
  }
}

  //   if (result != null) {
  //     return Scaffold(
  //         body: Center(
  //       child: Text(
  //         result!.code.toString(),
  //       ),
  //     ));
  //   } else {
  //     return Scaffold(
  //       body: Column(
  //         children: <Widget>[
  //           Expanded(
  //             flex: 5,
  //             child: QRView(
  //               key: qrKey,
  //               onQRViewCreated: _onQRViewCreated,
  //               overlay: QrScannerOverlayShape(
  //                   borderColor: secondary,
  //                   borderLength: 20,
  //                   borderRadius: 10,
  //                   cutOutSize: MediaQuery.of(context).size.width * .8),
  //             ),
  //           ),
  //           Expanded(
  //             flex: 1,
  //             child: Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceAround,
  //               // crossAxisAlignment: CrossAxisAlignment.center,
  //               children: [
  //                 IconButton(
  //                     onPressed: () async {
  //                       await controller?.flipCamera();
  //                     },
  //                     icon: const Icon(Icons.switch_camera)),
  //                 IconButton(
  //                     onPressed: () async {
  //                       setState(() {
  //                         flash = !flash;
  //                       });
  //                       await controller?.toggleFlash();
  //                     },
  //                     icon: flash == true
  //                         ? const Icon(Icons.flashlight_off)
  //                         : const Icon(Icons.flashlight_on)),
  //                 const PopButton(),
  //               ],
  //             ),
  //           ),
  //         ],
  //       ),
  //     );
  //   }
  // }

//   void _onQRViewCreated(QRViewController controller) {
//     this.controller = controller;
//     controller.scannedDataStream.listen((scanData) {
//       setState(() {
//         result = scanData;
//       });
//     });
//   }

//   @override
//   void dispose() {
//     controller?.dispose();
//     super.dispose();
//   }
// }
