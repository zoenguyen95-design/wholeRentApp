import 'package:flutter/material.dart';
import 'package:project_faceid3/pages/widgets/header_widget.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      //Header's style
      appBar: AppBar(
        title: Text("Home",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        elevation: .5,
        iconTheme: IconThemeData(color: Colors.white),
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight,
                  colors: <Color>[Theme.of(context).primaryColor, Theme.of(context).accentColor,]
              )
          ),
        ),
        actions:[
          Container(
            margin: EdgeInsets.only(top:16, right:16),
            child: Stack(
              children: <Widget>[
                Icon(Icons.notifications),
                Positioned(
                  right: 0,
                  child: Container(
                    padding: EdgeInsets.all(1),
                    decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(6),),
                    constraints: BoxConstraints(minHeight: 12, minWidth: 12,),
                    child: Text('5', style: TextStyle(color: Colors.white, fontSize: 8,), textAlign: TextAlign.center,),
                  ),
                )
              ],
            ),
          )
        ],
      ),
//--Off header'style

      body:SingleChildScrollView(
      child: Stack(
    children: [
    Container(height: 100, child:HeaderWidget(100,false,Icons.house_sharp),),
    Container(alignment: Alignment.center,
    margin: EdgeInsets.fromLTRB(25,10,25,10),
    padding: EdgeInsets.fromLTRB(10,0,10,0),



),
      ],
    ),
      ),
    );





  }
}
