import 'package:flutter/material.dart';

void main() {
  runApp(const SnapLabApp());
}

/// Tiny playground app for testing snaptool snapshots.
/// Change the title, defaults, or UI — then re-run your watch command
/// and inspect the diff / dashboard.
class SnapLabApp extends StatelessWidget {
  const SnapLabApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Snap Lab',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.teal,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      home: const SnapLabHome(),
    );
  }
}

class SnapLabHome extends StatefulWidget {
  const SnapLabHome({super.key});

  @override
  State<SnapLabHome> createState() => _SnapLabHomeState();
}

class _SnapLabHomeState extends State<SnapLabHome> {
  // Tweak these between snaptool runs to see meaningful diffs.
  static const String appHeadline = 'Snap Lab v1';

  int _taps = 0;
  int _colorIndex = 0;
  late final TextEditingController _noteController;

  static const List<Color> _swatches = [
    Colors.teal,
    Colors.indigo,
    Colors.pink,
  ];

  Color get _accent => _swatches[_colorIndex % _swatches.length];

  @override
  void initState() {
    super.initState();
    _noteController = TextEditingController(text: 'first note — edit me');
  }

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _accent.withValues(alpha: 0.08),
      appBar: AppBar(
        backgroundColor: _accent,
        foregroundColor: Colors.white,
        title: const Text(appHeadline),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Tap counter', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            Text(
              '$_taps',
              style: Theme.of(context).textTheme.displayLarge?.copyWith(
                color: _accent,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Scratch note',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _noteController,
              maxLines: 3,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                hintText: 'Type something temporary…',
              ),
            ),
            const SizedBox(height: 24),
            FilledButton.tonal(
              onPressed: () {
                setState(() => _colorIndex++);
              },
              child: const Text('Cycle accent color'),
            ),
            const SizedBox(height: 8),
            OutlinedButton(
              onPressed: () {
                setState(() {
                  _taps = 0;
                  _colorIndex = 0;
                  _noteController.text = 'reset';
                });
              },
              child: const Text('Reset'),
            ),
            const Spacer(),
            Text(
              'Tip: change appHeadline / defaults in main.dart,\n'
              'then run: snaptool watch -- flutter test',
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: Colors.black54),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: _accent,
        foregroundColor: Colors.white,
        onPressed: () => setState(() => _taps++),
        icon: const Icon(Icons.add),
        label: const Text('Tap'),
      ),
    );
  }
}
