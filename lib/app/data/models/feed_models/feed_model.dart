import 'package:Intellio/app/data/models/feed_models/feed_comment_model.dart';
import 'package:Intellio/app/data/models/space_models/space_model.dart';

class FeedTileModel {
  final String? uid;
  final String? docId;
  final String? userProfileImage;
  final String? userName;
  final SpaceModel? space;
  final String? postedTime;
  final String? feedTitle;
  final String? feedDescription;
  final String? feedType;
  final String? contentLink;
  final String? currentLikes;
  final String? currentComments;
  final String? currentShare;
  final List<String>? postMedia;
  final List<FeedCommentModel>? commentSection;

  FeedTileModel({
    this.uid,
    this.docId,
    this.userProfileImage,
    this.userName,
    this.space,
    this.postedTime,
    this.feedTitle,
    this.feedDescription,
    this.feedType,
    this.contentLink,
    this.currentLikes,
    this.currentComments,
    this.currentShare,
    this.postMedia,
    this.commentSection,
  });

  factory FeedTileModel.fromMap(Map<String, dynamic> map) {
    return FeedTileModel(
      uid: map['uid'] as String?,
      docId: map['docId'] as String?,
      userProfileImage: map['userProfileImage'] as String?,
      userName: map['userName'] as String?,
      space: map['space'] != null ? SpaceModel.fromMap(map['space']) : null,
      postedTime: map['postedTime'] as String?,
      feedTitle: map['feedTitle'] as String?,
      feedDescription: map['feedDescription'] as String?,
      feedType: map['feedType'] as String?,
      contentLink: map['contentLink'] as String?,
      currentLikes: map['currentLikes'] as String?,
      currentComments: map['currentComments'] as String?,
      currentShare: map['currentShare'] as String?,
      postMedia:
          map['postMedia'] != null ? List<String>.from(map['postMedia']) : [],
      commentSection:
          map['commentSection'] != null
              ? List<FeedCommentModel>.from(
                (map['commentSection'] as List).map(
                  (e) => FeedCommentModel.fromMap(e as Map<String, dynamic>),
                ),
              )
              : [],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'docId': docId,
      'userProfileImage': userProfileImage,
      'userName': userName,
      'space': space?.toMap(),
      'postedTime': postedTime,
      'feedTitle': feedTitle,
      'feedDescription': feedDescription,
      'feedType': feedType,
      'contentLink': contentLink,
      'currentLikes': currentLikes,
      'currentComments': currentComments,
      'currentShare': currentShare,
      'postMedia': postMedia ?? [],
      'commentSection': commentSection?.map((c) => c.toMap()).toList() ?? [],
    };
  }
}
