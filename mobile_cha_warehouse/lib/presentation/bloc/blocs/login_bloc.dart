import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_cha_warehouse/constant.dart';
import 'package:mobile_cha_warehouse/presentation/bloc/events/login_event.dart';
import 'package:mobile_cha_warehouse/presentation/bloc/states/login_state.dart';
import 'dart:io';
import 'package:oauth2/oauth2.dart' as oauth2;
import 'package:webview_flutter/webview_flutter.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginStateInitial(false, false, true)) {
    on((LoginEventChecking event, emit) => LoginStateFormatChecking(
        event.passWord.length < Constants.minLengthPassWord,
        event.userName.length < Constants.minLengthUserName));
    on<LoginEventLoginClicked>(_onLogin);
    on<LoginEventFetchToken>(_onFetch);

    on((LoginEventToggleShow event, emit) =>
        LoginStateToggleShow(!event.isShow));
  }
  var authorizationUrl;
  var grant;
  Future _onLogin(LoginEvent event, Emitter<LoginState> emit) async {
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
    var client = await createClient();
    emit(LoginStateLoadingRequest(DateTime.now(), authorizationUrl.toString()));
  }

  Future createClient() async {
    final authorizationEndpoint = Uri.parse(
        'https://authenticationserver20220822101419.azurewebsites.net/connect/authorize');
    final tokenEndpoint = Uri.parse(
        'https://authenticationserver20220822101419.azurewebsites.net/connect/token');

    final identifier = 'native-client';

    final redirectUrl = Uri.parse(
        'https://authenticationserver20220822101419.azurewebsites.net/account/login');

    final credentialsFile = File('~/.myapp/credentials.json');
    var exists = await credentialsFile.exists();

    if (exists) {
      var credentials =
          oauth2.Credentials.fromJson(await credentialsFile.readAsString());
      return oauth2.Client(
        credentials,
        identifier: identifier,
      );
    }

     grant = oauth2.AuthorizationCodeGrant(
      identifier,
      authorizationEndpoint,
      tokenEndpoint,
    );

    authorizationUrl = grant.getAuthorizationUrl(
      redirectUrl,
      scopes: ["openid native-client-scope profile"],
    );

    var responseUrl;

    // WebView(
    //   javascriptMode: JavascriptMode.unrestricted,
    //   initialUrl: authorizationUrl.toString(),
    //   navigationDelegate: (navReq) {
    //     if (navReq.url.startsWith(redirectUrl.toString())) {
    //       responseUrl = Uri.parse(navReq.url);

    //       return NavigationDecision.prevent;
    //     }
    //     return NavigationDecision.navigate;
    //   },
    // );

    // while (responseUrl == null) {}

    // return await grant.handleAuthorizationResponse(responseUrl.queryParameters);
  }

  Future _onFetch(LoginEvent event, Emitter<LoginState> emit) async {
    if (event is LoginEventFetchToken) {
      while (event.responseUrl == Uri.parse('')) {}
      await grant.handleAuthorizationResponse(event.responseUrl.queryParameters);

      //  await credentialsFile.writeAsString(client.credentials.toJson());

    }
  }
}
