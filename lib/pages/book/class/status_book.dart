import '../../../model/schedule.dart';

enum StatusBook {
  book,
  notify,
  notified,
  booked,
  completed,
  cancelled,
  unavailable
}

StatusBook getStatusBook(String statusBook) {
  Map<String, StatusBook> stats = {
    'available': StatusBook.book,
    'fully booked': StatusBook.notify,
    'unavailable': StatusBook.unavailable,
    'booked': StatusBook.booked,
    'waiting': StatusBook.notified
  };
  String key = statusBook.toLowerCase();
  if (stats.containsKey(key)) {
    return stats[key] ?? StatusBook.book;
  }
  return StatusBook.book;
}

StatusBook changeStatusBook(StatusBook statusBook) {
  if (statusBook == StatusBook.book) {
    return StatusBook.booked;
  }
  return StatusBook.book;
}

String? getNotify(Schedule schedule) {
  if (schedule.status?.toLowerCase() == 'fully booked' &&
      schedule.notifyMe != null) {
    return 'waiting';
  }
  return null;
}
