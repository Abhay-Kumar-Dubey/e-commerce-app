import 'dart:convert';
import 'dart:ui';
import 'package:e_commerce/bloc/home_screen_bloc.dart';
import 'package:e_commerce/productScreen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:e_commerce/mock_data.dart' as data;

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  late List itemName = List.empty();
  late List ProductName = List.empty();
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    http.Response response = await http.get(Uri.parse(
        "https://679340c85eae7e5c4d8e0bc5.mockapi.io/Ecommrce/api/item/productDetails"));
    http.Response response2 = await http.get(Uri.parse(
        "https://679340c85eae7e5c4d8e0bc5.mockapi.io/Ecommrce/api/item/home"));
    List<dynamic> JsonData = jsonDecode(response.body);
    List<dynamic> JsonData2 = jsonDecode(response2.body);

    setState(() {
      itemName = JsonData;
      ProductName = JsonData2;
    });
  }

  @override
  Widget build(BuildContext context) {
    String category = "";
    return BlocConsumer<HomeScreenBloc, HomeScreenState>(
      listener: (context, state) {
        if (state is SelectedCategory) {
          setState(() {
            category = state.Category;
          });
        }
      },
      builder: (context, state) {
        if (itemName.isEmpty || ProductName.isEmpty) {
          return Scaffold(body: Center(child: CircularProgressIndicator()));
        } else {
          return Scaffold(
            backgroundColor: const Color.fromARGB(255, 249, 244, 236),
            appBar: AppBar(
              backgroundColor: const Color.fromARGB(255, 249, 244, 236),
              title: Text("E-Commerce App"),
            ),
            body: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                // crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(50)),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.6,
                                child: TextField(
                                  decoration: InputDecoration(
                                      hintText: "Search here..."),
                                ),
                              ),
                              Container(
                                  width: 45,
                                  height: 45,
                                  decoration: BoxDecoration(
                                      color: Colors.amber,
                                      borderRadius: BorderRadius.circular(50)),
                                  child: IconButton(
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.search,
                                        size: 30,
                                      )))
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(50)),
                        child: Icon(
                          Icons.favorite_border_outlined,
                          size: 30,
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 3.0, top: 16, bottom: 16),
                    child: Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20)),
                        child: Image.asset(
                          "lib/assets/banner.png",
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Select by Category",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "See all",
                          style: TextStyle(fontSize: 16, color: Colors.amber),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 150,
                    width: MediaQuery.of(context).size.width,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 10, // specify the number of items
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    context.read<HomeScreenBloc>().add(
                                        CategorySelected(
                                            category: itemName[index]
                                                ['productName']));
                                  });
                                },
                                child: Container(
                                    width: 70,
                                    height: 70,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(70)),
                                    child: Image.network(
                                      itemName[index]['productImage'],
                                    )),
                              ),
                              Text(itemName[index]['productName'])
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 18.0),
                        child: BlocBuilder<HomeScreenBloc, HomeScreenState>(
                          builder: (context, state) {
                            String category = "";
                            if (state is SelectedCategory) {
                              category = state.Category;
                            }
                            return Text(
                                category == ""
                                    ? "Top Picks For You"
                                    : "$category",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold));
                          },
                        ),
                      )),
                  BlocBuilder<HomeScreenBloc, HomeScreenState>(
                    builder: (context, state) {
                      String category = "";
                      if (state is SelectedCategory) {
                        category = state.Category;
                      }
                      return GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10.0,
                            mainAxisSpacing: 25.0,
                            childAspectRatio: 0.8),
                        itemBuilder: (context, index) {
                          return Transform.translate(
                            offset: Offset(0, index.isEven ? 45 : 0),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Productscreen(
                                              index: index,
                                              productImage: category ==
                                                          "Home" ||
                                                      category == ""
                                                  ? ProductName[index]
                                                      ["productImage"]
                                                  : data.MockData[category]
                                                      [index]["productImage"],
                                              productName: category == "Home" ||
                                                      category == ""
                                                  ? ProductName[index]
                                                      ["productName"]
                                                  : data.MockData[category]
                                                      [index]["productName"],
                                              productPrice: category ==
                                                          "Home" ||
                                                      category == ""
                                                  ? '${ProductName[index]["productPrice"]}'
                                                  : data.MockData[category]
                                                      [index]["productPrice"],
                                              productRating: category ==
                                                          "Home" ||
                                                      category == ""
                                                  ? "${ProductName[index]["productRating"]}"
                                                  : data.MockData[category]
                                                      [index]["productRating"],
                                            )));
                              },
                              child: GridTile(
                                child: Stack(children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.white,
                                    ),
                                    child: Column(
                                      children: [
                                        Image.network(
                                          category == "Home" || category == ""
                                              ? ProductName[index]
                                                  ["productImage"]
                                              : data.MockData[category][index]
                                                  ["productImage"],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      ClipRect(
                                        child: BackdropFilter(
                                          filter: ImageFilter.blur(
                                              sigmaX: 10.0, sigmaY: 10.0),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(4.0),
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    Icons.star,
                                                    color: Colors.yellow,
                                                  ),
                                                  Text(
                                                      "${category == "Home" || category == "" ? ProductName[index]["productRating"] : data.MockData[category][index]["productRating"]}")
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Positioned(
                                    bottom: 0,
                                    left: 0,
                                    right: 0,
                                    child: Container(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          ClipRect(
                                            child: BackdropFilter(
                                                filter: ImageFilter.blur(
                                                    sigmaX: 10.0, sigmaY: 10.0),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    color: Colors.black
                                                        .withOpacity(0.4),
                                                  ),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(7),
                                                        child: Text(
                                                          "${category == "Home" || category == "" ? ProductName[index]["productName"] : data.MockData[category][index]["productName"]}",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 17),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                left: 10.0),
                                                        child: Text(
                                                            "₹ ${category == "Home" || category == "" ? ProductName[index]["productPrice"] : data.MockData[category][index]["productPrice"]}",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 16)),
                                                      )
                                                    ],
                                                  ),
                                                )),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ]),
                              ),
                            ),
                          );
                        },
                        itemCount: category == "Home" || category == ""
                            ? ProductName.length
                            : data.MockData[category]
                                .length, // specify the number of items
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                      );
                    },
                  )
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
