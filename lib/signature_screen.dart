import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_signature_pad/flutter_signature_pad.dart';
import 'package:image/image.dart' as img;
import 'dart:ui' as ui;

class SignOnImagePage extends StatefulWidget {
  const SignOnImagePage({super.key});

  @override
  State<SignOnImagePage> createState() => _SignOnImagePageState();
}

class _SignOnImagePageState extends State<SignOnImagePage> {
  @override
  void initState() {
    print("lendo este código");
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    super.initState();
  }

  final _sign = GlobalKey<SignatureState>();
  Color penColor = Colors.black;
  double penStrokeWidth = 6;
  late ByteData imgBytes;

  Future<void> _handleSavePressed() async {
    final sign = _sign.currentState;
    print("sign: $sign");
    print("data: ${await sign!.getData()}");
    final image = await sign.getData();
    var data = await image.toByteData(format: ui.ImageByteFormat.png);
    if (data != null) {
      setState(() {
        imgBytes = data;
      });
    }

    // Converte para a imagem e salva
    final pngBytes = data!.buffer.asUint8List();
    final img.Image signatureImage = img.decodeImage(pngBytes)!;
    final img.Image resizedImage = img.copyResize(signatureImage, width: 600);

    // Salvar a imagem
    final result = img.encodePng(resizedImage);
    print('Signature saved');

    print(result);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Assinar documento'),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  child: const Text('Limpar'),
                  onPressed: () {
                    final sign = _sign.currentState;
                    sign?.clear();
                  },
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _handleSavePressed,
                  child: const Text('Salvar'),
                ),
              ],
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(5),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.purple),
                borderRadius: const BorderRadius.all(Radius.circular(10))),
            child: InteractiveViewer(
              panEnabled: true,
              boundaryMargin: const EdgeInsets.all(20),
              minScale: 0.5,
              maxScale: 4.0,
              child: Signature(
                color: penColor,
                strokeWidth: penStrokeWidth,
                key: _sign,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }
}
