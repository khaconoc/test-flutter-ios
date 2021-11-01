import 'dart:convert';

import 'package:bccp_mobile_v2/core/services/http_service.dart';
import 'package:bccp_mobile_v2/core/values/constains.dart';
import 'package:bccp_mobile_v2/theme/colors_theme.dart';
import 'package:bccp_mobile_v2/widgets/if_widget.dart';
import 'package:bccp_mobile_v2/widgets/layout/layout_bottom_sheet.dart';
import 'package:collection/collection.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart' hide Response;

import '../lazy_load_progress_indicator.dart';
import 'package:bccp_mobile_v2/core/extentions/string_extention.dart';

class FormComBoBoxNetworkMulti extends StatefulWidget {
  final Function onChange;
  final List<Map<String, dynamic>> listItem;
  final List value;
  final String hint;
  final bool maxSize;
  final TextStyle style;
  final String apiUrl;
  final Map params;
  final String label;
  final bool disabled;
  final String error;
  final bool important;

  /// chú ý
  /// value là danh sách chuỗi hoặc có thể là kiểu Map
  /// tuy nhiên nếu value là kiểu Map thì các key: value không được chứa list
  FormComBoBoxNetworkMulti({
    @required this.onChange,
    this.listItem = const [],
    this.value = const [],
    this.hint = '',
    this.maxSize = false,
    this.style = const TextStyle(),
    this.apiUrl,
    this.params = const {},
    this.label = '',
    this.disabled = false,
    this.error = '',
    this.important = false,
  });

  @override
  _FormComBoBoxNetworkMultiState createState() =>
      _FormComBoBoxNetworkMultiState();
}

class _FormComBoBoxNetworkMultiState extends State<FormComBoBoxNetworkMulti> {
  HttpService _httpService = Get.find();
  String _text;
  dynamic _value;
  List _listSelected = [];

  bool _isLoading = false;

  List listValueControlKeep = [];
  Function deepEq = const DeepCollectionEquality().equals;

  @override
  void initState() {
    super.initState();
    setState(() {
      _listSelected = List.from(widget.value);
    });
    if (widget.value != null && widget.value.length > 0) {
      pathValue();
    }
  }

  @override
  void didUpdateWidget(FormComBoBoxNetworkMulti oldWidget) {
    var compare = deepEq(widget.value, listValueControlKeep);
    if(!compare) {
      setState(() {
        listValueControlKeep = List.from(widget.value);
      });
      pathValue();
    }
    super.didUpdateWidget(oldWidget);
  }

  void setLoading(bool loading) {
    setState(() {
      _isLoading = loading;
    });
  }

  void setValueControl({String text, dynamic value}) {
    setState(() {
      _text = text;
      _value = value;
    });
  }

  void addValueList(List lst) {
    setState(() {
      _listSelected.addAll(lst);
    });
  }

  void changeValueList(List lst) {
    setState(() {
      _listSelected.clear();
      _listSelected.addAll(lst);
    });
  }

  void setText(String text) {
    setState(() {
      _text = text;
    });
  }

  /// path value from parent widget to control
  void pathValue() async {
    if(widget.value.length < 1) return;
    setLoading(true);
    setState(() {
      _listSelected.clear();
    });

    /// tìm tất cả value trong list local
    // var itemListFind = widget.listItem.where((element) => setTemp.contains(element['value'])).toList();
    var itemListFind = widget.listItem.where((element) => widget.value.customExists(element['value']) != -1).toList();
    if(itemListFind.length > 0) {
      addValueList(itemListFind);
    }

    /// nếu list chọn local đủ tất cả giá trị thì không cần tìm trên api
    if(itemListFind.length == widget.value.length) {
      setLoading(false);
      return;
    }
    Map<dynamic, dynamic> json = {
      'valueSearch': [...widget.value],
    };

    var rs = (await _httpService.dio.post(
      widget.apiUrl,
      data: json,
    )) as Response;

    if (rs.statusCode == 200) {
      var itemListFindApi = (rs.data['data'] as List).where(
          (element) => widget.value.customExists(element['value']) != -1).toList();
      if (itemListFindApi.length > 0) {
        addValueList(itemListFindApi);
        setLoading(false);
        return;
      }
    }
    setLoading(false);
    // setValueControl(text: '', value: null);
  }

  void pathValueAfterSelected(List listValueAll) async {
    changeValueList(listValueAll);
  }

  /// on remove value
  removeValue() {
    if (widget.value is String) {
      widget.onChange(null);
      setValueControl(text: '', value: null);
    } else {
      widget.onChange(null);
      setValueControl(text: '', value: null);
    }
  }

  onEmitValueChange(List listAllValue) {
    var valueEmit = listAllValue.map((e) => e['value']).toList();

    /// path value select vao control
    pathValueAfterSelected(listAllValue);

    /// day value select ra ben ngoai
    widget.onChange(valueEmit);

    /// giu list select de khong bi render nhieu lan
    setState(() {
      listValueControlKeep = List.from(valueEmit);
    });

    /// đóng bottomsheet
    Navigator.pop(context);
  }

  /// show bottom sheet select multiple
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
              onEmitValueChange(value);
            },
            onUnSelect: removeValue,
          );
        });
      },
    );
  }

  /// render item selected in control
  _renderItemSelectedTag(String text) {
    return Container(
      padding: EdgeInsets.all(3),
      margin: EdgeInsets.only(top: 3, right: 3, bottom: 3),
      decoration: BoxDecoration(
        color: mainColor.withAlpha(50),
        borderRadius: BorderRadius.circular(5)
      ),
      child: Text(text.trim().maxLength()??''),
    );
  }


  ///********************************************************
  ///********************************************************
  ///********************************************************
  ///********************************************************
  /// render control show with user
  /// todo: render control show with user
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 5.0, bottom: 5.0),
            child: RichText(
              text: TextSpan(
                  text: widget.label,
                  style: TextStyle(color: Colors.black),
                  children: [
                    widget.important
                        ? TextSpan(
                            text: ' *',
                            style: TextStyle(color: Colors.redAccent),
                          )
                        : TextSpan()
                  ]),
            ),
          ),
          InkWell(
            onTap: widget.disabled
                ? null
                : () {
                    showBottomSheetSelect(context);
                  },
            child: Container(
              decoration: BoxDecoration(
                  color: widget.disabled
                      ? Colors.grey.withAlpha(50)
                      : mainColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(10),
                  border: (widget.error.isNotEmpty && !widget.disabled)
                      ? Border.all(color: Colors.redAccent)
                      : null),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: 50
                ),
                child: IfWidget(
                  condition: !_isLoading,
                  right: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: IfWidget(
                          condition: _listSelected.length == 0,
                          right: Text(
                            _listSelected.length == 0 ? widget.hint : '',
                            style: widget.style,
                          ),
                          wrong: Wrap(
                            children: [
                              ...List.generate(_listSelected.length, (index) {
                                return _renderItemSelectedTag(_listSelected[index]['text']);
                              }).toList()
                            ],
                          ),
                        ),
                      ),
                      IfWidget(
                        condition: !widget.disabled,
                        right: Icon(Icons.arrow_drop_down_rounded),
                      ),
                    ],
                  ),
                  wrong: SpinKitFadingCircle(color: Colors.grey, size: 20,),
                ),
              ),
            ),
          ),
          IfWidget(
            condition: widget.error.isNotEmpty && !widget.disabled,
            right: Padding(
              padding: const EdgeInsets.only(left: 5.0),
              child: Text(
                widget.error,
                style: TextStyle(color: Colors.redAccent),
              ),
            ),
          ),
        ],
      ),
    );
  }
}











/// todo: bottom sheet select
///************************************************************
/// widget dialog
/// ***********************************************************
class ViewSelect extends StatefulWidget {

  /// gợi ý
  final String hint;

  /// event select
  final Function onChange;

  /// event bỏ chọn tất cả
  final Function onUnSelect;

  /// list local để add them vào trước list api
  final List<Map<String, dynamic>> listItem;

  /// value có sẵn
  final List value;

  /// endpoint api
  final String apiUrl;

  /// tham số gọi api
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

  List listOfData = [];

  bool isSelected = false;

  List selectedValueInControl = [];

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

    setState(() {
      selectedValueInControl = List.from(widget.value);
    });

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
    await 0.3.delay();
    if (page == 1) {
      setLoading(false);
    }
    if (rs.statusCode == 200) {
      var listTemp = rs.data['data'] as List;

      if (listTemp.length < size + 1) {
        setEmptyData(true);
      } else {
        listTemp.removeLast();
      }

      if (page == 1) {
        listOfData.addAll(widget.listItem);
      }

      setState(() {
        listOfData.addAll(listTemp);
      });

      this.page = page;
    }
  }

  void toggleSelect(dynamic obj) {
    var value = obj['value'];
    var index = selectedValueInControl.customExists(value);
    if (index != -1) {
      selectedValueInControl.removeAt(index);
    } else {
      selectedValueInControl.add(value);
    }
    setState(() {});
  }

  onEmitSelect() {
    // widget.onChange(List.from(selectedValueInControl));
    var listAllValue = listOfData.where((element) => selectedValueInControl.customExists(element['value']) != -1).toList();
    widget.onChange(listAllValue);
  }

  onEmitSelectClear() {
    widget.onChange([]);
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
            wrong: Column(
              children: [
                Expanded(
                    child: ListView.separated(
                  physics: BouncingScrollPhysics(),
                  padding: const EdgeInsets.all(8),
                  itemCount: listOfData.length + 1,
                  controller: _scrollController,
                  itemBuilder: (BuildContext context, int index) {
                    if (listOfData.length == 0) {
                      return Center(child: Text('Không tìm thấy dữ liệu'));
                    }
                    if (index == listOfData.length) {
                      return IfWidget(
                        condition: !_emptyData,
                        right: LazyLoadProgressIndicator(isLoading: true),
                      );
                    }
                    return InkWell(
                      onTap: () {
                        toggleSelect(listOfData[index]);
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
                                  listOfData[index]['text'].toString(),
                                ),
                              ),
                              IfWidget(
                                condition: selectedValueInControl.customExists(listOfData[index]['value']) != -1,
                                // condition: selectedValue
                                //     .contains(listValueControl[index]['value']),
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
                )),
                Container(
                  padding: EdgeInsets.all(0),
                  child: Row(
                    mainAxisAlignment: widget.value.length > 0 ? MainAxisAlignment.spaceAround : MainAxisAlignment.center,
                    children: [
                      IfWidget(
                        condition: widget.value.length > 0,
                        right: TextButton(
                          child: Text(
                            'Bỏ chọn tất cả',
                            style: TextStyle(
                              color: Colors.redAccent.shade100,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onPressed: () {
                            onEmitSelectClear();
                          },
                        ),
                      ),
                      TextButton(
                        child: Text(
                          'Chọn ${selectedValueInControl.length}',
                          style: TextStyle(
                            color: mainColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onPressed: () {
                          onEmitSelect();
                        },
                      )
                    ],
                  ),
                ),
              ],
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
  // if (s is Map && d is Map) {
  //   if (mapEquals(s, d)) return true;
  //   return false;
  // }
  if (s is Map && d is Map) {
    return json.encode(s) == json.encode(d);
  }
  return false;
}

extension ExistsInList on List {
  int customExists(dynamic value) {
    if(!(value is  Map)) {
      return this.indexOf(value) ;
    } else {
      var item = this.indexWhere((element) => mapEquals(value, element));
      return item;
    }
  }
}