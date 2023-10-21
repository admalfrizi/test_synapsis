import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_synapsis/data/models/request/LoginRequest.dart';
import 'package:test_synapsis/presentation/home/ListSurveyScreen.dart';
import 'package:test_synapsis/presentation/widget_common/custom_btn.dart';
import 'package:test_synapsis/presentation/widget_common/edit_text.dart';
import 'package:http/http.dart' as http;
import '../../data/models/response/LoginResponse.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  bool isChecked = false;
  bool isLoggedIn = false;
  final TextEditingController _emailValue = TextEditingController();
  final TextEditingController _passwordValue = TextEditingController();
  final Future<SharedPreferences> _dataStore = SharedPreferences.getInstance();

  @override
  void initState() {
    super.initState();
    Future<String> _token;
    _token = _dataStore.then((SharedPreferences pref) {
      return pref.getString("token") ?? "";
    });

    tokenValidator(_token);
  }

  tokenValidator(token) async {
    String tokenData = await token;
    if(tokenData != ""){
      Future.delayed(Duration(seconds: 1), () async {
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (c)=> const ListSurveyScreen()))
            .then((value) {
          setState(() {
            isLoggedIn = !isLoggedIn;
          });
        });
      });
    }

    setState(() {
      isLoggedIn = isLoggedIn;
    });
  }

  validateData(){
    if(_emailValue.text.isEmpty && _passwordValue.text.isEmpty){
      final snackBar = SnackBar(
        content: const Text('Maaf Harus Mengisi Kedua Data Diatas !'),
        backgroundColor: (Colors.black),
        action: SnackBarAction(
          label: 'abaikan',
          onPressed: () {
            ScaffoldMessenger.of(context).removeCurrentSnackBar();
          },
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      loginUser();
    }
  }

  Future<LoginResponse> loginUser() async {
    try {
      var loginRequest = LoginRequest(email: _emailValue.text.trim(), password: _passwordValue.text.trim());
      var dataReq = loginRequest.toJson();

      String baseUrl = "https://panel-demo.obsight.com/";
      final response = await http.post(
        Uri.parse(baseUrl + "api/" + "login"),
        body: dataReq
      );

      final results = json.decode(response.body);
      String? token = response.headers['set-cookie'];

      final userData = LoginResponse(
          code: results["code"],
          status: results["status"],
          message: results["message"],
          data: Data(
              occupationLevel: results["data"]["occupation_level"],
              occupationName: results["data"]["occupation_name"]
          )
      );

      final authToken = token?.replaceRange(0, 6, "");
      final removeData = authToken?.replaceAll(";", "").replaceAll("expires", "").replaceAll("=", "").replaceAll("Sat", "");
      final removeLastChar = removeData?.replaceAll("GMT", "").replaceAll(",", "").replaceAll("path/", "");
      final tokenize = removeLastChar?.substring(0, removeLastChar.length - 48);

      Navigator.pushReplacement(context, MaterialPageRoute(builder: (c)=> const ListSurveyScreen()));

      setState(() {
        isLoggedIn = !isLoggedIn;
      });

      if(isChecked){
        saveUserData(tokenize!);
      }

      print("authToken : $tokenize");
      print(response.headers);

      return userData;
    } catch(e){
      rethrow;
    }
  }

  saveUserData(String tokenize) async {
    try {
      final SharedPreferences prefData = await _dataStore;
      prefData.setString("token", tokenize);
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (c)=> const ListSurveyScreen()))
          .then((value) {
        setState(() {

        });
      });
      print("data : ${prefData.getString("token")}");
    } catch(exp){
      print(exp.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const SizedBox(
                height: 34,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                child: const Text(
                    "Login to Synapsis",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 21
                  ),
                  textAlign: TextAlign.start,
                ),
              ),
              const SizedBox(
                height: 34,
              ),
              EditText(
                  nameEdtTxt: 'Email',
                  txtEdt: _emailValue,
                  txtType: TextInputType.emailAddress,
                  hintTxt: 'Masukan Email Anda',
              ),
              const SizedBox(
                height: 16,
              ),
              EditText(
                nameEdtTxt: 'Password',
                txtEdt: _passwordValue,
                txtType: TextInputType.visiblePassword,
                hintTxt: 'Masukan Password Anda',
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  Checkbox(
                      side: const BorderSide(
                          color: Color(0xFFD0D7DE)
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(3),
                      ),
                      value: isChecked,
                      onChanged: (value){
                        isChecked = !isChecked;
                        setState(() {
                        });
                      }
                  ),
                  const Text("Remember Me",
                      style: TextStyle(
                          color: Color(0xff646464),
                          fontSize: 12,
                          fontFamily: 'Rubic'
                      )
                  )
                ],
              ),
              const SizedBox(
                height: 48,
              ),
              CustomBtn(
                  nameBtn: 'Log In',
                  btnAction: (){
                    validateData();
                  },
                  btnColor: const Color(0xFF1FA0C9),
                  sizeExtend: Size(MediaQuery.of(context).size.width,43),
              ),
              const SizedBox(
                height: 16,
              ),
              const Text(
                "or",
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              CustomBtn(
                  nameBtn: 'Fingerprint',
                  btnAction: () {},
                  btnColor: Colors.white,
                  txtColor: const Color(0xFF1FA0C9),
                  borderBtn: const BorderSide(
                    color: Color(0xFF1FA0C9),
                  ),
                sizeExtend: Size(MediaQuery.of(context).size.width,43),
              )
            ],
          ),
        ),
      ),
    );
  }
}
