class CheckOutBook {
  final String credit;
  final String image;
  final String name;
  final String hour;
  final String date;
  final String? trainer;
  final String total;
  final String? location;
  final String? voucher;

  CheckOutBook(
      {required this.credit,
      required this.image,
      required this.name,
      required this.hour,
      required this.date,
      this.trainer,
      required this.total,
      this.location,
      this.voucher});
}
