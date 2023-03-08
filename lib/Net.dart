// ignore: file_names
import 'package:flutter/material.dart';
import 'Post.dart';

class Json extends StatefulWidget {
  @override
  _json createState() => _json();
}

class _json extends State<Json> {
  late Future<PostList> data;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Network network = Network("https://jsonplaceholder.typicode.com/posts");
    data = network.LoadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Json List ")),
      body: Center(
          child: Container(
        child: FutureBuilder(
            future: data,
            builder: (context, AsyncSnapshot<PostList> snapshot) {
              List<Post> allPosts;
              if (snapshot.hasData) {
                allPosts = snapshot.data!.posts;
                //return Text(allPosts[0].title);
                return createListView(allPosts, context);
              }

              return CircularProgressIndicator();
            }),
      )),
    );
  }

  Future getData() async {
    var data;
    String url = "https://jsonplaceholder.typicode.com/posts";
    Network network = Network(url);
    data = network.fetchData();
    // data.then((value) {
    //   print(value[0]['title']);
    // });
    return data;
  }

  Widget createListView(List<Post> data, BuildContext context) {
    return Container(
        child: ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, int index) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Divider(height: 50),
                  ListTile(
                    title: Text("${data[index].title}"),
                    subtitle: Text("${data[index].body}"),
                    leading: Column(
                      children: [
                        CircleAvatar(
                          backgroundColor: Color.fromRGBO(23, 34, 45, 1),
                          radius: 23,
                          child: Text("${data[index].userId}"),
                        )
                      ],
                    ),
                  )
                ],
              );
            }));
  }
}
