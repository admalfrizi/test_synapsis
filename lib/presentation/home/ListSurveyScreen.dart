import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_synapsis/data/models/response/ListSurveyModels.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../details/DetailsSurveyScreen.dart';
import '../login/LoginScreen.dart';

class ListSurveyScreen extends StatefulWidget {
  const ListSurveyScreen({super.key});

  @override
  State<ListSurveyScreen> createState() => _ListSurveyScreenState();
}

class _ListSurveyScreenState extends State<ListSurveyScreen> {
  final Future<SharedPreferences> _dataStore = SharedPreferences.getInstance();

  @override
  void initState() {
    super.initState();
  }

  Future logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('token');
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (c)=> const LoginScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text(
          "Halaman Survey",
          style: TextStyle(
              fontWeight: FontWeight.w500,
              color: Color(0xFF121212),
              fontSize: 17
          ),
          textAlign: TextAlign.start,
        ),
        actions: [
          IconButton(
              onPressed: () {
                logout();
              },
              icon: Icon(
                Icons.logout,
                color: Colors.black,
              )
          )
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: FutureBuilder<List<Data>>(
          future: _getListSurvey(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasData) {
              List<Data> listSurvey = snapshot.data!;
              return _surveyListView(listSurvey);
            } else {
              return const Center(child: Text("No data available"));
            }
          },
        ),
      ),
    );
  }

  Future<List<Data>> _getListSurvey() async {
    try {
      String baseUrl = "https://panel-demo.obsight.com/";
      final SharedPreferences pref = await _dataStore;
      final tokenData = pref.getString('token');

      print("Token $tokenData");

      final response = await http.get(
        Uri.parse("${baseUrl}api/survey"),
        headers: {
          'Authorization' : 'Bearer eyJhbGciOiJIUzI1NiJ9.e30.4knTJA8CR4vZNof4ik7K0BLguM8OkRotaagNhVKem2M',
          "Content-Type": 'application/json',
          'User-Agent': "Dart/3.1.4 (dart.io)",
          "Cookie": "token=$tokenData",
        }
      );

      final results = json.decode(response.body);
      List data = results["data"];
      final parseData = data.map((e) => Data.fromJson(e)).toList();

      print("listSurvey : $data");

      return parseData;

    } catch(e){
      rethrow;
    }
  }

  ListView _surveyListView(data){
    return ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: (){
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailSurveyScreen(
                    id: data[index].id,
                    nameSurvei: data[index].surveyName,
                    token: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJsZXZlbCI6IjMiLCJleHAiOjE2OTg0MDMxNTksImlzcyI6InV5cDFmZG9iaWMifQ.YeQGMhrCYR7PN-rN-YESzbAYM5-yIaRQuXKhUpFHTWI",
                  )
                )
              );
            },
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                  border: Border.all(
                      color: const Color(0xFFD9D9D9)
                  )
              ),
              child: Row(
                children: [
                  SvgPicture.asset(
                    "assets/ph_exam.svg",
                    width: 54,
                    height: 54,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data[index].surveyName,
                        style: const TextStyle(
                            fontSize: 14
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        "Created At: ${DateFormat("dd MMM yyyy","id_ID").format(DateTime.parse(data[index].createdAt))}",
                        style: const TextStyle(
                            fontSize: 12
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        }
    );
  }
}
