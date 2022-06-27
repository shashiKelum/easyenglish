/*
 * Copyright 2021 CeylonCodeLabs. All rights reserved.
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 * http://www.apache.org/licenses/LICENSE-2.0
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import 'package:flutter/material.dart';

class StreamWidget<T> extends StatelessWidget {
  final Stream<T> stream;
  final T? initialValue;

  /// If null, will use default Centered Circular Progress Indicator
  final Widget Function()? waiting;
  final Widget Function(Object? error)? error;
  final Widget Function(T? data) done;
  final bool showError;

  const StreamWidget(
      {Key? key,
      required this.stream,
      this.initialValue,
      this.waiting,
      this.error,
      this.showError = true,
      required this.done})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<T>(
      stream: stream,
      builder: (BuildContext context, AsyncSnapshot<T> snapshot) {
        if (snapshot.hasError)
          return !showError
              ? Container()
              : error != null
                  ? error!(snapshot.error)
                  : Container(
                      padding: EdgeInsets.all(16),
                      child: Text(
                        '${snapshot.error}',
                        textAlign: TextAlign.center,
                      ),
                    );
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            if (initialValue != null) return done(initialValue);
            return waiting == null
                ? Center(child: CircularProgressIndicator())
                : waiting!();
          case ConnectionState.active:
          case ConnectionState.done:
            return done(snapshot.data);
        }
      },
    );
  }
}
