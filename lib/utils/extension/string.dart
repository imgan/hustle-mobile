import 'package:intl/intl.dart';

extension StringExt on String {
  String? formatHour() {
    String timeString = this;
    DateTime time = DateFormat('HH:mm:ss').parse(timeString);
    return DateFormat('HH:mm').format(time);
  }

  String removeAllHtmlTags() {
    RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);

    return replaceAll(exp, ',');
  }

  String? formatDate({String? format}) {
    final date = DateTime.parse(this);
    final DateFormat dateFormat = DateFormat(format ?? 'dd MMMM yyyy');
    return dateFormat.format(date);
  }

  String getTimeAgo() {
    DateTime dateTime = DateTime.parse(this);
    DateTime now = DateTime.now();
    Duration difference = now.difference(dateTime);

    if (difference.inSeconds < 60) {
      return 'just now';
    } else if (difference.inMinutes < 60) {
      int minutes = difference.inMinutes;
      return '$minutes minute${minutes > 1 ? 's' : ''} ago';
    } else if (difference.inHours < 24) {
      int hours = difference.inHours;
      return '$hours hour${hours > 1 ? 's' : ''} ago';
    } else if (difference.inDays < 7) {
      int days = difference.inDays;
      return '$days day${days > 1 ? 's' : ''} ago';
    } else if (difference.inDays < 30) {
      int weeks = (difference.inDays / 7).floor();
      if (weeks == 1) {
        return '1 week ago';
      } else {
        return '$weeks weeks ago';
      }
    } else {
      int months = (difference.inDays / 30).floor();
      if (months == 1) {
        return '1 month ago';
      } else {
        return '$months months ago';
      }
    }
  }

  String getDateSchedule() {
    final date = DateTime.parse(this);
    final DateFormat formatter = DateFormat.EEEE();
    final DateFormat dateFormat = DateFormat('dd MMMM yyyy');
    final DateFormat hourFormat = DateFormat('HH:mm');
    return '${formatter.format(date)}, ${dateFormat.format(date)} • ${hourFormat
        .format(date)}';
  }

  String toCapitalized() => length > 0 ?'${this[0].toUpperCase()}${substring(1).toLowerCase()}':'';
  String toTitleCase() => replaceAll(RegExp(' +'), ' ').split(' ').map((str) => str.toCapitalized()).join(' ');
}
