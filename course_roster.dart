/// Welcome
void printWelcome(String appName) {
  print('=== $appName ===');
}

String generateCode(String title) {
  return title.substring(0, 2).toUpperCase() + '101';
}

void main() {
  // Part1
  printWelcome('Course Roster Manager');

  // Part2
  const int maxCapacity = 4;
  final DateTime createdAt = DateTime.now();

  String courseTitle = 'CS201: Mobile App Development';
  int capacity = maxCapacity;
  double creditHours = 3.0;
  bool isOpen = true;

  List<String> enrolledStudents = ['Aiden', 'Maria', 'Jamal'];

  Set<String> waitlist = {'Priya', 'Noah'};

  Map<String, int> attendanceCount = {
    'Aiden': 3,
    'Maria': 4,
    'Jamal': 2,
  };

  print(
    '$courseTitle | Capacity: $capacity | Enrolled: ${enrolledStudents.length}',
  );

  // Part3
  String? instructorEmail;

  print(instructorEmail ?? 'TBA');

  late String enrollmentCode;
  enrollmentCode = generateCode(courseTitle);

  print('Enrollment code: $enrollmentCode');

  print(instructorEmail?.length ?? 0);

  // Part4
  String rawNames = ' Aiden , maria ,JAMAL , Priya ';

  List<String> cleanNames = [];

  for (var name in rawNames.split(',')) {
    cleanNames.add(name.trim());
  }

  String description = '''
Course: $courseTitle
Credit Hours: $creditHours
Created At: $createdAt
''';

  print(cleanNames);
  print(description);

  print('Seats left: ${capacity - enrolledStudents.length}');

  // Part5
int fullGroups = enrolledStudents.length ~/ 3;
int leftover = enrolledStudents.length % 3;

print('Full groups of 3: $fullGroups');
print('Leftover: $leftover');

Object formInput = 'twenty-two';

if (formInput is String) {
  print('This is text!');
}

if (formInput is! int) {
  print('This is not an integer!');
}

StringBuffer report = StringBuffer()
  ..write('Report: $courseTitle')
  ..write(' | Cap: $capacity')
  ..write(' | Roster: ${enrolledStudents.length}');

print(report.toString());

List<String>? extraNotes;

extraNotes?..add('Room change pending');

print('Extra notes: $extraNotes');

int? bonusSeats;

bonusSeats ??= 0;

print('Bonus seats: $bonusSeats');


}