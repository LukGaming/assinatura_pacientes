import 'package:assinatura_paciente/models/document.dart';
import 'package:assinatura_paciente/second_signature_screen.dart';
import 'package:assinatura_paciente/signature_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

class DocumentListTile extends StatelessWidget {
  final Document document;

  const DocumentListTile({
    super.key,
    required this.document,
  });

  Future<String> _downloadAndSavePdf(String url) async {
    final response = await http.get(Uri.parse(url));
    final dir = await getApplicationDocumentsDirectory();
    final file = File("${dir.path}/${document.name}.pdf");
    await file.writeAsBytes(response.bodyBytes);
    return file.path;
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () async {
        try {
          final filePath = await _downloadAndSavePdf(document.url);
          if (context.mounted) {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ViewPdfPage(filePath: filePath),
            ));
          }
        } catch (e) {
          print("Error downloading PDF: $e");
        }
      },
      leading: const Icon(Icons.picture_as_pdf),
      title: Text(document.name),
      trailing: GestureDetector(
        onTap: () async {},
        child: const Icon(Icons.settings),
      ),
    );
  }
}

class ViewPdfPage extends StatelessWidget {
  const ViewPdfPage({
    super.key,
    required this.filePath,
  });

  final String filePath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        color: Colors.purple,
        child: PDFView(
          filePath: filePath,
          onError: (error) => print("error: $error"),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const SecondSignatureTest(),
            ),
          );
        },
        child: const Icon(Icons.edit_document),
      ),
    );
  }
}
