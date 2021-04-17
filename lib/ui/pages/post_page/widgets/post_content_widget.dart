import 'package:base_notifier/base_notifier.dart';
import 'package:flutter/material.dart';
import 'package:testapp/core/page_models/post_page_model.dart';

class PostContentWidget extends StatelessWidget {
  const PostContentWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseWidget<PostsPageModel>.cosnume(
      builder: (context, model, child) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Text(
              'last widget render at: ${DateTime.now().toString()}',
              textAlign: TextAlign.center,
            ),
            Container(
              height: 200,
              child: model.busy
                  ? loadingWidget()
                  : model.hasError
                      ? Center(
                          child: Text("Error"),
                        )
                      : dataWidget(context, model),
            ),
          ],
        );
      },
    );
  }

  loadingWidget() => Center(child: CircularProgressIndicator());

  dataWidget(BuildContext context, PostsPageModel model) {
    if (model.state == NotifierState.error) {
      return Text('error retreving data');
    } else {
      return ListView.builder(
          itemCount: model.posts.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: RaisedButton(
                onPressed: () => {},
                child: Text('post comments'),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0)),
                color: Colors.blue,
              ),
            );
          });
    }
  }
}
