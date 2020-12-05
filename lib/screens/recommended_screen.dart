import 'package:flutter/material.dart';

class RecommendedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Recommended for you',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Color(0xffF8F9F9),
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
        child: ListView(
          children: [
            RecommendedTourWidget(
                "https://cdn.mbl.is/frimg/1/22/55/1225528.jpg",
                "Iceland",
                "\$2,250"),
            RecommendedTourWidget(
                "https://assets.weforum.org/article/image/gXS80iJQCQhe8ACj3Xd1U35GreOmD8BbQNkWJbLPtts.jpg",
                "Switzerland",
                "\$6,750"),
            RecommendedTourWidget(
                "https://isthatplacesafe.com/wp-content/uploads/2018/12/japan.jpg",
                "Japan",
                "\$1,250"),
            RecommendedTourWidget(
                "https://www.everythingoverseas.com/wp-content/uploads/2018/07/10-places-portugal.jpg",
                "Portugal",
                "\$8,000"),
            RecommendedTourWidget(
                "https://www.akchabar.kg/media/news/db626349-f5ad-4e24-a59a-8619c2cd6281.jpg",
                "Kazakhstan",
                "\$1,250"),
            RecommendedTourWidget(
                "https://images.adsttc.com/media/images/5f73/76e0/63c0/17bc/c900/04e8/newsletter/HK_1_N3.jpg?1601402564",
                "Korea",
                "\$4,100"),
          ],
        ),
      ),
    );
  }
}

class RecommendedTourWidget extends StatelessWidget {
  final String imageUrl;
  final String country;
  final String price;

  RecommendedTourWidget(this.imageUrl, this.country, this.price);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black12),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            children: [
              AspectRatio(
                aspectRatio: 2 / 1,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                      bottomLeft: Radius.circular(0),
                      bottomRight: Radius.circular(0),
                    ),
                    image: DecorationImage(
                      image: NetworkImage(imageUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      country,
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                    ),
                    Text(
                      price,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 25,
        ),
      ],
    );
  }
}
