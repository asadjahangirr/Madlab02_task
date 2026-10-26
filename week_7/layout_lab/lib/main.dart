import 'dart:async';

import 'package:flutter/material.dart';

const String studentName = 'Asad Jahangir';
const String rollNo = '04072313036';

// ===== Seeded settings (generated from YOUR roll number). Do not edit. =====
final int seed = int.parse(rollNo.substring(rollNo.length - 2));
final int t = seed ~/ 10; // tens digit
final int u = seed % 10; // units digit

const List<String> courses = [
  'Mobile Dev',
  'Data Structures',
  'Operating Systems',
  'Databases',
  'Networks',
  'Software Eng',
  'AI',
  'Web Engineering',
  'Graphics',
  'Security',
];

const List<String> names = ['Ali', 'Sara', 'Omar', 'Hina', 'Zain', 'Maya'];

const List<String> mains = [
  'start',
  'center',
  'end',
  'spaceBetween',
  'spaceAround',
  'spaceEvenly',
];

const List<String> crosses = ['start', 'center', 'end'];
const List<String> hues = ['teal', 'indigo', 'orange', 'pink', 'green'];

const Map<String, MaterialColor> swatches = {
  'teal': Colors.teal,
  'indigo': Colors.indigo,
  'orange': Colors.orange,
  'pink': Colors.pink,
  'green': Colors.green,
};

final String course = courses[u];

// Steps 1-2: the clock
final int startSec = 5 * (1 + t % 5); // where the clock starts
final int tick = 1 + u % 3; // how much it adds every second
final int ticks = 4 + u % 4; // how many ticks until it stops
final int stopAt = startSec + ticks * tick; // the clock stops here

// Steps 4-5: the tiles
final String tileA = names[u % 6];
final String tileB = names[(u + 2) % 6];
final String tileC = names[(u + 4) % 6];
final int tapsToMake = 2 + t % 3;

// Step 6: axes (type the enums yourself)
final String mainName = mains[u % 6];
final String crossName = crosses[t % 3];

// Step 8: Expanded and Flexible
final double fixedW = 70.0 + 10 * u;
final int flexA = 1 + t % 3;
final int flexB = 1 + u % 2;

// Step 9: Container
final double boxMargin = 4.0 + 2 * (t % 5);
final double boxPad = 8.0 + 2 * (u % 5);
final double boxRadius = 4.0 * (1 + (t + u) % 4);
final double boxBorder = 1.0 + t % 3;
final String hue = hues[(t + u) % 5];

// Step 10: Stack
final double dotTop = 4.0 + 4 * (t % 4);
final double dotRight = 4.0 + 4 * (u % 4);
final double dotBottom = 4.0 + 4 * ((t + u) % 4);
final double dotLeft = 4.0 + 4 * ((t + 2 * u) % 4);
// ===========================================================================

final List<String> lifecycleLog = <String>[];

void main() => runApp(const LabApp());

// ===== Main App =====

class LabApp extends StatelessWidget {
  const LabApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(title: 'Team Board', home: HomePage());
  }
}

// ===== HomePage: All 10 Steps =====

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Team Board: $course')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SettingsCard(),
            const SizedBox(height: 12),

            const Welcome(),
            const SizedBox(height: 12),

            const Clock(),
            const SizedBox(height: 12),

            const SwapBoard(),
            const SizedBox(height: 12),

            const InfoPanel(),
            const SizedBox(height: 12),

            const SummaryRow(),
            const SizedBox(height: 12),

            const ShareRow(),
            const SizedBox(height: 12),

            const InfoBox(),
            const SizedBox(height: 12),

            const StampStack(),
          ],
        ),
      ),
    );
  }
}

// ===== SettingsCard: Provided Starter Widget =====

class SettingsCard extends StatelessWidget {
  const SettingsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'YOUR SETTINGS (seed $seed)\n'
      'clock: start $startSec, tick $tick, stop at $stopAt\n'
      'tiles: $tileA, $tileB, $tileC (taps for the Step 5 experiment: $tapsToMake)\n'
      'row main axis: $mainName | column cross axis: $crossName\n'
      'flex: $flexA and $flexB | fixed width: ${fixedW.toStringAsFixed(0)}\n'
      'box: margin $boxMargin, padding $boxPad, radius $boxRadius, '
      'border $boxBorder, colour $hue\n'
      'stamp: top $dotTop, right $dotRight, bottom $dotBottom, left $dotLeft',
      key: const Key('settings'),
      style: const TextStyle(fontFamily: 'monospace', fontSize: 12),
    );
  }
}

// ===== Step 7: SummaryRow with Expanded =====

class SummaryRow extends StatelessWidget {
  const SummaryRow({super.key});

  @override
  Widget build(BuildContext context) {
    // Constraints go down, sizes go up.
    // Expanded gives each Text a limited share of the Row width.
    // The Text wraps its words within that available width.

    return Row(
      children: [
        Expanded(
          child: Text(
            'Part A: read the widget tree of the $course board from top to bottom.',
            key: const Key('sum-a'),
          ),
        ),
        Expanded(
          child: Text(
            'Part B: build each box from small widgets and never extend a built-in class.',
            key: const Key('sum-b'),
          ),
        ),
        Expanded(
          child: Text(
            'Part C: break the layout on purpose, then fix it with Expanded or Wrap.',
            key: const Key('sum-c'),
          ),
        ),
      ],
    );
  }
}

// ===== Steps 1-2: Clock and Lifecycle =====

class Clock extends StatefulWidget {
  const Clock({super.key});

  @override
  State<Clock> createState() => _ClockState();
}

class _ClockState extends State<Clock> {
  late Timer _timer;
  int _seconds = startSec;
  int _builds = 0;

  @override
  void initState() {
    super.initState();

    lifecycleLog.add('initState');

    // The Timer belongs in initState because it starts only once.
    // Starting it inside build would create a new timer after
    // every rebuild, causing the clock to run faster.

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() => _seconds += tick);

      if (_seconds >= stopAt) {
        timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    lifecycleLog.add('dispose');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _builds++;

    // Each timer tick calls setState once, causing one Clock rebuild.
    // Both Text widgets update in that same rebuild.
    //
    // Without canceling the Timer in dispose, it could call setState
    // after the widget was removed, causing
    // "setState() called after dispose()".

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Session: $_seconds s', key: const Key('clock')),
        Text('Builds: $_builds', key: const Key('builds')),
        Probe(seconds: _seconds),
      ],
    );
  }
}

// ===== Step 3: Widget vs Element and BuildContext =====

class Probe extends StatelessWidget {
  final int seconds;

  const Probe({super.key, required this.seconds});

  @override
  Widget build(BuildContext context) {
    final bool above =
        context.findAncestorWidgetOfExactType<Scaffold>() != null;

    // Widget is a lightweight configuration replaced during rebuilds.
    // Element maintains the location in the widget tree and manages State.
    // RenderObjects perform layout, sizing, and painting.

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Seen at: $seconds s', key: const Key('probe-seen')),
        Text(
          'Widget #${identityHashCode(this)}',
          key: const Key('probe-widget'),
        ),
        Text(
          'Element #${identityHashCode(context)}',
          key: const Key('probe-element'),
        ),
        Text(
          'Context belongs to: ${context.widget.runtimeType}',
          key: const Key('probe-context'),
        ),
        Text('Scaffold above me: $above', key: const Key('probe-above')),
      ],
    );
  }
}

// ===== Step 4: Composition and Welcome =====

class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Welcome, $studentName', key: const Key('welcome')),
    );
  }
}

// ===== Step 4: Stateful Tile =====

class Tile extends StatefulWidget {
  const Tile(this.label, {super.key});

  final String label;

  @override
  State<Tile> createState() => _TileState();
}

class _TileState extends State<Tile> {
  int taps = 0;

  @override
  Widget build(BuildContext context) {
    // Composition builds the Tile using an ElevatedButton.
    // It is preferable to extending ElevatedButton because
    // smaller widgets can be reused and maintained independently.

    return ElevatedButton(
      onPressed: () => setState(() => taps++),
      child: Text('${widget.label}: $taps'),
    );
  }
}

// ===== Step 5: ValueKeys and Swapping =====

class SwapBoard extends StatefulWidget {
  const SwapBoard({super.key});

  @override
  State<SwapBoard> createState() => _SwapBoardState();
}

class _SwapBoardState extends State<SwapBoard> {
  var tiles = [
    Tile(tileA, key: ValueKey(tileA)),
    Tile(tileB, key: ValueKey(tileB)),
    Tile(tileC, key: ValueKey(tileC)),
  ];

  void swap() => setState(() => tiles = tiles.reversed.toList());

  @override
  Widget build(BuildContext context) {
    // Without keys, Flutter matches widgets by type and position.
    // Elements and their State stay in those positions.
    // ValueKeys make the correct State follow its widget when reordered.

    return Column(
      children: [
        Row(children: tiles),
        ElevatedButton(
          key: const Key('swap'),
          onPressed: swap,
          child: const Text('Swap'),
        ),
      ],
    );
  }
}

// ===== Step 6: Row and Column Alignment =====

class InfoPanel extends StatelessWidget {
  const InfoPanel({super.key});

  @override
  Widget build(BuildContext context) {
    // In a Column, the main axis is vertical.
    // The cross axis is horizontal, so crossAxisAlignment.center
    // changes the horizontal alignment, not vertical positioning.

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          key: const Key('info-row'),
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text('Start: $startSec s', key: const Key('row-a')),
            Text('Tick: $tick s', key: const Key('row-b')),
            Text('Stop: $stopAt s', key: const Key('row-c')),
          ],
        ),

        const SizedBox(height: 12),

        Column(
          key: const Key('info-col'),
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Name: $studentName', key: const Key('col-a')),
            Text('Roll no: $rollNo', key: const Key('col-b')),
            Text('Course: $course', key: const Key('col-c')),
          ],
        ),
      ],
    );
  }
}

// ===== Step 8: Expanded vs Flexible =====

class ShareRow extends StatelessWidget {
  const ShareRow({super.key});

  @override
  Widget build(BuildContext context) {
    // Expanded must fill its allocated share of the available width.
    // Flexible may stay smaller than its allocated share.
    //
    // Expanded is equivalent to Flexible with fit: FlexFit.tight.
    // If the two wrappers were swapped, the Flex button would
    // fill its share while the Exp button could stay smaller.

    return Row(
      key: const Key('share-row'),
      children: [
        SizedBox(
          key: const Key('fixed'),
          width: fixedW,
          child: ElevatedButton(onPressed: () {}, child: const Text('F')),
        ),

        Expanded(
          flex: flexA,
          child: ElevatedButton(
            key: const Key('exp'),
            onPressed: () {},
            child: const Text('Exp'),
          ),
        ),

        Flexible(
          flex: flexB,
          child: ElevatedButton(
            key: const Key('flex'),
            onPressed: () {},
            child: const Text('Flex'),
          ),
        ),
      ],
    );
  }
}

// ===== Step 9: Container — Margin, Padding, Decoration =====

class InfoBox extends StatelessWidget {
  const InfoBox({super.key});

  @override
  Widget build(BuildContext context) {
    // Margin is the space outside the border.
    // Padding is the space inside the border.
    // Use Padding for spacing without decoration.
    // Use SizedBox for fixed sizes or simple gaps.

    return Container(
      key: const Key('info-box'),
      margin: EdgeInsets.all(boxMargin),
      padding: EdgeInsets.all(boxPad),
      decoration: BoxDecoration(
        color: swatches[hue]!.shade100,
        borderRadius: BorderRadius.circular(boxRadius),
        border: Border.all(width: boxBorder),
      ),
      child: Text('Course: $course', key: const Key('box-text')),
    );
  }
}

// ===== Step 10: Stack and Positioned =====

class StampStack extends StatelessWidget {
  const StampStack({super.key});

  @override
  Widget build(BuildContext context) {
    // The non-positioned Container determines the Stack size.
    // Positioned widgets are placed relative to its edges.
    //
    // Stack paints children in order, with later children on top.
    // If the grey Container were placed last, it would cover
    // the star and circle.

    return Stack(
      key: const Key('stack'),
      children: [
        Container(
          key: const Key('layer-base'),
          width: 300,
          height: 120,
          color: Colors.grey.shade300,
        ),

        Positioned(
          top: dotTop,
          right: dotRight,
          child: const Icon(Icons.star, key: Key('dot-top')),
        ),

        Positioned(
          bottom: dotBottom,
          left: dotLeft,
          child: const Icon(Icons.circle, key: Key('dot-bottom')),
        ),
      ],
    );
  }
}
