import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var city ="";
  var temp = 273.0;
  var info;
  var icon;
  var descripton;
  bool isPressed = false;
  late var url = Uri.parse(
      'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=6781fa5c05e2baf86c25084f7c76a95d');

  Future callWeather() async {
    try {
      var response = await http.get(url);
      if (response.statusCode== 200) {
        var result = jsonDecode(response.body);
        setState(() {
          temp = result['main']['temp'];
          info = result['weather'][0]['main'];
          descripton = result['weather'][0]['description'];
          icon = result['weather'][0]['icon'];
        });
      } else {
        print(response.statusCode);
      }
    } catch (e) {
      print(e.toString());
    }
  }
  void changeCity(String cty){
    setState(() {
      city = cty;

    });
  }
  void changeUrl(cty){
    setState(() {
      url =Uri.parse(
          'https://api.openweathermap.org/data/2.5/weather?q=$cty&appid=6781fa5c05e2baf86c25084f7c76a95d');
    });
  }


  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: TextField(
                    onChanged: (newText) {
                      setState(() {
                        changeCity(newText);
                        changeUrl(newText);
                      });
                    },
                    cursorColor: Colors.green,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      hintText: 'Search City',
                      suffixIcon: FloatingActionButton(onPressed:(){
                        callWeather();
                        isPressed = true;
                      },
                        child: Icon(Icons.search,size: 40,),),
                      fillColor: Colors.white,
                      filled: true,
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                Container(
                  width: double.infinity,
                  height: height / 4,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        city,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 33,
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                       Text(
                        '${(temp-273).toStringAsFixed(2)} °C',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 33,
                        ),
                       ),
                    ],
                  ),
                ),

                Text('${info}',style: TextStyle(color: Colors.white,fontSize: 25),),
                SizedBox(height: 20,),
                Text('$descripton',style: TextStyle(color: Colors.white,fontSize: 25,),),
                SizedBox(height: 20,),
                isPressed ? Image.network('http://openweathermap.org/img/wn/$icon@2x.png'):SizedBox(),



                SizedBox(height: 20,),




              ],
            ),
          ),
        ),
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(
                'https://images.unsplash.com/photo-1603041592657-0709d7796f44?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Nnx8cmFpbnl8ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60',
              ),
              fit: BoxFit.cover),
        ),
      ),
    );
  }
}
