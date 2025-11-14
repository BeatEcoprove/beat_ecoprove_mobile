class MarkClothAsDailyUseRequest {
  final List<String> clothIds;
  final bool usage;

  MarkClothAsDailyUseRequest({
    required this.clothIds,
    required this.usage,
  });
}
