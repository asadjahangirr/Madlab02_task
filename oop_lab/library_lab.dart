// library_lab.dart  -  Campus Library System
// Name: ASADJAHANGIRR   Roll no: 04072313036

const String rollNo = '04072313036'; // e.g. '21F-0347'

// ===== Seeded settings (generated from YOUR roll number). Do not edit. =====
final int seed = int.parse(rollNo.substring(rollNo.length - 2));
final int t = seed ~/ 10; // tens digit
final int u = seed % 10; // units digit

const List<String> titles = [
  'Dart Basics',
  'Flutter In Action',
  'Data Structures',
  'Operating Systems',
  'Mobile Design',
  'Clean Code',
  'Algorithms Unlocked',
  'Computer Networks',
  'Database Systems',
  'Software Testing',
];

int yearOf(int i) => 1995 + 2 * i + t; // publication year of titles[i]
final int feePerDay = 5 + t; // late fee per day, in rupees
final int daysLate = 3 + (t + u) % 6; // normal number of days late
final int daysBig = 10 + u; // a long overdue period
final int feeCap = 150 + 10 * t; // no single fee may exceed this
final int renewLimit = 1 + t % 3; // renewals allowed per item
final int renewAttempts = 2 + u; // renewal attempts made in Step 5
final int shelfSize = 3 + u % 4; // items on the shelf in Steps 9-10

// ===========================================================================
//1.1
class LibraryItem {
  final String title;
  final int year;
  LibraryItem(this.title, this.year);
  String describe() => '$title ($year)';
}

//1.2
class Book extends LibraryItem {
  final int pages;
  Book(super.title, super.year, this.pages);
  //2.2
  @override
  String describe() =>
'${super.describe()}, $pages pages';
  // Think: If @override is omitted and describe is misspelled
  // as descibe(), Dart treats it as a different method.
  // The inherited describe() would run instead, omitting pages.
  // Using @override helps detect this mistake.
}
Book mainBook(){
      return Book(titles[u], yearOf(u), 100 + 3 * seed);
}
//2.3
class Magazine extends LibraryItem{
  final int issue;
  Magazine(super.title, super.year,this.issue);
  @override 
    String describe() => '${super.describe()}, issue $issue';
}

Magazine mainMagazine() {
  int i = (u + 1) % 10;
  return Magazine(titles[i], yearOf(i), 1 + (t + u) % 12);
}

void main() {
  print('Seed: $seed (t=$t, u=$u)');
  step1();
  step2();
  step3();
  step4();
  step5();
  step6();
  step7();
  step8();
  step9();
  step10();
}

void step1() {
  print('--- Step 1 ---');
  Book b = mainBook();
  LibraryItem item = b;
  print('step 1:${b.title} (${b.year}),${b.pages}page');
  print('step 1 stored as libraryItem: ${item.title}');
  print('runtimeType:${item.runtimeType}');
  //  Think: item.pages causes a compile error because item is
  //  declared as LibraryItem, which has no pages field.
  //  Dart checks member access using the declared variable type
  //2.1
  
  }


void step2() {
  print('--- Step 2 ---');
  print('Step 2: ${mainBook().describe()}');
  print('Step 2: ${mainMagazine().describe()}');
}

void step3() {
  print('--- Step 3 ---');
}

void step4() {
  print('--- Step 4 ---');
}

void step5() {
  print('--- Step 5 ---');
}

void step6() {
  print('--- Step 6 ---');
}

void step7() {
  print('--- Step 7 ---');
}

void step8() {
  print('--- Step 8 ---');
}

void step9() {
  print('--- Step 9 ---');
}

void step10() {
  print('--- Step 10 ---');
}
