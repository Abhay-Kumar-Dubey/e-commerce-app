import 'package:flutter/material.dart';

class Productscreen extends StatefulWidget {
  int index;
  String productImage;
  String productPrice;
  String productName;
  String productRating;
  Productscreen(
      {required this.index,
      required this.productImage,
      required this.productName,
      required this.productPrice,
      required this.productRating});

  @override
  State<Productscreen> createState() => _ProductscreenState();
}

class _ProductscreenState extends State<Productscreen> {
  @override
  Widget build(BuildContext context) {
    Color color = Colors.white;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(flex: 3, child: Image.network(widget.productImage)),
                  Expanded(
                    flex: 2,
                    child: Container(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(widget.productName,
                              style: TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.bold)),
                        ),
                        Row(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(width: 3),
                                    borderRadius: BorderRadius.circular(20)),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.star,
                                        color: Colors.amberAccent,
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10.0),
                                        child: Text(
                                          widget.productRating,
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 20.0, right: 5),
                                        child: Text('220 reviews'),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5.0, vertical: 20),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(20)),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 30.0),
                                    child: Text('₹${widget.productPrice}',
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10.0),
                                    child: Text("from ₹90 per month"),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 80.0),
                                    child: Icon(Icons.info_outline),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 7.0),
                          child: Text(
                            "Aute aliqua ad consequat nisi adipisicing nulla laboris sint ut fugiat laborum cillum. Anim cillum culpa eu mollit sint velit do id nulla irure Lorem. Eu Lorem proident esse ipsum irure deserunt.",
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ],
                    )),
                  )
                ],
              ),
              SafeArea(
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                          color: Colors.white30,
                          borderRadius: BorderRadius.circular(50)),
                      child: Icon(Icons.arrow_back)),
                ),
              ),
              SafeArea(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      if (color == Colors.white) {
                        color = Colors.red;
                      } else {
                        color = Colors.white;
                      }
                    });
                  },
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                            color: Colors.white30,
                            borderRadius: BorderRadius.circular(50)),
                        child: Icon(
                          Icons.favorite_border_outlined,
                          color: color,
                        )),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
          decoration: BoxDecoration(color: Colors.amberAccent),
          height: 80,
          child: TextButton(
              onPressed: () {},
              child: Text(
                "Add to Cart",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ))),
    );
  }
}
