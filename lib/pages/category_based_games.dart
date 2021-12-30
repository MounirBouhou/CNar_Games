import 'dart:convert';
import 'dart:io';
import 'package:cnargames/blocs/ad_bloc.dart';
import 'package:cnargames/blocs/banner_ad.dart';
import 'package:cnargames/blocs/new_games_bloc.dart';
import 'package:cnargames/colors/custom_colors.dart';
import 'package:cnargames/config/wp_config.dart';
import 'package:cnargames/services/connectivity_provider.dart';
import 'package:cnargames/utils/next_screen.dart';
import 'package:cnargames/models/games.dart';
import 'package:cnargames/pages/play_game.dart';
import 'package:cnargames/utils/custom_cache_image.dart';
import 'package:cnargames/utils/scroll_to_top.dart';
import 'package:cnargames/widgets/cat_loading.dart';
import 'package:cnargames/widgets/drawer.dart';
import 'package:cnargames/widgets/load_more.dart';
import 'package:cnargames/widgets/no_internet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class CategoryBasedGames extends StatefulWidget {
  final String? catName;
  final int? catId;
  final String? catThumb;

  CategoryBasedGames(
      {Key? key,
      required this.catName,
      required this.catId,
      required this.catThumb})
      : super(key: key);

  @override
  _CategoryBasedGamesState createState() => _CategoryBasedGamesState();
}

class _CategoryBasedGamesState extends State<CategoryBasedGames> {
  List<Games> _games = [];
  //List<mCategory> _catGames = [];
  ScrollController? _controller;
  int page = 1;
  int _postAmount = 10;
  bool? _loading;
  bool _showBackToTopButton = false;
  var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _controller =
        ScrollController(initialScrollOffset: 0.0, keepScrollOffset: true);
    _controller!.addListener(_scrollListener);
    fetchCatGames(page);
    _loading = false;

    Future.delayed(Duration(milliseconds: 0))
        .then((value) => context.read<AdsBloc>().showRewardedAd());
  }

  Future fetchCatGames(int page) async {
    try {
      var response = await http.get(Uri.parse(
          "${WpConfig().webURL}/wp-json/wp/v2/posts?categories[]=" +
              widget.catId.toString() +
              "&page=$page&tags=1126&per_page=$_postAmount&_fields=id,date,title,content,custom,link"));

      if (this.mounted) {
        if (response.statusCode == 200) {
          List? decodedData = jsonDecode(response.body);
          setState(() {
            _games.addAll(decodedData!.map((e) => Games.fromJson(e)).toList());
            if (_games.length == 0) {
              //_hasData = false;
            }
          });
        }
      }
    } on SocketException {
      throw 'No internet connection';
    }
  } // fetchCatGames

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Consumer<ConnectivityProvider>(builder: (c, model, child) {
        if (model.isOnline) {
          return Scaffold(
              key: scaffoldKey,
              backgroundColor: cColors().gray,
              endDrawer: CustomDrawer(),
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                // shape: CustomShapeBorder(),

                // bottom: new PreferredSize(
                //     preferredSize: const Size.fromHeight(50.0),
                //     child: new Container(
                //       width: double.infinity,
                //         color: Colors.transparent,
                //         padding: const EdgeInsets.all(5.0),
                //         child: new Text("test")
                //         )),

                leading: Center(
                  child: Container(
                    decoration: BoxDecoration(
                        color: cColors().pinkDark, shape: BoxShape.circle),
                    child: Padding(
                        padding: EdgeInsets.all(2),
                        child: CustomCacheImage(
                          img: widget.catThumb,
                        )),
                  ),
                ),

                leadingWidth: 80,

                centerTitle: true,
                title: FittedBox(
        fit: BoxFit.fitWidth,
        child:Text(
                  widget.catName.toString(),
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: cColors().pinkDark),
                ),
                ),

                actions: <Widget>[
                  IconButton(
                    onPressed: () => scaffoldKey.currentState!.openEndDrawer(),
                    icon: Icon(
                      Icons.menu,
                      color: cColors().pinkDark,
                      size: 30.0,
                    ),
                  ),
                ],
                elevation: 0,
              ),
              body: Directionality(
                textDirection: TextDirection.rtl,
                child: SafeArea(
                    child: SingleChildScrollView(
                      physics: ClampingScrollPhysics(),
                      controller: _controller, // +++

                      child: _games.isEmpty
                          ? CatLoading(
                              catThumb: widget.catThumb,
                              scaffoldKey: scaffoldKey)
                          : Column(
                              children: [
                                Center(child: Padding(
                                  padding: const EdgeInsets.only(top: 20, bottom: 10),
                                  child: BannerAD(),
                                )),
                                new StaggeredGridView.countBuilder(
                                  addAutomaticKeepAlives: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  crossAxisCount: 4,
                                  padding: EdgeInsets.only(
                                      top: 10, right: 12, left: 12),
                                  itemCount: _games.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return _ItemCard(
                                      games: _games[index],
                                      heroTag: "${widget.catName}${_games[index].id}",
                                      scaffoldKey: scaffoldKey,
                                      // imageHeight: _imageHeight,
                                    );
                                  },
                                  staggeredTileBuilder: (int index) =>
                                      new StaggeredTile.count(
                                          2, index.isEven ? 1.9 : 1.6),
                                  mainAxisSpacing: 12.0,
                                  crossAxisSpacing: 12.0,
                                ),
                                LoadMore(loading: _loading, color: cColors().pinkDark,)
                              ],
                            ),
                    )),
              ),
              floatingActionButton: _showBackToTopButton == false
                  ? null
                  : ScrollToTop(controller: _controller));
        } else {
          return NoInternet();
        }
      }),
    );
  }

  _scrollListener() async {
    var isEnd = _controller!.offset >= _controller!.position.maxScrollExtent &&
        !_controller!.position.outOfRange;
    if (isEnd) {
      print('end');
      setState(() {
        page += 1;
        _loading = true;
      });
      await fetchCatGames(page).then((value) {
        setState(() {
          _showBackToTopButton = true;
          _loading = false;
        });
      });
    } else {
      _showBackToTopButton = false;
      print('not end');
    }
  }
}

// Widget _bottomBar() => AppBar(
//       //title: Text(PageName.APP_BAR),
//       bottom: PreferredSize(
//         child: Container(
//           alignment: Alignment.center,
//           color: Colors.yellow,
//           constraints: BoxConstraints.expand(height: 50),
//           child: Text(
//             "bottom",
//             style: TextStyle(fontSize: 30),
//           ),
//         ),
//         preferredSize: Size(50, 50),
//       ),
//     );

// class CustomShapeBorder extends ContinuousRectangleBorder {
//   @override
//   Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
//     double x = 140, y = 45, r = 0.5;
//     Path path = Path()
//       ..addRRect(RRect.fromRectAndCorners(rect))
//       ..moveTo(rect.bottomRight.dx + 30, rect.bottomCenter.dy - 10)
//       ..relativeQuadraticBezierTo(
//           ((-x / 2) + (x / 6)) * (1 - r), 0, -x / 2 * r, y * r)
//       ..relativeQuadraticBezierTo(
//           -x / 6 * r, y * (1 - r), -x / 2 * (1 - r), y * (1 - r))
//       ..relativeQuadraticBezierTo(
//           ((-x / 2) + (x / 6)) * (1 - r), 0, -x / 2 * (1 - r), -y * (1 - r))
//       ..relativeQuadraticBezierTo(-x / 6 * r, -y * r, -x / 2 * r, -y * r);
//     path.close();
//     return path;
//   }
//}

class _ItemCard extends StatelessWidget {
  final Games games;
  final String heroTag;
  final GlobalKey<ScaffoldState> scaffoldKey;
  //final double imageHeight;

  const _ItemCard({
    Key? key,
    required this.games,
    required this.heroTag,
    required this.scaffoldKey,
    // required this.imageHeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //final bookmarkedList = Hive.box(Constants.bookmarkTag);
    return InkWell(
      child: Container(
        child: Hero(
            tag: heroTag,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: CustomCacheImage(img: games.image))),
      ),
      onTap: () {
        context.read<NewGamesBloc>().sendViewsCount(games.id.toString());
        nextScreen(context, PlayGame(tag: heroTag, gamesData: games));
      }
    );
  }
}

class SlidingAppBar extends StatelessWidget implements PreferredSizeWidget {
  SlidingAppBar({
    required this.child,
    required this.controller,
    required this.visible,
  });

  final PreferredSizeWidget child;
  final AnimationController controller;
  final bool visible;

  @override
  Size get preferredSize => child.preferredSize;

  @override
  Widget build(BuildContext context) {
    visible ? controller.reverse() : controller.forward();
    return SlideTransition(
      position: Tween<Offset>(begin: Offset.zero, end: Offset(0, -1)).animate(
        CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn),
      ),
      child: child,
    );
  }
}
