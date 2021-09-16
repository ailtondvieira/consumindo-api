import 'dart:convert';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LoginRepository loginRepository = LoginRepository();
    TextEditingController userController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ClipPath(
                clipper: WaveClipperOne(),
                child: Container(
                  height: 150,
                  color: Colors.deepPurple,
                ),
              ),
              Container(
                padding: EdgeInsets.all(25),
                child: Form(
                  child: Column(
                    children: [
                      TextFormField(
                        controller: userController,
                        decoration: InputDecoration(
                          hintText: 'Coloque seu login',
                        ),
                      ),
                      const SizedBox(height: 25),
                      TextFormField(
                        controller: passwordController,
                        decoration: InputDecoration(hintText: 'Coloque sua senha'),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        width: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.purple[50],
                        ),
                        child: MaterialButton(
                          onPressed: () async {
                            if (passwordController.text.isEmpty || userController.text.isEmpty) {
                              Get.rawSnackbar(message: 'Você precisa preencher os campos');
                            } else {
                              var response = await loginRepository.login(userController.text, passwordController.text);
                              print(response.toJson());
                              if (response.status != "ok") {
                                Get.rawSnackbar(message: 'Usuário ou senha estão incorretos');
                              } else {
                                Get.rawSnackbar(message: 'Obaaaa, logou');
                              }
                              passwordController.clear();
                              userController.clear();
                            }
                          },
                          child: Text('Logar'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: ClipPath(
                  clipper: WaveClipperOne(reverse: true),
                  child: Container(
                    height: 150,
                    color: Colors.deepPurple,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LoginRepository {
  Future<LoginModel> login(String username, String password) async {
    var headers = {"Content-type": "application/json"};

    var body = {
      "usuario": username,
      "senha": password,
    };
    
    var response = await http.post(
      Uri.parse('http://servicosflex.rpinfo.com.br:9000/v1.1/auth'),
      headers: headers,
      body: json.encode(body),
    );
    return LoginModel.fromMap(json.decode(response.body)['response']);
  }
}

class LoginModel {

  String? status;
  String? token;
  String? tokenExpiration;

  LoginModel({
    this.status,
    this.token,
    this.tokenExpiration,
  });

  Map<String, dynamic> toMap() {
    return {
      'status': status,
      'token': token,
      'tokenExpiration': tokenExpiration,
    };
  }

  factory LoginModel.fromMap(Map<String, dynamic> map) {
    return LoginModel(
      status: map['status'],
      token: map['token'],
      tokenExpiration: map['tokenExpiration'],
    );
  }

  String toJson() => json.encode(toMap());

  factory LoginModel.fromJson(String source) => LoginModel.fromMap(json.decode(source));
}
