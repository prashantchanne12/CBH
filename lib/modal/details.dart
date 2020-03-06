import 'package:intl/intl.dart';

class Details {
  final String name;
  final String uid;
  final String profilepic;
  final String email;
  final String interest;
  final String selectedStream;
  final String lastClass;
  var date;
  Details(
      {this.name,
      this.email,
      this.profilepic,
      this.uid,
      this.date,
      this.interest,
      this.lastClass,
      this.selectedStream});
}
