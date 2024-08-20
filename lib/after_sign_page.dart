import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ShowSignaturePage extends StatefulWidget {
  final File signature;
  const ShowSignaturePage({
    super.key,
    required this.signature,
  });

  @override
  State<ShowSignaturePage> createState() => _ShowSignaturePageState();
}

class _ShowSignaturePageState extends State<ShowSignaturePage> {
  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.file(widget.signature),
      ),
    );
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);

    super.dispose();
  }
}
