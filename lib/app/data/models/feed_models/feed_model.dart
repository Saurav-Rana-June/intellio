class FeedTileModel {
  final String? userProfileImage;
  final String? userName;
  final String? genre;
  final String? postedTime;
  final String? feedTitle;
  final String? feedContent;
  final String? currentLikes;
  final String? currentComments;
  final String? currentShare;
  final List<String> postImage;

  FeedTileModel({
    required this.userProfileImage,
    required this.userName,
    required this.genre,
    required this.postedTime,
    required this.feedTitle,
    required this.currentLikes,
    required this.currentComments,
    required this.currentShare,
    required this.postImage,
    this.feedContent,
  });
}
