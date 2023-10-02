import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TO DO',
      
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      
      home: const LoginPage(), // Start with the login page
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage();

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text('LOGIN PAGE'),
        elevation: 0,
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children:[
              TextField(
                controller: usernameController,
                decoration:const InputDecoration(
                  labelText: 'Username',
                ),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: passwordController,
                decoration:const InputDecoration(
                  labelText: 'Password',
                ),
                obscureText: true,
              ),
              const SizedBox(height: 24.0),
              ElevatedButton(
               onPressed: () {
               String username = usernameController.text;
               String password = passwordController.text;
               String validUsername = 'darshan';
               String validPassword = '123456';
               if (username == validUsername && password == validPassword) {
                // Navigate to the TodoApp page
                 Navigator.push(
                 context,
                  MaterialPageRoute(
                 builder: (context) => const TodoApp(),
                  ),
                );
               }
               },
               child: const Text('Login'),
               ),
            ],
          ),
        ),
      ),
    );
  }
}


class TodoApp extends StatefulWidget {
  const TodoApp();

  @override
  _TodoAppState createState() => _TodoAppState();
}

class _TodoAppState extends State<TodoApp> {
  List<String> tasks = [];

  void add(String task) {
    setState(() {
      tasks.add(task);
    });
  }

  void edit(int index, String updatedTask) {
    setState(() {
      tasks[index] = updatedTask;
    });
  }

  void remove(int index) {
    setState(() {
      tasks.removeAt(index);
    });
  }

  // logout method
  void logout() {
    Navigator.pop(context); //  back to the login page
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[200],
      appBar: AppBar(
        title: const Text('TO DO'),
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout), // Add a logout icon here
            onPressed: logout, // Call the logout method
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    String updatedTask = tasks[index];

                    return AlertDialog(
                      title: const Text('Edit Task'),
                      content: TextField(
                        onChanged: (value) {
                          updatedTask = value; // Update updatedTask when text changes
                        },
                        controller: TextEditingController(text: tasks[index]),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            edit(index, updatedTask); // Edit the task
                            Navigator.pop(context);
                          },
                          child: const Text('Save'),
                        ),
                      ],
                    );
                  },
                );
              },
              child: Text(tasks[index]),
            ),
            trailing: IconButton(
              icon: const Icon(Icons.delete_outline_rounded),
              onPressed: () {
                remove(index);
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              String newTask = '';

              return AlertDialog(
                title: const Text('Add Task'),
                content: TextField(
                  onChanged: (value) {
                    newTask = value;
                  },
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      add(newTask);
                      Navigator.pop(context);
                    },
                    child: const Text('OK'),
                  ),
                ],
              );
            },
          );
        },
        child: const Icon(Icons.add_circle_outline_sharp),
      ),
    );
  }
}
