import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  // Fetch places and restaurants from Firestore
  Future<Map<String, dynamic>> fetchCategories() async {
    try {
      DocumentSnapshot placesSnapshot = await FirebaseFirestore.instance.collection('categories').doc('places').get();
      DocumentSnapshot restaurantsSnapshot = await FirebaseFirestore.instance.collection('categories').doc('restaurants').get();

      return {
        'places': placesSnapshot['places'],
        'restaurants': restaurantsSnapshot['restaurants'],
      };
    } catch (e) {
      print('Error fetching categories: $e');
      return {'places': [], 'restaurants': []};
    }
  }

  // Update favorite status of places or restaurants
  Future<void> updateFavoriteStatus(String category, List<dynamic> items) async {
    try {
      await FirebaseFirestore.instance.collection('categories').doc(category).update({
        category: items,
      });
    } catch (e) {
      print('Error updating favorite status: $e');
    }
  }
}
