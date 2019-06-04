import 'package:flutter/material.dart';
import 'package:opentrivia/models/category.dart';
import 'package:opentrivia/models/question.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:opentrivia/ui/pages/quiz_finished.dart';

class QuizPage extends StatefulWidget {
  final List<Question> questions;
  final Category category;

  const QuizPage({Key key, @required this.questions, this.category}) : super(key: key);

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  final TextStyle _questionStyle = TextStyle(
    fontSize: 18.0,
    fontWeight: FontWeight.w500,
    color: Colors.white
  );

  int _currentIndex = 0;
  final Map<int,dynamic> _answers = {};


  @override
  Widget build(BuildContext context){
    Question question = widget.questions[_currentIndex];
    final List<dynamic> options = question.incorrectAnswers;
    if(!options.contains(question.correctAnswer)) {
      options.add(question.correctAnswer);
      options.shuffle();
    }
    
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category.name),
        elevation: 0,
      ),
      body: Stack(
        children: <Widget>[
          ClipPath(
            clipper: WaveClipperTwo(),
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor
              ),
              height: 200,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    CircleAvatar(
                      backgroundColor: Colors.white70,
                      child: Text("${_currentIndex+1}"),
                    ),
                    SizedBox(width: 16.0),
                    Expanded(
                      child: Text(widget.questions[_currentIndex].question,
                        softWrap: true,
                        style: _questionStyle,),
                    ),
                  ],
                ),

                SizedBox(height: 20.0),
                Card(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ...options.map((option)=>RadioListTile(
                        title: Text("$option"),
                        groupValue: _answers[_currentIndex],
                        value: option,
                        onChanged: (value){
                          setState(() {
                            _answers[_currentIndex] = option;
                          });
                        },
                      )),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.bottomCenter,
                    child: RaisedButton(
                      child: Text( _currentIndex == (widget.questions.length - 1) ? "Submit" : "Next"),
                      onPressed: (_currentIndex < (widget.questions.length - 1)) ? (){
                        setState(() {
                            _currentIndex++;
                        });
                      } : () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (_) => QuizFinishedPage(questions: widget.questions, answers: _answers)
                        ));
                      },
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}