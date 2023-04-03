import 'dart:io';

import 'package:camera/camera.dart';
import 'package:rubik_cube_solver/src/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rubik_cube_solver/src/second_view.dart';

class SecondImage extends StatefulHookConsumerWidget {
  const SecondImage({super.key});
  static const routeName = 'secondImage';

  @override
  _SecondImageState createState() => _SecondImageState();
}

class _SecondImageState extends ConsumerState<SecondImage> {
  late CameraController controller;

  @override
  Widget build(BuildContext context) {
    final xFileState = ref.watch(xFileProvider);

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: const [
            Text('Second Image'),
          ],
        ),
      ),
      body: Column(
        children: [
          FutureBuilder(
            future: initializationCamera(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    AspectRatio(
                      aspectRatio: 9 / 16,
                      child: CameraPreview(controller),
                    ),
                    AspectRatio(
                      aspectRatio: 9 / 16,
                      child: Image.asset(
                        'assets/images/frameNew.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                    InkWell(
                      onTap: () => onTakePicture(),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 20.0),
                        child: CircleAvatar(
                          radius: 30.0,
                          backgroundColor: Colors.white,
                        ),
                      ),
                    ),
                  ],
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ],
      ),
    );
  }

  Future<void> initializationCamera() async {
    var cameras = await availableCameras();
    controller = CameraController(
      cameras[EnumCameraDescription.front.index],
      ResolutionPreset.high,
      imageFormatGroup: ImageFormatGroup.jpeg,
    );
    await controller.initialize();
  }

  void onTakePicture() async {
    await controller.takePicture().then((XFile xfile) {
      if (mounted) {
        if (xfile != null) {
          ref.read(xFileProvider.notifier).state = xfile;
          context.pushNamed(SecondView.routeName);
        }
      }
      return;
    });
  }
}

enum EnumCameraDescription { front, back }
