import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:email_validator/email_validator.dart';
import 'package:examenfinal/helpers/api_helper.dart';
import 'package:examenfinal/models/finals.dart';
import 'package:examenfinal/models/response.dart';
import 'package:examenfinal/models/token.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class FormScreen extends StatefulWidget {
  final Token token;
  final Finals finals;
  
  FormScreen({required this.token, required this.finals});

  @override
  _FormScreenState createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {

  String _email = '';
  String _emailError = '';
  bool _emailShowError = false;
  TextEditingController _emailController = TextEditingController();

  int _rating = 0;
  String _ratingError = '';
  bool _ratingShowError = false;
  TextEditingController _ratingController = TextEditingController();

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
  void initState() {
    super.initState();
    _email = widget.finals.email;
    _emailController.text = _email;

    _rating = widget.finals.qualification;
    _ratingController.text = _rating.toString();
    
    _likeComentaries = widget.finals.theBest;
    _likeComentariesController.text = _likeComentaries;
    
    _dislikeComentaries = widget.finals.theWorst;
    _dislikeComentariesController.text = _dislikeComentaries;
    
    _remarks = widget.finals.remarks;
    _remarksController.text = _remarks;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Formulario'),
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
        _rating = rating.toInt();
        print(_rating);
      },
    );
  }

 Widget  _showLikeComentaries() {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextField(
        keyboardType: TextInputType.multiline,
        minLines: 1,
        maxLength: 100,
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
        maxLength: 100,
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
        maxLength: 100,
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

  void _save() {
    if (!_validateFields()) {
      return;
    }

    _saveRecord();
  }

  bool _validateFields() {
    bool isValid = true;

    if (_email.isEmpty) {
      isValid = false;
      _emailShowError = true;
      _emailError = 'Debes ingresar un email.';
    } else if (!EmailValidator.validate(_email)) {
      isValid = false;
      _emailShowError = true;
      _emailError = 'Debes ingresar un email válido.';
    } else if (!_email.toLowerCase().contains('correo.itm.edu.co')) {
      isValid = false;
      _emailShowError = true;
      _emailError = 'Debes ingresar un email del dominio del ITM.';
    } else {
      _emailShowError = false;
    }

    if (_rating == 0) {
      isValid = false;
      _ratingShowError = true;
      _ratingError = 'Debes seleccionar una puntuación.';
    } else {
      _ratingShowError = false;
    }
    
    if (_likeComentaries.isEmpty) {
      isValid = true;
      _likeComentariesShowError = true;
      _likeComentariesError = 'Debes ingresar lo que más te gustó del curso.';
    } else {
      _likeComentariesShowError = false;
    }
    
    if (_dislikeComentaries.isEmpty) {
      isValid = true;
      _dislikeComentariesShowError = true;
      _dislikeComentariesError = 'Debes ingresar lo que menos te gustó del curso.';
    } else {
      _dislikeComentariesShowError = false;
    }
    
    if (_remarks.isEmpty) {
      isValid = true;
      _remarksShowError = true;
      _remarksError = 'Debes ingresar un comentario general.';
    } else {
      _remarksShowError = false;
    }

    setState(() { });
    return isValid;
  }

  void _saveRecord() async {

    Map<String, dynamic> request = {
      'email': _email,
      'qualification': _rating,
      'theBest': _likeComentaries,
      'theWorst': _dislikeComentaries,
      'remarks': _remarks
    };

    Response response = await ApiHelper.post(
      request,
      widget.token
    );

    if (!response.isSuccess) {
      await showAlertDialog(
        context: context,
        title: 'Error',
        message: response.message,
        actions: <AlertDialogAction>[
          AlertDialogAction(key: null, label: 'Aceptar')
        ]
      );
      return;
    }
  }
}