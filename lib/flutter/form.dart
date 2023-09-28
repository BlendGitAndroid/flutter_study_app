import 'package:flutter/material.dart';

void main() => runApp(LoginPage());

// 表单控件
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //一个GlobalKey代表一个表单对象
  GlobalKey<FormState> _loginKey = GlobalKey<FormState>();
  String? _userName;
  String? _password;

  void _login() {
    var _loginForm = _loginKey.currentState;
    //验证回调,会调用每个表单的validator方法进行验证
    if (_loginForm?.validate() == true) {
      // 保存回调,会调用每个表单的onSaved方法
      _loginForm?.save();
      print('name: $_userName, password: $_password');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, //主轴居中
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                    key: _loginKey,
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          //用于控制TextField的外观显示，如提示文本、背景颜色、边框等
                          decoration: InputDecoration(
                            // 如果验证没有通过,这句话会变成红色
                            labelText: '请输入用户名',
                          ),
                          //保存回调
                          onSaved: (value) {
                            print('onSaved :$value');
                            _userName = value;
                          },
                          // 如果验证不通过,会在输入框下面显示这句话
                          validator: (value) {
                            return (value?.length ?? 0) < 2
                                ? '用户名长度不够2位'
                                : null;
                          },
                          //输入结束,点击软键盘完成的时候触发
                          onFieldSubmitted: (value) {
                            print('onFieldSubmitted : $value');
                          },
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: '请输入密码',
                          ),
                          //隐蔽的文本。主要用于密码输入框
                          obscureText: true,
                          onSaved: (value) {
                            _password = value;
                          },
                          validator: (value) {
                            return (value?.length ?? 0) < 6 ? '密码长度不够6位' : null;
                          },
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 20.0),
                          width: 400.0,
                          height: 40.0,
                          child: ElevatedButton(
                            onPressed: () {
                              _login();
                            },
                            child: Text('登录'),
                          ),
                        ),
                      ],
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
