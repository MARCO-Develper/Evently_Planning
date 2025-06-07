import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently/firebase/firebase_manager.dart';
import 'package:evently/models/task_model.dart';
import 'package:evently/screens/home/tabs/home_tab/event_item.dart';
import 'package:flutter/material.dart';

class FavoriteTab extends StatefulWidget {
  const FavoriteTab({super.key});

  @override
  State<FavoriteTab> createState() => _FavoriteTabState();
}

class _FavoriteTabState extends State<FavoriteTab> {
  String searchQuery = "";

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<TaskModel>>(
      stream: FirebaseManager.getFavoriteTasks(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return const Center(child: Text("Something went wrong"));
        }

        final allTasks =
            snapshot.data?.docs.map((doc) => doc.data()).toList() ?? [];
        final favoriteTasks = allTasks.where((task) {
          return task.title.toLowerCase().contains(searchQuery.toLowerCase());
        }).toList();

        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // 🔍 Search Box
              Padding(
                padding: const EdgeInsets.only(top: 18),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEFFAFF), // نفس لون الصورة
                    border: Border.all(color: Theme.of(context).primaryColor),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Row(
                    children: [
                      ImageIcon(
                        const AssetImage("assets/images/icons/Search.png"),
                        color: Theme.of(context).primaryColor,
                        size: 24,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: TextField(
                          decoration: const InputDecoration.collapsed(
                            hintText: "Search for Event",
                          ),
                          onChanged: (value) {
                            setState(() {
                              searchQuery = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // 📋 List of Favorite Tasks
              Expanded(
                child: favoriteTasks.isEmpty
                    ? const Center(child: Text("No favorite tasks yet"))
                    : ListView.builder(
                        itemCount: favoriteTasks.length,
                        itemBuilder: (context, index) {
                          return EventItem(model: favoriteTasks[index]);
                        },
                      ),
              ),
            ],
          ),
        );
      },
    );
  }
}
