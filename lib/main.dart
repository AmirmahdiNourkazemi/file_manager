import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(GoogleDriveApp());
}

class GoogleDriveApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(360, 690),
      child: MaterialApp(
        title: 'File manager',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: DriveHomePage(),
      ),
    );
  }
}

class DriveHomePage extends StatefulWidget {
  @override
  _DriveHomePageState createState() => _DriveHomePageState();
}

class _DriveHomePageState extends State<DriveHomePage> {
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    FilesView(),
    SharedView(),
    StarredView(),
    OfflineView(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('File manager'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: Row(
        children: [
          if (ScreenUtil().screenWidth >= 600)
            NavigationRail(
              selectedIndex: _selectedIndex,
              onDestinationSelected: _onItemTapped,
              labelType: NavigationRailLabelType.selected,
              destinations: [
                NavigationRailDestination(
                  icon: Icon(Icons.folder),
                  label: Text('Files'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.people),
                  label: Text('Shared'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.star),
                  label: Text('Starred'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.offline_pin),
                  label: Text('Offline'),
                ),
              ],
            ),
          Expanded(
            child: _widgetOptions.elementAt(_selectedIndex),
          ),
        ],
      ),
      bottomNavigationBar: ScreenUtil().screenWidth < 600
          ? BottomNavigationBar(
              selectedIconTheme: IconThemeData(color: Colors.blue),
              unselectedIconTheme: IconThemeData(color: Colors.grey),
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.folder),
                  label: 'Files',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.people),
                  label: 'Shared',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.star),
                  label: 'Starred',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.offline_pin),
                  label: 'Offline',
                ),
              ],
              currentIndex: _selectedIndex,
              selectedItemColor: Colors.blue,
              onTap: _onItemTapped,
            )
          : null,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
    );
  }
}

class FilesView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isDesktop = ScreenUtil().screenWidth >= 600;
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: isDesktop ? 4 : 2,
        childAspectRatio: 3 / 2,
      ),
      itemBuilder: (context, index) {
        return Card(
          margin: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.insert_drive_file, size: 50, color: Colors.grey),
              SizedBox(height: 10),
              Text('File ${index + 1}'),
            ],
          ),
        );
      },
      itemCount: 20,
    );
  }
}

class SharedView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Shared files view'),
    );
  }
}

class StarredView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Starred files view'),
    );
  }
}

class OfflineView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Offline files view'),
    );
  }
}
