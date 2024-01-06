import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sn_progress_dialog/sn_progress_dialog.dart';

import '../model/user.dart';
import 'login.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({Key? key}) : super(key: key);

  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  bool showPassword = false;
  bool showConfirmPassword = false;

  var accountController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  void _showErrorDialog(String errorMessage) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("アカウントの作成に失敗しました"),
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
                controller: accountController,
                decoration: InputDecoration(labelText: "アカウント名"),
                validator: (value) {
                  // メールアドレスが入力されていない場合
                  if (value == null || value.isEmpty) {
                    // 問題があるときはメッセージを返す
                    return 'アカウント名を入力して下さい';
                  }
                  // 問題ないときはnullを返す
                  return null;
                },
              ),
              SizedBox(height: 40),
              TextFormField(
                controller: emailController,
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
                  // 問題ないときはnullを返す
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
              SizedBox(height: 40),
              TextFormField(
                obscureText: !showConfirmPassword,
                controller: confirmPasswordController,
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  // メールアドレスが入力されていない場合
                  if (value == null || value.isEmpty) {
                    return 'パスワードを入力して下さい';
                  } else if (value != passwordController.text) {
                    return 'パスワードが一致しません';
                  }
                  // 問題ないときはnullを返す
                  return null;
                },
                decoration: InputDecoration(
                    labelText: "パスワード(確認用)",
                    suffixIcon: IconButton(
                      icon: Icon(showConfirmPassword
                          ? FontAwesomeIcons.solidEye
                          : FontAwesomeIcons.solidEyeSlash),
                      onPressed: () {
                        this.setState(() {
                          showConfirmPassword = !showConfirmPassword;
                        });
                      },
                    )),
              ),
              SizedBox(height: 40),
              ElevatedButton(
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      try {
                        //プログレスバー表示
                        pd.show(
                            msg: 'アカウントを作成中...',
                            progressType: ProgressType.normal,);

                        // メール/パスワードでユーザー登録
                        final FirebaseAuth auth = FirebaseAuth.instance;
                        var result = await auth.createUserWithEmailAndPassword(
                          email: emailController.text,
                          password: passwordController.text,
                        );
                        // ユーザー登録に成功した場合
                        //ユーザー情報を保存
                        final firestoreInstance = FirebaseFirestore.instance;
                        CollectionReference users =
                            firestoreInstance.collection("users");

                        try {
                          await users.doc(result.user!.uid).set({
                            "name": accountController.text,
                            "userId": result.user!.uid,
                            "createdTime": Timestamp.now(),
                            "updatedTime": Timestamp.now()
                          });

                          pd.close();

                          Navigator.of(context).pop();
                        } catch (e) {
                          pd.close();
                          _showErrorDialog(e.toString());
                          print(e.toString());
                        }
                      } catch (e) {
                        // ユーザー登録に失敗した場合
                        pd.close();
                        _showErrorDialog(e.toString());
                        print(e.toString());
                      }
                    }
                  },
                  child: Text("アカウント作成")),
              // Add your counter-related widgets here
            ],
          ),
        ),
      ),
    ));
  }
}

