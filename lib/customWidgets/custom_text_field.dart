import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final FormFieldSetter<String> onSaved;
  final Icon icon;
  final bool isDateTimePickerFormField;
  final String hint;
  final bool obscure;
  final bool isEnabled;
  final FormFieldValidator<String> validator;
  final TextEditingController textEditingController;
  final String labelText;
  final int maxLines;
  final int minLines;

  // constructor
  CustomTextField(
      {this.icon,
        this.hint,
        this.obscure = false,
        this.validator,
        this.onSaved,
        this.isEnabled = true,
        this.textEditingController,
        this.labelText,
        this.maxLines,
        this.minLines,
        this.isDateTimePickerFormField = false});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(left: 20, right: 20),
        decoration: new BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Color(0xFFEAECEB),
              blurRadius: 40.0, // has the effect of softening the shadow
              spreadRadius: 10.0, // has the effect of extending the shadow
              offset: Offset(
                1.0, // horizontal, move right 10
                1.0, // vertical, move down 10
              ),
            )
          ],
        ),
        child: TextFormField(
          enabled: isEnabled,
          onSaved: onSaved,
          validator: validator,
          autofocus: false,
          obscureText: obscure,
          maxLines: maxLines,
          minLines: minLines,
          style: TextStyle(
            fontFamily: 'Raleway',
            fontSize: 18,
          ),
          decoration: InputDecoration(
              hintStyle: TextStyle(fontFamily: 'Raleway', fontSize: 18),
              hintText: hint,
              labelText: labelText,
              filled: true,
              fillColor: Colors.white,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(
                  color: Color(0xFFFFFFFF),
                  //color: Theme.of(context).primaryColor,
                  width: 2,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(
                  color: Color(0xFFFFFFFF),
                  //color: Theme.of(context).primaryColor,
                  width: 2,
                ),
              ),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(
                    color: Color(0xFFFFFFFF),
                    //color: Theme.of(context).primaryColor,
                    width: 3,
                  )
              ),
              prefixIcon:
              Padding(
                child: IconTheme(
                  data: IconThemeData(color: Color(0xFFc6c6c6)),
                  //data: IconThemeData(color: Theme.of(context).primaryColor),

                  child: icon != null? icon: Icon(null),
                ),
                padding: icon != null? EdgeInsets.only(left: 30, right: 10) : EdgeInsets.only(left: 5, right: 5),
              )
          ),
        )
    );
  }
}