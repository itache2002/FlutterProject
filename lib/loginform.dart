import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'Bottomnavbar.dart';


class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey <FormState>formkey= GlobalKey<FormState>();

  void clearText(){
    nameController.clear();
    passwordController.clear();
  }



  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: const Text(
                  'ಅಪ್ಪು',
                  style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.w500,
                      fontSize: 30),
                )
            ),
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(5),
                child: const Text(
                  'LOG IN',
                  style: TextStyle(fontSize: 20),
                )),
            Container(
              padding: const EdgeInsets.all(5),
              child: Form(
                  key: formkey,
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                          controller: nameController,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "Email"
                          ),
                          validator:  MultiValidator([
                            RequiredValidator(errorText:"Required"),
                            EmailValidator(errorText: "Invalide Email")
                          ]
                          )
                      ),
                      SizedBox(height: 10,),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0,0, 0,0),
                        child:
                        TextFormField(
                          controller: passwordController,
                          obscureText: true,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Password",
                          ),
                          validator:
                          RequiredValidator(errorText:"Required"),
                        ),
                      )
                    ],
                  )
              ),
            ),
            TextButton(
              onPressed: () {
                //forgot password screen
              },
              child: const Text('Forgot Password',),
            ),
            Container(
                height: 50,
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: ElevatedButton(
                  child: const Text('Login'),
                  onPressed: () {
                    if(formkey.currentState!.validate()){
                      FirebaseAuth.instance.signInWithEmailAndPassword(
                          email:nameController.text,
                          password: passwordController.text).then((value) => {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()
                            )
                            ).onError((error, stackTrace) => {
                              print("Error${error.toString()}")
                            })
                          });
                    }
                    else
                    {
                      print("Error");
                    }
                  },
                )
            ),
            Row(
              children: <Widget>[
                const Text('Does not have account?'),
                TextButton(
                  child: const Text(
                    'Sign in',
                    style: TextStyle(fontSize: 20),
                  ),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context){
                      return const SignUpFormWidget();
                    }));
                  },
                )
              ],
              mainAxisAlignment: MainAxisAlignment.center,
            ),
          ],
        ));
  }
}
