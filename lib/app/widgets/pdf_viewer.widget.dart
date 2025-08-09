import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../infrastructure/theme/theme.dart';

class PdfViewScreen extends StatelessWidget {
  final String header;
  final String url;

  const PdfViewScreen({super.key, required this.url, required this.header});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          header,
          style: r16.copyWith(fontWeight: FontWeight.w600),
        ),
      ),
      body: SfPdfViewer.network(
        url,
        canShowScrollHead: true,
        canShowScrollStatus: true,
      ),
    );
  }
}
