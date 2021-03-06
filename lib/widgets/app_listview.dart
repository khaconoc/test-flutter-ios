import 'dart:convert';

import 'package:bccp_mobile_v2/core/services/http_service.dart';
import 'package:bccp_mobile_v2/core/services/position_service.dart';
import 'package:bccp_mobile_v2/core/values/constains.dart';
import 'package:bccp_mobile_v2/data/model/response_model.dart';
import 'package:bccp_mobile_v2/theme/colors_theme.dart';
import 'package:bccp_mobile_v2/widgets/list_frist_loading_widget.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart' hide Response;
import 'package:rxdart/rxdart.dart';

import 'if_widget.dart';
import 'lazy_load_progress_indicator.dart';

class AppListView extends StatefulWidget {
  final String url;
  final String keySearch;
  final String valueSearch;
  final Map params;
  final Map orderBy;
  final Function onChange;
  final List value;
  final Function itemBuilder;
  final Widget separator;
  final bool showSeparator;
  final dynamic reload;
  final bool allowLocation;

  AppListView(
      {this.url,
      this.keySearch,
      this.valueSearch,
      this.params,
      this.orderBy,
      @required this.onChange,
      this.value = const [],
      this.itemBuilder,
      this.separator = const Divider(
        height: 10,
        endIndent: 20,
        indent: 20,
      ),
      this.reload,
      this.allowLocation = false,
      this.showSeparator = true,
      key})
      : super(key: key);

  @override
  AppListViewState createState() => AppListViewState();
}

class AppListViewState extends State<AppListView> {
  ScrollController _scrollController = new ScrollController();
  HttpService _httpService = Get.find();
  PositionService positionService = Get.find();

  bool _isLoading = false;
  bool _emptyData = false;
  PagingModel _paging = new PagingModel(page: 1, size: kSize, count: 0);

  final _textSearchSubject = new PublishSubject<String>();

  Position position;
  bool isLoadLocation = false;

  @override
  void initState() {
    _scrollController = new ScrollController();
    super.initState();

    /// ????ng k?? l???ng nge scroll list
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
              _scrollController.position.maxScrollExtent &&
          !_emptyData) {
        getData(page: this._paging.page + 1);
      }
    });

    /// ????ng k?? l???ng nghe text search thay ?????i gi?? tr???
    _textSearchSubject
        .debounceTime(Duration(milliseconds: 800))
        .listen((textSearch) {
      getData();
    });

    doInitialAsync();
  }

  void doInitialAsync() async {
    if (widget.allowLocation) {
      try {
        _setLoading(true);
        var position = await positionService.getPosition();
        setState(() {
          this.position = position;
        });
      } catch (e) {}
    }
    getData();
  }

  @override
  void didUpdateWidget(AppListView oldWidget) {
    String oldParams = json.encode(oldWidget.params);
    String currentParams = json.encode(widget.params);
    // if (!mapEquals(oldWidget.params, widget.params)) {
    if (oldParams != currentParams || widget.reload != oldWidget.reload) {
      print('app list view reload');
      getData();
    }
    // else if (oldWidget.valueSearch != widget.valueSearch) {
    //   _textSearchSubject.add(widget.valueSearch);
    // }
    // if (widget.value.length > 0) print(widget.value[0]['status']);
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _textSearchSubject.close();
    super.dispose();
  }

  void _setLoading(bool isLoading) {
    setState(() {
      _isLoading = isLoading;
    });
  }

  void _setEmptyData(bool isEmpty) {
    setState(() {
      _emptyData = isEmpty;
    });
  }

  Future<void> getData({int page = 1, int size = kSize}) async {
    /// n???u load l???n ?????u ho???c search th?? set loading v?? emptyData = false
    if (page == 1) {
      _setLoading(true);
      _setEmptyData(false);
    }

    /// ch??? bi???n data g???i l??n api
    Map body = {
      'page': page,
      'size': size,

      /// 'loadMore': true s??? load th??m 1 item
      'loadMore': true,
      ...widget.params,
    };

    /// g???i l??n v??? tr??
    if (widget.allowLocation) {
      body['lat'] = position.latitude;
      body['long'] = position.longitude;
    }
    // Map where = {};
    // if (widget.keySearch != null && widget.keySearch.isNotEmpty) {
    //   where = {
    //     'and': [
    //       {
    //         // widget.keySearch: {'like': widget.valueSearch}
    //       }
    //     ],
    //   };
    // }

    // body.addAllIf(where.keys.length > 0, {'where': where});

    // print(body);

    /// g???i api
    print(
        'AppListView get data paging = $page with params: ${json.encode(body)}');
    var rs = (await _httpService.dio.post(
      widget.url,
      data: body,
    )) as Response;

    await 0.3.delay();

    /// k???t th??c g???i api th?? t???t loading
    if (page == 1) {
      _setLoading(false);
    }

    /// n???u g???i th??nh c??ng
    if (rs.statusCode == 200) {
      var tempList = (rs.data['data'] as List);

      /// ki???m tra n???u size api tr??? v??? < size load th???c t??? th?? kh??ng c???n load more
      /// N???u size api tr??? v??? = size load th???c t??? th?? x??a ph???n t??? cu???i, ta ch??? d??ng ????ng size
      // if (tempList.length < size + 1) {
      //   _setEmptyData(true);
      // } else {
      //   tempList.removeLast();
      // }
      if (rs.data['paging']['count'] < size + 1) {
        _setEmptyData(true);
      }

      if (page > 1) {
        /// load more
        setState(() {
          widget.onChange(tempList, AppListViewType.loadMore);
        });
      } else {
        /// first load or search load
        setState(() {
          widget.onChange(tempList, null);
        });
      }

      this._paging.page = page;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: RefreshIndicator(
        color: mainColor,
        onRefresh: () async {
          await 0.8.delay();
          await getData(page: 1);
        },
        child: IfWidget(
          condition: _isLoading,
          right: ListFirstLoadingWidget(),
          wrong: IfWidget(
            condition: widget.value.length != 0,
            right: Scrollbar(
              isAlwaysShown: true,
              controller: _scrollController,
              radius: Radius.circular(50),
              child: ListView.separated(
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                itemBuilder: (BuildContext context, int index) {
                  if (index == widget.value.length) {
                    return IfWidget(
                      condition: !_emptyData,
                      right: LazyLoadProgressIndicator(isLoading: true),
                    );
                  }
                  return widget.itemBuilder(
                      context, index, widget.value[index]);
                },
                separatorBuilder: (BuildContext context, int index) {
                  return widget.showSeparator ? widget.separator : SizedBox();
                },
                itemCount: widget.value.length + 1,
                physics: const AlwaysScrollableScrollPhysics(),
                controller: _scrollController,
              ),
            ),
            wrong: Center(
              child: Text('Kh??ng t??m th???y d??? li???u'),
            ),
          ),
        ),
      ),
    );
  }
}

enum AppListViewType { loadMore }
