import 'package:Intellio/app/data/models/space_models/space_model.dart';

class FeedCommentModel {
  final String? userProfileImage;
  final String? userName;
  final String? comment;

  FeedCommentModel({this.userProfileImage, this.userName, this.comment});

  factory FeedCommentModel.fromMap(Map<String, dynamic> map) {
    return FeedCommentModel(
      userProfileImage: map['userProfileImage'] as String?,
      userName: map['userName'] as String?,
      comment: map['comment'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userProfileImage': userProfileImage,
      'userName': userName,
      'comment': comment,
    };
  }
}
