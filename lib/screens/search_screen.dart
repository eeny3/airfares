import 'package:aviatickets/screens/info_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:aviatickets/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'recommended_screen.dart';

class SearchScreen extends StatelessWidget {
  String origin;
  String destination;
  String depDate;
  String retDate;

  getFlightData(
      String origin, String destination, String depDate, String retDate) async {
    var flightData = await http.get(
        'https://api.travelpayouts.com/v1/prices/cheap?origin=$origin&destination=$destination&depart_date=$depDate&return_date=$retDate&token=$kToken&currency=KZT');
    var flightDataDecoded = jsonDecode(flightData.body);
    return flightDataDecoded;
  }

  showAlertDialog(BuildContext context, String info) {
    // set up the button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Something went wrong"),
      content: Text(info),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: EdgeInsets.fromLTRB(25, 30, 25, 0),
        child: Column(
          children: [
            Column(
              children: [
                InfoTextField('Origin', (newVal) {
                  origin = newVal;
                }, '3 letter IATA code, example: MOW'),
                SizedBox(height: 16),
                InfoTextField(
                  'Destination',
                  (newVal) {
                    destination = newVal;
                  },
                  '3 letter IATA code, example: PAR',
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: InfoTextField('Departure', (newVal) {
                        depDate = newVal;
                      }, 'yyyy-mm-dd'),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: InfoTextField('Return', (newVal) {
                        retDate = newVal;
                        print(origin);
                      }, 'yyyy-mm-dd'),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: InfoTextField('Passengers', null, null),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: InfoTextField('Class', null, null),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 32),
            Material(
              elevation: 5.0,
              color: kCustomPurple,
              borderRadius: BorderRadius.circular(8),
              child: MaterialButton(
                onPressed: () async {
                  var flightDataDecoded = await getFlightData(
                      origin, destination, depDate, retDate);
                  if (flightDataDecoded["success"] == false) {
                    showAlertDialog(context, flightDataDecoded["error"]);
                  } else if (flightDataDecoded["data"].length == 0) {
                    showAlertDialog(context, 'Sorry, no tickets available');
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => InfoScreen(flightDataDecoded,
                            origin, destination, depDate, retDate),
                      ),
                    );
                  }
                },
                minWidth: double.infinity,
                height: 60,
                child: Text(
                  'Search',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Recommended for you',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => RecommendedScreen()),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color(0xffE9E9E9),
                    ),
                    child: Text(
                      'View all',
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: ListView(
                shrinkWrap: true,
                children: [
                  RecommendedTile(
                      "https://wantsee.world/wp-content/uploads/2020/03/Norway-Travel.jpg",
                      "Norway"),
                  RecommendedTile(
                      "https://www.state.gov/wp-content/uploads/2018/11/France-1980x1406.jpg",
                      "France"),
                  RecommendedTile(
                      "https://www.telegraph.co.uk/content/dam/Travel/Cruise/June-2020/mount-kirkjufell-waterfall-iceland-getty-xlarge.jpg",
                      "Iceland"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RecommendedTile extends StatelessWidget {
  final String imageUrl;
  final String country;

  RecommendedTile(this.imageUrl, this.country);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              flex: 1,
              child: AspectRatio(
                aspectRatio: 1 / 1,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                      image: NetworkImage(imageUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Center(
                child: Text(
                  country,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Center(
                child: Text(
                  '\$1,250',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 15,
        ),
      ],
    );
  }
}

class InfoTextField extends StatelessWidget {
  final String hintText;
  final String hintText2;
  final updateString;

  InfoTextField(this.hintText, this.updateString, this.hintText2);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          hintText,
          style: TextStyle(color: Colors.grey),
          textAlign: TextAlign.start,
        ),
        SizedBox(height: 8),
        TextField(
          textAlign: TextAlign.start,
          onChanged: updateString,
          decoration: InputDecoration(
            hintText: hintText2,
            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(8),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.grey,
                width: 1.0,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(8),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: kCustomPurple,
                width: 2.0,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(8),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
