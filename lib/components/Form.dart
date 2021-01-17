import 'package:flutter/material.dart';
import 'package:whatsapp/components/InputFields.dart';
import 'package:validators/validators.dart';
import 'package:email_validator/email_validator.dart';

class FormContainer extends StatelessWidget {
  final formKey;
  final emailOnSaved;
  final passwordOnSaved;
  FormContainer(
      {@required this.formKey, this.emailOnSaved, this.passwordOnSaved});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: new Column(
        children: [
          new Form(
            key: formKey,
            child: new Column(
              children: [
                new InputFieldArea(
                    hint: 'نام کاربری',
                    obscure: false,
                    icon: Icons.person_outline,
                    validator: (String value) {
                      if (!isEmail(value)) {
                        return 'ایمیل وارد شده صحیح نمیباشد';
                      }
                    },
                    onSaved: emailOnSaved),
                new InputFieldArea(
                    hint: 'پسورد ',
                    obscure: true,
                    icon: Icons.lock_open,
                    validator: (String value) {
                      if (value.length < 5) {
                        return 'نمیتواند کمتراز 6 کاراکتر  باشد';
                      }
                    },
                    onSaved: passwordOnSaved)
              ],
            ),
          )
        ],
      ),
    );
  }
}
