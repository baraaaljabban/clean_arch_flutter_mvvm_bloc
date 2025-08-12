class Question {
  final int id;
  final int userId;
  final String title;
  final String body;

  const Question({
    required this.id,
    required this.userId,
    required this.title,
    required this.body,
  });

  factory Question.fromMap(Map<String, Object?> map) {
    return Question(
      id: (map['id'] as num).toInt(),
      userId: (map['userId'] as num).toInt(),
      title: (map['title'] as String?) ?? '',
      body: (map['body'] as String?) ?? '',
    );
  }

  Map<String, Object?> toMap() {
    return <String, Object?>{
      'id': id,
      'userId': userId,
      'title': title,
      'body': body,
    };
  }
}
