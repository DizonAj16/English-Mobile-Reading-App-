import 'package:cloud_firestore/cloud_firestore.dart';
import '../../models/story_model.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Fetch all stories
  Stream<List<StoryModel>> getStories() {
    return _firestore.collection('stories').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return StoryModel.fromMap(doc.data() as Map<String, dynamic>, doc.id);
      }).toList();
    });
  }

  // Fetch quiz for a specific story
  Future<List<Map<String, dynamic>>> getQuiz(String storyId) async {
    QuerySnapshot quizSnapshot = await _firestore
        .collection('stories')
        .doc(storyId)
        .collection('quiz')
        .get();

    return quizSnapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
  }
}