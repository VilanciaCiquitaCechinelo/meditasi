//nampilin data

import 'package:flutter/material.dart';
import 'package:meditasi/models/API_models.dart';

class TrackList extends StatefulWidget {
  @override
  _TrackListState createState() => _TrackListState();
}

class _TrackListState extends State<TrackList> {
  late Future<List<Track>> topTracks;

  @override
  void initState() {
    super.initState();
    topTracks = getTopTracks();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Track>>(
      future: topTracks,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text(
            'Error: ${snapshot.error}',
            style: TextStyle(color: Colors.white),
          );
        } else {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 16.0, top: 16.0, right: 16.0),
                child: Text(
                  '5 songs Recommend based on your top 5 track',
                  style: TextStyle(
                    fontSize: 30.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: EdgeInsets.only(left: 16.0, right: 16.0),
                child: Text(
                  'for your day',
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 20),
              ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      snapshot.data![index].name,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      snapshot.data![index].artists.join(', '),
                      style: TextStyle(
                          color: Colors.white,
                        fontSize: 10.0,
                      ),
                    ),
                  );
                },
              ),
            ],
          );
        }
      },
    );
  }
}


