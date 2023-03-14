class UserModel {
  static const String collectionName="Users";
  String? id;
  String? firstName;
  String? userName;
  String? email;

  UserModel(
      {required this.id,
      required this.firstName,
      required this.userName,
      required this.email});

  UserModel.fromJson(Map<String, dynamic> json)
      : this(
          id: json["id"],
          email: json["email"],
          firstName: json["firstName"],
          userName: json["userName"],
        );

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "email": email,
      "firstName": firstName,
      "userName": userName,
    };
  }
}
