String formatDateTimeMmDd(DateTime dateTime) {
  final local = dateTime.toLocal();
  final mm = local.month.toString().padLeft(2, '0');
  final dd = local.day.toString().padLeft(2, '0');
  final hh = local.hour.toString().padLeft(2, '0');
  final min = local.minute.toString().padLeft(2, '0');
  return '$mm/$dd • $hh:$min';
}
