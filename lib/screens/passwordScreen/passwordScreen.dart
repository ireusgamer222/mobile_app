import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class PasswordEntryScreen extends StatefulWidget {
  @override
  _PasswordEntryScreenState createState() => _PasswordEntryScreenState();
}

class _PasswordEntryScreenState extends State<PasswordEntryScreen> {
  final _passwordController = TextEditingController();
  bool _obscureText = true;
  String finalpassword = "";
  DatabaseReference ref = FirebaseDatabase.instance.ref("password");

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> passwordSetter(String finalpassword) async {
    await ref.set({
      "password": finalpassword,
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    print(finalpassword);
    return Scaffold(
      appBar: AppBar(
        title: Text('Password Entry Screen'),
      ),
      body:
      SizedBox.expand(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.purple, Colors.red],
            ),
          ),


          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Please enter the password key to enter the house\n",style: TextStyle(fontSize: 20,color: Colors.white),),
                TextField(


                  controller: _passwordController,
                  obscureText: _obscureText,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                      filled: true,
                      fillColor: Colors.white,
                    labelStyle: const TextStyle(
                        color: Colors.black
                    ),


                    labelText: 'Password',
                    suffixIcon: IconButton(
                      icon: Icon(_obscureText ? Icons.visibility_off : Icons.visibility),
                      onPressed: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
                const SizedBox(height: 20.0),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,

                      textStyle: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                  onPressed: () {
                    // Validate password (optional)
                    // You can add password validation logic here before storing it.
                    final password = _passwordController.text;
                    // Store the password in your variable
                    setState(() {
                      // Update your variable holding the password here (e.g., a String variable)
                      finalpassword = password;
                      print(finalpassword);
                      passwordSetter(finalpassword);
                    });
                    // Navigate to a different screen or perform other actions
                  },
                  child: const Text('Submit'),
                ),
              ],
            ),
          ) ,
        ),
      ),


    );
  }
}