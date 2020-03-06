class User {
  final String uid;
  User({this.uid});
}

class UserName {
  final String uid;
  final String name;
  final String email;
  final String lastClass;
  final String lastStream;
  final String interest;
  final String profilepic;
  var date;
  UserName(
      {this.uid,
      this.name,
      this.email,
      this.profilepic,
      this.date,
      this.lastStream,
      this.lastClass,
      this.interest});
}
