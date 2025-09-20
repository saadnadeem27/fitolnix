class Workout {
  final String id;
  final String title;
  final String description;
  final String category;
  final String difficulty;
  final int duration; // in minutes
  final int caloriesBurned;
  final String? imageUrl;
  final String? videoUrl;
  final List<Exercise> exercises;
  final bool isFavorite;

  Workout({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.difficulty,
    required this.duration,
    required this.caloriesBurned,
    this.imageUrl,
    this.videoUrl,
    required this.exercises,
    this.isFavorite = false,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'category': category,
      'difficulty': difficulty,
      'duration': duration,
      'caloriesBurned': caloriesBurned,
      'imageUrl': imageUrl,
      'videoUrl': videoUrl,
      'exercises': exercises.map((e) => e.toJson()).toList(),
      'isFavorite': isFavorite,
    };
  }

  factory Workout.fromJson(Map<String, dynamic> json) {
    return Workout(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      category: json['category'],
      difficulty: json['difficulty'],
      duration: json['duration'],
      caloriesBurned: json['caloriesBurned'],
      imageUrl: json['imageUrl'],
      videoUrl: json['videoUrl'],
      exercises: (json['exercises'] as List)
          .map((e) => Exercise.fromJson(e))
          .toList(),
      isFavorite: json['isFavorite'] ?? false,
    );
  }

  Workout copyWith({
    String? id,
    String? title,
    String? description,
    String? category,
    String? difficulty,
    int? duration,
    int? caloriesBurned,
    String? imageUrl,
    String? videoUrl,
    List<Exercise>? exercises,
    bool? isFavorite,
  }) {
    return Workout(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      category: category ?? this.category,
      difficulty: difficulty ?? this.difficulty,
      duration: duration ?? this.duration,
      caloriesBurned: caloriesBurned ?? this.caloriesBurned,
      imageUrl: imageUrl ?? this.imageUrl,
      videoUrl: videoUrl ?? this.videoUrl,
      exercises: exercises ?? this.exercises,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}

class Exercise {
  final String id;
  final String name;
  final String description;
  final int sets;
  final int reps;
  final int? duration; // in seconds
  final String? imageUrl;
  final String? videoUrl;
  final String? instructions;

  Exercise({
    required this.id,
    required this.name,
    required this.description,
    required this.sets,
    required this.reps,
    this.duration,
    this.imageUrl,
    this.videoUrl,
    this.instructions,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'sets': sets,
      'reps': reps,
      'duration': duration,
      'imageUrl': imageUrl,
      'videoUrl': videoUrl,
      'instructions': instructions,
    };
  }

  factory Exercise.fromJson(Map<String, dynamic> json) {
    return Exercise(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      sets: json['sets'],
      reps: json['reps'],
      duration: json['duration'],
      imageUrl: json['imageUrl'],
      videoUrl: json['videoUrl'],
      instructions: json['instructions'],
    );
  }
}