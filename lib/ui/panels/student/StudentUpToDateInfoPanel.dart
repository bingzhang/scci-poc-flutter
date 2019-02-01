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
//        body: Column(
//          children: <Widget>[Text('Slide 7 right panel')],
//        )

//        body:Column(children:<Widget>[Expanded(child:
//            Container(color: Colors.red)
//        )])

          body:Column(crossAxisAlignment:CrossAxisAlignment.start, children:<Widget>[
              Expanded(child:Container(padding:EdgeInsets.fromLTRB(10, 10, 10, 0),
                decoration: new BoxDecoration(image: new DecorationImage(
                  image: new AssetImage("images/header_about.jpg", ),
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
                          Text('5min from you', style: TextStyle(color: Colors.black45),)
                        ],),
                        Container(width: 20),
                        Column(children: <Widget>[
                          Image.asset('images/icon-time.png', width: 42, height: 42, fit: BoxFit.cover),
                          Text('10 min', style: TextStyle(color: Colors.black45),)
                        ],),
                      ],),
                      Container(height: 20),
                      Text('Beckman Institute Cafe', style: TextStyle(fontWeight:FontWeight.w600, fontSize: 16, color: Colors.black87),),
                      Text('Today launch special is Red Chicken Curry! The menu also features a made to order sandwich, hot soups, and fresh salds.',
                        style: TextStyle(fontWeight:FontWeight.w300, fontSize: 14, color: Colors.black54),
                      ),

                    ],),
                  ),



                ])
              )),
              Container(padding:EdgeInsets.fromLTRB(10, 10, 10, 10), child:
                Text("Driving Options Nearby", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),)
              ),
              Container(height: 1, color: Colors.black26,),
              Container(padding:EdgeInsets.fromLTRB(10, 10, 10, 10), child:
                //ListView(scrollDirection: Axis.horizontal, children: <Widget>[
                Row(children: <Widget>[
                  Container(padding: EdgeInsets.only(right: 10), child:Image.asset('images/icon-option-placeholder.png', width: 64, height: 64, fit: BoxFit.cover)),
                  Container(padding: EdgeInsets.only(right: 10), child:Image.asset('images/icon-option-placeholder.png', width: 64, height: 64, fit: BoxFit.cover)),
                  Container(padding: EdgeInsets.only(right: 10), child:Image.asset('images/icon-option-placeholder.png', width: 64, height: 64, fit: BoxFit.cover)),
                  Container(padding: EdgeInsets.only(right: 10), child:Image.asset('images/icon-option-placeholder.png', width: 64, height: 64, fit: BoxFit.cover)),
                  Container(padding: EdgeInsets.only(right: 10), child:Image.asset('images/icon-option-placeholder.png', width: 64, height: 64, fit: BoxFit.cover)),
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
