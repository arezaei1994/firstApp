import 'package:flutter/material.dart';

class InputFieldArea extends StatelessWidget {
  final String hint;
  final bool obscure;
  final IconData icon;
  final validator;
  final onSaved;
  
  InputFieldArea({this.hint , this.obscure , this.icon , this.validator, this.onSaved});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsetsDirectional.only(bottom: 10),
        child: new TextFormField(
          validator: validator,
          onSaved: onSaved,
          obscureText: obscure,
          style: const TextStyle(
          color: Colors.white,
          ),
          decoration: new InputDecoration(
                      icon: new Icon(
                      icon,
                      color: Colors.white, 
                      ),
          enabledBorder: UnderlineInputBorder(
           borderSide: new BorderSide(
              color:  Colors.white30
           )
          ) ,
          errorBorder: UnderlineInputBorder(
           borderSide: new BorderSide(
              color:  Colors.amber
           )
          ),  
          focusedBorder: UnderlineInputBorder(
           borderSide: new BorderSide(
              color:  Colors.white
           )
          ), 
          focusedErrorBorder: UnderlineInputBorder(
           borderSide: new BorderSide(
              color:  Colors.amber
           )
          ),
         errorStyle: TextStyle(color: Colors.amber),
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.white , fontSize: 15 ),
          contentPadding: const EdgeInsets.only(
                        top: 15, right: 0, bottom: 20, left: 5 
          )
          ),
        )
    );

  }
  
}