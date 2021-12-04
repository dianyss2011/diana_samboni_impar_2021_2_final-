import 'package:examenfinal/models/token.dart';
import 'package:examenfinal/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class FormScreen extends StatefulWidget {
  final Token token;
  final User user;
  
  FormScreen({required this.token, required this.user});

  @override
  _FormScreenState createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {

  String _email = '';
  String _emailError = '';
  bool _emailShowError = false;
  TextEditingController _emailController = TextEditingController();

  String _likeComentaries = '';
  String _likeComentariesError = '';
  bool _likeComentariesShowError = false;
  TextEditingController _likeComentariesController = TextEditingController();

  String _dislikeComentaries = '';
  String _dislikeComentariesError = '';
  bool _dislikeComentariesShowError = false;
  TextEditingController _dislikeComentariesController = TextEditingController();

  String _remarks = '';
  String _remarksError = '';
  bool _remarksShowError = false;
  TextEditingController _remarksController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.user.id.isEmpty
            ? 'Formulario' 
            : widget.user.fullName
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: <Widget>[
                _showEmail(),
                _showRanking(),
                _showLikeComentaries(),
                _showDislikeComentaries(),
                _showRemarks(),
                _showButtons(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _showButtons() {
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Expanded(
            child: ElevatedButton(
              child: Text('Guardar'),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith<Color>(
                  (Set<MaterialState> states) {
                    return Color(0xFF120E43);
                  }
                )
              ),
              onPressed: () => _save()
            ),
          ),
        ],
      ),
    );
  }

  Widget _showEmail() {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextField(
        enabled: widget.user.id.isEmpty,
        controller: _emailController,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          hintText: 'Ingresa email...',
          labelText: 'Email',
          errorText: _emailShowError ? _emailError : null,
          suffixIcon: Icon(Icons.email),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10)
          ),
        ),
        onChanged: (value) {
          _email = value;
        },
      ),
    );
  }

  Widget _showRanking() {
    return RatingBar.builder(
      initialRating: 3,
      minRating: 1,
      direction: Axis.horizontal,
      allowHalfRating: true,
      itemCount: 5,
      itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
      itemBuilder: (context, _) => Icon(
        Icons.star,
        color: Colors.amber,
      ),
      onRatingUpdate: (rating) {
        print(rating);
      },
    );
  }

 Widget  _showLikeComentaries() {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextField(
        keyboardType: TextInputType.multiline,
        minLines: 1,
        maxLength: 4,
        controller: _likeComentariesController,
        decoration: InputDecoration(
          hintText: 'Lo que más te gustó del curso...',
          labelText: 'Lo que más te gustó',
          errorText: _likeComentariesShowError ? _likeComentariesError : null,
          suffixIcon: Icon(Icons.description),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10)
          )
        ),
        onChanged: (value) {
          _likeComentaries = value;
        },
      ),
    );
  }

  Widget _showDislikeComentaries() {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextField(
        keyboardType: TextInputType.multiline,
        minLines: 1,
        maxLength: 4,
        controller: _dislikeComentariesController,
        decoration: InputDecoration(
          hintText: 'Lo que menos te gustó del curso...',
          labelText: 'Lo que menos te gustó',
          errorText: _dislikeComentariesShowError ? _dislikeComentariesError : null,
          suffixIcon: Icon(Icons.description),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10)
          )
        ),
        onChanged: (value) {
          _dislikeComentaries = value;
        },
      ),
    );
  }

  Widget _showRemarks() {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextField(
        keyboardType: TextInputType.multiline,
        minLines: 1,
        maxLength: 4,
        controller: _remarksController,
        decoration: InputDecoration(
          hintText: 'Ingresa un comentario general...',
          labelText: 'Comentario general',
          errorText: _remarksShowError ? _remarksError : null,
          suffixIcon: Icon(Icons.description),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10)
          )
        ),
        onChanged: (value) {
          _remarks = value;
        },
      ),
    );
  }

  _save() {}
}