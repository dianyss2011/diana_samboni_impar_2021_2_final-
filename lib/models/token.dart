import 'package:examenfinal/models/document_type.dart';
import 'package:examenfinal/models/parameters.dart';
import 'package:examenfinal/models/user.dart';

class Token {
  String token = '';
  String expiration = '';
  User user = User(
    firstName: '',
    lastName: '',
    documentType: DocumentType(id: 0, description: ''),
    document: '',
    address: '',
    imageId: '',
    imageFullPath: '',
    userType: 0,
    loginType: 0,
    fullName: '',
    id: '',
    userName: '',
    email: '',
    countryCode: '57',
    phoneNumber: '',
  );
  Parameters parameters = Parameters(phoneNumber: '');

  Token({required this.token, required this.expiration, required this.user, required this.parameters});

  Token.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    expiration = json['expiration'];
    user = User.fromJson(json['user']);
    parameters = Parameters.fromJson(json['parameters']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    data['expiration'] = this.expiration;
    data['user'] = this.user.toJson();
    data['parameters'] = this.parameters.toJson();
    return data;
  }
}