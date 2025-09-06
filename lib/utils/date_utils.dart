Map<String, String> formatDateTime(String? isoString) {
  if (isoString == null || isoString.isEmpty) return {};
  final dt = DateTime.tryParse(isoString);
  if (dt == null) return {};
  final date = '${dt.day.toString().padLeft(2, '0')}/${dt.month.toString().padLeft(2, '0')}/${dt.year}';
  final hour = dt.hour;
  final isPm = hour >= 12;
  int hour12 = hour % 12;
  if (hour12 == 0) hour12 = 12;
  final minute = dt.minute.toString().padLeft(2, '0');
  final period = isPm ? 'PM' : 'AM';
  final time = '$hour12:$minute $period';
  return {'date': date, 'time': time};
}
