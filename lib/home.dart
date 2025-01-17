import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'detail.dart';
import 'favorite.dart';
import 'main.dart';
import 'images.dart';

String searchText = "";

class HomePage extends StatefulWidget {
  final String? userName;
  HomePage({Key? key, this.userName}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  String selectedCat = 'all';
  String searchText = "";
  final TextEditingController _searchController = TextEditingController();
  List<String> filteredData = [];

  List<dynamic> places = [];
  List<dynamic> restaurants = [];
  List<dynamic> allItems = [];
  List<String> images = [];
  final TextEditingController _nameController = TextEditingController();


  late User loggedInUser;
  String? uidT;
  String? userName;
  bool isLoading = true;

  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  List<Map<String, String>> filteredVideos = [];

  @override
  void initState() {
    super.initState();
    fetchCategories();
    getCurrentUser();
  }


  // Search function to filter the names
  void _search(List<String> allNames) {
    setState(() {
      filteredData = allNames
          .where((name) =>
          name.toLowerCase().contains(searchText.toLowerCase()))
          .toList();
    });
  }

  // Fetch places and restaurants from Firestore
  void fetchCategories() async {
    try {
      DocumentSnapshot placesSnapshot = await FirebaseFirestore.instance
          .collection('categories')
          .doc('places')
          .get();
      DocumentSnapshot restaurantsSnapshot = await FirebaseFirestore.instance
          .collection('categories')
          .doc('restaurants')
          .get();

      if (placesSnapshot.exists && restaurantsSnapshot.exists) {
        setState(() {
          places = List.from(placesSnapshot['places'] ?? []);
          restaurants = List.from(restaurantsSnapshot['restaurants'] ?? []);
          allItems = [
            ...places,
            ...restaurants
          ]; // Combine places and restaurants into one list
        });
      } else {
        // Handle missing documents or data
        print("Documents do not exist.");
      }
    } catch (e) {
      // Handle any errors
      print("Error fetching categories: $e");
    }
  }

  Future<void> getCurrentUser() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
        uidT = loggedInUser.uid;
        await fetchUserProfile();
      }
    } catch (e) {
      print('Error getting current user: $e');
    }
  }

  Future<void> fetchUserProfile() async {
    try {
      final userDoc = await _firestore.collection('users')
          .doc(loggedInUser.uid)
          .get();
      if (userDoc.exists) {
        setState(() {
          userName = userDoc.data()?['UserName'] ?? '';
          _nameController.text = userName ?? '';
        });
      }
    } catch (e) {
      print('Error fetching user profile: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void _filterItems() {
    setState(() {
      List<dynamic> sourceList = [];
      if (selectedCat == 'places') {
        sourceList = places;
      } else if (selectedCat == 'restaurants') {
        sourceList = restaurants;
      } else {
        sourceList = allItems;
      }

      filteredData = sourceList
          .where((item) => item.toString().toLowerCase().contains(searchText))
          .map((item) => item.toString()) // Convert items to String
          .toList();
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        backgroundColor: Theme
            .of(context)
            .colorScheme
            .background,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text
              (
              "Hello,",
              style: AppTextStyles.satosh(
                  Theme
                      .of(context)
                      .colorScheme
                      .secondary),
            ),
            Text
              (
                "$userName 👋 ",
                style: AppTextStyles.pageTextStyle(
                    button, 25)
            )
          ],
        ),
        actions: [
          SizedBox(width: 20),
        ],
      ),
      backgroundColor: Theme
          .of(context)
          .colorScheme
          .background,
      body: places.isEmpty && restaurants.isEmpty
          ? Center(
          child:
          CircularProgressIndicator(
            color: button,
          )) // Show loading spinner if data is empty
          : Padding(
        padding: const EdgeInsets.symmetric(horizontal: 08),
        child: ListView(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Where You \n   Wanna go?",
                    style: AppTextStyles.pageTextStyle(
                        Theme
                            .of(context)
                            .colorScheme
                            .secondary, 40)),

                Expanded(
                  child: ClipRRect(
                    child: Image.asset('images/home.png', fit: BoxFit.fill),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                //i want the search here
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(left: 10),
                      prefixIcon: Icon(Icons.search,
                          color: Theme
                              .of(context)
                              .colorScheme
                              .primary),
                      hintText: 'Search',
                      hintStyle: TextStyle(color: Theme
                          .of(context)
                          .colorScheme
                          .primary),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: BorderSide(color: button, width: 2),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: BorderSide(
                            color: Theme
                                .of(context)
                                .colorScheme
                                .primary, width: 2),
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        searchText = value.toLowerCase();
                        _filterItems();
                      });
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Hot Events",
                    style: AppTextStyles.pageTextStyle(
                        Theme
                            .of(context)
                            .colorScheme
                            .secondary, 30)),
                TextButton(
                  onPressed: () {},
                  child:
                  Text("See all", style: AppTextStyles.satosh(button)),
                ),
              ],
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  SizedBox(width: 10),
                  ReusableEvents('images/abdulmajeed.jpg'),
                  ReusableEvents('images/kadhim.jpg'),
                ],
              ),
            ),
            Column(

              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text("Hot Events",
                    style: AppTextStyles.pageTextStyle(
                        Theme
                            .of(context)
                            .colorScheme
                            .secondary, 30)),
              ],
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedCat = 'all';
                      });
                    },
                    child: Categories_Section('all'),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedCat = 'places';
                      });
                    },
                    child: Categories_Section('places'),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedCat = 'restaurants';
                      });
                    },
                    child: Categories_Section('restaurants'),
                  ),
                ],
              ),
            ),
            if (selectedCat == 'all')
              GridView.count(
                physics: NeverScrollableScrollPhysics(),
                // Prevents scrolling
                crossAxisCount: 2,
                // Two items per row
                crossAxisSpacing: 10,
                // Space between columns
                mainAxisSpacing: 10,
                // Space between rows
                childAspectRatio: 1.0,
                // Adjust the aspect ratio to fit content nicely
                shrinkWrap: true,
                // Ensure the grid fits within the screen
                children: allItems.map<Widget>((item) {
                  // Get the item name (make sure item has a 'name' attribute)
                  String itemName = item["name"];
                  // Get the image list from placeImages for the item
                  List<String> images = placeImages[itemName] ?? [];

                  return TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Detailspage(item: item),
                        ),
                      );
                    },
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: Image.asset(
                            images.isNotEmpty
                                ? images[0]
                                : 'images/profile.jpeg',
                            height: 230,
                            width: 180,
                            fit: BoxFit.fill,
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          child: Container(
                            height: 100,
                            width: 180,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              gradient: LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                colors: [
                                  Colors.black.withOpacity(0.7),
                                  Colors.transparent,
                                ],
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 20,
                          left: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    width: 100,
                                    child: Text(
                                      item["name"],
                                      style: AppTextStyles.satosh(background2),
                                    ),
                                  ),
                                  SizedBox(width: 25),
                                  Icon(
                                    FontAwesomeIcons.solidStar,
                                    color: headline2,
                                    size: 16,
                                  ),
                                  Text(
                                    " ${item['rating']}",
                                    style: AppTextStyles.satosh(background2),
                                  ),
                                ],
                              ),
                              SizedBox(height: 8),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(
                                    Icons.location_on_outlined,
                                    color: background2,
                                    size: 20,
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    item['location'],
                                    style: TextStyle(
                                      color: background2,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          right: 10,
                          child: IconButton(
                            icon: Icon(
                              item['favorite'] == true
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: item['favorite'] == true
                                  ? Colors.red
                                  : background,
                              size: 30,
                            ),
                            onPressed: () {
                              setState(() {
                                item['favorite'] = !item['favorite'];
                              });
                              FirebaseFirestore.instance
                                  .collection('categories')
                                  .doc('restaurants')
                                  .update({
                                'restaurants': restaurants,
                              });
                              FirebaseFirestore.instance
                                  .collection('categories')
                                  .doc('places')
                                  .update({
                                'places': places,
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),


            if (selectedCat == 'places')
              GridView.count(
                physics: NeverScrollableScrollPhysics(),
                // Prevents scrolling
                crossAxisCount: 2,
                // Two items per row
                crossAxisSpacing: 10,
                // Space between columns
                mainAxisSpacing: 10,
                // Space between rows
                childAspectRatio: 1.0,
                // Adjust aspect ratio for uniform display
                shrinkWrap: true,
                // Make sure the grid content fits
                children: places.map<Widget>((place) {
                  // Get the item name (make sure item has a 'name' attribute)
                  String itemName = place["name"];
                  // Get the image list from placeImages for the item
                  List<String> images = placeImages[itemName] ?? [];
                  return TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Detailspage(item: place),
                        ),
                      );
                    },
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: Image.asset(
                            images.isNotEmpty
                                ? images[0]
                                : 'images/profile.jpeg',
                            height: 230,
                            width: 180,
                            fit: BoxFit.fill,
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          child: Container(
                            height: 100,
                            width: 180,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              gradient: LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                colors: [
                                  Colors.black.withOpacity(0.7),
                                  Colors.transparent,
                                ],
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 20,
                          left: 02,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    width: 100,
                                    child: Text(
                                      place['name'],
                                      style:
                                      AppTextStyles.satosh(background2),
                                    ),
                                  ),
                                  SizedBox(width: 25),
                                  Icon(
                                    FontAwesomeIcons.solidStar,
                                    color: headline2,
                                    size: 16,
                                  ),
                                  Text(
                                    " ${place['rating']}",
                                    style:
                                    AppTextStyles.satosh(background2),
                                  ),
                                ],
                              ),
                              SizedBox(height: 8),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(
                                    Icons.location_on_outlined,
                                    color: background2,
                                    size: 20,
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    place['location'],
                                    style: TextStyle(
                                      color: background2,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          right: 10,
                          child: IconButton(
                            icon: Icon(
                              place['favorite'] == true
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: place['favorite'] == true
                                  ? Colors.red
                                  : background,
                              size: 30,
                            ),
                            onPressed: () {
                              setState(() {
                                place['favorite'] =
                                !place['favorite'];
                              });
                              FirebaseFirestore.instance
                                  .collection('categories')
                                  .doc('places')
                                  .update({
                                'places': places,
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),


            if (selectedCat == 'restaurants')
              GridView.count(
                physics: NeverScrollableScrollPhysics(),
                // Prevents scrolling
                crossAxisCount: 2,
                // Ensure 2 items per row
                crossAxisSpacing: 1,
                // Space between columns
                mainAxisSpacing: 1,
                // Space between rows
                childAspectRatio:
                1.0,
                // Adjust aspect ratio to fit your content nicely
                shrinkWrap:
                true,
                // Ensure it fits within the screen space properly
                children: restaurants.map<Widget>((restaurant) {
                  // Get the item name (make sure item has a 'name' attribute)
                  String itemName = restaurant["name"];
                  // Get the image list from placeImages for the item
                  List<String> images = placeImages[itemName] ?? [];
                  return TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Detailspage(item: restaurant),
                        ),
                      );
                    },
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: Image.asset(
                            images.isNotEmpty
                                ? images[0]
                                : 'images/profile.jpeg',
                            height: 230,
                            width: 180,
                            fit: BoxFit.fill,
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          child: Container(
                            height: 100,
                            width: 180,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              gradient: LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                colors: [
                                  Colors.black.withOpacity(0.7),
                                  Colors.transparent,
                                ],
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 20,
                          left: 02,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    width: 100,
                                    child: Text(
                                      restaurant['name'],
                                      style:
                                      AppTextStyles.satosh(background2),
                                    ),
                                  ),
                                  SizedBox(width: 25),
                                  Icon(
                                    FontAwesomeIcons.solidStar,
                                    color: headline2,
                                    size: 16,
                                  ),
                                  Text(
                                    " ${restaurant['rating']}",
                                    style:
                                    AppTextStyles.satosh(background2),
                                  ),
                                ],
                              ),
                              SizedBox(height: 8),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(
                                    Icons.location_on_outlined,
                                    color: background2,
                                    size: 20,
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    restaurant['location'],
                                    style: TextStyle(
                                      color: background2,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          right: 10,
                          child: IconButton(
                            icon: Icon(
                              restaurant['favorite'] == true
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: restaurant['favorite'] == true
                                  ? Colors.red
                                  : background,
                              size: 30,
                            ),
                            onPressed: () {
                              setState(() {
                                restaurant['favorite'] =
                                !restaurant['favorite'];
                              });
                              FirebaseFirestore.instance
                                  .collection('categories')
                                  .doc('restaurants')
                                  .update({
                                'restaurants': restaurants,
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              )
          ],
        ),
      )
    );
  }

  Container Categories_Section(String section) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: selectedCat == section
            ? button
            : Theme
            .of(context)
            .colorScheme
            .tertiary,
      ),
      padding: EdgeInsets.symmetric(vertical: 6, horizontal: 16),
      child: Text(
        section == 'all'
            ? 'All'
            : section[0].toUpperCase() + section.substring(1),
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold,
          color: selectedCat == section ? Theme
              .of(context)
              .colorScheme
              .background : Theme
              .of(context)
              .colorScheme
              .secondary,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Padding ReusableEvents(String image) {
    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset(image,
                fit: BoxFit.fill, width: 250, height: 150),
          ),
          Positioned(
            bottom: 16,
            left: 20,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme
                    .of(context)
                    .colorScheme
                    .background,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25)),
                minimumSize: Size(105, 35),
                padding: EdgeInsets.zero,
              ),
              child: Center(
                child: Text("Book Now",
                    style: AppTextStyles.satosh(
                        Theme
                            .of(context)
                            .colorScheme
                            .secondary)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
