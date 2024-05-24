class Book {
  String? bid;
  String bookNo;
  String title;
  String authors;
  int pages;
  double cost;
  int publisherYear;
  int printedYear;
  int purchasedYear;
  String isvnCode;
  final int? quantity;
  final bool? isAvailable;

  Book({
    this.bid,
    required this.bookNo,
    required this.title,
    required this.authors,
    required this.pages,
    required this.cost,
    required this.publisherYear,
    required this.printedYear,
    required this.purchasedYear,
    required this.isvnCode,
    this.isAvailable,
    this.quantity,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      bid: json['bid'],
      bookNo: json['bookNo'] ?? '',
      title: json['title'] ?? '',
      authors: json['authors'] ?? '',
      pages: json['pages'] ?? 0,
      cost: (json['cost'] ?? 0).toDouble(),
      publisherYear: json['publisherYear'] ?? 0,
      printedYear: json['printedYear'] ?? 0,
      purchasedYear: json['purchasedYear'] ?? 0,
      isvnCode: json['isvnCode'] ?? '',
      isAvailable: json['isAvailable'],
      quantity: json['quantity'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'bid': bid,
      'bookNo': bookNo,
      'title': title,
      'authors': authors,
      'pages': pages,
      'cost': cost,
      'publisherYear': publisherYear,
      'printedYear': printedYear,
      'purchasedYear': purchasedYear,
      'isvnCode': isvnCode,
      'isAvailable':isAvailable,
      'quantity':quantity,
    };
  }
}
