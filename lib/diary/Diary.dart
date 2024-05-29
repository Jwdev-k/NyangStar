import 'package:flutter/material.dart';
import 'package:nyangstar/api/login/LoginApi.dart';
import 'package:nyangstar/diary/DairyEdit.dart';
import 'package:nyangstar/diary/dao/DiaryEntry.dart';
import 'package:nyangstar/main.dart';
import 'package:provider/provider.dart';

class Diary extends StatefulWidget {
  Diary({super.key});

  @override
  State<Diary> createState() => _DiaryState();
}

class _DiaryState extends State<Diary> {
  List<DiaryEntry> diaryEntries = []; // 다이어리 목록

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'NyangStar',
          style: TextStyle(
              fontFamily: 'HiMelody',
              fontSize: 34,
              fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor:
        themeProvider.themeMode == ThemeMode.dark ? Colors.black12 : Colors
            .white,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundImage: AssetImage(
                  'images/profile_picture.png'), // replace with your profile image asset
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: Column(
          children: [
            DrawerHeader(
              child: Text(
                'Menu',
                style: TextStyle(
                    fontFamily: 'HiMelody',
                    fontSize: 28,
                    fontWeight: FontWeight.bold),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () {
                Navigator.of(context).pop(); // close the drawer
                Navigator.of(context).pushNamed("/home");
              },
            ),
            ListTile(
              leading: Icon(Icons.book),
              title: Text('Diary'),
              onTap: () {
                Navigator.of(context).pop(); // close the drawer
                Navigator.of(context).pushNamed("/diary");
              },
            ),
            ListTile(
              leading: Icon(Icons.calendar_today),
              title: Text('Calendar'),
              onTap: () {
                Navigator.of(context).pop(); // close the drawer
                Navigator.of(context).pushNamed("/calendar");
              },
            ),
            Spacer(),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () {
                Navigator.of(context).pop(); // close the drawer
                Navigator.of(context).pushNamed("/settings");
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
              onTap: () {
                LoginApi().signOut(context);
              },
            ),
          ],
        ),
      ),
      body: ListView.builder(
        itemCount: diaryEntries.length,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            child: ListTile(
              contentPadding: EdgeInsets.all(8.0),
              leading: CircleAvatar(
                backgroundImage: AssetImage(diaryEntries[index].profilePicture), // 프로필 사진 이미지
              ),
              title: Text(
                diaryEntries[index].author,
                style: TextStyle(fontWeight: FontWeight.bold),
              ), // 사용자 이름
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    diaryEntries[index].content,
                    overflow: TextOverflow.ellipsis,
                  ), // 일기 내용
                  SizedBox(height: 8),
                  Text(
                    '${diaryEntries[index].date.toString()}',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ), // 작성 날짜
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _navigateToEditPage(context); // 일기 작성 페이지로 이동
        },
        child: Icon(Icons.add),
      ),
    );
  }

  // 일기 작성 페이지로 이동하는 함수
  void _navigateToEditPage(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => DiaryEditPage()),
    );

    if (result != null) {
      setState(() {
        diaryEntries.add(result); // 작성한 일기를 리스트에 추가
      });
    }
  }
}

