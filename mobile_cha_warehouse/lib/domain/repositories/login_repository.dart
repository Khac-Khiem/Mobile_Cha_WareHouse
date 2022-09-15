import 'package:mobile_cha_warehouse/domain/entities/token.dart';

abstract class LoginRepository {
  Future<String> loginRequest(String userName, String password);
}
