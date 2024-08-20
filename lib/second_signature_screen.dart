import 'dart:io';

import 'package:assinatura_paciente/after_sign_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:signature/signature.dart';
import 'package:path/path.dart' as path;

class SecondSignatureTest extends StatefulWidget {
  const SecondSignatureTest({super.key});

  @override
  State<SecondSignatureTest> createState() => _SecondSignatureTestState();
}

class _SecondSignatureTestState extends State<SecondSignatureTest> {
  final SignatureController _controller = SignatureController(
    penStrokeWidth: 6,
    penColor: Colors.black,
    exportBackgroundColor: Colors.white,
    strokeCap: StrokeCap.round,
  );
  @override
  void didUpdateWidget(covariant SecondSignatureTest oldWidget) {
    print("Updating widget");
    super.didUpdateWidget(oldWidget);
  }

  @override
  void deactivate() {
    // TODO: implement deactivate
    super.deactivate();
  }

  @override
  void didChangeDependencies() {
    print("Mudando dependencias");
    super.didChangeDependencies();
  }

  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);

    super.initState();
  }

  Future<File> uint8ListToFile(Uint8List uint8List, String fileName) async {
    // Obtém o diretório temporário do dispositivo
    final tempDir = await getTemporaryDirectory();

    // Cria o caminho completo do arquivo no diretório temporário
    final filePath = path.join(tempDir.path, fileName);

    // Cria o arquivo e escreve os bytes nele
    final file = File(filePath);
    return await file.writeAsBytes(uint8List);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        actions: [
          ElevatedButton(
              onPressed: () {
                _controller.clear();
              },
              child: const Text("Limpar")),
          ElevatedButton(
              onPressed: () async {
                Uint8List? image = await _controller.toPngBytes();
                if (image != null) {
                  File generatedSignature =
                      await uint8ListToFile(image, "user_signature");
                  if (context.mounted) {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) =>
                            ShowSignaturePage(signature: generatedSignature),
                      ),
                    );
                  }
                }
              },
              child: const Text("Salvar"))
        ],
      ),
      backgroundColor: Colors.white,
      body: Signature(
        controller: _controller,
        backgroundColor: Colors.white,
      ),
    );
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    _controller.dispose();
    super.dispose();
  }
}
