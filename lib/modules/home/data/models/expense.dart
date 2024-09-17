
class Expense {
  int id;
  double summa;
  DateTime dateTime;
  String description;
  String category;


  Expense({
    required this.id,
    required this.dateTime,
    required this.summa,
    required this.category,
    required this.description,
  });

  factory Expense.fromMap(Map<String, Object?> map) {
    return Expense(
      id: map["id"] as int,
      dateTime: DateTime.parse(map["dateTime"] as String),
      summa: map["summa"] as double,
      category: map["category"] as String,
      description: map["description"] as String,
    );
  }
}
