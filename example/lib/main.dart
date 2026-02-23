import 'package:before_after_slider/before_after_slider.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const ExampleApp());
}

class ExampleApp extends StatelessWidget {
  const ExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'before_after_slider example',
      home: const ExamplePage(),
      theme: ThemeData(useMaterial3: true),
    );
  }
}

class ExamplePage extends StatefulWidget {
  const ExamplePage({super.key});

  @override
  State<ExamplePage> createState() => _ExamplePageState();
}

class _ExamplePageState extends State<ExamplePage> {
  double _progress = 0.5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('before_after_slider example')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: BeforeAfter(
                beforeChild:
                    Image.asset('assets/before.jpeg', fit: BoxFit.cover),
                afterChild: Image.asset('assets/after.jpeg', fit: BoxFit.cover),
                progress: _progress,
                onProgressChanged: (value) => setState(() => _progress = value),
              ),
            ),
            const SizedBox(height: 12),
            Slider(
              value: _progress,
              onChanged: (value) => setState(() => _progress = value),
            ),
          ],
        ),
      ),
    );
  }
}
