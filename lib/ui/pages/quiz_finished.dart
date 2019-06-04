import 'package:flutter/material.dart';
import 'package:opentrivia/models/question.dart';

class QuizFinishedPage extends StatelessWidget {
  final List<Question> questions;
  final Map<int, dynamic> answers;
  int correctAnswers;
  QuizFinishedPage({Key key, @required this.questions, @required this.answers}): super(key: key) {
    
  }

  @override
  Widget build(BuildContext context){
    int correct = 0;
    this.answers.forEach((index,value){
      if(this.questions[index].correctAnswer == value)
        correct++;
    });
    
    return Scaffold(
      appBar: AppBar(
        title: Text('End of Quiz'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Text("Total: ${questions.length}"),
            Text("Correct: $correct")
          ],
        ),
      ),
    );
  }
}