class StoryModel {
  final String id;
  final String title;
  final String content;

  StoryModel({
    required this.id,
    required this.title,
    required this.content,
  });

  factory StoryModel.fromMap(Map<String, dynamic> data, String id) {
    return StoryModel(
      id: id,
      title: data['title'] ?? '',
      content: data['content'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'content': content,
    };
  }
}