import 'package:flutter_store_app/app/extensions.dart';
import 'package:flutter_store_app/data/responses/login_response.dart';
import 'package:flutter_store_app/domain/models/login_models.dart';
import 'package:flutter_store_app/resources/string_manager.dart';

extension ContactResponseMapper on ContactsResponse? {
  ContactsModel toDomain() {
    return ContactsModel(
      email: this?.email ?? StringManager.emptyString,
      password: this?.password ?? StringManager.emptyString,
      link: this?.link ?? StringManager.emptyString,
    );
  }
}

extension CustomerResponseMapper on CustomerResponse? {
  CustomerModel toDomain() {
    return CustomerModel(
      id: this?.id ?? StringManager.emptyString,
      name: this?.name ?? StringManager.emptyString,
      numberOfNotifications: this?.numberOfNotifications ?? 0,
    );
  }
}

extension LoginResponseMapper on LoginResponse {
  LoginResponseModel toDomain() {
    return LoginResponseModel(
      status: status.orZero(),
      message: message.orEmpty(),
      customer: customer.toDomain(),
      contacts: contacts.toDomain(),
    );
  }
}
