import 'package:assinatura_paciente/mock/generate_document_list.dart';
import 'package:assinatura_paciente/models/document.dart';
import 'package:flutter/material.dart';

class DocumentsController extends ValueNotifier<List<Document>> {
  DocumentsController() : super([]);

  void init() {
    value = generateDocumentList();
  }
}
