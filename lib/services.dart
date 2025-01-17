import 'package:cloud_firestore/cloud_firestore.dart';

void addPlacesAndRestaurants() {
  // Reference to the Firestore collection 'categories'
  CollectionReference categories = FirebaseFirestore.instance.collection('categories');

  // Data for places with description field and favorite field
  List<Map<String, dynamic>> places = [
    {
      "name": "Dukan",
      "location": "Sulaymaniyah, Iraq",
      "rating": 4.5,
      "image": "dukan.jpg",
      "type": "place",
      "favorite": false, // default value for favorite
      "description": "Dukan is a beautiful area in Sulaymaniyah, known for its scenic landscapes, traditional Kurdish architecture, and vibrant local culture. It's a popular destination for both locals and tourists seeking tranquility and nature."
    },
    {
      "name": "Bekhal",
      "location": "Erbil, Iraq",
      "rating": 4.7,
      "image": "bekhal.jpg",
      "type": "place",
      "favorite": false, // default value for favorite
      "description": "Bekhal is a stunning natural spot located near Erbil. Famous for its refreshing waterfall and picturesque surroundings, it's a perfect escape for a peaceful day out in nature. Visitors can enjoy hiking, picnics, and the fresh air."
    },
    {
      "name": "Iraq Museum",
      "location": "Erbil, Iraq",
      "rating": 4.2,
      "image": "musem.jpg",
      "type": "place",
      "favorite": false, // default value for favorite
      "description": "The Erbil Museum offers an insightful look into the history of the region, showcasing artifacts from ancient civilizations. The museum highlights the cultural richness of northern Iraq, making it a must-visit for history enthusiasts."
    },

    {
      "name": "Erbil Castle",
      "location": "Erbil, Iraq",
      "rating": 4.2,
      "image": "erbil.jpg",
      "type": "place",
      "favorite": false, // default value for favorite
      "description": "The Erbil  offers an insightful look into the history of the region, showcasing artifacts from ancient civilizations. The Castle highlights the cultural richness of northern Iraq, making it a must-visit for history enthusiasts."
    },

  ];

  // Data for restaurants with description field and favorite field
  List<Map<String, dynamic>> restaurants = [
    {
      "name": "TopOrganic",
      "location": "Erbil, Iraq",
      "rating": 4.8,
      "image": "toporganic.jpg",
      "type": "restaurant",
      "favorite": false, // default value for favorite
      "description": "TopOrganic is a health-conscious restaurant in Erbil offering organic, locally sourced ingredients in every dish. Known for its fresh salads, vegan options, and wholesome meals, it’s the perfect place for anyone looking to eat clean and healthy."
    },
    {
      "name": "Buffalo",
      "location": "Erbil, Iraq",
      "rating": 4.6,
      "image": "buffalo.jpg",
      "type": "restaurant",
      "favorite": false, // default value for favorite
      "description": "Buffalo offers a delightful variety of dishes, from juicy burgers to hearty steaks, all served in a vibrant and relaxed atmosphere. It’s a favorite among locals and visitors alike who enjoy casual dining with excellent food and service."
    },
    {
      "name": "The Grill",
      "location": "Erbil, Iraq",
      "rating": 4,
      "image": "grill.jpg",
      "type": "restaurant",
      "favorite": false, // default value for favorite
      "description": "The Grill offers a delightful variety of dishes, from juicy burgers to hearty steaks, all served in a vibrant and relaxed atmosphere. It’s a favorite among locals and visitors alike who enjoy casual dining with excellent food and service."
    },
    {
      "name": "Huqqa",
      "location": "Baghdad, Iraq",
      "rating": 4.2,
      "image": "buffalo.jpg",
      "type": "restaurant",
      "favorite": false, // default value for favorite
      "description": "Huqqa offers a delightful variety of dishes, from juicy burgers to hearty steaks, all served in a vibrant and relaxed atmosphere. It’s a favorite among locals and visitors alike who enjoy casual dining with excellent food and service."
    },
  ];

  // Adding places to the 'places' document within 'categories' collection
  categories.doc('places').set({
    'places': places
  }).then((value) {
    print("Places Added");
  }).catchError((error) {
    print("Failed to add places: $error");
  });

  // Adding restaurants to the 'restaurants' document within 'categories' collection
  categories.doc('restaurants').set({
    'restaurants': restaurants
  }).then((value) {
    print("Restaurants Added");
  }).catchError((error) {
    print("Failed to add restaurants: $error");
  });
}
