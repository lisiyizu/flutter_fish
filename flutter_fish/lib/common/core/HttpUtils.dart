import 'dart:async';

import 'package:dio/dio.dart';

import 'package:flutter_fish/common/core/RequestCtx.dart';

import 'HInterface.dart';

class HttpUtils{

  HAdapter _adapter;

  static final HttpUtils _instance = new HttpUtils._internal();

  static HttpUtils get() => _instance;

  factory HttpUtils() => _instance;

  HttpUtils._internal();

  setAdapter(HAdapter adapter){
    this._adapter = adapter;
  }

  Future<dynamic> req(String url, {String method,int timeout,
    Map<String, dynamic> header,
    Map<String, dynamic> params,
    Map<String, dynamic> body,
    Transformer transformer,
    List<Interceptor> interceptors}) {
    assert(_adapter!=null);
    try {
      RequestCtx ctx = new Builder()
          .setUrl(url)
          .setMethod(method)
          .setHeaderMap(header)
          .setTimeout(timeout)
          .setParams(params)
          .setResponseType(ResponseType.plain)
          .setBodyMap(body)
          .setTransformer(transformer)
          .setInterceptors(interceptors)
          .build();
      return _adapter.request(ctx);
      
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }

  String wrapUrlByParams(String url,Map<String, dynamic> params){
    String ret = url;
    if (params != null && params is Map && params.isNotEmpty) {
      StringBuffer sb = new StringBuffer("?");
      params.forEach((key, value) {
        sb.write("$key" + "=" + "$value" + "&");
      });
      String paramStr = sb.toString();
      paramStr = paramStr.substring(0, paramStr.length - 1);
      ret += paramStr;
    }
    return ret;
  }

}



