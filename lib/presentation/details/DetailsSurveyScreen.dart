import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:test_synapsis/data/models/response/DetailsSurveyModels.dart';
import 'package:test_synapsis/presentation/widget_common/custom_btn.dart';
import 'package:http/http.dart' as http;
import 'package:test_synapsis/presentation/widget_common/answer_list.dart';
import 'package:top_modal_sheet/top_modal_sheet.dart';

class DetailSurveyScreen extends StatefulWidget {
  final String id;
  String token;
  String nameSurvei;

  DetailSurveyScreen({
    super.key,
    required this.id,
    required this.token,
    required this.nameSurvei,
  });

  @override
  State<DetailSurveyScreen> createState() => _DetailSurveyScreenState();
}

class _DetailSurveyScreenState extends State<DetailSurveyScreen> {

  final CarouselController controllerList = CarouselController();
  String? _topModalData;

  Future<List<Questions>> _getQuestionList() async {
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
      List dataQuestions = results["data"]["questions"];
      final parseData = dataQuestions.map((e) => Questions.fromJson(e)).toList();

      return parseData;

    } catch(e){
      rethrow;
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Container(
          width: 158,
          height: 36,
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                  color: Colors.blue
              ),
              borderRadius: const BorderRadius.all(Radius.circular(4))
          ),
          child: const Text(
            "45 Seconds Left",
            style: TextStyle(
                fontSize: 14,
                color: Colors.blue
            ),
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () async {
              var value = await showTopModalSheet<String?>(context,
                SafeArea(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 25.98),
                        child: const Text("Survei Questions",
                            style: TextStyle(color: Colors.black, fontSize: 18.4),
                            textAlign: TextAlign.start),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Divider(
                        thickness: 2,
                      ),
                      SizedBox(
                        height: 12,
                      ),
                    ],
                  ),
                ),
              );

              setState(() {
                _topModalData = value;
              });
            },
            child: Container(
                width: 79,
                height: 36,
                margin: EdgeInsets.only(right: 24, top: 12, bottom: 12),
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                decoration: const BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.all(Radius.circular(4))
                ),
                child: Row(
                  children: [
                    SvgPicture.asset(
                        "assets/ic_outline-list-alt.svg"
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    const Text(
                      "1/3",
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.white
                      ),
                    ),
                  ],
                )
            ),
          ),
        ],
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomBtn(
              nameBtn: 'Back',
              btnAction: () {
                controllerList.previousPage();
              },
              btnColor: Colors.white,
              txtColor: const Color(0xFF1FA0C9),
              borderBtn: const BorderSide(
                color: Color(0xFF1FA0C9),
              ),
              sizeExtend: Size(127,42),
            ),
            CustomBtn(
              nameBtn: 'Next',
              btnAction: () {
                controllerList.nextPage();
              },
              btnColor: Color(0xFF1FA0C9),
              txtColor: Colors.white,
              sizeExtend: Size(169, 42),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: FutureBuilder<List<Questions>>(
          future: _getQuestionList(),
          builder: (context, snapshot){
            if(snapshot.hasError){
              return Center(
                child: Text(
                  '${snapshot.error}'
                ),
              );
            }
            else if(snapshot.hasData){
              List<Questions> listPertanyaan = snapshot.data!;
              return questionList(listPertanyaan);
            }
            else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        )
      ),
    );
  }

  CarouselSlider questionList(listData){
    return CarouselSlider.builder(
      carouselController: controllerList,
      itemCount: listData.length,
      itemBuilder: (BuildContext context, int index, int realIndex) {
        return listTileQuestions(listData, index);
      },
      options: CarouselOptions(
        height: MediaQuery.of(context).size.height,
        viewportFraction: 1.0,
        enlargeCenterPage: false,
        enableInfiniteScroll: false,

      ),
    );
  }

  Widget listTileQuestions(listData, index){
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 12,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Text(
              widget.nameSurvei,
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700
              ),
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Text(
              "${listData[index].questionNumber}. ${listData[index].questionName}",
              style: TextStyle(
                  fontSize: 16
              ),
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          const Divider(
            thickness: 5,
          ),
          const SizedBox(
            height: 12,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Text(
              "Answer",
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w400
              ),
            ),
          ),
          AnswerList(
              id: widget.id,
              token: widget.token,
              answerIndex: index,
          )
        ],
      ),
    );
  }
}


