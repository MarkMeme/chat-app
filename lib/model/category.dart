class Category {
  String id;

  late String title;

  late String image;

  static const sportsId = 'sports';
  static const moviesId = 'movies';
  static const musicId = 'music';

  Category({required this.title, required this.id, required this.image});

  Category.fromId(this.id) {
    if (id == moviesId) {
      title = 'Movies';
      image = 'assets/images/movies.png';
    } else if (id == musicId) {
      title = 'Music';
      image = 'assets/images/music.png';
    } else if (id == sportsId) {
      title = 'Sports';
      image = 'assets/images/sports.png';
    }
  }

  static List<Category> getCategory() {
    return [
      Category.fromId(musicId),
      Category.fromId(moviesId),
      Category.fromId(sportsId),
    ];
  }
}
