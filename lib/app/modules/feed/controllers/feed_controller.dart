import 'package:Intellio/app/data/models/feed_models/feed_model.dart';
import 'package:all/all.dart';
import 'package:get/get.dart';

class FeedController extends GetxController {
  RxList<FeedTileModel> feeds =
      <FeedTileModel>[
        FeedTileModel(
          userProfileImage: 'https://example.com/user1.png',
          userName: 'Alice Smith',
          genre: 'Travel',
          postedTime: '1h ago',
          feedTitle: 'Exploring the Alps!',
          currentLikes: '120',
          currentComments: '25',
          currentShare: '10',
          postImage: [
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR74iyhQrxt2GyCE_kLUMY3yICoA0RrCiWO9A&s',
            'https://upload.wikimedia.org/wikipedia/commons/thumb/d/d9/Alpenrelief_01.jpg/330px-Alpenrelief_01.jpg',
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSAIQy17-miPA9oYxbT1xqXuD274pdfLaCj8w&s',
          ],
          feedContent:
              'The view from the Swiss Alps is breathtaking! Highly recommend the Domhütte route.',
        ),
        FeedTileModel(
          userProfileImage: 'https://example.com/user2.png',
          userName: 'Bob Johnson',
          genre: 'Food',
          postedTime: '3h ago',
          feedTitle: 'Best Ramen in Tokyo 🍜',
          currentLikes: '340',
          currentComments: '44',
          currentShare: '18',
          postImage: [
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR74iyhQrxt2GyCE_kLUMY3yICoA0RrCiWO9A&s',
            'https://upload.wikimedia.org/wikipedia/commons/thumb/d/d9/Alpenrelief_01.jpg/330px-Alpenrelief_01.jpg',
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSAIQy17-miPA9oYxbT1xqXuD274pdfLaCj8w&s',
          ],
          feedContent:
              'Nothing beats a hot bowl of ramen at Ichiran Shibuya after a long day.',
        ),
        FeedTileModel(
          userProfileImage: 'https://example.com/user3.png',
          userName: 'Carlos Diaz',
          genre: 'Fitness',
          postedTime: '30m ago',
          feedTitle: 'Morning Routine Complete 💪',
          currentLikes: '220',
          currentComments: '30',
          currentShare: '7',
          postImage: [
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR74iyhQrxt2GyCE_kLUMY3yICoA0RrCiWO9A&s',
            'https://upload.wikimedia.org/wikipedia/commons/thumb/d/d9/Alpenrelief_01.jpg/330px-Alpenrelief_01.jpg',
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSAIQy17-miPA9oYxbT1xqXuD274pdfLaCj8w&s',
          ],
          feedContent:
              'Just wrapped up my 5AM workout. Remember, discipline beats motivation!',
        ),
        FeedTileModel(
          userProfileImage: 'https://example.com/user4.png',
          userName: 'Diana Prince',
          genre: 'Photography',
          postedTime: '6h ago',
          feedTitle: 'Golden Hour in Santorini 🌅',
          currentLikes: '450',
          currentComments: '90',
          currentShare: '60',
          postImage: [
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR74iyhQrxt2GyCE_kLUMY3yICoA0RrCiWO9A&s',
            'https://upload.wikimedia.org/wikipedia/commons/thumb/d/d9/Alpenrelief_01.jpg/330px-Alpenrelief_01.jpg',
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSAIQy17-miPA9oYxbT1xqXuD274pdfLaCj8w&s',
          ],
          feedContent:
              'Captured this magical sunset while wandering the cliffs of Oia.',
        ),
        FeedTileModel(
          userProfileImage: 'https://example.com/user5.png',
          userName: 'Ethan Lee',
          genre: 'Tech',
          postedTime: '4h ago',
          feedTitle: 'Trying Out the New iPhone 15 Pro 📱',
          currentLikes: '610',
          currentComments: '112',
          currentShare: '48',
          postImage: [
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR74iyhQrxt2GyCE_kLUMY3yICoA0RrCiWO9A&s',
            'https://upload.wikimedia.org/wikipedia/commons/thumb/d/d9/Alpenrelief_01.jpg/330px-Alpenrelief_01.jpg',
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSAIQy17-miPA9oYxbT1xqXuD274pdfLaCj8w&s',
          ],
          feedContent:
              'Testing the camera and performance today. Impressed so far!',
        ),
        FeedTileModel(
          userProfileImage: 'https://example.com/user6.png',
          userName: 'Fiona Gallagher',
          genre: 'Art',
          postedTime: '10h ago',
          feedTitle: 'My Latest Acrylic Painting 🎨',
          currentLikes: '298',
          currentComments: '35',
          currentShare: '20',
          postImage: [
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR74iyhQrxt2GyCE_kLUMY3yICoA0RrCiWO9A&s',
            'https://upload.wikimedia.org/wikipedia/commons/thumb/d/d9/Alpenrelief_01.jpg/330px-Alpenrelief_01.jpg',
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSAIQy17-miPA9oYxbT1xqXuD274pdfLaCj8w&s',
          ],
          feedContent:
              'Inspired by Van Gogh’s brush strokes and summer fields.',
        ),
        FeedTileModel(
          userProfileImage: 'https://example.com/user7.png',
          userName: 'George Lin',
          genre: 'Nature',
          postedTime: '2d ago',
          feedTitle: 'Camping in Yosemite 🌲',
          currentLikes: '710',
          currentComments: '130',
          currentShare: '50',
          postImage: [
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR74iyhQrxt2GyCE_kLUMY3yICoA0RrCiWO9A&s',
            'https://upload.wikimedia.org/wikipedia/commons/thumb/d/d9/Alpenrelief_01.jpg/330px-Alpenrelief_01.jpg',
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSAIQy17-miPA9oYxbT1xqXuD274pdfLaCj8w&s',
          ],
          feedContent: 'Woke up to the sound of birds and the scent of pine.',
        ),
        FeedTileModel(
          userProfileImage: 'https://example.com/user8.png',
          userName: 'Hannah Kim',
          genre: 'Books',
          postedTime: '5h ago',
          feedTitle: 'Finished “Atomic Habits” 📘',
          currentLikes: '170',
          currentComments: '22',
          currentShare: '12',
          postImage: [
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR74iyhQrxt2GyCE_kLUMY3yICoA0RrCiWO9A&s',
            'https://upload.wikimedia.org/wikipedia/commons/thumb/d/d9/Alpenrelief_01.jpg/330px-Alpenrelief_01.jpg',
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSAIQy17-miPA9oYxbT1xqXuD274pdfLaCj8w&s',
          ],
          feedContent:
              'Game-changer in building consistent habits. Highly recommend!',
        ),
        FeedTileModel(
          userProfileImage: 'https://example.com/user9.png',
          userName: 'Ivan Novak',
          genre: 'Cars',
          postedTime: '8h ago',
          feedTitle: 'New Porsche GT3 Delivery Day!',
          currentLikes: '980',
          currentComments: '200',
          currentShare: '90',
          postImage: [
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR74iyhQrxt2GyCE_kLUMY3yICoA0RrCiWO9A&s',
            'https://upload.wikimedia.org/wikipedia/commons/thumb/d/d9/Alpenrelief_01.jpg/330px-Alpenrelief_01.jpg',
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSAIQy17-miPA9oYxbT1xqXuD274pdfLaCj8w&s',
          ],
          feedContent:
              'Took her for a spin on the track today. Unreal power and handling!',
        ),
        FeedTileModel(
          userProfileImage: 'https://example.com/user10.png',
          userName: 'Julia Wong',
          genre: 'Pets',
          postedTime: '12h ago',
          feedTitle: 'My Cat’s Birthday 🐱🎉',
          currentLikes: '380',
          currentComments: '65',
          currentShare: '25',
          postImage: [
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR74iyhQrxt2GyCE_kLUMY3yICoA0RrCiWO9A&s',
            'https://upload.wikimedia.org/wikipedia/commons/thumb/d/d9/Alpenrelief_01.jpg/330px-Alpenrelief_01.jpg',
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSAIQy17-miPA9oYxbT1xqXuD274pdfLaCj8w&s',
          ],
          feedContent: 'Gave Luna a tuna cake and she loved it!',
        ),
      ].obs;
}
