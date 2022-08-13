import 'package:mobile_cha_warehouse/domain/entities/token.dart';

abstract class LoginRepository {
  Future<LoginData> loginRequest(String userName, String password);
}
