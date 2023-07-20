import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class UploadPage extends StatefulWidget {
  const UploadPage({super.key});

  @override
  State<UploadPage> createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  PlatformFile? pickFile;
  var filepicked = false;
  UploadTask? uploadTask;
  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null) return;
    setState(() {
      pickFile = result.files.first;
      filepicked = true;
    });
  }

  Future uploadFile() async {
    var uuid = Uuid();
    final path = 'files/${uuid.v1() + pickFile!.name}';
    final file = File(pickFile!.path!);

    final ref = FirebaseStorage.instance.ref().child(path);
    uploadTask = ref.putFile(file);

    final snapshot = await uploadTask!.whenComplete(() {});

    final urlDownload = await snapshot.ref.getDownloadURL();
    print(urlDownload);

    popcon();
  }

  void popcon() {
    navigator?.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Tikipap Upload your post")),
      body: SingleChildScrollView(
        child: Column(
          children: [
            filepicked
                ? (Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        child: Image.file(
                      File(pickFile!.path!),
                      fit: BoxFit.cover,
                    )),
                  ))
                : InkWell(
                    onTap: () async {
                      selectFile();
                    },
                    child: (Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 200,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 220, 220, 220),
                        ),
                        child: Center(
                          child: Text("Choose A Image To Post"),
                        ),
                      ),
                    )),
                  ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
              child: TextFormField(
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Caption..',
                ),
              ),
            ),
            TextButton(
                onPressed: () async {
                  await uploadFile();
                },
                child: Text("Upload"))
          ],
        ),
      ),
    );
  }
}
