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

    /// Đăng ký lắng nge scroll list
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
              _scrollController.position.maxScrollExtent &&
          !_emptyData) {
        getData(page: this._paging.page + 1);
      }
    });

    /// đăng ký lắng nghe text search thay đổi giá trị
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
    /// nếu load lần đầu hoặc search thì set loading và emptyData = false
    if (page == 1) {
      _setLoading(true);
      _setEmptyData(false);
    }

    /// chế biến data gọi lên api
    Map body = {
      'page': page,
      'size': size,

      /// 'loadMore': true sẽ load thêm 1 item
      'loadMore': true,
      ...widget.params,
    };

    /// gửi lên vị trí
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

    /// gọi api
    print(
        'AppListView get data paging = $page with params: ${json.encode(body)}');
    var rs = (await _httpService.dio.post(
      widget.url,
      data: body,
    )) as Response;

    await 0.3.delay();

    /// kết thúc gọi api thì tắt loading
    if (page == 1) {
      _setLoading(false);
    }

    /// nếu gọi thành công
    if (rs.statusCode == 200) {
      var tempList = (rs.data['data'] as List);

      /// kiểm tra nếu size api trả về < size load thực tế thì không cần load more
      /// Nếu size api trả về = size load thực tế thì xóa phần tử cuối, ta chỉ dùng đúng size
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
              child: Text('Không tìm thấy dữ liệu'),
            ),
          ),
        ),
      ),
    );
  }
}

enum AppListViewType { loadMore }
