import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Home.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late SharedPreferences sharedPreferences;
  var newUser = false;

  bool _isSwitched = false;

  bool isChecked = false;

  RegExp emailValidator = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  List<String> lanlist = ["English", "Hindi", "Gujarati"];
  var dropdownvalue = "English";

  var userlist = ["yogi@gmail.com", "yogesh@gmail.com", "xyz@gmail.com"];
  var passlist = ["123456", "123456", "123456"];


  @override
  void initState() {
    checkLogin();
  }

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final key = GlobalKey<FormState>();

  var darkcolor = Colors.black;
  var lightcolor = Colors.white;
  var darkfont = Colors.black;
  var whitefont = Colors.white;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: key,
      child: Scaffold(

          backgroundColor: _isSwitched ? darkcolor : lightcolor,
          appBar: AppBar(actions: [
            Switch(
            value: _isSwitched,
            onChanged: (value) {
              setState(() {
                _isSwitched = value;
                value ? Icon(Icons.dark_mode) : Icon(Icons.light_mode);
              });
            },)
          ],),
          body: SafeArea(

              child: Center
              (
                child: Card
                (
                  child: Padding
                  (
                    padding: const EdgeInsets.all(20.0),
                    child: Column
                    (
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children:
                      [
                        CircleAvatar(child: Container(child: Row(mainAxisAlignment: MainAxisAlignment.center,children: [Image.asset('assets/images.jfif')])),radius: 50, ),
                        SizedBox(height: 10,),
                        Text("Student Login",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold)),
                        SizedBox(height: 10,),

                        TextFormField(controller: emailController, decoration: InputDecoration(hintText: "Enter Email..", prefixIcon: Icon(Icons.email),border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
                          validator: (value)
                          {
                            if(emailController.text.isEmpty)
                            {
                              return "Enter Email";
                            }
                            else if(!emailValidator.hasMatch(emailController.text))
                            {
                              return "Invalid Email";
                            }
                            else if(emailController.text != userlist.toString())
                            {
                              return "Invalid Email";
                            }
                            return null;
                          },),
                        SizedBox(height: 10,),

                        TextFormField(controller: passwordController, decoration: InputDecoration(hintText: "Enter Password..", prefixIcon: Icon(Icons.password),border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
                          validator: (value) {
                            if(passwordController.text.isEmpty)
                            {
                              return "Enter Password";
                            }
                            else if(passwordController.text.length != 6)
                            {
                              return "Password must be 6 characters";
                            }
                            else if(passwordController.text != "123456")
                            {
                              return "Invalid Password";
                            }
                            return null;
                          },),

                        SizedBox(height: 10,),
                        Row(
                          children:
                          [
                            Text("Remember Me"),
                            Checkbox(value: isChecked, onChanged:(value) {
                              setState(() {
                                isChecked = !isChecked;
                              });
                              if(isChecked == true)
                                {
                                  sharedPreferences.setBool('rememberMe', false);
                                }
                                else
                                {
                                  sharedPreferences.setBool('rememberMe', true);
                                }
                            }),
                            Spacer(),
                            DropdownButton(value: dropdownvalue,items: lanlist.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                                onChanged: (String? newValue) => {
                              setState(() {
                                dropdownvalue = newValue!;
                              })
                                })
                          ],

                        ),

                        ElevatedButton(onPressed: () {
                          String email = emailController.text.trim();
                          String pass = passwordController.text.trim();
                          String lan = dropdownvalue;
                          var color = _isSwitched ? darkcolor : lightcolor;

                          setState(() {
                            sharedPreferences.setString('email', email);
                            sharedPreferences.setString('password', pass);
                            sharedPreferences.setString('language', lan);
                            sharedPreferences.setBool('isSwitched', _isSwitched);

                          });
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));

                        }, child: Text("Login"), style: ElevatedButton.styleFrom(backgroundColor: Colors.blue.shade50,))
                      ]
                  )
                )
              ),
            ),
          ),
      ),
    );
  }

  checkLogin() async
  {
    sharedPreferences = await SharedPreferences.getInstance();
    newUser = sharedPreferences.getBool('rememberMe') ?? true;

    if(newUser == false)
    {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
    }
  }

}
