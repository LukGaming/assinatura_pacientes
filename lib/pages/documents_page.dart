import 'package:assinatura_paciente/controllers/documents_controller.dart';
import 'package:assinatura_paciente/widgets/document_list_tile.dart';
import 'package:flutter/material.dart';

class PacientFilesPage extends StatefulWidget {
  const PacientFilesPage({super.key});

  @override
  State<PacientFilesPage> createState() => _PacientFilesPageState();
}

class _PacientFilesPageState extends State<PacientFilesPage> {
  final _documentsController = DocumentsController();

  @override
  void initState() {
    _documentsController.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Seus arquivos"),
      ),
      body: ValueListenableBuilder(
        valueListenable: _documentsController,
        builder: (context, state, child) {
          return ListView.builder(
            itemBuilder: (context, index) =>
                DocumentListTile(document: state[index]),
            itemCount: state.length,
          );
        },
      ),
    );
  }
}
