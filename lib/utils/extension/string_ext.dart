extension StringExt on String {
  bool parseBool() {
    return toLowerCase() == 'true';
  }

  String get extractLocalTime {
    try {
      DateTime dateTime = DateTime.parse(this);
      DateTime localDateTime = dateTime;
      // DateTime localDateTime = dateTime.toLocal();
      String localTime =
          '${_formatTwoDigits(localDateTime.hour)}:${_formatTwoDigits(localDateTime.minute)}';

      return localTime;
    } catch (e) {
      return '';
    }
  }

  String _formatTwoDigits(int n) {
    return n.toString().padLeft(2, '0');
  }
}
