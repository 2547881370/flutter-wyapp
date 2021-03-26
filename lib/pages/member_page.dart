import "package:flutter/material.dart";

class MemberPage extends StatefulWidget {
  @override
  _MemberPageState createState() => _MemberPageState();
}

class _MemberPageState extends State<MemberPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:Text("1111")),
      body: Container(
          child: Row(
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(color: Colors.orange),
              ),),
              InkWell(
                onTap: (){print("111");},
                child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(color: Colors.black),
              ),
              )
          ],),
        ),
    );
  }
}