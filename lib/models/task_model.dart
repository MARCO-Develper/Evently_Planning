class TaskModel {
  String id;
  String title;
  String category;
  String location;
  String description;
  int date;
  bool isDone;
  bool isFavorite;
  String userId;

  TaskModel({
    this.id = "",
    required this.title,
    required this.description,
    required this.category,
    required this.userId,
    this.location = "",
    required this.date,
    this.isDone = false,
    this.isFavorite = false,
  });

  TaskModel.fromJson(Map<String, dynamic> json)
      : this(
            id: json['id'],
            title: json['title'],
            description: json['description'],
            date: json['date'],
            location: json['location'],
            category: json['category'],
            userId: json['userId'],
            isDone: json['isDone'],
            isFavorite: json['isFavorite'] ?? false);

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "description": description,
      "date": date,
      "location": location,
      "category": category,
      "userId": userId,
      "isDone": isDone,
      "isFavorite": isFavorite,
    };
  }
}
