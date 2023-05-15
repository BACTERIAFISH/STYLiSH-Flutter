import 'package:flutter/material.dart';
import 'package:arkit_plugin/arkit_plugin.dart';
import 'package:vector_math/vector_math_64.dart';

class ARDefaultPage extends StatefulWidget {
  const ARDefaultPage({super.key});

  @override
  State<ARDefaultPage> createState() => _ARDefaultPageState();
}

class _ARDefaultPageState extends State<ARDefaultPage> {
  late ARKitController arkitController;

  @override
  void dispose() {
    arkitController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'AR Default',
        ),
      ),
      body: ARKitSceneView(
        onARKitViewCreated: onARKitViewCreated,
      ),
    );
  }

  void onARKitViewCreated(ARKitController arkitController) {
    this.arkitController = arkitController;
    final node = ARKitNode(
      geometry: ARKitSphere(radius: 0.15),
      position: Vector3(0, 0, -1),
    );
    this.arkitController.add(node);
  }
}
