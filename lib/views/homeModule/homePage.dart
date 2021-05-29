import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:morphosis_demo/model/imdbModel.dart';
import 'package:morphosis_demo/widgets/customLoaderWidget.dart';
import 'homeController.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController _searchTextField = TextEditingController();
  final HomeController homeController =
      Get.put<HomeController>(HomeController());
  @override
  void initState() {
    _searchTextField.text = "Search";
    super.initState();
  }

  @override
  void dispose() {
    _searchTextField.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => CustomLoaderWidget(
          isTrue: homeController.isLoading.value,
          child: Scaffold(
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CupertinoSearchTextField(
                    controller: _searchTextField,
                  ),
                ),
                // Spacer(),
                // homeController.moviesList.isEmpty
                //     ? SizedBox()
                //     :
                Expanded(
                  child: StaggeredGridView.countBuilder(
                    shrinkWrap: true,
                    crossAxisCount: 4,
                    itemCount: homeController.moviesList.length,
                    itemBuilder: (BuildContext context, int index) =>
                        _Tile(homeController.moviesList[index]),
                    staggeredTileBuilder: (int index) =>
                        new StaggeredTile.count(2, 2
                            // index.isEven ? 2 : 1
                            ),
                    mainAxisSpacing: 4.0,
                    crossAxisSpacing: 4.0,
                  ),
                )
                // Spacer(),
              ],
            ),
          ),
        ));
  }
}

class _Tile extends StatelessWidget {
  const _Tile(
    this.movie,
  );

  final Titles movie;

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;

    return Card(
      // clipBehavior: Clip.hardEdge,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Image.network(
            movie.image,
            // width: size.width * 0.4,
            height: 120,
          ),
          Padding(
            padding: const EdgeInsets.all(4),
            child: Column(
              children: <Widget>[
                Text(
                  movie.title,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  'IMDB# ${movie.id}',
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
