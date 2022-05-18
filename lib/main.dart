import 'dart:math';

import 'package:flutter/material.dart';

import 'map_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  MapController? controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: MapView(
                  initialCoordinate: const LatLon(59.93, 30.36),
                  onCreated: (controller) => setState(() {
                    this.controller = controller;
                  }),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      onPressed: () => controller?.move(
                        LatLon(
                          Random().nextDouble() * 180 - 90,
                          Random().nextDouble() * 360 - 180,
                        ),
                      ),
                      child: const Text('Random'),
                    ),
                    ElevatedButton(
                      onPressed: controller?.causeError,
                      child: const Text('Error'),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 88,
            right: 16,
            child: controller == null
                ? const SizedBox.shrink()
                : StreamBuilder<LatLon>(
                    stream: controller!.coordinateStream,
                    builder: (context, snapshot) {
                      final latLon = snapshot.data;
                      if (latLon == null) return const SizedBox.shrink();

                      return Text(
                        '${latLon.lat.toStringAsPrecision(5)} ; ${latLon.lon.toStringAsPrecision(5)}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.w600,
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
