import 'base_response_model.dart';

class LoginResponseModel extends BaseResponseModel {
  final CustomerModel? customer;
  final ContactsModel? contacts;

  LoginResponseModel({
    required super.status,
    required super.message,
    required this.customer,
    required this.contacts,
  });
}

class CustomerModel {
  final String id;
  final String name;
  final int numberOfNotifications;

  CustomerModel({
    required this.id,
    required this.name,
    required this.numberOfNotifications,
  });
}

class ContactsModel {
  final String email;
  final String password;
  final String link;

  ContactsModel({
    required this.email,
    required this.password,
    required this.link,
  });
}
