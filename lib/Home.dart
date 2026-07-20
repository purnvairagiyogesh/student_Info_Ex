import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_info/login.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
{

  var darkcolor = Colors.black;
  var lightcolor = Colors.white;
  var darkfont = Colors.black;
  var whitefont = Colors.white;


  late SharedPreferences sharedPreferences;

  bool isnotiSwitched = false;
  bool isthemeSwitched = false;
  bool islanwitched = false;

  var email;
  var lan = "";
  
  @override
  void initState() {
    checkLogin();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold
    (

      backgroundColor: isthemeSwitched ? darkcolor : lightcolor,
      appBar: AppBar(title: Text("Home Screen"), centerTitle: true, backgroundColor: isthemeSwitched ? Colors.deepPurple.shade200 : Colors.blue.shade200,),
      body: SafeArea(
        child: Center
        (
          child: Flexible(
            child: Card
            (
              color: isthemeSwitched ? Colors.grey : lightcolor,
              child: Padding(
                padding: const EdgeInsets.all(28.0),
                child: Column
                (
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children:
                  [
                    CircleAvatar(child: Container(child: Row(mainAxisAlignment: MainAxisAlignment.center,children: [Image.asset('assets/images.jfif')])),radius: 50, ),
                    SizedBox(height: 10,),
                    Text("Yogesh Purnviaragi", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: isthemeSwitched? Colors.white : Colors.black)),
                    SizedBox(height: 10,),
                    Text("Enr No. : 12345", style: TextStyle(color: isthemeSwitched? Colors.white : Colors.black),),

                    SizedBox(height: 10,),
                    Text("Course : B.C.A.",style: TextStyle(color: isthemeSwitched? Colors.white : Colors.black)),

                    SizedBox(height: 10,),
                    Text("Sem : 1", style: TextStyle(color: isthemeSwitched? Colors.white : Colors.black)),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      drawer: Drawer(
        backgroundColor: isthemeSwitched ? darkcolor : lightcolor,
        child: ListView
        (
            children:
            [
              UserAccountsDrawerHeader(
                accountName: Text(email, style: TextStyle(color: isthemeSwitched? Colors.white : Colors.black)),
                accountEmail: Text("yogi@gmail.com",style: TextStyle(color: isthemeSwitched? Colors.white : Colors.black)),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: isthemeSwitched ? Colors.deepPurple : Colors.blue,
                  child: Text(email[0].toUpperCase(), style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                ),
              ),
              ListTile
              (
                leading: Icon(Icons.home,color: isthemeSwitched? Colors.white : Colors.black),
                title: Text("Notification",style: TextStyle(color: isthemeSwitched? Colors.white : Colors.black)),
                trailing: Switch(
                  value: isnotiSwitched,
                  onChanged: (bool value) {
                    setState(() {
                      isnotiSwitched = value;
                      isnotiSwitched ? notifyon() : notifyoff();
                    });
                  },
                  activeColor: Colors.blue,
                  inactiveThumbColor: Colors.grey,
                )
                
              ),
              Divider(),
              ListTile
                (
                  leading: Icon(Icons.color_lens,color: isthemeSwitched? Colors.white : Colors.black),
                  title: Text("Theme",style: TextStyle(color: isthemeSwitched? Colors.white : Colors.black)),
                  trailing: Switch(
                    value: isthemeSwitched,
                    onChanged: (bool bgcolor) {
                      setState(() {
                        if(isthemeSwitched)
                        {
                          isthemeSwitched = !isthemeSwitched;
                        }
                        else
                        {
                          isthemeSwitched = !isthemeSwitched;
                        }
                      });
                    },
                    activeColor: Colors.blue,
                    inactiveThumbColor: Colors.grey,
                  )

              ),
              Divider(),
              ListTile
                (
                  leading: Icon(Icons.language,color: isthemeSwitched? Colors.white : Colors.black),
                  title: Text("Language",style: TextStyle(color: isthemeSwitched? Colors.white : Colors.black)),
                  trailing: Text(lan,style: TextStyle(color: isthemeSwitched? Colors.white : Colors.black)),

              ),
              Divider(),
              ListTile
                (
                  leading: Icon(Icons.logout),
                  title: Text("Logout",style: TextStyle(color: isthemeSwitched? Colors.white : Colors.black)),
                  onTap: () {
                    sharedPreferences.clear();
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                  },

              ),
            ],
        )
      ),
    );
  }

  checkLogin() async
  {
    sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      email = sharedPreferences.getString('email');
      lan = sharedPreferences.getString('language')!;;
    });
  }

  darkTheme()
  {
    return Container(
      child: Scaffold
        (
        backgroundColor: Colors.black,
          appBar: AppBar(title: Text("Home Screen"), centerTitle: true, backgroundColor: Colors.deepPurple,),
          body: SafeArea(
            child: Center
              (
              child: Flexible(
                child: Card
                  (
                  child: Padding(
                    padding: const EdgeInsets.all(28.0),
                    child: Column
                      (
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children:
                      [
                        CircleAvatar(child: Container(child: Row(mainAxisAlignment: MainAxisAlignment.center,children: [Image.asset('assets/images.jfif')])),radius: 50, ),
                        SizedBox(height: 10,),
                        Text("Yogesh Purnviaragi", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white)),
                        SizedBox(height: 10,),
                        Text("Enr No. : 12345", style:  TextStyle(color: Colors.white),),

                        SizedBox(height: 10,),
                        Text("Course : B.C.A.", style:  TextStyle(color: Colors.white)),

                        SizedBox(height: 10,),
                        Text("Sem : 1", style:  TextStyle(color: Colors.white)),


                      ],


                    ),
                  ),
                ),
              ),
            ),
          ),
      ),
    );
  }

  LightTheme()
  {
    return Scaffold
      (
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text("Home Screen"), centerTitle: true, backgroundColor: Colors.blue.shade50,),
      body: SafeArea(
        child: Center
          (
          child: Flexible(
            child: Card
              (
              child: Padding(
                padding: const EdgeInsets.all(28.0),
                child: Column
                  (
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children:
                  [
                    CircleAvatar(child: Container(child: Row(mainAxisAlignment: MainAxisAlignment.center,children: [Image.asset('assets/images.jfif')])),radius: 50, ),
                    SizedBox(height: 10,),
                    Text("Yogesh Purnviaragi", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold,)),
                    SizedBox(height: 10,),
                    Text("Enr No. : 12345"),

                    SizedBox(height: 10,),
                    Text("Course : B.C.A."),

                    SizedBox(height: 10,),
                    Text("Sem : 1"),


                  ],


                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  notifyon() {
    showDialog(context: context, builder: (context) => AlertDialog(title: Text("Notification On"), content: Text("Notification is now On!"), actions: [TextButton(onPressed: () { Navigator.pop(context);}, child: Text("OK"))]));
  }

  notifyoff() {
    showDialog(context: context, builder: (context) => AlertDialog(title: Text("Notification Off"), content: Text("Notification is now Off!"), actions: [TextButton(onPressed: () { Navigator.pop(context);}, child: Text("OK"))]));
  }
}
