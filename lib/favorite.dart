import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'detail.dart';
import 'images.dart';
import 'main.dart';
class FavoritesPage extends StatefulWidget {
  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  List<dynamic> favoritePlaces = [];
  List<dynamic> favoriteRestaurants = [];
  List<String> images = [];

  @override
  void initState() {
    super.initState();
    fetchFavorites();
  }

  // Fetch favorite places and restaurants from Firestore
  void fetchFavorites() async {
    DocumentSnapshot placesSnapshot = await FirebaseFirestore.instance.collection('categories').doc('places').get();
    DocumentSnapshot restaurantsSnapshot = await FirebaseFirestore.instance.collection('categories').doc('restaurants').get();

    setState(() {
      favoritePlaces = placesSnapshot['places'].where((place) => place['favorite'] == true).toList();
      favoriteRestaurants = restaurantsSnapshot['restaurants'].where((restaurant) => restaurant['favorite'] == true).toList();
    });
  }

  // Function to update the favorite status in Firestore
  void updateFavoriteStatus(bool isPlace, dynamic item) {
    String collection = isPlace ? 'places' : 'restaurants';
    FirebaseFirestore.instance.collection('categories').doc('places').update({
      'places': FieldValue.arrayUnion([item]), // Update the places collection
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: TextButton(onPressed: ()
            {
              Navigator.pop(context);
            }
            , child: Icon(Icons.arrow_back_ios_new_outlined,color: button,size: 30,)),
        title: Text(
          "Favorites",
          style: AppTextStyles.pageTextStyle(Theme.of(context).colorScheme.secondary, 30),
        ),
      ),
      body: ListView(
        children: [
          // Display Favorite Places
          ...favoritePlaces.map<Widget>((place) {
            String itemName = place["name"];
            List<String> placeImagesList = placeImages[itemName] ?? [];

            return TextButton(
              onPressed: () {
                // Navigate to the detail page (pass the place object)
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
                    child: placeImagesList.isNotEmpty
                        ? Image.asset(placeImagesList[0], fit: BoxFit.cover)
                        : Image.asset('images/logo.png', fit: BoxFit.cover),
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
                    left: 10,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: 100,
                              child: Text(
                                place["name"],
                                style: TextStyle(color: Colors.white, fontSize: 18),
                              ),
                            ),
                            SizedBox(width: 25),
                            Icon(
                              Icons.star,
                              color: Colors.yellow,
                              size: 16,
                            ),
                            Text(
                              " ${place['rating']}",
                              style: TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          ],
                        ),
                        SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.location_on_outlined,
                              color: Colors.white,
                              size: 20,
                            ),
                            SizedBox(width: 8),
                            Text(
                              place['location'],
                              style: TextStyle(
                                color: Colors.white,
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
                        place['favorite'] == true ? Icons.favorite : Icons.favorite_border,
                        color: place['favorite'] == true ? Colors.red : Colors.white,
                        size: 30,
                      ),
                      onPressed: () {
                        setState(() {
                          place['favorite'] = !place['favorite'];
                        });

                        // Update Firestore after toggling favorite
                        updateFavoriteStatus(true, place);  // Pass true for places
                      },
                    ),
                  ),
                ],
              ),
            );
          }).toList(),

          // Display Favorite Restaurants (using a similar approach)
          ...favoriteRestaurants.map<Widget>((restaurant) {
            String restaurantName = restaurant["name"];
            List<String> restaurantImages = placeImages[restaurantName] ?? [];

            return TextButton(
              onPressed: () {
                // Navigate to the detail page (pass the restaurant object)
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
                    child: restaurantImages.isNotEmpty
                        ? Image.asset(restaurantImages[0], fit: BoxFit.cover)
                        : Image.asset('images/logo.png', fit: BoxFit.cover),
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
                    left: 10,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 100,
                              child: Text(
                                restaurant["name"],
                                style: TextStyle(color: Colors.white, fontSize: 18),
                              ),
                            ),
                            Icon(
                              Icons.star,
                              color: Colors.yellow,
                              size: 16,
                            ),
                            Text(
                              " ${restaurant['rating']}",
                              style: TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          ],
                        ),
                        SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.location_on_outlined,
                              color: Colors.white,
                              size: 20,
                            ),
                            SizedBox(width: 8),
                            Text(
                              restaurant['location'],
                              style: TextStyle(
                                color: Colors.white,
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
                        restaurant['favorite'] == true ? Icons.favorite : Icons.favorite_border,
                        color: restaurant['favorite'] == true ? Colors.red : Colors.white,
                        size: 30,
                      ),
                      onPressed: () {
                        setState(() {
                          restaurant['favorite'] = !restaurant['favorite'];
                        });

                        // Update Firestore after toggling favorite
                        updateFavoriteStatus(false, restaurant);
                      },
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }
}
