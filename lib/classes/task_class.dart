class Task {
  final String name;
  final String description;

  const Task(this.name, this.description);

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
    };
  }

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      json['name'],
      json['description'],
    );
  }
}
