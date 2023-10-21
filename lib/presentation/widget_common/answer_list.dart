import 'dart:convert';

import 'package:flutter/material.dart';

import '../../data/models/response/DetailsSurveyModels.dart';
import 'package:http/http.dart' as http;

class AnswerList extends StatefulWidget {
  final String id;
  String token;
  int answerIndex;

  AnswerList({
    super.key,
    required this.id,
    required this.token,
    required this.answerIndex,
  });

  @override
  State<AnswerList> createState() => _RadioBtnState();
}

class _RadioBtnState extends State<AnswerList> {
  int? _selectedAnswer;

  @override
  void initState() {
    super.initState();
  }

  Future<List<Options>> _getAnswerList() async {
    try {
      String baseUrl = "https://panel-demo.obsight.com/";
      final response = await http.get(
          Uri.parse("${baseUrl}api/survey/${widget.id}"),
          headers: {
            'Authorization' : 'Bearer ',
            "Content-Type": 'application/json',
            "Cookie": "token=${widget.token}",
          }
      );

      final results = json.decode(response.body);
      List dataOptions = results["data"]["questions"][widget.answerIndex]["options"];
      final parseData = dataOptions.map((e) => Options.fromJson(e)).toList();

      return parseData;

    } catch(e){
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Options>>(
      future: _getAnswerList(),
      builder: (context, snapshot){
        if(snapshot.hasError){
          return Center(
            child: Text(
                '${snapshot.error}'
            ),
          );
        }
        else if(snapshot.hasData){
          List<Options> listJwb = snapshot.data!;
          return tileRadioButton(listJwb);
        }
        else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }


  Widget tileRadioButton(listJwb){
      return SingleChildScrollView(
        child: ListView.builder(
            itemCount: listJwb.length,
            shrinkWrap: true,
            itemBuilder: (context, index){
             return ListTile(
                title: Text(listJwb[index].optionName),
                leading: Radio(
                  value: listJwb[index].value,
                  onChanged: (value) {
                    setState(() {
                      _selectedAnswer = value;
                    });
                  },
                  groupValue: _selectedAnswer,
                ),
              );
            }
        ),
      );
    }
}
