import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import "dart:math";
import "package:flutter/services.dart";
//import "money_color.dart";

void main() => runApp(MaterialApp(
  home: Monopoly(),
));

class Monopoly extends StatefulWidget {
  @override
  _MonopolyState createState() => _MonopolyState();
}


class _MonopolyState extends State<Monopoly> {
  var amount = 0;
  Random random = Random();
  var randomNumber = 0;
  Color _color = Colors.white;
  var selected = 0;
  var selectedCard;

  List<String> chance = [
  "Advance to Go (Collect \$200)",
  "Advance token to nearest Utility. If unowned, you may buy it from the Bank. If owned, throw dice and pay owner a total ten times the amount thrown.",
  "Advance token to the nearest Railroad and pay owner twice the rental to which he/she {he} is otherwise entitled. If Railroad is unowned, you may buy it from the Bank.",
  "Get Out of Jail Free",
  "Go Back 3 Spaces",
  "Go to Jail–Go directly to Jail–Do not pass Go, do not collect \$200",
  "You have been elected Chairman of the Board–Pay each player \$50",
  "Make general repairs on all your property–For each house pay \$25–For each hotel \$100",
  "Your building and loan matures—Collect \$150",
  "Pay poor tax of \$15",
  "Bank pays you dividend of \$50",
  "Take a trip to Reading Railroad–If you pass Go, collect \$200",
  "Take a walk on the Boardwalk–Advance token to Boardwalk",
  "You have won a crossword competition—Collect \$100",
  "Advance to Illinois Ave—If you pass Go, collect \$200",
  "Advance to St. Charles Place – If you pass Go, collect \$200",
  ];

  List<String> chest = [
  "Advance to Go (Collect \$200)",
  "Bank error in your favor—Collect \$200",
  "Doctor's fee—Pay \$50",
  "Get Out of Jail Free",
  "From sale of stock you get \$50",
  "Go to Jail–Go directly to Jail–Do not pass Go, do not collect \$200",
  "It is your birthday—Collect \$10",
  "Holiday Fund matures—Receive \$100",
  "Income tax refund–Collect \$20",
  "Life insurance matures–Collect \$100",
  "Pay hospital fees of \$100",
  "Pay school fees of \$150",
  "Receive \$25 consultancy fee",
  "You are assessed for street repairs–\$40 per house–\$115 per hotel",
  "You have won second prize in a beauty contest–Collect \$10",
  "You inherit \$100",
  ];


  void _colorShifter(){
//    if (amount<=0){
//      amount = 0;
//    }
    if (amount<=-1){
      _color = Colors.red;
    }
    if ((amount<=4) & (amount>=0)){
      _color = Colors.white;
    }
    if ((amount>=5) & (amount<=9)){
      _color = Colors.pink[100];
    }
    if ((amount>=10) & (amount<=19)){
      _color = Colors.cyan[200];
    }
    if ((amount>=20) & (amount<=49)){
      _color = Colors.lightGreen[300];
    }
    if ((amount>=50) & (amount<=99)){
      _color = Colors.purple[200];
    }
    if ((amount>=100) & (amount<=499)){
      _color = Colors.amberAccent;
    }
    if (amount>=500){
      _color = Colors.orange;
    }
  }


  void _settingModalBottomSheet(context){
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc){
          return Container(
            child: Wrap(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    TextField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          icon: Icon(Icons.attach_money),
                          labelText: 'Enter an integer:',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),)
                      ),
                      onSubmitted: (val) {
                        print("$val");
                        selected = int.parse(val);
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text(
                            "Deposit:",
                            style: TextStyle(
                                fontFamily: "Rye",
                                fontSize: 20
                            )
                        ),
                        IconButton(
                          onPressed: (){
                            print("Deposit");
                            setState(() {
                              amount += selected;
                              _colorShifter();
                            });
                            },
                          icon: Icon(Icons.add_circle),
                          color: Colors.green,
                          iconSize: 60,
                        ),
                        IconButton(
                          onPressed: (){
                            print("Withdraw");
                            setState(() {
                              amount -= selected;
                              _colorShifter();
                            });
                            },
                          icon: Icon(Icons.remove_circle),
                          color: Colors.red,
                          iconSize: 60,
                        ),
                        Text(
                            ":Withdraw",
                            style: TextStyle(
                                fontFamily: "Rye",
                                fontSize: 20
                            )
                        ),
                      ],
                    ),
                    Text(
                        "Standard Operations",
                        style: TextStyle(
                        fontFamily: "Rye",
                        fontSize: 30
                    )
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        ButtonTheme(
                          minWidth: 30,
                          height: 100,
                          child: RaisedButton(
                            padding: EdgeInsets.all(10),
                            onPressed: (){
                              print("Go trough start - get 200");
                              setState(() {
                                amount += 200;
                                _colorShifter();
                              });
                            },
                            color: Colors.yellowAccent,
                            elevation: 10,
                            child: Text("Start - get 200"),
                          ),
                        ),
                        ButtonTheme(
                          minWidth: 30,
                          height: 100,
                          child: RaisedButton(
                            onPressed: (){
                              print("Tax - lose 100");
                              setState(() {
                                amount -= 100;
                                _colorShifter();
                              });
                            },
                            color: Colors.red,
                            elevation: 10,
                            child: Text("Tax - lose 100"),
                          ),
                        ),
                        ButtonTheme(
                          minWidth: 30,
                          height: 100,
                          child: RaisedButton(
                            onPressed: (){
                              print("Tax - lose 200");
                              setState(() {
                                amount -= 200;
                                _colorShifter();
                              });
                            },
                            color: Colors.red,
                            elevation: 10,
                            child: Text("Tax - lose 200"),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 100,
                    ),
                  ],
                ),
              ],
            ),
          );
        }
    ).whenComplete(() {
      selected = 0;
    });
  }


  void _chanceModalBottomSheet(context){
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc){
          return Container(
            color: Colors.grey,
            padding: EdgeInsets.all(10),
            child: Card(
              margin: EdgeInsets.all(20),
                child: Container(
                  padding: EdgeInsets.all(20),
                    child: Text(
                        "$selectedCard",
                      style: TextStyle(
                        fontFamily: "Rye"
                      ),
                    )
                )
            ),
          );
        }
    ).whenComplete(() {
    });
  }


  void _communityModalBottomSheet(context){
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc){
          return Container(
            color: Colors.grey,
            padding: EdgeInsets.all(10),
            child: Card(
                margin: EdgeInsets.all(20),
                child: Container(
                    padding: EdgeInsets.all(20),
                    child: Text(
                      "$selectedCard",
                      style: TextStyle(
                          fontFamily: "Rye"
                      ),
                    )
                )
            ),
          );
        }
    ).whenComplete(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[600],
        centerTitle: true,
        title: Text(
          "Monopoly Manager",
          style: TextStyle(
          fontFamily: "Rye",
          fontSize: 30
          )),
      ),
      body: Builder(builder: (context){
        return Container(
          color: Colors.grey[800],
          height: 1000,
          child: Container(
            margin: EdgeInsets.all(10),
            child: Stack(
              children: <Widget>[
                GestureDetector(
                  onTap: (){
                    _settingModalBottomSheet(context);
                    //_color = Color.fromRGBO(_rng.nextInt(256), _rng.nextInt(256), _rng.nextInt(256), 1);
                  },
                  child: Container(
                    width: 330,
                    height: 160,
                    color: Colors.grey[800],
                    child: Card(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                        elevation: 10,
                        color: this._color,
                        child: Stack(
                          children: <Widget>[
                            Image.asset("assets/monopoly-money-template_alpha.png",),
                            Container(
                                margin: EdgeInsets.fromLTRB(90, 55, 1, 1),
                                //color: Colors.red,
                                width: 140,
                                height: 50,
                                child: Text(
                                  "$amount",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontFamily: "Rye",
                                      fontSize: 40
                                  ),
                                )
                            ),
                            Container(
                                margin: EdgeInsets.fromLTRB(235, 100, 1, 1),
                                //color: Colors.blue,
                                width: 55,
                                height: 20,
                                child: Text(
                                  "$amount",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontFamily: "Rye",
                                      fontSize: 15
                                  ),
                                )
                            ),
                            Container(
                                margin: EdgeInsets.fromLTRB(30, 33, 1, 1),
                                //color: Colors.yellow,
                                width: 55,
                                height: 20,
                                child: Text(
                                  "$amount",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontFamily: "Rye",
                                      fontSize: 15
                                  ),
                                )
                            ),
                          ],
                        )
                    ),
                  ),),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    GestureDetector(
                      onTap: (){
                        //print("chance");
                        //SnackBar mysnackbar = SnackBar(content: Text("Chance!"), duration: Duration(milliseconds: 500),);
                        //Scaffold.of(context).showSnackBar(mysnackbar);
                        randomNumber = random.nextInt(16); // from 0 up to 15 included
                        selectedCard = chance[randomNumber];
                        _chanceModalBottomSheet(context);
                      },
                      child: Container(
                        margin: EdgeInsets.fromLTRB(10, 200, 0, 0),
                        //color: Colors.red,
                        width: 100,
                        height: 100,
                        child: Card(
                          elevation: 10,
                          child: Image.asset("assets/chance_question.png"),),
                      ),),
                    GestureDetector(
                      onTap: (){
                        print("community");
                        //SnackBar mysnackbar = SnackBar(content: Text("Community!"), duration: Duration(milliseconds: 500),);
                        //Scaffold.of(context).showSnackBar(mysnackbar);
                        randomNumber = random.nextInt(16); // from 0 up to 15 included
                        selectedCard = chest[randomNumber];
                        _communityModalBottomSheet(context);
                      },
                      child: Container(
                        margin: EdgeInsets.fromLTRB(10, 200, 0, 0),
                        //color: Colors.red,
                        width: 100,
                        height: 100,
                        child: Card(
                          elevation: 10,
                          child: Image.asset("assets/community_chest.jpg"),),),),
                  ],
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(50, 350, 50, 50),
                  color: Colors.grey,
                  child: Image.asset("assets/jail_free.png"),
                ),
              ],
            ),
          ),
        );
      },)
    );
    }
    }



