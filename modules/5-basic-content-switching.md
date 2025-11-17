# Basic Content Switching

This module demonstrates how to switch the main content of a screen while keeping a persistent header and bottom navigation bar. The pattern shown here is a foundation for many apps that have multiple tabs (Home, Search, Profile) and swap views in place.

## Full Example

```dart
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _views = const [
    Center(child: Text("Home View", style: TextStyle(fontSize: 24))),
    Center(child: Text("Search View", style: TextStyle(fontSize: 24))),
    Center(child: Text("Profile View", style: TextStyle(fontSize: 24))),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // HEADER
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            color: Colors.deepPurple,
            child: const Text(
              "My Header",
              style: TextStyle(
                fontSize: 28,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          // CHANGING CONTENT
          Expanded(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 250),
              child: _views[_selectedIndex],
            ),
          ),
        ],
      ),

      // NAVBAR
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}
```

---

## Section-by-section Breakdown

### 1) Entry Point and App Shell
- `void main() { runApp(const MyApp()); }`
  - The Dart/Flutter entry point. `runApp` inflates the widget tree starting at `MyApp`.
- `class MyApp extends StatelessWidget`
  - A simple app shell that sets up a `MaterialApp` and points `home` to `HomeScreen`.
  - `debugShowCheckedModeBanner: false` removes the debug banner from the top-right in debug builds.

### 2) Stateful HomeScreen
- `class HomeScreen extends StatefulWidget` and its `_HomeScreenState`
  - We need state because the selected tab index changes as the user taps the BottomNavigationBar.
  - `int _selectedIndex = 0;` tracks which tab is active.

### 3) Views List (the switchable content)
- `final List<Widget> _views = const [ ... ];`
  - A fixed list of three simple views.
  - Using `const` where possible makes rebuilds cheaper because constant widgets can be reused.
  - Each view is wrapped in `Center` with a `Text` label to show which page is active.

### 4) Scaffold and Page Layout
- `Scaffold` provides the basic Material layout structure (body + bottomNavigationBar).
- `body: Column(...)` stacks a persistent header at the top and the switchable content below.
  - The header is a `Container` with full width, padding, a background color, and styled text.
  - `Expanded` wraps the main content area so it takes all remaining vertical space below the header.

### 5) AnimatedSwitcher for Smooth Transitions
- `AnimatedSwitcher(duration: Duration(milliseconds: 250), child: _views[_selectedIndex])`
  - Automatically animates when its `child` changes.
  - By default, it fades between the old and new child. You can customize via `transitionBuilder`.
  - Tip: If you reuse the same widget type for different pages, consider giving children different `Key`s to help AnimatedSwitcher distinguish them:
    ```dart
    child: KeyedSubtree(
      key: ValueKey(_selectedIndex),
      child: _views[_selectedIndex],
    )
    ```

### 6) Bottom Navigation and State Updates
- `BottomNavigationBar(currentIndex: _selectedIndex, onTap: (index) { ... })`
  - `currentIndex` highlights the selected tab.
  - `onTap` receives the index of the tapped item. Inside, we call `setState` to update `_selectedIndex` and trigger a rebuild.
  - The `items` define the icon and label for each tab.

### 7) setState and Rebuild Flow
- When a user taps an item:
  - `onTap` sets `_selectedIndex` inside `setState`.
  - Flutter schedules a rebuild of `_HomeScreenState`.
  - On rebuild, `_views[_selectedIndex]` changes. `AnimatedSwitcher` detects the new child and animates the transition.

### 8) Customization Ideas
- Replace the placeholder `Center(Text(...))` with your actual pages (e.g., `HomePage()`, `SearchPage()`, `ProfilePage()`).
- Customize transitions:
  ```dart
  AnimatedSwitcher(
    duration: const Duration(milliseconds: 300),
    transitionBuilder: (child, animation) => FadeTransition(
      opacity: animation,
      child: SlideTransition(
        position: Tween<Offset>(begin: const Offset(0.05, 0), end: Offset.zero).animate(animation),
        child: child,
      ),
    ),
    child: _views[_selectedIndex],
  )
  ```
- Preserve state per tab by using separate stateful widgets for each page, or use an `IndexedStack` when you want to keep all children alive and only show one:
  ```dart
  IndexedStack(
    index: _selectedIndex,
    children: _views,
  )
  ```

### 9) Common Pitfalls and Best Practices
- Avoid expensive work inside `build`; move heavy computations out or memoize.
- Use `const` constructors wherever possible to reduce rebuild cost.
- If animations look odd when switching between similar widgets, add unique `Key`s for children.
- Consider accessibility: labels in `BottomNavigationBarItem` help screen readers.

### 10) When to Choose AnimatedSwitcher vs IndexedStack
- Use `AnimatedSwitcher` when you want a transition between views and do not need to preserve the off-screen views' states.
- Use `IndexedStack` when preserving each tab's state (e.g., scroll positions, text field contents) is important.

---

## Summary
- Header stays fixed at the top.
- Bottom navigation stays fixed at the bottom.
- The middle content switches based on `_selectedIndex`.
- `setState` triggers rebuilds; `AnimatedSwitcher` makes the change smooth.

## Exercises

1. Create a navigation for 2 views:

* Viewing of all Cedula Forms (this can be temporary)
* Form for applying for cedula (migrate the form here)
