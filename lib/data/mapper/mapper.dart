import 'package:complete_advanced_project/app/extensions.dart';
import '../../domain/model.dart';
import '../responses/responses.dart';

const empty = '';
const zero = 0;

// to convert the response into a non nullable object (model)
extension CustomerResponseMapper on CustomerResponse?{
  Customer toDomain(){
    return Customer(
        this?.id?.orEmpty() ?? empty,
        this?.name.orEmpty() ?? empty,
        this?.numOfNotification?.orZero() ?? zero,
    );
  }
}

extension ContactsResponseMapper on ContactResponse?{
  Contacts toDomain(){
    return Contacts(
      this?.email?.orEmpty() ?? empty,
      this?.phone.orEmpty() ?? empty,
      this?.link?.orEmpty() ?? empty,
    );
  }
}

extension AuthenticationResponseMapper on AuthenticationResponse? {
  Authentication toDomain(){
    return Authentication(
      this?.customer?.toDomain(),
      this?.contacts?.toDomain()
    );
  }
}