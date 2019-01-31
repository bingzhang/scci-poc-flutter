/*
 * Copyright (c) 2019 UIUC. All rights reserved.
 */

import 'package:flutter/material.dart';
import 'package:profile_demo/ui/widgets/HeaderAppBar.dart';

class StudentCampusPanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: HeaderAppBar(context: context),
//        body: Column(
//          children: <Widget>[Text('Slide 7 right panel')],
//        )

//        body:Column(children:<Widget>[Expanded(child:
//            Container(color: Colors.red)
//        )])

          body:Column(crossAxisAlignment:CrossAxisAlignment.start, children:<Widget>[
              Container(padding:EdgeInsets.fromLTRB(10, 10, 10, 0), child:
                Row(children: <Widget>[
                  Column(crossAxisAlignment:CrossAxisAlignment.start, children:<Widget>[
                    Text("Tuesday, January 29th", style: TextStyle(fontWeight:FontWeight.w600, fontSize: 12, color: Colors.black87),),
                    Text("11:20 am", style: TextStyle(fontWeight:FontWeight.w300, fontSize: 26, color: Colors.black87)),
                  ]),
                  Expanded(child:Column()),
                  Column(children:<Widget>[
                    Image.asset('images/icon-weather.png', width: 42, height: 42, fit: BoxFit.cover),
                    Text("43°F", style: TextStyle(color: Colors.black45),),
                  ]),
                ],),
              ),
              Expanded(child:Row()),
              Container(height: 1, color: Colors.black45,),
              Container(padding:EdgeInsets.fromLTRB(10, 20, 10, 20), child:
                Text("Assignments Due Next", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),)
              ),
              Container(height: 1, color: Colors.black45,),
              Container(padding:EdgeInsets.fromLTRB(10, 20, 10, 20), child:
                Text("Today's Schedule", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),)
              ),
              Container(padding:EdgeInsets.fromLTRB(10, 10, 10, 15), color: Colors.black26 , child:
                Row(children: <Widget>[
                  Image.asset('images/icon-settings.png', width: 42, height: 42, fit: BoxFit.cover),
                  Expanded(child:Column()),
                  Image.asset('images/icon-search.png', width: 42, height: 42, fit: BoxFit.cover),
                ])
              )
            ])
        );
  }
}
