import 'package:mobile_cha_warehouse/datasource/service/login_service.dart';
import 'package:mobile_cha_warehouse/domain/entities/token.dart';
import 'package:mobile_cha_warehouse/domain/repositories/login_repository.dart';

class LoginRepoImpl implements LoginRepository {
  LoginService loginService;
  LoginRepoImpl(this.loginService);
  @override
  Future<String> loginRequest(String userName, String password) {
    // TODO: implement loginRequest
    final token = loginService.login(userName, password);
    return token;
  }
}
