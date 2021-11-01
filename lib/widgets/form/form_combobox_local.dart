import 'dart:convert';

import 'package:bccp_mobile_v2/core/services/http_service.dart';
import 'package:bccp_mobile_v2/core/values/constains.dart';
import 'package:bccp_mobile_v2/theme/colors_theme.dart';
import 'package:bccp_mobile_v2/widgets/if_widget.dart';
import 'package:bccp_mobile_v2/widgets/layout/layout_bottom_sheet.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;
import 'dart:convert';

import '../lazy_load_progress_indicator.dart';

class FormComBoBoxLocal extends StatefulWidget {

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

  /// tiêu đề hiển thị trên
  final String label;

  final bool disabled;

  /// hiển thị lỗi
  final String error;

  /// hiển thị (*)
  final bool important;

  /// cho phep bỏ chọn
  final bool allowClear;

  FormComBoBoxLocal({
    @required this.onChange,
    this.listItem = const [],
    this.value,
    this.hint = '',
    this.maxSize = false,
    this.style = const TextStyle(),
    this.label = '',
    this.disabled = false,
    this.error = '',
    this.important = false,
    this.allowClear = true,
  });

  @override
  _FormComBoBoxLocalState createState() => _FormComBoBoxLocalState();
}

class _FormComBoBoxLocalState extends State<FormComBoBoxLocal> {
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
  void didUpdateWidget(FormComBoBoxLocal oldWidget) {
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
    var item = widget.listItem.firstWhere(
        (element) => element['value'].toString() == widget.value.toString(),
        orElse: () => null);
    if (item != null) {
      setValueControl(text: item['text'], value: item['value']);
      return;
    }

    if(widget.value == null) {
      return;
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
            value: widget.value,
            hint: widget.hint,
            listItem: widget.listItem,
            allowClear: widget.allowClear,
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

  final bool allowClear;

  ViewSelect({
    this.hint,
    this.onChange,
    this.listItem,
    this.value,
    this.onUnSelect,
    this.allowClear,
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
    listValueControl.addAll(widget.listItem);
    /// nếu load data thành công thì check lengt
    /// nếu length = size + 1 thì xóa phần tử cuối đi
    /// nếu length < size + 1 thì là hết page, set empty data để không phải load page tiếp
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBottomSheet(
      title: widget.hint,
      textActionRight:  !widget.allowClear ? 'Đóng' : isSelected ? 'Bỏ chọn' : 'Đóng',
      onPressActionRight: widget.allowClear ? null : widget.onUnSelect,
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
              itemCount: listValueControl.length,
              controller: _scrollController,
              itemBuilder: (BuildContext context, int index) {
                if (listValueControl.length == 0) {
                  return Center(child: Text('Không tìm thấy dữ liệu'));
                }
                // if (index == listValueControl.length) {
                //   return IfWidget(
                //     condition: !_emptyData,
                //     right: LazyLoadProgressIndicator(isLoading: true),
                //   );
                // }
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
  // if (s is Map && d is Map) {
  //   if (mapEquals(s, d)) return true;
  //   return false;
  // }
  if (s is Map && d is Map) {
    return json.encode(s) == json.encode(d);
  }
  return false;
}
