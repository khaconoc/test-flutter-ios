import 'dart:convert';

import 'package:bccp_mobile_v2/core/services/http_service.dart';
import 'package:bccp_mobile_v2/core/values/constains.dart';
import 'package:bccp_mobile_v2/theme/colors_theme.dart';
import 'package:bccp_mobile_v2/widgets/form/form_input_text.dart';
import 'package:bccp_mobile_v2/widgets/if_widget.dart';
import 'package:bccp_mobile_v2/widgets/layout/layout_bottom_sheet.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;
import 'package:rxdart/rxdart.dart';
import 'dart:convert';

import '../combobox_placeholder_loading.dart';
import '../lazy_load_progress_indicator.dart';

class FormComBoBoxNetwork extends StatefulWidget {

  /// dùng onChange đẩy value ra bên người
  final Function onChange;

  /// list item local muốn kết hợp với api
  final List<Map<String, dynamic>> listItem;

  /// value nhận vào
  final dynamic value;

  /// text hiển thi khi chưa chọn
  final String hint;

  /// auto max width
  final bool maxSize;

  /// style cho text trong control
  final TextStyle style;

  /// url api combobox
  final String apiUrl;

  /// params
  final Map params;

  /// tiêu đề hiển thị trên
  final String label;

  final bool disabled;

  final bool showSearch;

  /// hiển thị lỗi
  final String error;

  /// hiển thị (*)
  final bool important;

  final Widget prefix;
  final Widget suffix;

  FormComBoBoxNetwork({
    @required this.onChange,
    this.listItem = const [],
    this.value,
    this.hint = '',
    this.maxSize = false,
    this.style = const TextStyle(),
    this.apiUrl,
    this.params = const {},
    this.label = '',
    this.disabled = false,
    this.showSearch = false,
    this.error = '',
    this.important = false,
    this.prefix,
    this.suffix,
  });

  @override
  _FormComBoBoxNetworkState createState() => _FormComBoBoxNetworkState();
}

class _FormComBoBoxNetworkState extends State<FormComBoBoxNetwork> {
  /// get service http
  HttpService _httpService = Get.find();

  /// text hiển thị lên control
  String _text;

  /// value temp control
  dynamic _value;

  @override
  void initState() {
    super.initState();
    /// nếu có value mặc định thì tìm và chọn vào value đó
    if (widget.value != null && widget.value != '') {
      pathValue();
    }
  }

  @override
  void didUpdateWidget(FormComBoBoxNetwork oldWidget) {
    if (oldWidget.value != widget.value) {
      pathValue();
    }
    super.didUpdateWidget(oldWidget);
  }

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
    /// tìm value trong list local trước
    /// nếu tìm thấy thì setValue control bằng value đó,
    /// nếu không tìm thấy thì tìm từ api
    var label = widget.label;
    var item = widget.listItem.firstWhere(
        (element) => element['value'].toString() == widget.value.toString(),
        orElse: () => null);
    if (item != null) {
      setValueControl(text: item['text'], value: item['value']);
      return;
    }

    if(widget.value == null) {
      setValueControl(text: '', value: null);
      return;
    }

    /// tìm value từ api
    Map<dynamic, dynamic> dataSend = {
      'valueSearch': [widget.value],
      ...widget.params
    };
    var rs = (await _httpService.dio.post(
      widget.apiUrl,
      data: dataSend,
    )) as Response;

    if (rs.statusCode == 200) {
      var item = (rs.data['data'] as List).firstWhere(
          (element) => compare(element['value'],widget.value),
          orElse: () => null);
      /// tìm thấy value thì set value control
      if (item != null) {
        setValueControl(text: item['text'], value: item['value']);
        return;
      }
    }
    /// ngược lại không tìm thấy thì set giá trị mặc định null
    setValueControl(text: '', value: null);
  }

  /// xóa value khi đã chọn
  removeValue() {
    if (widget.value is String) {
      widget.onChange(null);
      setValueControl(text: '', value: null);
    } else {
      widget.onChange(null);
      setValueControl(text: '', value: null);
    }
  }

  /// hiển bị bottom sheet danh sách select
  /// danh sách sẽ được kết hợp giữ list local + list paging api
  showBottomSheetSelect(BuildContext context) async {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (thisLowerContext, innerSetState) {
          ///**************************************************************
          /// tách ra widget mới vì để chung khó setState để rerender UI được
          return ViewSelect(
            apiUrl: widget.apiUrl,
            value: widget.value,
            hint: widget.hint,
            listItem: widget.listItem,
            params: widget.params,
            showSearch: widget.showSearch,
            onChange: (value) {
              /// khi press vào item trên list thì list đẩy value ra đây
              /// ở đây sẽ đẩy value ra ngoài widget cha
              widget.onChange(value);
              // setText(value['text']);
              // innerSetState(() {
              //   _text = value['text'];
              // });
              /// và set value control để show lên cho người dùng
              setValueControl(text: value['text'], value: value['value']);
              // print(value['text']);
              /// đóng bottom sheet
              Navigator.pop(context);
            },
            /// sự kiện bỏ chọn
            onUnSelect: removeValue,
          );
        });
      },
    );
  }

  /// render giao diện control
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// render tiêu đề trên control
          IfWidget(condition: widget.label != '', right: Padding(
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
          )),
          /// render control
          InkWell(
            onTap: widget.disabled
                ? null
                : () {
                    showBottomSheetSelect(context);
                  },
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                  color: widget.disabled
                      ? Colors.grey.withAlpha(50)
                      : mainColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(10),
                  border: (widget.error.isNotEmpty && !widget.disabled)
                      ? Border.all(color: Colors.redAccent)
                      : null),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  IfWidget(condition: widget.prefix != null, right: widget.prefix),
                  IfWidget(condition: widget.prefix != null, right: VerticalDivider(),),
                  Expanded(
                    child: Text(
                      _value != null ? _text : widget.hint,
                      style: widget.style,
                    ),
                  ),
                  IfWidget(
                    condition: !widget.disabled,
                    right: Icon(Icons.arrow_drop_down_rounded),
                  ),
                  IfWidget(condition: widget.suffix != null, right: VerticalDivider(),),
                  IfWidget(condition: widget.suffix != null, right: widget.suffix),
                  SizedBox(
                    width: 10,
                  ),
                ],
              ),
            ),
          ),
          /// render lỗi nếu có
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

class ViewSelect extends StatefulWidget {
  /// hiển thị tiêu đề bottom sheet
  final String hint;

  /// sự kiện onchange khi press select
  final Function onChange;

  /// sự kiện hủy chọn
  final Function onUnSelect;

  /// list item local add them vào danh sách chọn
  final List<Map<String, dynamic>> listItem;

  /// value control đang giữ để hiển thị biểu tượng check đã chọn
  final dynamic value;

  /// url để gọi api
  final String apiUrl;

  final bool showSearch;

  /// params để gọi api
  final Map params;

  ViewSelect({
    this.hint,
    this.onChange,
    this.listItem,
    this.value,
    this.apiUrl,
    this.params = const {},
    this.onUnSelect,
    this.showSearch = false,
  });

  @override
  _ViewSelectState createState() => _ViewSelectState();
}

class _ViewSelectState extends State<ViewSelect> {
  /// gọi service http dio
  HttpService _httpService = Get.find();

  /// controller lắng nghe khi cuộn tới cuối để load page tiếp theo
  ScrollController _scrollController = new ScrollController();

  /// load lần đầu
  bool _isLoading = false;

  /// khi không còn dữ liệu thì không cần get thêm page
  bool _emptyData = false;

  /// page đầu tiên là 1
  int page = 1;

  /// list value lấy được từ api
  List listValueControl = [];

  /// check có giá trị mặc định chưa,
  /// nếu có hiển thị nút bỏ chọn
  /// nếu chưa hiển thị nút đóng
  bool isSelected = false;

  final _textSearchSubject = new PublishSubject<String>();
  String _textSearch = '';

  @override
  void initState() {
    super.initState();
    /// đăng ký lắng nge khi cuộn page
    /// khi cuộn tới cuối thì lấy dữ liệu page kế tiếp
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
              _scrollController.position.maxScrollExtent &&
          !_emptyData) {
        getData(page: this.page + 1);
      }
    });

    _textSearchSubject
        .debounceTime(Duration(milliseconds: 800))
        .listen((textSearch) {
          print('rxdart search');
      getData();
    });

    /// check xem control có value chưa
    /// cần tối ưu
    if (widget.value is Map && (widget.value as Map).length > 0) {
      setState(() {
        isSelected = true;
      });
    } else if (widget.value is String && widget.value != '') {
      setState(() {
        isSelected = true;
      });
    }

    /// gọi lấy data mặc định
    getData();
  }

  @override
  void dispose() {
    _textSearchSubject.close();
    super.dispose();
  }

  void setTextSearch(String value) {
    setState(() {
      _textSearch = value;
    });
    _textSearchSubject.add(value);
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

    /// load size thêm 1 phần tử

    /// map thêm params vào page, size mặc định
    Map<dynamic, dynamic> body = {
      'page': page,
      'size': size,
      'loadMore': true,
      ...widget.params,
    };

    if (_textSearch != null && _textSearch != '') {
      body['textSearch'] = _textSearch;
    }

    /// nếu page = 1: load lần đầu hoặc tìm kiếm thì hiển thị loading
    if (page == 1) {
      listValueControl.clear();
      setLoading(true);
      setEmptyData(false);
    }

    String x = json.encode(body);
    /// gọi lên server để lấy dữ liệu
    var rs = (await _httpService.dio.post(
      widget.apiUrl,
      data: body,
    )) as Response;

    /// đợi ít nhât 0.3s để cho hiệu ứng không bị giật
    await 0.3.delay();

    /// nếu page đầu tiên thì tắt hiệu ứng loading đang bật
    if (page == 1) {
      setLoading(false);
    }

    /// nếu load data thành công thì check lengt
    /// nếu length = size + 1 thì xóa phần tử cuối đi
    /// nếu length < size + 1 thì là hết page, set empty data để không phải load page tiếp
    if (rs.statusCode == 200) {
      var listTemp = rs.data['data'] as List;

      if (listTemp.length < size + 1) {
        setEmptyData(true);
      } else {
        listTemp.removeLast();
      }

      /// nếu là page đầu tiên thì add thêm list local vào
      if (page == 1) {
        listValueControl.addAll(widget.listItem);
      }

      /// add các phẩn tử load được từ api
      setState(() {
        listValueControl.addAll(listTemp);
      });

      /// gán page bằng page hiện tại
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
        child: Column(
          children: [
            Container(
              color: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: FormInputText(
                onChange: (value) {
                  setTextSearch(value);
                },
                value: _textSearch,
                hintText: 'Nhập tìm kiếm...',
              ),
            ),
            Expanded(child: Container(
              color: Colors.white,
              child: IfWidget(
                condition: _isLoading,
                right: Container(
                  width: MediaQuery.of(context).size.width,
                  // child: LazyLoadProgressIndicator(isLoading: true),
                  child: ComboboxPlaceHolderLoading(),
                ),
                wrong: ListView.separated(
                  keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
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
            ),)
          ],
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
    // return json.encode(s) == json.encode(d);
    return mapEquals(s,d);
  }
  return false;
}
