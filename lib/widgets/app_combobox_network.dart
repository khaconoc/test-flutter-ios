import 'package:bccp_mobile_v2/core/services/http_service.dart';
import 'package:bccp_mobile_v2/core/values/constains.dart';
import 'package:bccp_mobile_v2/widgets/if_widget.dart';
import 'package:bccp_mobile_v2/widgets/layout/layout_bottom_sheet.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;

import 'lazy_load_progress_indicator.dart';

class AppComboBoxNetwork extends StatefulWidget {
  final Function onChange;
  final List<Map<String, dynamic>> listItem;
  final dynamic value;
  final String hint;
  final bool maxSize;
  final TextStyle style;
  final String apiUrl;
  final Map params;

  AppComboBoxNetwork({
    @required this.onChange,
    this.listItem = const [],
    this.value,
    this.hint = '',
    this.maxSize = false,
    this.style = const TextStyle(),
    this.apiUrl,
    this.params = const {},
  });

  @override
  _AppComboBoxNetworkState createState() => _AppComboBoxNetworkState();
}

class _AppComboBoxNetworkState extends State<AppComboBoxNetwork> {
  HttpService _httpService = Get.find();
  String _text;
  dynamic _value;

  @override
  void initState() {
    super.initState();
    if (widget.value != null && widget.value != '') {
      pathValue();
    }
  }

  // @override
  // void didUpdateWidget(AppComboBoxNetwork oldWidget) {
  //   // if (oldWidget.value != widget.value) {
  //   //   pathValue();
  //   // }
  //   super.didUpdateWidget(oldWidget);
  // }

  void setValueControl({String text, dynamic value}) {
    setState(() {
      _text = text;
      _value = value;
    });
  }

  void setText(String text) {
    setState(() {
      _text = text;
    });
  }

  void pathValue() async {
    var item = widget.listItem.firstWhere(
        (element) => element['value'].toString() == widget.value.toString(),
        orElse: () => null);
    if (item != null) {
      setValueControl(text: item['text'], value: item['value']);
    }

    Map<dynamic, dynamic> json = {
      'valueSearch': [widget.value],
    };
    var rs = (await _httpService.dio.post(
      widget.apiUrl,
      data: json,
    )) as Response;

    if (rs.statusCode == 200) {
      var item = (rs.data['data'] as List).firstWhere(
          (element) => element['value'].toString() == widget.value.toString(),
          orElse: () => null);
      if (item != null) {
        setValueControl(text: item['text'], value: item['value']);
      }
    }
  }

  removeValue() {
    if (widget.value is String) {
      widget.onChange(null);
      setValueControl(text: '', value: null);
    } else {
      widget.onChange(null);
      setValueControl(text: '', value: null);
    }
  }

  showBottomSheetSelect(BuildContext context) async {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (thisLowerContext, innerSetState) {
          return ViewSelect(
            apiUrl: widget.apiUrl,
            value: widget.value,
            hint: widget.hint,
            listItem: widget.listItem,
            params: widget.params,
            onChange: (value) {
              widget.onChange(value);
              setValueControl(text: value['text'], value: value['value']);
              Navigator.pop(context);
            },
            onUnSelect: removeValue,
          );
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: () {
          showBottomSheetSelect(context);
        },
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              _value != null ? _text : widget.hint,
              style: widget.style,
            ),
            IfWidget(
              condition: widget.maxSize,
              right: Spacer(),
            ),
            Icon(Icons.arrow_drop_down_rounded),
          ],
        ),
      ),
    );
  }
}

class ViewSelect extends StatefulWidget {
  final String hint;
  final Function onChange;
  final Function onUnSelect;
  final List<Map<String, dynamic>> listItem;
  final dynamic value;
  final String apiUrl;
  final Map params;

  ViewSelect({
    this.hint,
    this.onChange,
    this.listItem,
    this.value,
    this.apiUrl,
    this.params = const {},
    this.onUnSelect,
  });

  @override
  _ViewSelectState createState() => _ViewSelectState();
}

class _ViewSelectState extends State<ViewSelect> {
  HttpService _httpService = Get.find();
  ScrollController _scrollController = new ScrollController();

  bool _isLoading = false;
  bool _emptyData = false;
  int page = 1;

  List listValueControl = [];

  bool isSelected = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
              _scrollController.position.maxScrollExtent &&
          !_emptyData) {
        getData(page: this.page + 1);
      }
    });

    if (widget.value is Map && (widget.value as Map).length > 0) {
      setState(() {
        isSelected = true;
      });
    } else if (widget.value is String && widget.value != '') {
      setState(() {
        isSelected = true;
      });
    }

    getData();
  }

  void setLoading(bool loading) {
    setState(() {
      _isLoading = loading;
    });
  }

  void setEmptyData(bool empty) {
    setState(() {
      _emptyData = empty;
    });
  }

  void getData({int page = 1, int size = kSize}) async {
    print('fetch $page');
    if (page == 1) {
      setLoading(true);
      setEmptyData(false);
    }

    Map<dynamic, dynamic> json = {
      'page': page,
      'size': size,
      'loadMore': true,
      ...widget.params,
    };
    if (page == 1) {
      setLoading(true);
    }
    var rs = (await _httpService.dio.post(
      widget.apiUrl,
      data: json,
    )) as Response;
    // await 0.3.delay();
    if (page == 1) {
      setLoading(false);
    }
    if (rs.statusCode == 200) {
      var listTemp = rs.data['data'] as List;

      if (rs.data['paging']['count'] < size + 1) {
        setEmptyData(true);
      }
      // else {
      //   listTemp.removeLast();
      // }

      if (page == 1) {
        listValueControl.addAll(widget.listItem);
      }

      setState(() {
        listValueControl.addAll(listTemp);
      });

      this.page = page;
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBottomSheet(
      title: widget.hint,
      textActionRight: isSelected ? 'Bỏ chọn' : 'Đóng',
      onPressActionRight: widget.onUnSelect,
      child: Expanded(
        child: Container(
          color: Colors.white,
          child: IfWidget(
            condition: _isLoading,
            right: Container(
              width: MediaQuery.of(context).size.width,
              child: LazyLoadProgressIndicator(isLoading: true),
            ),
            wrong: ListView.separated(
              physics: BouncingScrollPhysics(),
              padding: const EdgeInsets.all(8),
              itemCount: listValueControl.length + 1,
              controller: _scrollController,
              itemBuilder: (BuildContext context, int index) {
                if (listValueControl.length == 0) {
                  return Center(child: Text('Không tìm thấy dữ liệu'));
                }
                if (index == listValueControl.length) {
                  return IfWidget(
                    condition: !_emptyData,
                    right: LazyLoadProgressIndicator(isLoading: true),
                  );
                }
                return InkWell(
                  onTap: () {
                    widget.onChange(listValueControl[index]);
                  },
                  child: Container(
                    height: 50,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              listValueControl[index]['text'].toString(),
                            ),
                          ),
                          IfWidget(
                            condition: compare(
                                listValueControl[index]['value'], widget.value),
                            // listValueControl[index]['value'].toString() ==
                            //     widget.value.toString(),
                            right: Icon(
                              Icons.check,
                              color: Colors.green,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) =>
                  const SizedBox(
                child: Divider(),
                width: 100,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

bool compare(dynamic s, dynamic d) {
  if (s is String && d is String) {
    return s == d;
  }
  if (s is Map && d is Map) {
    if (mapEquals(s, d)) return true;
    return false;
  }
  return false;
}
