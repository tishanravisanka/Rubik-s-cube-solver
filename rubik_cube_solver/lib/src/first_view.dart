import 'dart:io';
import 'dart:convert';
import 'package:rubik_cube_solver/src/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:async/async.dart';
import 'package:go_router/go_router.dart';

class FirstView extends StatefulHookConsumerWidget {
  const FirstView({super.key});
  static const routeName = 'first-view';

  @override
  _FirstViewState createState() => _FirstViewState();
}

class _FirstViewState extends ConsumerState<FirstView> {
  File? selectedImage;
  String? message = "";
  File? imageFile;
  String temp = "";

  uploadImage() async {
    temp = await upload(imageFile!);

    setState(() {});
  }

  upload(File imageFile) async {
    // open a bytestream
    var stream = http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
    // get file length
    var length = await imageFile.length();
    // string to uri
    var uri = Uri.parse("http://d3b4-192-248-34-29.ngrok.io");

    // create multipart request
    var request = http.MultipartRequest("POST", uri);

// multipart that takes file
    var multipartFile = http.MultipartFile('image', stream, length,
        filename: basename("image1.jpg"));

    // add file to multipart
    request.files.add(multipartFile);

    // send
    var response = await request.send();
    print(response.statusCode);
    final res = await response.stream.bytesToString();
    return res;
  }

  @override
  Widget build(BuildContext context) {
    final xFileState = ref.watch(xFileProvider);
    imageFile = File(xFileState.path);
    return Scaffold(
      appBar: AppBar(
        title: const Text('First Image'),
      ),
      body: Column(
        children: [
          Center(
            child: Image.file(
              File(xFileState.path),
              height: 400,
            ),
          ),
          TextButton.icon(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.blue)),
              onPressed: () async {
                await uploadImage();
                temp == "First Done"
                    ? context.go('/secondImage')
                    : Navigator.pop(context); //fun2
              },
              icon: const Icon(Icons.upload_file),
              label: const Text(
                "Upload",
                style: TextStyle(
                  color: Colors.white,
                ),
              )),
          //     ))
        ],
      ),
    );
  }
}
