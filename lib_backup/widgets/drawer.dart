import 'package:cnargames/blocs/category_bloc.dart';
import 'package:cnargames/blocs/featured_games_bloc.dart';
import 'package:cnargames/blocs/new_games_bloc.dart';
import 'package:cnargames/blocs/theme_bloc.dart';
import 'package:cnargames/colors/custom_colors.dart';
import 'package:cnargames/config/config.dart';
import 'package:cnargames/config/strings.dart';
import 'package:cnargames/pages/bookmark.dart';
import 'package:cnargames/pages/home.dart';
import 'package:cnargames/services/app_services.dart';
import 'package:cnargames/utils/next_screen.dart';
import 'package:cnargames/widgets/policy.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
    child: Drawer(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                height: 260,
                width: double.infinity,
                color: Theme.of(context).iconTheme.color,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      child: Image(
                          height: 100,
                          width: 100,
                          fit: BoxFit.contain,
                          image: AssetImage(Config().splash)),
                    ),
                    SizedBox(height: 15),
                    Text(Config().appName)
                  ],
                )
            ),
            Container(
              padding: EdgeInsets.all(15),
              child: Column(
                children: [
                  ListTile(
                    isThreeLine: false,
                    contentPadding: EdgeInsets.all(0),
                    leading: Icon(Icons.home, size: 22,color: Theme.of(context).iconTheme.color,),
                    horizontalTitleGap: 5,
                    title: Text(st.home,
                      style: Theme.of(context).textTheme.headline2,
                    ),
                    onTap: (){
                      context.read<NewGamesBloc>().clearGames();
                      context.read<FeaturedGamesBloc>().clearGames();
                      context.read<CategoryBloc>().clearGames();
                      nextScreenReplace(context, Home());
                    },
                  ),

                  ListTile(
                    isThreeLine: false,
                    contentPadding: EdgeInsets.all(0),
                    leading: Icon(Icons.favorite_sharp, size: 22, color: cColors().yellowDark,),
                    horizontalTitleGap: 5,
                    title: Text(st.favorite,
                      style: Theme.of(context).textTheme.headline2,
                    ),
                    onTap: (){
                      nextScreen(context, Bookmark());
                    },
                  ),

                  SizedBox(height: 10),
                  Divider(
                    thickness: 0.3,
                    color: Theme.of(context).iconTheme.color,
                  ),
                  SizedBox(height: 10),

                  ListTile(
                    contentPadding: EdgeInsets.all(0),
                    horizontalTitleGap: 5,
                    leading: Icon(
                      Icons.dark_mode,
                      size: 20,
                      color: Theme.of(context).iconTheme.color,
                    ),
                    title: Text(st.darkMode,
                      style:Theme.of(context).textTheme.headline2,
                    ),
                    trailing: Switch(
                        activeColor: Theme.of(context).iconTheme.color,
                        value: context.watch<ThemeBloc>().darkTheme!,
                        onChanged: (bool) {
                          context.read<ThemeBloc>().toggleTheme();
                        }),
                  ),

                  SizedBox(height: 10),

                  Divider(
                    thickness: 0.3,
                    color: Theme.of(context).iconTheme.color,
                  ),
                  SizedBox(height: 10),

                  ListTile(
                    isThreeLine: false,
                    contentPadding: EdgeInsets.all(0),
                    leading: Icon(Icons.email_outlined, size: 22,color: Theme.of(context).iconTheme.color,),
                    horizontalTitleGap: 5,
                    title: Text(st.messageUs,
                      style: Theme.of(context).textTheme.headline2,
                    ),
                    onTap: (){
                      Navigator.pop(context);
                      AppServices().openEmailSupport();
                    },
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.all(0),
                    leading: Icon(Icons.policy_outlined, size: 22,color: Theme.of(context).iconTheme.color,),
                    horizontalTitleGap: 5,
                    title: Text(st.policy,
                      style: Theme.of(context).textTheme.headline2,
                    ),
                    onTap: (){
                      nextScreenPopup(context, Policy());
                    },
                  ),





                ],
              ),
            ),

          ],
        ),
      ),
    )
    );
  }
}
