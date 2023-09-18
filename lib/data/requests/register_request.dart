class RegisterRequest {
  String email;
  String userName;
  String password;
  String mobileNumber;
  String profilePicture;
  String countryMobileCode;

  RegisterRequest({
    this.email = '',
    this.userName = '',
    this.password = '',
    this.mobileNumber = '',
    this.profilePicture = '',
    this.countryMobileCode = '',
  });
}
