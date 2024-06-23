class BookIssue {
  String? bid;
  String? bookNo;
  String title;
  String authors;
  String issueDate;
  String returnDate;
  String issuerName;

  BookIssue({
    this.bid,
    required this.bookNo,
    required this.title,
    required this.authors,
    required this.issueDate,
    required this.returnDate,
    required this.issuerName,
  });

  factory BookIssue.fromMap(Map<String, dynamic> map) {
    return BookIssue(
      bid: map['bid'],
      bookNo: map['bookNo'],
      title: map['title'],
      authors: map['authors'],
      issueDate: map['issueDate'],
      returnDate: map['returnDate'],
      issuerName: map['issuerName'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'bid': bid,
      'bookNo': bookNo,
      'title': title,
      'authors': authors,
      'issueDate': issueDate,
      'returnDate': returnDate,
      'issuerName': issuerName,
    };
  }
}

