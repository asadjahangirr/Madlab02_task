
 // main.dart - Study Tracker lab
import 'dart:async';

import 'package:flutter/material.dart';

const String studentName = 'Asad Jahangir';
const String rollNo = '04072313036'; // e.g. '21F-0347'

// ===== Seeded settings (generated from YOUR roll number). Do not edit. =====
final int seed = int.parse(rollNo.substring(rollNo.length - 2));
final int t = seed ~/ 10; // tens digit
final int u = seed % 10; // units digit

const List<String> courses = [
  'Mobile Dev', 'Data Structures', 'Operating Systems', 'Databases',
  'Networks', 'Software Eng', 'AI', 'Web Engineering', 'Graphics', 'Security',
];

final String course = courses[u]; // your course name
final int startCount = 3 + u; // where the tally starts
final int stepSize = 1 + t % 4; // how much + and - change the tally
final int maxCount = 20 + 2 * t; // the tally may never go above this
final int startSeconds = 5 + (t + u) % 6; // where the countdown starts
final int bugStep = 1 + u % 4; // used by BuggyCounter in Step 7
// ===========================================================================

// Step 9 writes to this list from initState and dispose.
final List<String> lifecycleLog = <String>[];

void main() => runApp(const LabApp());

// Think Question - Step 1:
// runApp() receives the root widget (LabApp) to start the app.
// MaterialApp's home receives HomePage, the main screen.
// runApp starts the app, while home defines the first page.

//1

// Keep the name LabApp and its const constructor: the checker uses them.

// Stateless - LabApp only provides the root app configuration.
class LabApp extends StatelessWidget {
  const LabApp({super.key});

  //1.1
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Study Tracker',
      home: HomePage(),
    );
  }
}

//creating home

// Stateless - HomePage builds the screen from given values.
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  //1.2
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Study Tracker: $course'),
      ),

      //3.1
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            //2.3
            StudentCard(
              name: studentName,
              roll: rollNo,
              course: course,
            ),

            const SizedBox(height: 12),

            //3.2
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Start: $startCount', key: const Key('info-start')),
                Text('Step: $stepSize', key: const Key('info-step')),
                Text('Max: $maxCount', key: const Key('info-max')),
              ],
            ),

            //5.3
            const SizedBox(height: 12),
            const Tally(),

            //8.4
            const SizedBox(height: 12),
            const Countdown(),

            //7.1
            const SizedBox(height: 12),
            const BuggyCounter(),
          ],
        ),
      ),
    );
  }
}

//2

// Think Question - Step 2:
// StatelessWidget fields are final because widgets are immutable.
// final prevents changing their values after initialization.
// Removing final causes an immutable widget field error.

// Stateless - StudentCard displays the values passed to it.
class StudentCard extends StatelessWidget {
  final String name;
  final String roll;
  final String course;

  //2.1
  const StudentCard({
    super.key,
    required this.name,
    required this.roll,
    required this.course,
  });

  //2.2
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Name: $name', key: const Key('student-name')),
            Text('Roll no: $roll', key: const Key('student-roll')),
            Text('Course: $course', key: const Key('student-course')),
          ],
        ),
      ),
    );
  }
}

// Think Question - Step 3:
// Widget tree:
// LabApp -> MaterialApp -> HomePage -> Scaffold
// -> SingleChildScrollView -> Column -> Row -> Text('Max')
// Text('Max') is at level 8 when LabApp is level 1.

//4

// Stateless - GoalBanner displays progress using final values.
class GoalBanner extends StatelessWidget {
  final int count;
  final int max;

  //4.1
  const GoalBanner({
    super.key,
    required this.count,
    required this.max,
  });

  //4.2
  @override
  Widget build(BuildContext context) {
    final percent = count * 100 ~/ max;

    return Text(
      'Progress: $count of $max ($percent%)',
      key: const Key('progress'),
    );
  }
}

// Think Question - Step 4:
// GoalBanner does not need setState because it is Stateless.
// To show a new count, the parent rebuilds GoalBanner
// with a new count value.

//5

// Stateful - Tally needs State to store the changing count.
class Tally extends StatefulWidget {
  const Tally({super.key});

  //5.1
  @override
  State<Tally> createState() => _TallyState();
}

// Stateful - _TallyState keeps the count and updates it.
class _TallyState extends State<Tally> {
  int _count = startCount;

  //5.3 and 6.1
  void _plus() {
    setState(() {
      _count += stepSize;

      if (_count > maxCount) {
        _count = maxCount;
      }
    });
  }

  //6.2
  void _minus() {
    setState(() {
      _count -= stepSize;

      if (_count < 0) {
        _count = 0;
      }
    });
  }

  //6.2
  void _reset() {
    setState(() {
      _count = startCount;
    });
  }

  //5.2 and 6.2
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Count: $_count', key: const Key('count')),

        GoalBanner(
          count: _count,
          max: maxCount,
        ),

        Row(
          children: [
            ElevatedButton(
              key: const Key('plus'),
              onPressed: _plus,
              child: Text('+$stepSize'),
            ),

            const SizedBox(width: 8),

            ElevatedButton(
              key: const Key('minus'),
              onPressed: _minus,
              child: Text('-$stepSize'),
            ),

            const SizedBox(width: 8),

            OutlinedButton(
              key: const Key('reset'),
              onPressed: _reset,
              child: const Text('Reset'),
            ),
          ],
        ),
      ],
    );
  }
}

// Think Question - Step 5:
// Tally is the widget configuration.
// _TallyState stores the changing data.
// Two classes separate the widget from its mutable State.

// Think Question - Step 6:
// Hot reload preserves the current State.
// For example, a count of 13 normally stays 13.
// Hot restart creates a new widget tree and State.
// Therefore, the count resets to 9.

//7

// Stateful - BuggyCounter stores a changing click count.
class BuggyCounter extends StatefulWidget {
  const BuggyCounter({super.key});

  @override
  State<BuggyCounter> createState() => _BuggyCounterState();
}

// Stateful - _BuggyCounterState stores and changes _clicks.
class _BuggyCounterState extends State<BuggyCounter> {
  int _clicks = 0;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text('Bug clicks: $_clicks', key: const Key('bug-text')),
        const SizedBox(width: 12),
        ElevatedButton(
          key: const Key('bug-button'),
          onPressed: () {

            //7.2
            setState(() {
              _clicks += bugStep;
            });

          },
          child: Text('+$bugStep'),
        ),
      ],
    );
  }
}

// Think Question - Step 7:
// Before fixing the bug, after 3 taps:
// _clicks inside State = 9.
// Screen showed Bug clicks: 0.
// Without setState, the screen does not rebuild.
// After fixing, every tap updates the screen by 3.

//8

// Stateful - Countdown needs State for the timer and time left.
class Countdown extends StatefulWidget {
  const Countdown({super.key});

  //8.1
  @override
  State<Countdown> createState() => _CountdownState();
}

// Stateful - _CountdownState manages time, builds, and lifecycle.
class _CountdownState extends State<Countdown> {
  late int _left;
  late Timer _timer;

  //9.1
  int _builds = 0;

  //8.2 and 9.2
  @override
  void initState() {
    super.initState();

    //9.2
    lifecycleLog.add('initState');

    _left = startSeconds;

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() => _left--);

      if (_left <= 0) timer.cancel();
    });
  }

  //8.3 and 9.2
  @override
  void dispose() {
    _timer.cancel();

    //9.2
    lifecycleLog.add('dispose');

    super.dispose();
  }

  //8.4 and 9.1
  @override
  Widget build(BuildContext context) {
    //9.1
    _builds++;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (_left > 0)
          Text(
            'Time left: $_left s',
            key: const Key('time-left'),
          )
        else
          const Text(
            'Time is up!',
            key: Key('time-left'),
          ),

        //9.1
        Text(
          'Builds: $_builds',
          key: const Key('builds'),
        ),
      ],
    );
  }
}

// Think Question - Step 8:
// If the timer is not cancelled in dispose,
// it may continue after the State is removed.
// This can cause setState() called after dispose().

// Think Question - Step 9:
// The timer calls setState once every second,
// so build normally runs once per second.
// We can print lifecycleLog inside dispose()
// after adding 'dispose' to verify the lifecycle.

//10

//10.1
// HomePage contains all widgets in the correct order:
// StudentCard -> Info Row -> Tally -> Countdown -> BuggyCounter.
// Each widget appears once.

//10.2
// SingleChildScrollView allows vertical scrolling.
// Const constructors are used wherever appropriate.

//10.3
// Stateless and Stateful explanations are written
// above each widget class.
