extension MapExtension on Map<String, dynamic> {
  Map<String, dynamic> get removeEmptyValue {
    return Map.fromEntries(
        entries.where((entry) => entry.value != null && entry.value != ''));
  }
}
