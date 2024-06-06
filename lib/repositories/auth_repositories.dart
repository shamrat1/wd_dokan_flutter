import 'package:dokan/models/login_response.dart';
import 'package:dokan/models/registration_response.dart';
import 'package:dokan/utils/constants/urls.dart';
import 'package:dokan/utils/http/dio_client.dart';
import 'package:dokan/utils/http/http_client.dart';

class AuthRepositories {
  Future<RegistrationResponse> signUp(Map<String, dynamic> data) async {
    final response = await THttpHelper.post(TUrls.registerUrl, data);
    return RegistrationResponse.fromJson(response);
  }

  Future<LoginResponse> login(Map<String, dynamic> data) async {
    final response = await DioClient().postUrlEncoded(
      "${THttpHelper.baseUrl}${TUrls.loginUrl}",
      data,
    );
    if (response.statusCode == 403) {
      throw Exception("Entered credentials not found.");
    }
    return LoginResponse.fromJson(response.data);
  }
}
