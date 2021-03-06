import 'package:buck/basic_app.dart';
import 'package:buck/utils/dio_client.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:permission_handler/permission_handler.dart';

/// @author wujianchuan
/// @date 2019/12/28 17:01
class UpgradeDialog extends StatefulWidget {
  final String title;
  final String content;
  final double width;
  final double height;
  final String nextTime;
  final String upgradeNow;
  final bool mandatory;

  final String url;
  final String path;

  UpgradeDialog({
    @required this.url,
    @required this.path,
    this.title = 'New Version',
    this.content = 'There is a new version to upgrade.',
    this.nextTime = 'Next Time',
    this.upgradeNow = 'Upgrade Now',
    this.mandatory = false,
    this.width = 280,
    this.height = 250,
  }) : assert(title != null, content != null);

  @override
  State<StatefulWidget> createState() => UpgradeDialogState();
}

class UpgradeDialogState extends State<UpgradeDialog> {
  double _progressPoint;
  bool _isPerformingRequest;

  @override
  void initState() {
    super.initState();
    _progressPoint = 0.0;
    _isPerformingRequest = false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Center(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Theme.of(context).cardColor,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(widget.title,
                  style: TextStyle(
                      color: Theme.of(context).textTheme.title.color,
                      fontSize: 18,
                      decoration: TextDecoration.none,
                      fontFamily: 'pinshang')),
              Divider(),
              Expanded(
                child: SizedBox(
                  width: widget.width - 20,
                  child: SingleChildScrollView(
                    child: Text(widget.content,
                        style: TextStyle(
                            color: Theme.of(context).textTheme.body1.color,
                            fontSize: 15,
                            decoration: TextDecoration.none,
                            fontWeight: FontWeight.normal)),
                  ),
                ),
              ),
              _progressPoint <= 0
                  ? Divider()
                  : SizedBox(
                      width: 200,
                      height: 10,
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        child: LinearProgressIndicator(
                          value: _progressPoint,
                          backgroundColor: Color(0xffFFE3E3),
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Color(0xffFF4964)),
                        ),
                      ),
                    ),
              widget.mandatory
                  ? Container()
                  : MaterialButton(
                      color: Colors.orange,
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text(
                        widget.nextTime,
                        style: TextStyle(
                            fontSize: 17,
                            color: Colors.white,
                            fontFamily: 'pinshang'),
                      ),
                    ),
              MaterialButton(
                color: _isPerformingRequest ? Colors.grey[500] : Colors.green,
                onPressed: () async {
                  if (!_isPerformingRequest) {
                    await _handleStorage();
                    this.setState(() => _isPerformingRequest = true);
                    String storagePath = buck.documentsDir.path + widget.path;
                    await DioClient().download(
                      context,
                      widget.url,
                      path: storagePath,
                      onReceiveProgress: (rec, total) {
                        if (mounted)
                          setState(() => _progressPoint = rec / total);
                      },
                    );
                    if (mounted) {
                      Navigator.of(context).pop();
                      OpenFile.open(storagePath);
                    }
                  }
                },
                child: Text(
                  _isPerformingRequest
                      ? '${(_progressPoint * 100).toStringAsFixed(2)}%'
                      : widget.upgradeNow,
                  style: TextStyle(
                      fontSize: 17,
                      color: Colors.white,
                      fontFamily: 'pinshang'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _handleStorage() async {
    await Permission.storage.request();
  }
}
