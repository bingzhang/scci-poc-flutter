/*
 * Copyright (c) 2019 UIUC. All rights reserved.
 */

import 'package:flutter/material.dart';
import 'package:profile_demo/ui/widgets/HeaderAppBar.dart';
import 'package:profile_demo/ui/widgets/SearchBar.dart';
import 'package:profile_demo/ui/widgets/TimeAndWhetherHeader.dart';

class StudentEventsPanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: HeaderAppBar(context: context),
        body: Column(crossAxisAlignment:CrossAxisAlignment.start, children:<Widget>[
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
                    Text('ILLINI Women\'s Basketball', style: TextStyle(fontFamily: 'Avenir', fontWeight:FontWeight.w700, fontSize: 16, color: Colors.black87),),
                    Text('The fighting ILLINI are off to a good start this season! Come join us for their home game of the season this Friday at 9pm!',
                      style: TextStyle(fontFamily: 'Avenir', fontWeight:FontWeight.w300, fontSize: 14, color: Colors.black87),
                    ),
                  ],),
                ),
              ])
            )),
            
            Container(height: 1, color: Colors.black26,),
            Container(padding:EdgeInsets.fromLTRB(10, 10, 10, 10), child:
              Text("News + Events", style: TextStyle(fontFamily: 'Avenir', fontWeight: FontWeight.w700, fontSize: 16),)
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

            SearchBar()
          ]));
  }
}
