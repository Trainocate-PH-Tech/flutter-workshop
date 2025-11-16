# List View with Content Switching

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
      home: const ListDemoScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ListDemoScreen extends StatefulWidget {
  const ListDemoScreen({super.key});

  @override
  State<ListDemoScreen> createState() => _ListDemoScreenState();
}

class _ListDemoScreenState extends State<ListDemoScreen> {
  // Mock dataset of maps
  final List<Map<String, dynamic>> items = [
    {"id": 1, "name": "Laptop", "description": "A portable computer"},
    {"id": 2, "name": "Headphones", "description": "Noise-cancelling audio device"},
    {"id": 3, "name": "Smartphone", "description": "Touch-screen communication device"},
    {"id": 4, "name": "Camera", "description": "Used for capturing images"},
  ];

  Map<String, dynamic>? selectedItem; // This will hold the clicked item

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // HEADER
          Container(
            padding: const EdgeInsets.all(24),
            width: double.infinity,
            color: Colors.blue,
            child: const Text(
              "Product List Demo",
              style: TextStyle(
                fontSize: 26,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          // INNER EXPANDED PART
          Expanded(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 250),
              child: selectedItem == null
                  ? _buildListView()
                  : _buildDetailView(selectedItem!),
            ),
          ),
        ],
      ),
    );
  }

  // ----------------------------------------
  // LIST VIEW
  // ----------------------------------------
  Widget _buildListView() {
    return ListView.builder(
      key: const ValueKey("listView"),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];

        return ListTile(
          leading: CircleAvatar(child: Text(item["id"].toString())),
          title: Text(item["name"]),
          subtitle: Text(item["description"]),
          onTap: () {
            setState(() {
              selectedItem = item;
            });
          },
        );
      },
    );
  }

  // ----------------------------------------
  // DETAIL VIEW
  // ----------------------------------------
  Widget _buildDetailView(Map<String, dynamic> item) {
    return Container(
      key: const ValueKey("detailView"),
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      color: Colors.grey.shade200,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(item["name"],
              style: const TextStyle(
                  fontSize: 28, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          Text(
            item["description"],
            style: const TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              setState(() {
                selectedItem = null; // Go back to list
              });
            },
            child: const Text("Back to List"),
          )
        ],
      ),
    );
  }
}
```

---

## Section-by-section Breakdown

### 1) What this demo shows
- A common master-detail pattern: a list of items and a detail view for the selected item.
- Instead of navigating to a new page, the main content area swaps between the list and detail using AnimatedSwitcher.

### 2) Data and State
- `items` is a simple in-memory dataset of maps with `id`, `name`, and `description`.
- `Map<String, dynamic>? selectedItem` holds the item that was tapped. When it is `null`, the list is shown; when set, the detail view is shown.

Tip: In production, prefer a typed model class:
```dart
class Product {
  final int id;
  final String name;
  final String description;
  const Product({required this.id, required this.name, required this.description});
}
```

### 3) App Entry and Shell
- `main()` uses `runApp(const MyApp())` to start the widget tree.
- `MyApp` is a `StatelessWidget` that configures a `MaterialApp` and sets `home` to `ListDemoScreen`.
- `debugShowCheckedModeBanner: false` removes the debug banner in debug builds.

### 4) Stateful Screen: ListDemoScreen
- We use a `StatefulWidget` because the UI depends on the mutable `selectedItem`.
- The state flips between `list` and `detail` by assigning `selectedItem` within `setState()`.

### 5) Layout Structure with Scaffold and Column
- `Scaffold` gives us the base Material page structure.
- `body` contains a `Column` with:
  - A fixed header `Container` at the top.
  - An `Expanded` that occupies the remaining space for the switchable content.

### 6) Header Bar
- The header is a `Container` with padding, full width, and a blue background.
- The `Text` is styled to stand out as a page title.

### 7) AnimatedSwitcher for Content Swapping
- `AnimatedSwitcher` animates when its `child` changes.
- Here, the `child` is either the list view or the detail view depending on `selectedItem`:
  ```dart
  child: selectedItem == null ? _buildListView() : _buildDetailView(selectedItem!),
  ```
- `duration: Duration(milliseconds: 250)` sets a quick fade animation by default.
- Keys help AnimatedSwitcher understand that the child truly changed:
  - List view uses `key: ValueKey("listView")`
  - Detail view uses `key: ValueKey("detailView")`

Optional: Customize transitions
```dart
AnimatedSwitcher(
  duration: const Duration(milliseconds: 300),
  transitionBuilder: (child, animation) => FadeTransition(
    opacity: animation,
    child: ScaleTransition(scale: Tween<double>(begin: 0.98, end: 1).animate(animation), child: child),
  ),
  child: selectedItem == null ? _buildListView() : _buildDetailView(selectedItem!),
)
```

### 8) Building the List View
- `ListView.builder` efficiently builds only visible items.
- `itemCount: items.length` tells the list how many items to render.
- `itemBuilder` returns a `ListTile` for each item:
  - `leading: CircleAvatar` shows the item id.
  - `title` and `subtitle` show the name and description.
  - `onTap` sets `selectedItem = item` inside `setState` to trigger the detail view.
- The root list view carries a `ValueKey("listView")` to distinguish it from the detail view for animations.

Enhancements:
- Use `ListView.separated` to add dividers or spacing.
- For very large lists, consider `ListView.builder` with proper caching and possibly `const` widgets where possible.
- Provide `Semantics` or `tooltip` for accessibility if needed.

### 9) Building the Detail View
- A padded `Container` styled with a light background to separate it visually from the list.
- Shows the selected item's `name` and `description`.
- A single "Back to List" button that sets `selectedItem = null` to return to the list.
- The container has a `ValueKey("detailView")` to pair with the AnimatedSwitcher.

Ideas:
- Add an image, price, or actions (e.g., "Add to cart").
- Use `SingleChildScrollView` if content may overflow vertically.

### 10) State Transition Flow
1. Initial state: `selectedItem == null` -> list view is shown.
2. User taps a `ListTile` -> `setState(() => selectedItem = item)`.
3. `build()` runs again; `AnimatedSwitcher` sees a new child (detail view) and animates the change.
4. User taps "Back to List" -> `setState(() => selectedItem = null)`.
5. `build()` runs again; `AnimatedSwitcher` swaps back to the list with an animation.

### 11) Alternatives and Enhancements
- Navigation-based detail: Use `Navigator.push` to a separate detail screen if you want a new route with app bar, back button, and better deep linking.
- Keep both views alive: Use `IndexedStack` if you need to preserve list and detail states simultaneously.
- Typed models: Replace `Map<String, dynamic>` with a `Product` class for type safety and maintainability.
- Hero animations: Wrap shared widgets (e.g., image or title) in `Hero` for a polished transition.
- State management: For more complex flows, consider Provider, Riverpod, or Bloc to manage selected item and data fetching.

### 12) Common Pitfalls and Best Practices
- Avoid heavy work inside `build`. Prepare data outside or cache results.
- Give distinct keys to distinct screens to help AnimatedSwitcher (already done with `ValueKey`s).
- Be cautious with large texts/images in lists—use placeholders and lazy loading as needed.
- Accessibility: Ensure text contrast and provide meaningful labels for screen readers.

---

## Summary
- The screen swaps between a list and a detail view in-place using `AnimatedSwitcher`.
- A single `selectedItem` piece of state drives which child is displayed.
- `setState` triggers rebuilds, and keys ensure smooth, correct animations.
- This is a good base for master-detail experiences and can be expanded with navigation, typed models, and richer UI.
