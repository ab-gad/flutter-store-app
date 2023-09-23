import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_store_app/app/extensions.dart';
import 'package:flutter_store_app/data/responses/login_response.dart';
import 'package:flutter_store_app/domain/enums/response_status_enum.dart';
import 'package:flutter_store_app/domain/models/login_models.dart';

import '../../generated/locale_keys.g.dart';

extension ContactResponseMapper on ContactsResponse? {
  ContactsModel toDomain() {
    return ContactsModel(
      email: this?.email ?? LocaleKeys.emptyString.tr(),
      password: this?.password ?? LocaleKeys.emptyString.tr(),
      link: this?.link ?? LocaleKeys.emptyString.tr(),
    );
  }
}

extension CustomerResponseMapper on CustomerResponse? {
  CustomerModel toDomain() {
    return CustomerModel(
      id: this?.id ?? LocaleKeys.emptyString.tr(),
      name: this?.name ?? LocaleKeys.emptyString.tr(),
      numberOfNotifications: this?.numberOfNotifications ?? 0,
    );
  }
}

extension LoginResponseMapper on LoginResponse {
  LoginResponseModel toDomain() {
    ResponseStatusEnum status = this.status.orZero() == 1
        ? ResponseStatusEnum.failure
        : ResponseStatusEnum.success;
    return LoginResponseModel(
      status: status,
      message: message.orEmpty(),
      customer: customer.toDomain(),
      contacts: contacts.toDomain(),
    );
  }
}
