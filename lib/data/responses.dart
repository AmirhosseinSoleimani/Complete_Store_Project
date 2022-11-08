import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class BaseResponse{
  @JsonKey(name: 'status')
  int? baseResponsesStatus;
  @JsonKey(name: 'message')
  String? message;
}

@JsonSerializable()
class CustomerResponse{
  @JsonKey(name: "id")
  String? id;
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "numOfNotification")
  int? numOfNotification;
}

@JsonSerializable()
class ContactResponse{
  @JsonKey(name: "email")
  String? email;
  @JsonKey(name: "phone")
  String? phone;
  @JsonKey(name: "link")
  String? link;
}

@JsonSerializable()
class AuthenticationResponse extends BaseResponse{
  @JsonKey(name: "customer")
  CustomerResponse? customer;
  @JsonKey(name: "contacts")
  ContactResponse? contacts;
}