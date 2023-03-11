import 'package:flutter/material.dart';


final Widget imageExample = Column(
  children: [
    const Padding(
      padding:  EdgeInsets.all(8.0),
      child: Text('NetworkImage Example'),
    ),
    Image.network('http://i.pravatar.cc/300'),
    const Padding(
      padding:  EdgeInsets.all(8.0),
      child: Text('AssetImage Example'),
    ),
    SizedBox(
      height: 70,
      child: Image.asset('assets/logo.png'),
      ),
  ],
);