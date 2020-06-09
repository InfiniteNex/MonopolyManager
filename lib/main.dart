//import 'dart:html';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import "package:flutter/services.dart";

var opponents = 1; // AT LEAST 1 OPPONENT BY DEFAULT
var possessedHouses = 0;
var possessedHotels = 0;
bool jailCard = false;
Color _jailColor = Colors.grey[800];


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
    "Advance token to nearest Utility. If unowned, you may buy it from the Bank. If owned, throw dice and pay owner a total ten times the amount thrown.", //TODO add function
    "Advance token to the nearest Railroad and pay owner twice the rental to which he/she {he} is otherwise entitled. If Railroad is unowned, you may buy it from the Bank.", //TODO add function
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




  void _chanceDirectBanking(){
    if (randomNumber == 0){
      amount += 200;
    }
    else if (randomNumber == 6) {
      amount -= (50*opponents);
    }
    else if (randomNumber == 7){
      amount -= (25*possessedHouses)+(100*possessedHotels);
    }
    else if (randomNumber == 8){
      amount += 150;
    }
    else if (randomNumber == 9){
      amount -= 15;
    }
    else if (randomNumber == 10){
      amount += 50;
    }
    else if (randomNumber == 13){
      amount += 100;
    }
  }


  void _chestDirectBanking(){
    if (randomNumber == 0){
      amount += 200;
    }
    if (randomNumber == 1){
      amount += 200;
    }
    if (randomNumber == 2){
      amount -= 50;
    }
    if (randomNumber == 3){
      print("Jail Free card collected");
    }
    if (randomNumber == 4){
      amount += 50;
    }
    if (randomNumber == 6){
      amount += 10;
    }
    if (randomNumber == 7){
      amount += 100;
    }
    if (randomNumber == 8){
      amount += 20;
    }
    if (randomNumber == 9){
      amount += 100;
    }
    if (randomNumber == 10){
      amount -= 100;
    }
    if (randomNumber == 11){
      amount -= 150;
    }
    if (randomNumber == 12){
      amount += 25;
    }
    if (randomNumber == 13){
      amount -= (40*possessedHouses)+(115*possessedHotels);
    }
    if (randomNumber == 14){
      amount += 10;
    }
    if (randomNumber == 15){
      amount += 100;
    }
    _colorShifter();
  }


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


  void _moneyModalBottomSheet(context){
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
                            //print("Deposit");
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
                            //print("Withdraw");
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
                              //print("Go trough start - get 200");
                              setState(() {
                                amount += 200;
                                _colorShifter();
                              });
                            },
                            color: Colors.yellowAccent,
                            elevation: 10,
                            child: Column(
                              children: <Widget>[
                                Text("Pass Start",
                                    style: TextStyle(
                                        fontFamily: "Rye",
                                        fontSize: 15
                                    )),
                                Text("Get \$200",
                                    style: TextStyle(
                                        fontFamily: "Rye",
                                        fontSize: 15
                                    )),
                              ],
                            ),
                          ),
                        ),
                        ButtonTheme(
                          minWidth: 30,
                          height: 100,
                          child: RaisedButton(
                            onPressed: (){
                              //print("Tax - lose 100");
                              setState(() {
                                amount -= 100;
                                _colorShifter();
                              });
                            },
                            color: Colors.red,
                            elevation: 10,
                            child: Column(
                              children: <Widget>[
                                Text("Tax",
                                    style: TextStyle(
                                        fontFamily: "Rye",
                                        fontSize: 15
                                    )),
                                Text("Pay \$100",
                                    style: TextStyle(
                                        fontFamily: "Rye",
                                        fontSize: 15
                                    )),
                              ],
                            ),
                          ),
                        ),
                        ButtonTheme(
                          minWidth: 30,
                          height: 100,
                          child: RaisedButton(
                            onPressed: (){
                              //print("Tax - lose 200");
                              setState(() {
                                amount -= 200;
                                _colorShifter();
                              });
                            },
                            color: Colors.red,
                            elevation: 10,
                            child: Column(
                              children: <Widget>[
                                Text("Tax",
                                    style: TextStyle(
                                        fontFamily: "Rye",
                                        fontSize: 15
                                    )),
                                Text("Pay \$200",
                                    style: TextStyle(
                                        fontFamily: "Rye",
                                        fontSize: 15
                                    )),
                              ],
                            ),
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


  _dynamicChance() {
    if (randomNumber == 3){
      print("Jail Free card collected");
      _jailColor = Colors.white;
      return Text("");
    }
    else if (randomNumber == 6) {
      var temp = (50*opponents);
      return Text("Amount payed to opponents: $temp");
    }
    else if (randomNumber == 7){
      var temp = (25*possessedHouses)+(100*possessedHotels);
      return Text("Amount payed: $temp");
    }
    else if (randomNumber == 11){
      return RaisedButton(
        onPressed: (){
          setState(() {
            Navigator.pop(context);
            amount += 200;
          });
        },
        child: Text(
          "Pass through start - get \$200",
          style: TextStyle(
              fontFamily: "Rye",
              fontSize: 20
          ),
        ),
      );
    }
    else if (randomNumber == 14){
      return RaisedButton(
        onPressed: (){
          setState(() {
            Navigator.pop(context);
            amount += 200;
          });
        },
        child: Text(
          "Pass through start - get \$200",
          style: TextStyle(
              fontFamily: "Rye",
              fontSize: 20
          ),
        ),
      );
    }
    else if (randomNumber == 15){
      return RaisedButton(
        onPressed: (){
          setState(() {
            Navigator.pop(context);
            amount += 200;
          });
        },
        child: Text(
          "Pass through start - get \$200",
          style: TextStyle(
              fontFamily: "Rye",
              fontSize: 20
          ),
        ),
      );
    }
    else {
      return Text("");
    }
  }


  _dynamicChest() {
    if (randomNumber == 3){
      print("Jail Free card collected");
      _jailColor = Colors.white;
      return Text("");
    }
    else if (randomNumber == 13){
      var temp = (40*possessedHouses)+(115*possessedHotels);
      return Text("Amount payed: $temp");
    }
    else {
      return Text("");
    }
  }


  void _chanceModalBottomSheet(dynamic){
    showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.grey,
        context: context,
        builder: (BuildContext bc){
          return Wrap(
            children: <Widget>[
              Container(
                color: Colors.grey,
                padding: EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Card(
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
                  _dynamicChance(),
                ],
              )
          )
            ],
          );
        }
    ).whenComplete(() {
    });
  }


  void _communityModalBottomSheet(dynamic){
    showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.grey,
        context: context,
        builder: (BuildContext bc){
          return Wrap(
            children: <Widget>[
              Container(
                color: Colors.grey,
                padding: EdgeInsets.all(10),
                child: Column(
                  children: <Widget>[
                      Card(
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
                      _dynamicChest()
                    ],
                  )
              )
            ],
          );
        }
    ).whenComplete(() {
    });
  }


  void _housingModalBottomSheet(dynamic){
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext bc){
                return Wrap(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Image.asset("assets/house.png", scale: 2,),
                              Row(
                                children: <Widget>[
                                  IconButton(
                                    onPressed: (){
                                      setState(() {
                                        possessedHouses += 1;
                                      });
                                    },
                                    icon: Icon(Icons.add_circle),
                                    color: Colors.green,
                                    iconSize: 60,
                                  ),
                                  IconButton(
                                    onPressed: (){
                                      setState(() {
                                        if (possessedHouses != 0) {
                                          possessedHouses -= 1;
                                        }
                                      });
                                    },
                                    icon: Icon(Icons.remove_circle),
                                    color: Colors.red,
                                    iconSize: 60,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Column(
                              children: <Widget>[
                                Image.asset("assets/hotel.png", scale: 2,),
                                Row(
                                  children: <Widget>[
                                    IconButton(
                                      onPressed: (){
                                        setState(() {
                                          possessedHotels += 1;
                                        });
                                      },
                                      icon: Icon(Icons.add_circle),
                                      color: Colors.green,
                                      iconSize: 60,
                                    ),
                                    IconButton(
                                      onPressed: (){
                                        setState(() {
                                          if (possessedHotels != 0) {
                                            possessedHotels -= 1;
                                          }
                                        });
                                      },
                                      icon: Icon(Icons.remove_circle),
                                      color: Colors.red,
                                      iconSize: 60,
                                    ),
                                  ],
                                ),
                              ]
                          ),
                        ],
                      ),
                    ),
                  ],
                );
        }
    );//.whenComplete((){});
  }



  
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Scaffold(
        backgroundColor: Colors.grey[800],
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
          return ListView( //MAIN BUILDER COLUMN
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      GestureDetector(
                        onTap: (){
                          _moneyModalBottomSheet(context);
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
                    ],
                  ),
                ],
              ), //MONEY BILL
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  GestureDetector(
                    onTap: (){
                      setState(() {
                        //SnackBar mysnackbar = SnackBar(content: Text("Chance!"), duration: Duration(milliseconds: 500),);
                        //Scaffold.of(context).showSnackBar(mysnackbar);
                        randomNumber = random.nextInt(16); // from 0 up to 15 included
                        selectedCard = chance[randomNumber];
                        _chanceDirectBanking();
                        _chanceModalBottomSheet(context);
                        _colorShifter();
                      });
                    },
                    child: Container(
                      width: 100,
                      height: 100,
                      child: Card(
                        elevation: 10,
                        child: Image.asset("assets/chance_question.png"),),
                    ),),
                  SizedBox(
                    width: 20,
                  ),
                  GestureDetector(
                    onTap: (){
                      setState(() {
                        //SnackBar mysnackbar = SnackBar(content: Text("Community!"), duration: Duration(milliseconds: 500),);
                        //Scaffold.of(context).showSnackBar(mysnackbar);
                        randomNumber = random.nextInt(16); // from 0 up to 15 included
                        selectedCard = chest[randomNumber];
                        _chestDirectBanking();
                        _communityModalBottomSheet(context);
                      });
                    },
                    child: Container(
                      width: 100,
                      height: 100,
                      child: Card(
                        elevation: 10,
                        child: Image.asset("assets/community_chest.jpg"),),),),
                ],
              ), //CHANCE AND CHEST CARDS
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      GestureDetector(
                        child: Container(
                          color: _jailColor,
                          child: Image.asset(
                            "assets/jail_free.png",
                            scale: 1.5,
                          ),
                        ),
                        onTap: (){
                          setState(() {
                            _jailColor = Colors.grey[800];
                          });
                        },
                      ),
                      Text(
                          "Tap when jail card is used up.",
                        style: TextStyle(
                            fontFamily: "Rye",
                            fontSize: 12
                        ),
                      )
                    ],
                  ), //PRISON CARD
                  GestureDetector(
                    onTap: (){
                      setState(() {
//                        SnackBar mysnackbar = SnackBar(content: Text("Future houses and hotels menu"), duration: Duration(milliseconds: 1000),);
//                        Scaffold.of(context).showSnackBar(mysnackbar);
                          _housingModalBottomSheet(context);
                      });
                    },
                    child: Card(
                      child: Row(
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Image.asset("assets/house.png", scale: 2,),
                              Image.asset("assets/hotel.png", scale: 2,),
                            ],
                          ), //HOUSE AND HOTELS
                          Column(
                            children: <Widget>[
                              Text(
                                "$possessedHouses",
                                style: TextStyle(
                                    fontFamily: "Rye",
                                    fontSize: 40
                                ),
                              ),
                              SizedBox(
                                  height: 20
                              ),
                              Text(
                                "$possessedHotels",
                                style: TextStyle(
                                    fontFamily: "Rye",
                                    fontSize: 40
                                ),
                              ),
                            ],
                          ), //HOUSES AND HOTELS VALUES
                        ],
                      ),
                    ),
                  ),
                ],
              ), //PRISON CARD, HOTELS AND HOUSES
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "SETTINGS:",
                    style: TextStyle(
                        fontFamily: "Rye",
                        fontSize: 30
                    ),
                  ),
                ],
              ), //SETTINGS LABEL
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text(
                      "Opponents",
                      style: TextStyle(
                          fontFamily: "Rye",
                          fontSize: 15
                      ),
                    ),
                    Container(
                      color: Colors.white,
                        height: 30,
                        width: 50,
                        padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                        child: DropDownMenu()
                    ),
                    SizedBox(
                      width: 40,
                    ),
                    RaisedButton(
                      color: Colors.redAccent,
                      child: Text(
                        "Reset Game",
                        style: TextStyle(
                            fontFamily: "Rye",
                            fontSize: 15
                        ),
                      ),
                      onPressed: (){
                        setState(() {
                          amount = 0;
                          _colorShifter();
                          //opponents = 1; // AT LEAST 1 OPPONENT BY DEFAULT
                          possessedHouses = 0;
                          possessedHotels = 0;
                          _jailColor = Colors.grey[800];
                        });
                      },
                    )
                  ],
                ),
              ), //SETTINGS
            ],
          );
        },)
    );
  }
}



class DropDownMenu extends StatefulWidget {
  @override
  _DropDownMenuState createState() => _DropDownMenuState();
}
class _DropDownMenuState extends State<DropDownMenu> {
  String dropdownValue = '1';

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      hint: Text(
        '',
        style: TextStyle(
            fontFamily: "Rye",
            fontSize: 20
        ),
      ),
      value: dropdownValue,
      onChanged: (newValue) {
        setState(() {
          dropdownValue = newValue;
          opponents = int.parse(dropdownValue);
          print(opponents);
        });
      },
      items: <String>['1', '2', '3', '4', '5', '6', '7'].map<DropdownMenuItem<String>>((String val) {
        return DropdownMenuItem<String>(
          value: val,
          child: Text(val),
        );
      }).toList(),
    );
  }
}




class HousingMenu extends StatefulWidget {
  @override
  _HousingMenuState createState() => _HousingMenuState();
}
class _HousingMenuState extends State<HousingMenu> {

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
