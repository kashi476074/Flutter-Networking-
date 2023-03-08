// ignore: file_names
import 'dart:convert';
import 'package:http/http.dart';

class PostList {
  final List<Post> posts;
  PostList({required this.posts});
  factory PostList.fromJson(List<dynamic> parsedJson) {
    List<Post> posts = new List.empty();
    posts = parsedJson.map((e) => Post.fromJson(e)).toList();

    return new PostList(posts: posts);
  }
}

class Post {
  int id;
  int userId;
  String title;
  String body;
  Post(
      {required this.id,
      required this.userId,
      required this.title,
      required this.body});
  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
        id: json['id'],
        userId: json['userId'],
        title: json['title'],
        body: json['body']);
  }
}

class Network {
  final String url;
  Network(this.url);

  Future<PostList> LoadData() async {
    print("$url");
    Response response = await get(Uri.parse(url));

    if (response.statusCode == 200) {
      //print(response.body[0]);
      return PostList.fromJson(json.decode(response.body));
    } else {
      throw Exception("Failed To load Check Internet ");
    }
  }

  Future fetchData() async {
    print("$url");
    Response response = await get(Uri.parse(url));

    if (response.statusCode == 200) {
      //print(response.body[0]);
      return json.decode(response.body);
    } else {
      print(response.body);
    }
  }
}
