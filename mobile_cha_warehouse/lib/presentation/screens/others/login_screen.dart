import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_cha_warehouse/constant.dart';
import 'package:mobile_cha_warehouse/function.dart';
import 'package:mobile_cha_warehouse/presentation/bloc/blocs/login_bloc.dart';
import 'package:mobile_cha_warehouse/presentation/bloc/events/login_event.dart';
import 'package:mobile_cha_warehouse/presentation/bloc/states/login_state.dart';
import 'package:mobile_cha_warehouse/presentation/widget/main_app_name.dart';
import 'package:mobile_cha_warehouse/presentation/widget/widget.dart';

class LoginScreen extends StatelessWidget {
  // String text = "a";
  TextEditingController userController = TextEditingController();
  TextEditingController passController = TextEditingController();
 bool _showPass = true;
   bool _isUsernameErr = false;
   bool _isPasswordErr = false;
  //var responseUrl;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 60 * SizeConfig.ratioHeight,
          backgroundColor: Constants.mainColor,
          title: Text(
            'Đăng nhập',
            style: TextStyle(fontSize: 22 * SizeConfig.ratioFont),
          ),
          leading: IconButton(
            icon: Icon(Icons.west_outlined),
            iconSize: 25 * SizeConfig.ratioRadius,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          actions: [
            Builder(
              builder: (context) => IconButton(
                icon: const Icon(Icons.menu),
                iconSize: 25 * SizeConfig.ratioRadius,
                onPressed: () => Scaffold.of(context).openEndDrawer(),
              ),
            ),
          ],
        ),
        endDrawer: DrawerUser(),
        body: BlocConsumer<LoginBloc, LoginState>(listener: (context, state) {
        
        if (state is LoginStateToggleShow) {
            _showPass = !_showPass;
          }
        }, builder: (context, state) {
          // if (state is LoginStateLoadingRequest) {
          //   return WebView(
          //     javascriptMode: JavascriptMode.unrestricted,
          //     initialUrl: state.author,
          //     navigationDelegate: (navReq) {
          //       if (navReq.url.startsWith(Uri.parse(
          //               'https://authenticationserver20220822101419.azurewebsites.net/account/login?code')
          //           .toString())) {
          //         // responseUrl = Uri.parse(navReq.url);
          //         responseUrl = Uri.parse('https://authenticationserver20220822101419.azurewebsites.net/account/login?code=A2657C78203076154608F2D0DB55C8B2EE0ABA03E7910A6774CCC92B7589173C-1&scope=openid%20native-client-scope%20profile&state=mL1wXCILxzO5PEv2gg1mQg&session_state=40GwnHoaY9qITIsS7G0mdrlZ0Lz7wf7qvxAvgr6SccA.7C79390A8DFE3A612C89AAE8CC84AE52&iss=https%3A%2F%2Fauthenticationserver20220822101419.azurewebsites.net');

          //         BlocProvider.of<LoginBloc>(context)
          //             .add(LoginEventFetchToken(responseUrl, DateTime.now()));

          //         return NavigationDecision.prevent;
          //       } else {
          //         // BlocProvider.of<LoginBloc>(context)
          //         //     .add(LoginEventFetchToken(responseUrl, DateTime.now()));
          //       }
          //       return NavigationDecision.navigate;
          //     },
          //   );
          // } else {
          return SingleChildScrollView(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                SizedBox(
                  height: 40 * SizeConfig.ratioHeight,
                ),
                MainAppName(),

                SizedBox(
                  width: 300 * SizeConfig.ratioWidth,
                  child: TextField(
                    controller: userController,
                    maxLength: 20,
                    style: TextStyle(
                        fontSize: 25 * SizeConfig.ratioFont,
                        color: Colors.black),
                    decoration: InputDecoration(
                        labelText: "Tên đăng nhập",
                        labelStyle: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 20 * SizeConfig.ratioFont,
                        ),
                        errorText: _isUsernameErr
                            ? "Tên đăng nhập phải dài hơn " +
                                "${Constants.minLengthUserName} ký tự"
                            : null,
                        errorStyle: TextStyle(
                            color: Colors.red,
                            fontSize: 15 * SizeConfig.ratioFont)),
                    onChanged: (text) {
                      //print("Tên đăng nhập là: ${userController.text} ");
                      //Yêu cầu Bloc check dữ liệu username và password
                      BlocProvider.of<LoginBloc>(context).add(
                          LoginEventChecking(
                              userController.text, passController.text));
                    },
                  ),
                ),
                SizedBox(height: 5 * SizeConfig.ratioHeight),
                SizedBox(
                  width: 300 * SizeConfig.ratioWidth,
                  child: Stack(
                      alignment: AlignmentDirectional.centerEnd,
                      children: [
                        TextField(
                          obscureText: _showPass,
                          controller: passController,
                          maxLength: 20,
                          style: TextStyle(
                              fontSize: 25 * SizeConfig.ratioFont,
                              color: Colors.black),
                          decoration: InputDecoration(
                              fillColor: Colors.red,
                              labelText: "Mật khẩu",
                              labelStyle: TextStyle(
                                color: Colors.grey[700],
                                fontSize: 20 * SizeConfig.ratioFont,
                              ),
                              errorText: _isPasswordErr
                                  ? "Mật khẩu phải dài hơn " +
                                      "${Constants.minLengthPassWord} ký tự"
                                  : null,
                              errorStyle: TextStyle(
                                  color: Colors.red,
                                  fontSize: 15 * SizeConfig.ratioFont)),
                          onChanged: (_) {
                            //Yêu cầu Bloc check dữ liệu username và password
                            BlocProvider.of<LoginBloc>(context).add(
                                LoginEventChecking(
                                    userController.text, passController.text));
                          },
                        ),
                        IconButton(
                            onPressed: () {
                              BlocProvider.of<LoginBloc>(context)
                                  .add(LoginEventToggleShow(_showPass));
                            },
                            icon: Icon(
                              _showPass
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Constants.mainColor,
                            ))
                      ]),
                ),
                SizedBox(
                  height: 40 * SizeConfig.ratioHeight,
                ),
                CustomizedButton(
                  text: "Đăng nhập",
                  onPressed: () async {
                    BlocProvider.of<LoginBloc>(context).add(
                        LoginEventFetchToken(userController.text,
                            passController.text, DateTime.now()));
                    Navigator.pushNamed(context, '///');
                  },
                )
                // onPressed: (userController.text == "" ||
                //         passController.text == "" ||
                //         _isPasswordErr ||
                //         _isUsernameErr)
                //     ? null
                //     : () async {
                //Code này cho bản full
                // BlocProvider.of<LoginBloc>(context).add(
                //     LoginEventLoginClicked(
                //         username: userController.text,
                //         password: passController.text,
                //         timestamp: DateTime.now()));
                // //Code này cho bản test
              ]));
        }));
  }
}
