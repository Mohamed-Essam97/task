import 'package:base_notifier/base_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testapp/core/models/api_models.dart';
import 'package:testapp/core/page_models/static_content_page_model.dart';
import 'package:testapp/ui/pages/post_page/widgets/post_content_widget.dart';
import 'package:testapp/ui/styles/colors.dart';

class StaticContentPage extends StatelessWidget {
  const StaticContentPage({Key key, Post post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ///📌this named constructor initialize the page with it's model and render it's content one time only preventing unnecessary screen build
    return BaseWidget<StaticContentPageModel>.staticBuilder(
      ///🧠initialize the page model
      model: StaticContentPageModel(api: Provider.of(context)),

      ///🦄 the builder function that gets fired every time setState is called or on the first frame render.
      staticBuilder: (context, model) {
        return Scaffold(
          appBar: AppBar(
              title: Text('Override architecture example'),
              backgroundColor: Colors.blue),

          ///🧠use constant colors to improve readability
          backgroundColor: AppColors.primaryBackground,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                staticContentPage(),
                renderWidget(model),
                Align(
                    alignment: Alignment.bottomCenter,
                    child: PostContentWidget())
              ],
            ),
          ),
        );
      },
    );
  }

  staticContentPage() {
    return Text(
        '🍉StaticContentPage🍉\nlast widget render at: ${DateTime.now().toString()}',
        textAlign: TextAlign.center);
  }

  renderWidget(StaticContentPageModel model) {
    return Column(
      children: <Widget>[
        SizedBox(height: 55),
        Text('last screen render at: ${DateTime.now().toString()}'),
        RaisedButton(
          onPressed: () => model.renderAgain(),
          child: Text('press me to render again'),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
          color: Colors.blue,
        ),
      ],
    );
  }
}
