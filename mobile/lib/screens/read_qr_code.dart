import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:plant_iot_epitech/screens/plant_created.dart';

class ReadQrCode extends StatefulWidget {
  const ReadQrCode({super.key});

  @override
  State<ReadQrCode> createState() => _ReadQrCodeState();
}

class _ReadQrCodeState extends State<ReadQrCode> {
  final Widget logo = SvgPicture.asset(
    'assets/logos/plant.svg',
    semanticsLabel: 'plant',
    fit: BoxFit.contain,
  );

  MobileScannerController cameraController = MobileScannerController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: const Color(0xffF9FAF7),
      //   elevation: 0,
      //   iconTheme: const IconThemeData(
      //     color: Color(0xff708265), //change your color here
      //   ),
      // ),
      body: SafeArea(
        child: Container(
          color: const Color(0xffF9FAF7),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      Positioned(
                        left: 10,
                        child: IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(
                            Icons.arrow_back,
                            color: Color(0xff708265),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 288,
                        height: 80,
                        child: logo,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  'Scan QR-code',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                    color: Color(0xff708265),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(24),
                  child: Text(
                    'Please scan the QR-code inside your box, to link your plant',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xff8BA07E),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  width: 316,
                  height: 316,
                  child: MobileScanner(
                    allowDuplicates: false,
                    controller: cameraController,
                    onDetect: (barcode, args) {
                      if (barcode.rawValue == null) {
                        debugPrint('Failed to scan Barcode');
                      } else {
                        final String code = barcode.rawValue!;
                        debugPrint('Barcode found! $code');
                      }
                    },
                  ),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return const PlantCreated();
                        },
                      ),
                    );
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                      const Color(0xffC9DBBD),
                    ),
                    fixedSize: MaterialStateProperty.all<Size>(
                      const Size(327, 48),
                    ),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(48),
                      ),
                    ),
                  ),
                  child: const Text(
                    'Take picture',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
