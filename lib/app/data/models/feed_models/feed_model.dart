class FeedTileModel {
  final String? uid;
  final String? userProfileImage;
  final String? userName;
  final String? genre;
  final String? postedTime;
  final String? feedTitle;
  final String? feedDescription;
  final String? feedType;
  final String? currentLikes;
  final String? currentComments;
  final String? currentShare;
  final List<String>? postImage;

  FeedTileModel({
    this.uid,
    this.userProfileImage,
    this.userName,
    this.genre,
    this.postedTime,
    this.feedTitle,
    this.feedType,
    this.currentLikes,
    this.currentComments,
    this.currentShare,
    this.postImage,
    this.feedDescription,
  });

  factory FeedTileModel.fromMap(Map<String, dynamic> map) {
    return FeedTileModel(
      uid: map['uid'] as String?,
      userProfileImage: map['userProfileImage'] as String?,
      userName: map['userName'] as String?,
      genre: map['genre'] as String?,
      postedTime: map['postedTime'] as String?,
      feedTitle: map['feedTitle'] as String?,
      feedDescription: map['feedDescription'] as String?,
      currentLikes: map['currentLikes'] as String?,
      currentComments: map['currentComments'] as String?,
      currentShare: map['currentShare'] as String?,
      postImage: List<String>.from(map['postImage'] ?? []),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'userProfileImage': userProfileImage,
      'userName': userName,
      'genre': genre,
      'postedTime': postedTime,
      'feedTitle': feedTitle,
      'feedDescription': feedDescription,
      'currentLikes': currentLikes,
      'currentComments': currentComments,
      'currentShare': currentShare,
      'postImage': postImage,
    };
  }
}
