class HistoryActionResult {
  final String actionName;
  final DateTime date;

  HistoryActionResult(
    this.actionName,
    this.date,
  );

  factory HistoryActionResult.fromJson(Map<String, dynamic> json) {
    return HistoryActionResult(
      json['actionName'],
      DateTime.parse(json['date']),
    );
  }
}
