/*
 * Copyright (c) 2019 UIUC. All rights reserved.
 */

import 'package:flutter/material.dart';
import 'package:profile_demo/ui/widgets/HeaderAppBar.dart';
import 'package:profile_demo/ui/widgets/RibbonButton.dart';
import 'package:profile_demo/ui/widgets/SearchBar.dart';
import 'package:profile_demo/ui/widgets/TimeAndWhetherHeader.dart';

class StudentUpToDateInfoPanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: HeaderAppBar(context: context),

          body:Column(crossAxisAlignment:CrossAxisAlignment.start, children:<Widget>[
            Expanded(child:Container(padding:EdgeInsets.fromLTRB(10, 10, 10, 0),
              decoration: BoxDecoration(image: new DecorationImage(
                image: AssetImage("images/header_about.jpg", ),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.2), BlendMode.dstATop)
              ),),
              child: Column(children: <Widget>[
                TimeAndWhetherHeader(),
                Expanded(child:Row()),
                Container(
                  margin: EdgeInsets.only(top:10),
                  padding:EdgeInsets.fromLTRB(10, 10, 10, 10),
                  decoration: new BoxDecoration(
                    color: Colors.white, //new Color.fromRGBO(255, 0, 0, 0.0),
                    borderRadius: new BorderRadius.only(
                      topLeft:  const  Radius.circular(10.0),
                      topRight: const  Radius.circular(10.0))
                  ),
                  child: Column(crossAxisAlignment:CrossAxisAlignment.start, children: <Widget>[
                    Row(crossAxisAlignment:CrossAxisAlignment.end, children: <Widget>[
                      Expanded(child: Column(),),
                      Column(children: <Widget>[
                        Image.asset('images/icon-walk.png', width: 42, height: 42, fit: BoxFit.cover),
                        Text('5min from you', style: TextStyle(fontFamily: 'Avenir', fontWeight:FontWeight.w300, fontSize: 12, color: Colors.black87, ),)
                      ],),
                      Container(width: 20),
                      Column(children: <Widget>[
                        Image.asset('images/icon-time.png', width: 42, height: 42, fit: BoxFit.cover),
                        Text('10 min', style: TextStyle(fontFamily: 'Avenir', fontWeight:FontWeight.w300, fontSize: 12, color: Colors.black87, ),)
                      ],),
                    ],),
                    Container(height: 20),
                    Text('Beckman Institute Cafe', style: TextStyle(fontFamily: 'Avenir', fontWeight:FontWeight.w700, fontSize: 16, color: Colors.black87),),
                    Text('Today launch special is Red Chicken Curry! The menu also features a made to order sandwich, hot soups, and fresh salds.',
                      style: TextStyle(fontFamily: 'Avenir', fontWeight:FontWeight.w300, fontSize: 14, color: Colors.black87),
                    ),
                  ],),
                ),
              ])
            )),
            
            Container(padding:EdgeInsets.fromLTRB(10, 10, 10, 10), child:
              Text("Driving Options Nearby", style: TextStyle(fontFamily: 'Avenir', fontWeight: FontWeight.w700, fontSize: 16),)
            ),
            
            Container(height: 1, color: Colors.black26,),
            Container(height: 84, padding:EdgeInsets.fromLTRB(10, 10, 10, 10), child:
              ListView(scrollDirection: Axis.horizontal, children: <Widget>[
                Image.asset('images/icon-option-placeholder.png', width: 64, height: 64, fit: BoxFit.cover),
                Container(width: 10),
                Image.asset('images/icon-option-placeholder.png', width: 64, height: 64, fit: BoxFit.cover),
                Container(width: 10),
                Image.asset('images/icon-option-placeholder.png', width: 64, height: 64, fit: BoxFit.cover),
                Container(width: 10),
                Image.asset('images/icon-option-placeholder.png', width: 64, height: 64, fit: BoxFit.cover),
                Container(width: 10),
                Image.asset('images/icon-option-placeholder.png', width: 64, height: 64, fit: BoxFit.cover),
                Container(width: 10),
                Image.asset('images/icon-option-placeholder.png', width: 64, height: 64, fit: BoxFit.cover),
                Container(width: 10),
                Image.asset('images/icon-option-placeholder.png', width: 64, height: 64, fit: BoxFit.cover),
              ],)
            ),

            Container(height: 1, color: Colors.black26,),
            RibbonButton(title: 'Assignments Due Next',),
            Container(height: 1, color: Colors.black26,),
            RibbonButton(title: "Today's Schedule",),
            SearchBar()
          ])
        );
  }
}
