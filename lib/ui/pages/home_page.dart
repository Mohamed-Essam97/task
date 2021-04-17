import 'package:base_notifier/base_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testapp/core/page_models/home_page_model.dart';
import 'package:testapp/core/services/database/database_helper.dart';
import 'package:testapp/ui/styles/colors.dart';
import 'package:ui_utils/ui_utils.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  // 🧠📌🦄🔥
  @override
  Widget build(BuildContext context) {
    final dbHelper = DatabaseHelper.instance;

    return BaseWidget<HomePageModel>(
      ///🧠initialize the page model
      model: HomePageModel(api: Provider.of(context)),

      ///📌 the static part of the scree that dont need to be rendered every time.
      staticChild: Container(
          width: 100,
          height: 100,
          color: Colors.red,
          child: Text("this widget will not get rerendered over setStates")),

      ///🦄 the builder function that gets fired every time setState is called or on the first frame render.
      builder: (context, model, child) {
        ///wrapping the scaffold with focus widget hepls improving the user experience when using text forms if exists in this page
        return FocusWidget(
          child: Scaffold(
            appBar: AppBar(
                title: Text('Override architecture example'),
                backgroundColor: Colors.blue),

            ///🧠use constant colors to improve readability
            backgroundColor: AppColors.primaryBackground,
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  model.busy ? loadingWidget() : dataWidget(context, model),
                  renderWidget(model),
                  navigateWidget(context, model),
                  RaisedButton(
                    onPressed: () async {
                      // row to insert
                      Map<String, dynamic> row = {
                        DatabaseHelper.columnToken: 'dsafsdsfdd',
                        DatabaseHelper.columnUserInfo: '{id:2}'
                      };
                      final id = await dbHelper.insert(row);
                      print('inserted row id: $id');
                    },
                    child: Text("insert"),
                    color: Colors.red,
                  ),
                  RaisedButton(
                    onPressed: () async {
                      var res = await dbHelper.queryAllRows();
                      res.forEach((element) {
                        print(element);
                      });
                    },
                    child: Text("query"),
                    color: Colors.red,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  loadingWidget() => CircularProgressIndicator();

  dataWidget(BuildContext context, HomePageModel model) {
    if (model.state == NotifierState.error) {
      return Text('error retreving data');
    } else {
      return Text(
        '🍉data🍉\nlast widget render at: ${DateTime.now().toString()}',
        textAlign: TextAlign.center,
      );
    }
  }

  renderWidget(HomePageModel model) {
    return Column(
      children: <Widget>[
        SizedBox(height: 170),
        Text('last screen render at: ${DateTime.now().toString()}'),
        RaisedButton(
          onPressed: () => model.renderAgain(),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
          child: Text('press me to render again',
              style: TextStyle(color: Colors.white)),
          color: Colors.blue,
        ),
      ],
    );
  }

  navigateWidget(BuildContext context, HomePageModel model) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        RaisedButton(
          onPressed: () => model.openPostPage(context),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
          child: Text('open post page', style: TextStyle(color: Colors.white)),
          color: Colors.blue,
        ),
      ],
    );
  }
}
