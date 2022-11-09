import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_cha_warehouse/constant.dart';
import 'package:mobile_cha_warehouse/domain/usecases/login_usecase.dart';
import 'package:mobile_cha_warehouse/global.dart';
import 'package:mobile_cha_warehouse/presentation/bloc/events/login_event.dart';
import 'package:mobile_cha_warehouse/presentation/bloc/states/login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginUsecase loginUsecase;
  LoginBloc(this.loginUsecase) : super(LoginStateInitial(false, false, true)) {
    on((LoginEventChecking event, emit) => LoginStateFormatChecking(
        event.passWord.length < Constants.minLengthPassWord,
        event.userName.length < Constants.minLengthUserName));
    // on<LoginEventLoginClicked>(_onLogin);
    on<LoginEventFetchToken>(_onFetch);
    on((LoginRefreshEvent event, emit) =>
        emit(LoginStateInitial(false, false, true)));
    on((LoginEventToggleShow event, emit) =>
        emit(LoginStateToggleShow(!event.isShow)));
  }
  // var authorizationUrl;
  // var grant;
  // var client;
  // var credentials;
  // var credentialsFile;
  // Future _onLogin(LoginEvent event, Emitter<LoginState> emit) async {
  //   if (Platform.isAndroid) WebView.platform = AndroidWebView();
  //   client = await createClient();
  //   emit(LoginStateLoadingRequest(DateTime.now(), authorizationUrl.toString()));
  // }

  // Future createClient() async {
  //   final authorizationEndpoint = Uri.parse(
  //       'https://authenticationserver20220822101419.azurewebsites.net/connect/authorize');
  //   final tokenEndpoint = Uri.parse(
  //       'https://authenticationserver20220822101419.azurewebsites.net/connect/token');

  //   final identifier = 'native-client';

  //   final redirectUrl = Uri.parse(
  //       'https://authenticationserver20220822101419.azurewebsites.net/account/login');

  //   credentialsFile = File('~/.myapp/credentials.json');
  //   var exists = await credentialsFile.exists();

  //   if (exists) {
  //     credentials =
  //         oauth2.Credentials.fromJson(await credentialsFile.readAsString());
  //     return oauth2.Client(
  //       credentials,
  //       identifier: identifier,
  //     );
  //   }

  //   grant = oauth2.AuthorizationCodeGrant(
  //     identifier,
  //     authorizationEndpoint,
  //     tokenEndpoint,
  //   );

  //   authorizationUrl = grant.getAuthorizationUrl(
  //     redirectUrl,
  //     scopes: ["openid native-client-scope profile"],
  //   );
  //   print(authorizationUrl);

  //   // WebView(
  //   //   javascriptMode: JavascriptMode.unrestricted,
  //   //   initialUrl: authorizationUrl.toString(),
  //   //   navigationDelegate: (navReq) {
  //   //     if (navReq.url.startsWith(redirectUrl.toString())) {
  //   //       responseUrl = Uri.parse(navReq.url);

  //   //       return NavigationDecision.prevent;
  //   //     }
  //   //     return NavigationDecision.navigate;
  //   //   },
  //   // );

  //   // while (responseUrl == null) {}

  //   // return await grant.handleAuthorizationResponse(responseUrl.queryParameters);
  // }

  Future<void> _onFetch(LoginEvent event, Emitter<LoginState> emit) async {
    if (event is LoginEventFetchToken) {
      emit(LoginStateLoadingRequest(DateTime.now()));
      try {
        final request =
            await loginUsecase.fetchToken(event.userName, event.password);
        if (request != 'error') {
          employeeIdOverall = event.userName;
          emit(LoginStateLoginSuccessful(DateTime.now()));
        } else {
          emit(LoginStateLoginFailure(DateTime.now()));
        }
      } catch (e) {
        emit(LoginStateLoginFailure(DateTime.now()));
      }
    }
  }
}
