# Passing Data

**Create the child widget with a parameter**

```dart
class GreetingWidget extends StatelessWidget {
  final String name;

  const GreetingWidget({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Text("Hello, $name!");
  }
}
```

**Parent widget passes the data**

```dart
class ParentWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GreetingWidget(name: "Raphael"),
      ),
    );
  }
}
```

## Example: Passing Multiple Data Items

In this example, the child has many properties.

```dart
class ProfileCard extends StatelessWidget {
  final String title;
  final int age;
  final bool isOnline;

  const ProfileCard({
    super.key,
    required this.title,
    required this.age,
    required this.isOnline,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(title),
        Text("Age: $age"),
        Text(isOnline ? "Online" : "Offline"),
      ],
    );
  }
}
```

Parent calls the child and passes all required property values via the constructor:

```dart
ProfileCard(
  title: "Soundesign Admin",
  age: 32,
  isOnline: true,
)
```

## Example: Passing events

Sometimes, a child needs to notify a parent. You can pass a **callback** function or event.

**Child**

```dart
class ActionButton extends StatelessWidget {
  final VoidCallback onPressed;

  const ActionButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text("Click Me"),
    );
  }
}
```

**Parent**

```dart
ActionButton(
  onPressed: () {
    print("Button clicked in child!");
  },
)
```

## Passing a function with arguments

**Parent Widget**

```dart
class ParentWidget extends StatelessWidget {
  void handleTap(String item) {
    print("You tapped on: $item");
  }

  @override
  Widget build(BuildContext context) {
    return MyChildWidget(onItemSelected: handleTap);
  }
}
```

**Child Widget**

```dart
class MyChildWidget extends StatelessWidget {
  final Function(String) onItemSelected;

  const MyChildWidget({super.key, required this.onItemSelected});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => onItemSelected("Soundesign Manila"),
      child: Text("Select Item"),
    );
  }
}
```

## Exercise

Students must build functionality of an app where:

* A parent widget that contains a list of contacts
* A child widget that contains a form
* The child widget passes a new contact (name + phone) back to the parent

**Starter Code**

```dart
class ContactListPage extends StatefulWidget {
  const ContactListPage({super.key});

  @override
  State<ContactListPage> createState() => _ContactListPageState();
}

class _ContactListPageState extends State<ContactListPage> {
  List<Map<String, String>> contacts = [];

  // TODO: Implement addContact callback
  void addContact(String name, String phone) {
    // Should add to contacts list and call setState
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Contacts")),

      body: Column(
        children: [
          // TODO: Pass addContact to AddContactForm
          AddContactForm(onAddContact: addContact),

          const SizedBox(height: 20),

          Expanded(
            child: ListView.builder(
              itemCount: contacts.length,
              itemBuilder: (context, index) {
                final contact = contacts[index];
                return ListTile(
                  title: Text(contact["name"]!),
                  subtitle: Text(contact["phone"]!),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
```
