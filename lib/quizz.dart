import 'dart:math';
import 'package:flutter/material.dart';
import 'Class/question_data_rock.dart';
import 'Class/Answer/bad_answer.dart';
import 'Class/Answer/good_answer.dart';
import 'Class/result_sentence.dart';

class QuizzPage extends StatefulWidget{
  const QuizzPage({super.key});

  @override
  State<QuizzPage> createState() => QuizPageState();
}

class QuizPageState extends State<QuizzPage> {

  int _counterScore = 0;
  int _counterQuestion = 0;


  void _incrementCounterScore() {
    setState(() {
      _counterScore++;
    });  }

  void _incrementCounterQuestion() {
    setState(() {
      _counterQuestion++;
    });
  }

  void _answerQuestion(int questionId, bool response) async {
    var isRight = QuestionDataRock().questionList[questionId].response == response;

    if(isRight) {
      _incrementCounterScore();
    }
    //await showCustomDialogResponse(dialog: customAlertDialogResponse(questionId, isRight), context: context);

    if(_counterQuestion + 1 == QuestionDataRock().questionList.length){
      showCustomDialogEnd(dialog: customAlertDialogEnd(), context: context);
      return;
    }
    _incrementCounterQuestion();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Courage chef'),
        centerTitle: true,
      ),
      body: Center(
          child: Card(
            child: SizedBox(
              width: 250,
              height: 710,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Question numéro ${_counterQuestion + 1}'),
                  const SizedBox(height: 20),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: 250,
                    height: 350,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: FittedBox(
                        fit: BoxFit.cover,
                        child: Image(
                          image: AssetImage('assets/images/${QuestionDataRock().questionList[_counterQuestion].imagePath}'),
                ),
              ),
            ),
          ),
                  const SizedBox(height: 20),
                  Text(QuestionDataRock().questionList[_counterQuestion].question, textAlign: TextAlign.center,),
                  const SizedBox(height: 20),
                  ElevatedButton(onPressed: () {_answerQuestion(_counterQuestion, true); }, child: Text('Vrai')),
                  const SizedBox(height: 5),
                  ElevatedButton(onPressed: () {_answerQuestion(_counterQuestion, false); }, child: Text('Faux')),
                  const SizedBox(height: 50),
                  Text('Votre score: $_counterScore')

                ],
              ),
            ),
          )
      ),
    );
  }

  Future<void> showCustomDialogResponse({required Widget dialog, required BuildContext context}) async {
    await showDialog(
        barrierDismissible: true,
        context: context,
        builder: (BuildContext buildContext) {
          return dialog;
        }
    );
  }

  Future<void> showCustomDialogEnd({required Widget dialog, required BuildContext context}) async {
    await showDialog(
        barrierDismissible: true,
        context: context,
        builder: (BuildContext buildContext) {
          return dialog;
        }
    );
  }

  AlertDialog customAlertDialogResponse(int questionId, bool isRight) {
    return AlertDialog(
      title: Text( textAlign: TextAlign.center, isRight ?
        GoodAnswer().goodAnswer[Random().nextInt(GoodAnswer().goodAnswer.length - 1)] :
        BadAnswer().badAnswer[Random().nextInt(BadAnswer().badAnswer.length - 1)]
      ),
      content: Text(textAlign: TextAlign.center, QuestionDataRock().questionList[questionId].explanation),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text("OK")
        )
      ],
    );
  }

  AlertDialog customAlertDialogEnd() {
    return AlertDialog(
      title: Text(textAlign: TextAlign.center, 'Ton Score Final: $_counterScore'),
      content: Text( textAlign: TextAlign.center, ResultSentence().resultPhrases[_counterScore].toString()),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pushNamed(context, '/home');
            },
            child: const Text("Retourne à l'acceuil")
        )
      ],
    );
  }
}
