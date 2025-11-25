class Customer {
  String firstName = "";
  String lastName = "";
  String? gender = "Male";
  String address = "";
  DateTime? dateOfBirth;
  double gross = 0.0;
  bool isEmployed = false;
  bool isProfessional = false;

  Customer({required firstName, required lastName});

  String fullName() {
    return lastName + ", " + firstName;
  }

  Map<String, dynamic> toMap() {
    return {
      "firstName": firstName
    };
  }
}