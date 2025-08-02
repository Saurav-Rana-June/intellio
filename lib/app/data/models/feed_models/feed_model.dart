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

  factory FeedTileModel.fromMap(Map<String, dynamic> map) {
    return FeedTileModel(
      userProfileImage: map['userProfileImage'] as String?,
      userName: map['userName'] as String?,
      genre: map['genre'] as String?,
      postedTime: map['postedTime'] as String?,
      feedTitle: map['feedTitle'] as String?,
      feedContent: map['feedContent'] as String?,
      currentLikes: map['currentLikes'] as String?,
      currentComments: map['currentComments'] as String?,
      currentShare: map['currentShare'] as String?,
      postImage: List<String>.from(map['postImage'] ?? []),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userProfileImage': userProfileImage,
      'userName': userName,
      'genre': genre,
      'postedTime': postedTime,
      'feedTitle': feedTitle,
      'feedContent': feedContent,
      'currentLikes': currentLikes,
      'currentComments': currentComments,
      'currentShare': currentShare,
      'postImage': postImage,
    };
  }
}
