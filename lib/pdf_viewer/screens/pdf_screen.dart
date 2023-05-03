// ignore_for_file: unused_local_variable, unused_element, unused_field, library_private_types_in_public_api

import 'dart:async';
import 'dart:io';

import 'package:dictionary/utils/logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdftron_flutter/pdftron_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../utils/navigator.dart';

class PdfScreen extends StatefulWidget {
  final String path;
  const PdfScreen({super.key, required this.path});

  @override
  _PdfScreenState createState() => _PdfScreenState();
}

class _PdfScreenState extends State<PdfScreen> {
  String _version = 'Unknown';
  bool _showViewer = true;

  @override
  void initState() {
    super.initState();
    initPlatformState();

    showViewer();

    if (Platform.isIOS) {
      showViewer();
    } else {
      launchWithPermission();
    }
  }

  Future<void> launchWithPermission() async {
    PermissionStatus permission = await Permission.storage.request();
    if (permission.isGranted) {
      showViewer();
    }
  }

  // Platform messages are asynchronous, so initialize in an async method.
  Future<void> initPlatformState() async {
    String version;
    // Platform messages may fail, so use a try/catch PlatformException.
    try {
      // Initializes the PDFTron SDK, it must be  ed before you can use any functionality.
      PdftronFlutter.initialize("your_pdftron_license_key");

      version = await PdftronFlutter.version;
    } on PlatformException {
      version = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, you want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _version = version;
    });
  }

  void showViewer() async {
    // opening without a config file will have all functionality enabled.
    // await PdftronFlutter.openDocument(_document);

    var config = Config();
    
    config.autoSaveEnabled = true;
    config.showLeadingNavButton = true;

    // An event listener for document loading
    var documentLoadedCancel = startDocumentLoadedListener((filePath) {
      logger.info("document loaded: $filePath");
    });

    var leadingNavCancel = startLeadingNavButtonPressedListener(() {
      logger.error("LEADING PRESSED");
      // Uncomment this to quit the viewer when leading navigation button is pressed.
      setState(() {
        _showViewer = !_showViewer;
      });

      // Show a dialog when leading navigation button is pressed.
      _showMyDialog();
    });

    leadingNavCancel();

    await PdftronFlutter.openDocument(widget.path, config: config);

    try {
      // The imported command is in XFDF format and tells whether to add, modify or delete annotations in the current document.
      PdftronFlutter.importAnnotationCommand(
          "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n    <xfdf xmlns=\"http://ns.adobe.com/xfdf/\" xml:space=\"preserve\">\n      <add>\n        <square style=\"solid\" width=\"5\" color=\"#E44234\" opacity=\"1\" creationdate=\"D:20200619203211Z\" flags=\"print\" date=\"D:20200619203211Z\" name=\"c684da06-12d2-4ccd-9361-0a1bf2e089e3\" page=\"1\" rect=\"113.312,277.056,235.43,350.173\" title=\"\" />\n      </add>\n      <modify />\n      <delete />\n      <pdf-info import-version=\"3\" version=\"2\" xmlns=\"http://www.pdftron.com/pdfinfo\" />\n    </xfdf>");
    } on PlatformException catch (e) {
      // print("");
      logger.error("Failed to importAnnotationCommand '${e.message}'.");
    }

    try {
      // Adds a bookmark into the document.
      PdftronFlutter.importBookmarkJson('{"0":"Page 1"}');
    } on PlatformException catch (e) {
      logger.error("Failed to importBookmarkJson '${e.message}'.");
    }

    // An event listener for when local annotation changes are committed to the document.
    // xfdfCommand is the XFDF Command of the annotation that was last changed.
    var annotCancel = startExportAnnotationCommandListener((xfdfCommand) {
      String command = xfdfCommand;
      logger.info("flutter xfdfCommand:\n");
      // Dart limits how many characters are printed onto the console.
      // The code below ensures that all of the XFDF command is printed.
      if (command.length > 1024) {
        int start = 0;
        int end = 1023;
        while (end < command.length) {
          logger.error("${command.substring(start, end)}\n");
          start += 1024;
          end += 1024;
        }
        logger.info(command.substring(start));
      } else {
        logger.info("flutter xfdfCommand:\n $command");
      }
    });

    var bookmarkCancel = startExportBookmarkListener((bookmarkJson) {
      logger.info("flutter bookmark: $bookmarkJson");
    });

    var path = await PdftronFlutter.saveDocument();
    logger.info("flutter save: $path");

    // To cancel event:
    // annotCancel();
    // bookmarkCancel();
    // documentLoadedCancel();
  }

  @override
  Widget build(BuildContext context) {
    appRouter.pop();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => appRouter.pop(),
          icon: const Icon(
            Icons.arrow_back_outlined,
            size: 30,
            color: Colors.black,
          ),
        ),
      ),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child:
            // Uncomment this to use Widget version of the viewer.
            _showViewer
                ? DocumentView(
                    onCreated: _onDocumentViewCreated,
                  )
                : Container(),
      ),
    );
  }

  // This function is used to control the DocumentView widget after it has been created.
  // The widget will not work without a void Function(DocumentViewController controller) being passed to it.
  void _onDocumentViewCreated(DocumentViewController controller) async {
    Config config = Config();

    var leadingNavCancel = startLeadingNavButtonPressedListener(() {
      // Uncomment this to quit the viewer when leading navigation button is pressed.
      // this.setState(() {
      //   _showViewer = !_showViewer;
      // });

      // Show a dialog when leading navigation button is pressed.
      _showMyDialog();
    });

    controller.openDocument(widget.path, config: config);
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // User must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('AlertDialog'),
          content: const SingleChildScrollView(
            child: Text('Leading navigation button has been pressed.'),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
