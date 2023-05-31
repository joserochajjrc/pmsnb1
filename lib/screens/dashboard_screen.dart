import 'package:day_night_switcher/day_night_switcher.dart';
import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:flutter/material.dart';
import 'package:pmsnb1/provider/flags_provider.dart';
import 'package:pmsnb1/screens/list_post_cloud_screen.dart';
import 'package:pmsnb1/screens/list_post_screen.dart';
import 'package:pmsnb1/settings/styles.dart';
import 'package:pmsnb1/widgets/futures_modal.dart';
import 'package:pmsnb1/widgets/modal_add_post.dart';
import 'package:provider/provider.dart';
import '../provider/theme_provider.dart';

class DashboardScreen extends StatefulWidget {
  DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  //bool isDarkThemeEnable = false;
  void _toggleTheme(theme) {
    final settings = Provider.of<ThemeProvider>(context, listen: false);
    settings.toggleTheme(theme);
  }
  

  @override
  Widget build(BuildContext context) {
    ThemeProvider theme = Provider.of<ThemeProvider>(context);
    //final theme = Theme.of(context);

    final spaceHorizontal = SizedBox(height: 15,);

    final btnEvents = ElevatedButton.icon(
      onPressed: (){
        Navigator.pushNamed(context, '/events');
      }, 
      style: ElevatedButton.styleFrom(
        elevation: 10.0,
        fixedSize: const Size(800, 60)
      ),
      icon: Icon(Icons.calendar_today), 
      label: Text('Eventos'),
    );

    FlagsProvider flags = Provider.of<FlagsProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text('TecBook :)'),),
      //body: flags.getupdatePosts() == true ? const ListPostScreen() : const ListPostScreen(),
      body: ListPostCloudScreen(),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Color.fromARGB(255, 2, 88, 5),
        onPressed: (){
          openCustomDialog(context, null);
        }, 
        icon: Icon(Icons.add_comment),
        label: Text('Post it!')
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            const UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage('https://raw.githubusercontent.com/obliviate-dan/Login-Form/master/img/avatar.png'),
              ),
              accountName: Text('José Juan Rocha Cisneros'), 
              accountEmail: Text('19031005@itcelaya.edu.mx')
            ),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, '/popular');
              },
              horizontalTitleGap: 0.0,
              leading: const Icon(Icons.movie),
              title: const Text(
                'Trending Movies',
                style: TextStyle(fontSize: 16),
              ),
              trailing: const Icon(Icons.chevron_right),
            ),
            /*ListTile(
              onTap: () {
                Navigator.pushNamed(context, '/detail');
              },
              horizontalTitleGap: 0.0,
              leading: const Icon(Icons.movie_filter),
              title: const Text(
                'Detail Movies',
                style: TextStyle(fontSize: 16),
              ),
              trailing: const Icon(Icons.chevron_right),
            ),*/
            /*DayNightSwitcher(
                isDarkModeEnabled: isDarkThemeEnable,
                onStateChanged: ((isDarkModeEnabled) {
                  isDarkModeEnabled 
                    ? theme.setthemeData(StylesApp.darkTheme(context))
                    : theme.setthemeData(StylesApp.lightTheme(context));

                  
                  isDarkThemeEnable = isDarkModeEnabled;
                  setState(() {
                    
                  });

                }),
              ),*/
              DropdownButtonFormField<String>(
                  isExpanded: true,
                  value: theme.getTheme(),
                  decoration: const InputDecoration(
                    labelText: 'Tema',
                    prefixIcon: Icon(Icons.color_lens),
                  ),
                  items: <String>['light','dark','red', 'eco'].map((i) {
                    return DropdownMenuItem(
                        value: i,
                        child: Text(
                          i,
                        ));
                  }).toList(),
                  hint: const Text('Tema'),
                  //padding: const EdgeInsets.symmetric(horizontal: 10),
                  onChanged: (value) {
                    if (value == 'light') {
                      _toggleTheme('light');
                    }
                    if (value == 'dark') {
                      _toggleTheme('dark');
                    }
                    if (value == 'red') {
                      _toggleTheme('red');
                    }
                    if (value == 'eco') {
                      _toggleTheme('eco');
                    }
                  }),
              spaceHorizontal,
              btnEvents
          ],
        ),
      ),
    );
  }

}



