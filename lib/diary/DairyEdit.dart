import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:nyangstar/diary/dao/DiaryEntry.dart';

class DiaryEditPage extends StatefulWidget {
  @override
  _DiaryEditPageState createState() => _DiaryEditPageState();
}

class _DiaryEditPageState extends State<DiaryEditPage> {
  final quill.QuillController _controller = quill.QuillController.basic();
  final FocusNode _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '다이어리 작성',
          style: TextStyle(
              fontFamily: 'HiMelody',
              fontSize: 34,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            quill.QuillToolbar.simple(
              configurations: quill.QuillSimpleToolbarConfigurations(
                controller: _controller,
              ),
            ),
            Expanded(
              child:
              quill.QuillEditor.basic(
                focusNode: _focusNode,
                configurations: quill.QuillEditorConfigurations(
                  controller: _controller,
                  scrollable: true,
                  placeholder: "내용을 입력 해주세요.",
                  padding: EdgeInsets.zero,
                ),
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // @Todo 다이어리 작성 api 요청 구현 필요
                Navigator.pop(
                  context,
                  DiaryEntry(
                    content: _controller.document.toPlainText(),
                    author: '사용자 이름',
                    profilePicture: 'images/profile_picture.png',
                    date: DateTime.now(),
                  ),
                );
              },
              child: Text('저장'),
            ),
          ],
        ),
      ),
    );
  }
}
