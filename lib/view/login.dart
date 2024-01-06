import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:kagyo/view/createAccount.dart';
import 'package:kagyo/view/home.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sn_progress_dialog/sn_progress_dialog.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool showPassword = false;

  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  void _showErrorDialog(String errorMessage) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("エラー"),
          content: Text(errorMessage),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("閉じる"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {

    ProgressDialog pd = ProgressDialog(context: context);

    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text("ログイン"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 40),
              TextFormField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(labelText: "メールアドレス"),
                validator: (value) {
                  // メールアドレスが入力されていない場合
                  if (value == null || value.isEmpty) {
                    // 問題があるときはメッセージを返す
                    return 'メールアドレスを入力して下さい';
                  }
                  // 問題ないときはnullを返す
                  return null;
                },
              ),
              SizedBox(height: 40),
              TextFormField(
                obscureText: !showPassword,
                controller: passwordController,
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  // メールアドレスが入力されていない場合
                  if (value == null || value.isEmpty) {
                    // 問題があるときはメッセージを返す
                    return 'パスワードを入力して下さい';
                  }
                  // 問題ないときはnullを返す。
                  return null;
                },
                decoration: InputDecoration(
                    labelText: "パスワード",
                    suffixIcon: IconButton(
                      icon: Icon(showPassword
                          ? FontAwesomeIcons.solidEye
                          : FontAwesomeIcons.solidEyeSlash),
                      onPressed: () {
                        this.setState(() {
                          showPassword = !showPassword;
                        });
                      },
                    )),
              ),
              SizedBox(height: 20),
              RichText(
                text:
                    TextSpan(style: TextStyle(color: Colors.black), children: [
                  TextSpan(text: "アカウントを作成していない方は"),
                  TextSpan(
                    text: "こちら",
                    style: TextStyle(color: Colors.blue),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => CreateAccount(),
                          ),
                        );
                      },
                  ),
                ]),
              ),
              SizedBox(height: 40),
              ElevatedButton(
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      pd.show(
                        msg: 'ログイン中...',
                        progressType: ProgressType.normal,);
                      try {
                        // メール/パスワードでユーザー登録
                        final FirebaseAuth auth = FirebaseAuth.instance;
                        await auth.signInWithEmailAndPassword(
                          email: emailController.text,
                          password: passwordController.text,
                        );
                        pd.close();
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => Home(),
                          ),
                        );
                        // ユーザー登録に成功した場合
                        //ユーザー情報を保存
                      } catch (e) {
                        // ユーザー登録に失敗した場合
                        pd.close();
                        _showErrorDialog(e.toString());
                        print(e.toString());
                      }
                    }
                  },
                  child: Text("ログイン")),
              // Add your counter-related widgets here
            ],
          ),
        ),
      ),
    ));
  }
}
