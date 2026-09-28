// Week3.dart - Library Desk Assistant
// Name: ASAD JAHANGIRR
// Roll no: 036

final List<Map<String, dynamic>> books = [
  {
    'title': 'Dart in Action',
    'author': 'Ada',
    'year': 2021,
    'copies': 3,
    'tags': ['dart', 'programming']
  },
  {
    'title': 'Flutter Basics',
    'author': 'Sam',
    'year': 2023,
    'copies': 0,
    'tags': ['flutter', 'mobile']
  },
  {
    'title': 'Clean Code',
    'author': 'Martin',
    'year': 2008,
    'copies': 2,
    'tags': ['programming', 'design']
  },
  {
    'title': 'Algorithms',
    'author': 'Knuth',
    'year': 1968,
    'copies': 1,
    'tags': ['programming', 'math']
  },
  {
    'title': 'UI Design',
    'author': 'Nora',
    'year': 2019,
    'copies': 4,
    'tags': ['design', 'mobile']
  },
];

//part1.1
double lateFee(int daysLate, double ratePerDay) =>
    daysLate * ratePerDay;

//part1.2
String formatTitle(String title, [String? author]) {
  if (author == null) {
    return title;
  }
  return '$title by $author';
}

//part1.3
Map<String, dynamic> makeBook({
  required String title,
  required String author,
  int year = 2024,
  int copies = 1,
}) {
  return {
    'title': title,
    'author': author,
    'year': year,
    'copies': copies,
  };
}

//part1.4
bool isClassic(int year) =>
    year < 2000;

//part2.1
List<String> transformAll(
    List<String> items, String Function(String) fn) {
  return items.map(fn).toList();
}

//part2.2
int Function() makeCounter() {
  int count = 0;

  return () {
    count++;
    return count;
  };
}

//part2.3
double Function(int) makeFeeCalculator(double rate) {
  return (int days) {
    return days * rate;
  };
}

//part2.4
int sumDigits(int n) {
  if (n < 10) {
    return n;
  }

  return n % 10 + sumDigits(n ~/ 10);
}

//part3.4
Map<String, int> buildStock() {
  return {
    for (var book in books)
      book['title'] as String: book['copies'] as int
  };
}

//part4.1
class Box<T> {
  T value;

  Box(this.value);
}

//part4.2
T firstOr<T>(List<T> items, T fallback) {
  if (items.isEmpty) {
    return fallback;
  }

  return items.first;
}

//part4.3
class Pair<A, B> {
  A first;
  B second;

  Pair(this.first, this.second);

  @override
  String toString() {
    return '($first, $second)';
  }
}

//part5.1
class BookNotFoundException implements Exception {
  final String title;

  BookNotFoundException(this.title);
}

class BookNotAvailableException implements Exception {
  final String title;

  BookNotAvailableException(this.title);
}

//part5.2
void checkOut(Map<String, int> stock, String title) {
  if (!stock.containsKey(title)) {
    throw BookNotFoundException(title);
  }

  if (stock[title]! <= 0) {
    throw BookNotAvailableException(title);
  }

  stock[title] = stock[title]! - 1;
}

//part5.4
Map<String, dynamic> findBook(String title) {
  return books.firstWhere(
    (book) => book['title'] == title,
  );
}

//part6.1
Future<String> fetchBookOfTheDay() async {
  await Future.delayed(Duration(seconds: 1));

  return 'Dart in Action';
}

//part6.3
Future<String> fetchBroken() async {
  await Future.delayed(Duration(milliseconds: 500));

  throw Exception('Server down');
}
//bonus b1
Map<String, List<String>> groupByTag() {
  Map<String, List<String>> groups = {};

  for (var book in books) {
    var tags = book['tags'] as List<String>;

    for (var tag in tags) {
      if (!groups.containsKey(tag)) {
        groups[tag] = [];
      }
    }
  }

  return groups;
}
void main() async {
  part1();
  part2();
  part3();
  part4();
  part5();
  await part6();
}

void part1() {
  print('--- Part 1 ---');

  //part1.1
  print('Late fee: ${lateFee(5, 0.5)}');

  //part1.2
  print(formatTitle('Dart in Action'));
  print(formatTitle('Dart in Action', 'Ada'));

  //part1.3
  print(makeBook(
    title: 'Clean Code',
    author: 'Martin',
  ));

  print(makeBook(
    title: 'Algorithms',
    author: 'Knuth',
    year: 1968,
  ));

  //part1.4
  print(isClassic(1968));
  print(isClassic(2021));
}

void part2() {
  print('--- Part 2 ---');

  //part2.1
  var titles = [
    'Dart in Action',
    'Clean Code'
  ];

  print(transformAll(
    titles,
    (String title) {
      return title.toUpperCase();
    },
  ));

  print(transformAll(
    titles,
    (title) => '$title!',
  ));

  //part2.2
  var desk1 = makeCounter();
  var desk2 = makeCounter();

  print(desk1());
  print(desk1());
  print(desk1());
  print(desk2());

  //part2.3
  var studentFee = makeFeeCalculator(0.25);
  var staffFee = makeFeeCalculator(0.10);

  print('Student fee: ${studentFee(4)}');
  print('Staff fee: ${staffFee(4)}');

  //part2.4
  print('Sum of digits: ${sumDigits(503)}');
}

void part3() {
  print('--- Part 3 ---');

  //part3.1
  var titles = books
      .map((book) => book['title'] as String)
      .toList();

  print('Titles: $titles');

  var available = books
      .where((book) => (book['copies'] as int) > 0)
      .map((book) => book['title'] as String)
      .toList();

  print('Available: $available');

  //part3.2
  var totalCopies = books.fold<int>(
    0,
    (sum, book) => sum + (book['copies'] as int),
  );

  print('Total copies: $totalCopies');

  var years = books
      .map((book) => book['year'] as int)
      .toList();

  var oldestYear = years.reduce(
    (a, b) => a < b ? a : b,
  );

  print('Oldest year: $oldestYear');

  //part3.3
  var sortedBooks = List.of(books);

  sortedBooks.sort(
    (a, b) => (a['year'] as int)
        .compareTo(b['year'] as int),
  );

  var byYear = sortedBooks
      .map((book) => book['title'] as String)
      .toList();

  print('By year: $byYear');

  //part3.4
  var stock = buildStock();

  print('Stock: $stock');

  stock.forEach((title, copies) {
    if (copies == 0) {
      print('Out of stock: $title');
    }
  });

  print('Copies of Unknown: ${stock['Unknown'] ?? 0}');

  //part3.5
  Set<String> allTags = {
    for (var book in books)
      ...(book['tags'] as List<String>)
  };

  print('All tags: $allTags');

  var a = {
    'Dart in Action',
    'Clean Code',
    'Flutter Basics'
  };

  var b = {
    'Clean Code',
    'Flutter Basics',
    'Algorithms'
  };

  print('Union: ${a.union(b)}');
  print('Common: ${a.intersection(b)}');
  print('Only in A: ${a.difference(b)}');
  //bonus b1
print(groupByTag());
}

void part4() {
  print('--- Part 4 ---');

  //part4.1
  var intBox = Box<int>(5);
  var stringBox = Box<String>('dart');

  print('Box<int>: ${intBox.value}');
  print('Box<String>: ${stringBox.value}');

  //part4.2
  print(firstOr(
    ['Dart in Action', 'Clean Code'],
    'none',
  ));

  print(firstOr<String>(
    [],
    'z',
  ));

  //part4.3
  print(Pair(
    'Dart in Action',
    3,
  ));
}

void part5() {
  print('--- Part 5 ---');

  //part5.3
  var stock = buildStock();

  var titles = [
    'Dart in Action',
    'Flutter Basics',
    'Unknown Book'
  ];

  for (var title in titles) {
    try {
      checkOut(stock, title);

      print('Checked out: $title');
    } on BookNotAvailableException catch (e) {
      print('Sorry: "${e.title}" has no copies left');
    } on BookNotFoundException catch (e) {
      print('Not found: "${e.title}"');
    } finally {
      print('Transaction logged.');
    }
  }

  print(
      'Copies left of Dart in Action: ${stock['Dart in Action']}');

  //part5.4
  try {
    findBook('Missing');
  } on StateError {
    print('Search failed: no such book');
  }
}

Future<void> part6() async {
  print('--- Part 6 ---');

  //part6.1
  print('Fetching...');

  var book = await fetchBookOfTheDay();

  print('Book of the day: $book');

  //part6.3
  try {
    await fetchBroken();
  } catch (e) {
    print('Fetch failed: $e');
  }
} 