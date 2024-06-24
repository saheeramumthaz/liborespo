class BookIssue {
  final String bookNo;
  final String title;
  final String authors;
  final String issueDate;
  final String returnDate;
  final String issuerName;
  String? issuedTo; // 'Student' or 'Teacher'
  String? issuerId;

  BookIssue({
    required this.bookNo,
    required this.title,
    required this.authors,
    required this.issueDate,
    required this.returnDate,
    required this.issuerName,
    this.issuedTo,
    this.issuerId,
  });

  Map<String, dynamic> toMap() {
    return {
      'bookNo': bookNo,
      'title': title,
      'authors': authors,
      'issueDate': issueDate,
      'returnDate': returnDate,
      'issuerName': issuerName,
      'issuedTo': issuedTo,
      'issuerId': issuerId,
    };
  }
}
