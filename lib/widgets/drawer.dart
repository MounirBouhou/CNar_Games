import 'package:cnargames/colors/custom_colors.dart';
import 'package:cnargames/config/config.dart';
import 'package:cnargames/pages/home.dart';
import 'package:cnargames/services/app_services.dart';
import 'package:cnargames/utils/next_screen.dart';
import 'package:cnargames/widgets/policy.dart';
import 'package:flutter/material.dart';

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
                color: cColors().bg,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 3),
                      child: Image(
                          height: 100,
                          width: 100,
                          fit: BoxFit.contain,
                          image: AssetImage(Config().splash)),
                    ),
                    SizedBox(height: 20),
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
                    leading: Icon(Icons.home, size: 22,),
                    horizontalTitleGap: 5,
                    title: Text(
                      'الصفحة الرئيسية',
                      style: TextStyle(
                        color: cColors().darkGray,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    onTap: (){
                      nextScreen(context, Home());
                    },
                  ),
                  ListTile(
                    isThreeLine: false,
                    contentPadding: EdgeInsets.all(0),
                    leading: Icon(Icons.email_outlined, size: 22,),
                    horizontalTitleGap: 5,
                    title: Text(
                      'اتصل بنا',
                      style: TextStyle(
                        color: cColors().darkGray,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    onTap: (){
                      Navigator.pop(context);
                      AppServices().openEmailSupport();
                    },
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.all(0),
                    leading: Icon(Icons.policy_outlined, size: 22,),
                    horizontalTitleGap: 5,
                    title: Text(
                      'سياسة الخصوصية',
                      style: TextStyle(
                        color: cColors().darkGray,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    onTap: (){
                      nextScreenPopup(context, Policy());
                    },
                  ),
                ],
              ),
            ),
            Divider(
              color: cColors().darkGray,
            ),
          ],
        ),
      ),
    )
    );
  }
}
