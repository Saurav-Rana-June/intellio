import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/spaces_controller.dart';

class SpacesView extends GetView<SpacesController> {
  const SpacesView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SpacesView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'SpacesView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
