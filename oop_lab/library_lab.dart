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
abstract class LibraryItem {
  final String title;
  final int year;

  // Task 9.1
  static int created = 0;

  LibraryItem(this.title, this.year) {
    created++;
  }

  //2.1
  String describe() => '$title ($year)';

  //3.1
  int lateFee(int days);

  //9.1
  static int capFee(int fee) => fee > feeCap ? feeCap : fee;
}

//1.2
class Book extends LibraryItem with Renewable implements Borrowable {
  final int pages;

  //4.2
  bool _out = false;

  Book(super.title, super.year, this.pages);

  //2.2
  @override
  String describe() => '${super.describe()}, $pages pages';

  // Think: If @override is omitted and describe is misspelled
  // as descibe(), Dart treats it as a different method.
  // The inherited describe() would run instead, omitting pages.
  // Using @override helps detect this mistake.

  //3.2
  @override
  int lateFee(int days) => days * feePerDay;

  //4.2
  @override
  bool get isAvailable => !_out;

  @override
  void borrow() {
    _out = true;
  }

  @override
  void giveBack() {
    _out = false;
  }
}

//4.1
abstract class Borrowable {
  bool get isAvailable;
  void borrow();
  void giveBack();
}

//5.1
mixin Renewable {
  int renewals = 0;

  bool renew(int limit) {
    if (renewals >= limit) {
      return false;
    }
    renewals++;
    return true;
  }
}

//1.3
Book mainBook() {
  return Book(titles[u], yearOf(u), 100 + 3 * seed);
}

//2.3
class Magazine extends LibraryItem {
  final int issue;

  Magazine(super.title, super.year, this.issue);

  @override
  String describe() => '${super.describe()}, issue $issue';

  //3.2
  @override
  int lateFee(int days) => days * (feePerDay ~/ 2);
}

//3.2 and 5.2
class Dvd extends LibraryItem with Renewable {
  final int minutes;

  Dvd(super.title, super.year, this.minutes);

  @override
  String describe() => '${super.describe()}, $minutes min';

  @override
  int lateFee(int days) => days * feePerDay * 2;
}

Dvd mainDvd() {
  int i = (u + 2) % 10;
  return Dvd(titles[i], yearOf(i), 90 + seed % 40);
}

Magazine mainMagazine() {
  int i = (u + 1) % 10;
  return Magazine(titles[i], yearOf(i), 1 + (t + u) % 12);
}

//6.1
enum MemberType {
  student(3, 50),
  faculty(10, 20),
  guest(1, 0);

  final int maxLoans;
  final int discountPercent;

  const MemberType(this.maxLoans, this.discountPercent);

  int applyDiscount(int fee) => fee * (100 - discountPercent) ~/ 100;
}

//7.1
extension MoneyText on int {
  String get rs => 'Rs $this';
}

extension Initials on String {
  String get initials => split(' ').map((word) => word[0]).join();
}

extension ShelfMath on List<LibraryItem> {
  int totalLateFee(int days) =>
      fold(0, (sum, item) => sum + item.lateFee(days));
}

//8.1
class Fine {
  final int amount;

  const Fine(this.amount);

  Fine operator +(Fine other) => Fine(amount + other.amount);

  bool operator >(Fine other) => amount > other.amount;

  @override
  bool operator ==(Object other) =>
      other is Fine && other.amount == amount;

  @override
  int get hashCode => amount.hashCode;

  @override
  String toString() => 'Fine($amount)';
}

//9.2
List<LibraryItem> buildShelf() {
  List<LibraryItem> shelf = [];
  for (int k = 0; k < shelfSize; k++) {
    int i = (u + k) % 10;
    if (k % 3 == 0) {
      shelf.add(Book(titles[i], yearOf(i), 100 + 3 * seed));
    } else if (k % 3 == 1) {
      shelf.add(Magazine(titles[i], yearOf(i), 1 + (t + k) % 12));
    } else {
      shelf.add(Dvd(titles[i], yearOf(i), 90 + seed % 40));
    }
  }
  return shelf;
}

//10.1
class Member {
  final String name;
  final MemberType type;

  Member(this.name, this.type);

  Fine feeFor(LibraryItem item, int days) {
    int fee = item.lateFee(days);
    fee = LibraryItem.capFee(fee);
    fee = type.applyDiscount(fee);
    return Fine(fee);
  }
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

//1.3
void step1() {
  print('--- Step 1 ---');
  Book b = mainBook();
  LibraryItem item = b;
  print('Step 1: ${b.title} (${b.year}), ${b.pages} pages');
  print('Step 1: stored as LibraryItem: ${item.title}');
  print('Step 1: runtimeType = ${item.runtimeType}');
  //  Think: item.pages causes a compile error because item is
  //  declared as LibraryItem, which has no pages field.
  //  Dart checks member access using the declared variable type
  //2.1
}

//2.3
void step2() {
  print('--- Step 2 ---');
  print('Step 2: ${mainBook().describe()}');
  print('Step 2: ${mainMagazine().describe()}');
}

//3.3
void step3() {
  print('--- Step 3 ---');
  Book book = mainBook();
  Magazine magazine = mainMagazine();
  Dvd dvd = mainDvd();

  print('Step 3: Book late fee for $daysLate days = ${book.lateFee(daysLate)}');
  print('Step 3: Magazine late fee for $daysLate days = ${magazine.lateFee(daysLate)}');
  print('Step 3: Dvd late fee for $daysLate days = ${dvd.lateFee(daysLate)}');

  // Think: LibraryItem cannot be instantiated directly because
  // it is an abstract class with an unimplemented lateFee()
  // method. Only concrete subclasses implementing this method
  // can be instantiated.
}

//4.3
void step4() {
  print('--- Step 4 ---');
  Book book = mainBook();
  print('Step 4: available? ${book.isAvailable}');
  book.borrow();
  print('Step 4: after borrow? ${book.isAvailable}');
  book.giveBack();
  print('Step 4: after return? ${book.isAvailable}');

  List<LibraryItem> items = [book, mainMagazine(), mainDvd()];
  for (LibraryItem item in items) {
    print('Step 4: ${item.runtimeType} borrowable? ${item is Borrowable}');
  }

  // Think: extends would inherit existing implementations, but
  // Borrowable only defines a contract. implements lets Book
  // provide its own borrowing and returning behaviour.
}

//5.3
void step5() {
  print('--- Step 5 ---');
  Book book = mainBook();
  int ok = 0;

  for (int attempt = 0; attempt < renewAttempts; attempt++) {
    if (book.renew(renewLimit)) {
      ok++;
    }
  }

  print('Step 5: renewed $ok of $renewAttempts attempts (limit $renewLimit)');
  print('Step 5: renew once more? ${book.renew(renewLimit)}');
  print('Step 5: dvd can renew too? ${mainDvd().renew(1)}');

  // Think: A mixin shares renewal code only with Book and Dvd.
  // Putting renew() in LibraryItem would also give it to Magazine,
  // which must not be renewable.
}

//6.2
void step6() {
  print('--- Step 6 ---');
  MemberType type = MemberType.values[seed % 3];
  int fee = mainBook().lateFee(daysLate);

  print('Step 6: member type = ${type.name} (index ${type.index})');
  print('Step 6: max loans = ${type.maxLoans}');
  print('Step 6: book fee $fee -> ${type.applyDiscount(fee)} after discount');

  // Think: MemberType.student is checked by Dart and can only be
  // one of the defined enum values. A string may contain a typo.
}

//7.2
void step7() {
  print('--- Step 7 ---');
  MemberType type = MemberType.values[seed % 3];
  int fee = mainBook().lateFee(daysLate);
  int discountedFee = type.applyDiscount(fee);
  List<LibraryItem> shelf = [mainBook(), mainMagazine(), mainDvd()];

  print('Step 7: ${discountedFee.rs}');
  print('Step 7: initials of "${titles[u]}" = ${titles[u].initials}');
  print('Step 7: shelf fee for $daysLate days = ${shelf.totalLateFee(daysLate).rs}');

  // Think: An extension provides natural dot notation, like 72.rs,
  // without changing the int class or calling a separate function.
}

//8.2
void step8() {
  print('--- Step 8 ---');
  Fine f1 = Fine(mainBook().lateFee(daysLate));
  Fine f2 = Fine(mainMagazine().lateFee(daysLate));
  Set<Fine> fineSet = {f1, Fine(f1.amount), f2};

  print('Step 8: $f1 + $f2 = ${f1 + f2}');
  print('Step 8: first bigger? ${f1 > f2}');
  print('Step 8: equal copies? ${f1 == Fine(f1.amount)}');
  print('Step 8: set size = ${fineSet.length}');

  // Think: Without a matching hashCode, equal Fine objects might
  // have different hashes, so a Set may keep duplicate values.
  // Equal objects must produce equal hash codes.
}

//9.3
void step9() {
  print('--- Step 9 ---');
  LibraryItem.created = 0;
  buildShelf();
  List<LibraryItem> shelf = buildShelf();

  print('Step 9: items created = ${LibraryItem.created}');
  print('Step 9: capped fee = ${LibraryItem.capFee(shelf.first.lateFee(daysBig))} (cap $feeCap)');
  print('Step 9: const copies identical? ${identical(const Fine(10), const Fine(10))}');
  print('Step 9: new copies identical? ${identical(Fine(10), Fine(10))}');

  // Think: created is static, so it belongs to LibraryItem itself,
  // not to a particular object. It can be accessed by class name.
}

//10.2
void step10() {
  print('--- Step 10 ---');
  List<LibraryItem> shelf = buildShelf();
  Member member = Member('S$seed', MemberType.values[seed % 3]);
  Fine total = shelf.fold<Fine>(
    Fine(0),
    (sum, item) => sum + member.feeFor(item, daysLate),
  );

  int borrowableCount = shelf.where((item) => item is Borrowable).length;
  int renewableCount = shelf.where((item) => item is Renewable).length;

  print('Step 10: ${shelf.length} items, $borrowableCount borrowable, $renewableCount renewable');
  print('Step 10: ${member.name} (${member.type.name}) owes $total');
  print('Step 10: over the cap? ${total > Fine(feeCap)}');
}
