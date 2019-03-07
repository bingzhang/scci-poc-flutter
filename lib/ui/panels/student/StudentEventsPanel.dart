/*
 * Copyright (c) 2019 Illinois. All rights reserved.
 */

import 'package:flutter/material.dart';
import 'package:profile_demo/lang/locale/locales.dart';
import 'package:profile_demo/ui/panels/EventsPanel.dart';
import 'package:profile_demo/ui/widgets/HeaderAppBar.dart';
import 'package:profile_demo/ui/widgets/SearchBar.dart';
import 'package:profile_demo/ui/widgets/TimeAndWhetherHeader.dart';
import 'package:profile_demo/ui/widgets/ReadMore.dart';

class StudentEventsPanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AppLocalizations str = AppLocalizations.of(context);
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
                  padding:EdgeInsets.fromLTRB(10, 10, 10, 5),
                  decoration: BoxDecoration(
                    color: Colors.white, //new Color.fromRGBO(255, 0, 0, 0.0),
                    borderRadius: BorderRadius.only(
                      topLeft:  const  Radius.circular(10.0),
                      topRight: const  Radius.circular(10.0))
                  ),
                  child: Column(crossAxisAlignment:CrossAxisAlignment.start, children: <Widget>[
                    Text(str.studentEventTitle, style: TextStyle(fontFamily: 'Avenir', fontWeight:FontWeight.w700, fontSize: 16, color: Colors.black87),),
                    Text(str.studentEventContentMessage, style: TextStyle(fontFamily: 'Avenir', fontWeight:FontWeight.w300, fontSize: 14, color: Colors.black87),
                    ),
                    ReadMore(),
                  ],),
                ),
              ])
            )),

            Container(height: 1, color: Colors.black26,),
            Container(padding: EdgeInsets.fromLTRB(10, 10, 10, 10), child:
            InkWell(
              onTap: () =>
                  Navigator.push(context,
                      MaterialPageRoute(
                          builder: (context) =>
                              EventsPanel(title: str.studentEventsHeader))),
              child: Row(children: <Widget>[Text(str.studentHomeButtonNewsEvent,
                style: TextStyle(fontFamily: 'Avenir',
                    fontWeight: FontWeight.w700,
                    fontSize: 16),)
              ],),)
            ),

            Container(height: 1, color: Colors.black26,),
            Container(height: 84, padding:EdgeInsets.fromLTRB(10, 10, 10, 10), child:
              ListView(scrollDirection: Axis.horizontal, children: <Widget>[
                Container(width: 64.0, height: 64.0, decoration: new BoxDecoration(shape: BoxShape.circle, image: DecorationImage(fit: BoxFit.cover, image:
                    NetworkImage("https://www.washingtonpost.com/resizer/yUycUqygEvxLzyR2zwgzkpKzyEw=/480x0/arc-anglerfish-washpost-prod-washpost.s3.amazonaws.com/public/2OAGYJTUJY2H5I6I7HCD6O7S2Q.jpg")
                ))),
                Container(width: 10),
                Container(width: 64.0, height: 64.0, decoration: new BoxDecoration(shape: BoxShape.circle, image: DecorationImage(fit: BoxFit.cover, image:
                    NetworkImage("https://comps.canstockphoto.com/two-great-tits-stock-photography_csp34174302.jpg")
                ))),
                Container(width: 10),
                Container(width: 64.0, height: 64.0, decoration: new BoxDecoration(shape: BoxShape.circle, image: DecorationImage(fit: BoxFit.cover, image:
                    NetworkImage("https://upload.wikimedia.org/wikipedia/commons/1/16/Yellow-billed_oxpeckers_%28Buphagus_africanus_africanus%29_on_zebra.jpg")
                ))),
                Container(width: 10),
                Container(width: 64.0, height: 64.0, decoration: new BoxDecoration(shape: BoxShape.circle, image: DecorationImage(fit: BoxFit.cover, image:
                    NetworkImage("https://previews.123rf.com/images/ondrejprosicky/ondrejprosicky1801/ondrejprosicky180100950/93506859-three-songbird-garden-bird-great-tit-parus-major-black-and-yellow-songbird-sitting-on-the-nice-liche.jpg")
                ))),
                Container(width: 10),
                Container(width: 64.0, height: 64.0, decoration: new BoxDecoration(shape: BoxShape.circle, image: DecorationImage(fit: BoxFit.cover, image:
                    NetworkImage("https://static01.nyt.com/images/2018/02/17/science/17TB-COFFEE6/17TB-COFFEE6-articleLarge.jpg?quality=75&auto=webp&disable=upscale")
                ))),
                Container(width: 10),
                Container(width: 64.0, height: 64.0, decoration: new BoxDecoration(shape: BoxShape.circle, image: DecorationImage(fit: BoxFit.cover, image:
                    NetworkImage("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQRFW3WuP0j5Mx1wc8rdT9whUht5ei0bmGnNDeeAj8_KKkfJVv2")
                ))),
                Container(width: 10),
                Container(width: 64.0, height: 64.0, decoration: new BoxDecoration(shape: BoxShape.circle, image: DecorationImage(fit: BoxFit.cover, image:
                    NetworkImage("https://comps.canstockphoto.com/two-beautiful-great-tits-stock-photography_csp43424306.jpg")
                ))),
                Container(width: 10),
                Container(width: 64.0, height: 64.0, decoration: new BoxDecoration(shape: BoxShape.circle, image: DecorationImage(fit: BoxFit.cover, image:
                    NetworkImage("http://nm.audubon.org/sites/g/files/amh686/f/styles/engagement_card/public/swfl_singing_kelly_colgan_azar.jpg?itok=CDYHanhb")
                ))),
              ],)
            ),
            SearchBar()
          ]));
  }
}


