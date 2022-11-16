import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'loginform.dart';
 
class SignUpFormWidget extends StatelessWidget {
  const SignUpFormWidget({Key? key,}) : super(key: key);
  static const String _title = 'Food Wasteage Reduction';



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(_title)),
      body: MySingin(),
    );
  }
}
class MySingin extends StatefulWidget {
  const MySingin({Key? key}) : super(key: key);

  @override
  State<MySingin> createState() => _MySinginState();
}

class _MySinginState extends State<MySingin> {
  TextEditingController name= TextEditingController();
  TextEditingController email=TextEditingController();
  TextEditingController number=TextEditingController();
  TextEditingController password=TextEditingController();
  TextEditingController conformpass=TextEditingController();
  GlobalKey <FormState>formkey= GlobalKey<FormState>();


  void  store(){
     final sname=name.text.trim();
     final semail=email.text;
     final sphone=number.text;
     final spassword=password.text;
     final conpassword=conformpass.text;

     FirebaseFirestore.instance.collection("store")
         .add({
       "name":sname,
       "email":semail,
       "phone":sphone,
       "password":spassword,
       "conformpass":conpassword
     });
     FirebaseAuth.instance.createUserWithEmailAndPassword(
         email: semail,
         password: spassword).then((value) =>{
     Navigator.pop(context, MaterialPageRoute(builder: (context){
     return const LoginForm() ;
     }))
     }).onError((error, stackTrace) => {
       print("Error ${error.toString()}")
     });
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child:
      SingleChildScrollView(
        child: Column(
          children: [
            Container(
                alignment: Alignment.center,
                child: const Text(
                  'Sign In',
                  style: TextStyle(fontSize: 40),
                )
            ),

            Container(
              alignment:  Alignment.center,
              child: Form(
                key: formkey,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                        controller: name,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Name"
                        ),
                        validator:
                        RequiredValidator(errorText:"Required")
                    ),

                    SizedBox(height: 10,),
                    TextFormField(
                        controller: email,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Email"
                        ),
                        validator:MultiValidator(
                            [
                              RequiredValidator(errorText: "Required"),
                              EmailValidator(errorText: "Invaild Email")
                            ]
                        )
                    ),

                    SizedBox(height: 10,),
                    TextFormField(
                      controller: number,
                      keyboardType: TextInputType.phone,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Phone"
                      ),
                      validator: MultiValidator(
                          [
                            RequiredValidator(errorText: "Required"),
                            MinLengthValidator(10, errorText: "Min Length 10")
                          ]
                      ),
                    ),
                    SizedBox(height: 10,),
                    TextFormField(
                      controller: password,
                      obscureText: true,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Password"
                      ),
                      validator: RequiredValidator(errorText: "Required"),
                    ),
                    SizedBox(height: 10,),
                    TextFormField(
                      controller: conformpass,
                      obscureText: true,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Conform Password"
                      ),
                      validator:
                          (val){
                        if(val!=password.text)
                        {
                          return"Not Match";
                        }
                      },

                    ),
                    SizedBox(height: 10,),
                    Container(
                        height: 50,
                        padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                        child: ElevatedButton(
                          child: const Text('Create Account'),
                          onPressed: () {
                            if(formkey.currentState!.validate()){
                              store();
                            }
                            else
                            {
                              print("Error");
                            }
                          },
                        )
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      );
  }
}

