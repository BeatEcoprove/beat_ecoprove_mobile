enum HistoryActionType implements Comparable<HistoryActionType> {
  dailyUse(value: "DailyUseActivity"),
  maintenance(value: "MaintenanceActivity");

  final String value;

  const HistoryActionType({required this.value});

  static HistoryActionType getOf(String value) =>
      HistoryActionType.values.singleWhere((element) => element.value == value);

  static List<HistoryActionType> getAllTypes() {
    return HistoryActionType.values.toList();
  }

  @override
  toString() => value;

  @override
  int compareTo(HistoryActionType other) {
    throw UnimplementedError();
  }
}
