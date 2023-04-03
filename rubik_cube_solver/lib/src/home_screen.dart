import 'dart:io';

import 'package:camera/camera.dart';
import 'package:rubik_cube_solver/src/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'first_view.dart';

class HomeScreen extends StatefulHookConsumerWidget {
  const HomeScreen({super.key});
  static const routeName = 'home-screen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  late CameraController controller;

  @override
  Widget build(BuildContext context) {
    final xFileState = ref.watch(xFileProvider);

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.white,
              backgroundImage: Image.file(File(xFileState.path)).image,
            ),
            const SizedBox(
              width: 10.0,
            ),
            const Text('First Image'),
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
          // ElevatedButton(
          //   onPressed: () {
          //     context.goNamed("results", params: {'sol': "L U F' D L' D'"});
          //   },
          //   child: const Text('Enabled'),
          // ),
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
          context.pushNamed(FirstView.routeName);
        }
      }
      return;
    });
  }
}

enum EnumCameraDescription { front, back }
