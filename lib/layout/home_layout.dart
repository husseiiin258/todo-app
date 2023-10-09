import 'package:flutter/material.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({super.key});
  static const String routeName = "home_layout";

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xFFDFECDB),
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                padding: EdgeInsets.only(left: 35, top: 55),
                width: mediaQuery.width,
                color: const Color(0xFF5D9CEC),
                height: 170,
                child: const Text(
                  "TO DO LIST",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
         const SizedBox(
            height: 80,
          ),
          Container(

            margin: EdgeInsets.symmetric(horizontal: 40),
            width: mediaQuery.width,
            height: 100,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12)
            ),
            child: Expanded(
              child: Row(
                children: [
                  VerticalDivider(
                    width: 30,
                    thickness: 3,
                    color: Color(0xFF5D9CEC),
                    endIndent: 13,
                    indent: 13,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20 , left: 20),
                    child: Column(

                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Play Basketball" , style:
                          TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color:  Color(0xFF5D9CEC),
                          ) , ),
                        Container(
                          margin: EdgeInsets.only(top: 10 ),
                          child: Row(
                           mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(Icons.alarm_outlined) , 
                              Text("   10:30 AM" ,style:
                                TextStyle(fontSize: 16),)
                            ],
                          ),
                        )
                      ],
                    ),
                  ) , Expanded(child:  Container(
                    margin:EdgeInsets.only(left: 40 , right: 10) ,
                    width: 70,
                    height: 40,
                    child: Image.asset("assets/images/Group 10.png",
                      fit: BoxFit.fill,),
                  ))

                ],
              ),
            ),
          )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(items: [
        BottomNavigationBarItem(icon: Icon(Icons.menu) , label: "menu") ,
        BottomNavigationBarItem(icon: Icon(Icons.settings) , label: "settings"),
      ]),
    );
  }
}
