import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../firebase/firebase_manager.dart';
import '../../../../models/task_model.dart';
import '../../../../providers/create_event_provider.dart';
import '../../../../widgets/category_event_item.dart';

class EditTaskScreen extends StatelessWidget {
  static const String routeName = "EditTaskScreen";
  final TaskModel model;

  const EditTaskScreen({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    final TextEditingController titleController =
    TextEditingController(text: model.title);
    final TextEditingController descriptionController =
    TextEditingController(text: model.description);

    return ChangeNotifierProvider(
      create: (context) => CreateEventProvider()
        ..setInitialData(
          selectedCategoryName: model.category,
          selectedDate: DateTime.fromMillisecondsSinceEpoch(model.date),
        ),
      builder: (context, child) {
        var provider = Provider.of<CreateEventProvider>(context);

        return Scaffold(
          appBar: AppBar(
            iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
            title: Text(
              "Edit Event",
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(color: Theme.of(context).primaryColor),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Display selected category image
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.asset(
                      "assets/images/${provider.eventCategories[provider.selectedCategory]}.png",
                      height: 220,
                      fit: BoxFit.fill,
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Category selection
                  SizedBox(
                    height: 40,
                    child: ListView.separated(
                      separatorBuilder: (context, index) =>
                      const SizedBox(width: 16),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            provider.changeCategory(index);
                          },
                          child: CategoryEventItem(
                            text: provider.eventCategories[index],
                            isSelected: provider.selectedCategory == index,
                          ),
                        );
                      },
                      itemCount: provider.eventCategories.length,
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Title input
                  TextField(
                    controller: titleController,
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall!
                        .copyWith(color: Theme.of(context).focusColor),
                    decoration: InputDecoration(
                      labelText: "Title",
                      labelStyle: Theme.of(context)
                          .textTheme
                          .titleSmall!
                          .copyWith(color: Theme.of(context).focusColor),
                      prefixIcon: const Icon(Icons.edit_note),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 2, color: Theme.of(context).focusColor),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 2, color: Theme.of(context).focusColor),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 2, color: Theme.of(context).focusColor),
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Description input
                  TextField(
                    controller: descriptionController,
                    maxLines: 3,
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall!
                        .copyWith(color: Theme.of(context).focusColor),
                    decoration: InputDecoration(
                      labelText: "Description",
                      labelStyle: Theme.of(context)
                          .textTheme
                          .titleSmall!
                          .copyWith(color: Theme.of(context).focusColor),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 2, color: Theme.of(context).focusColor),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 2, color: Theme.of(context).focusColor),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 2, color: Theme.of(context).focusColor),
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Date selection
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Select Time",
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall!
                            .copyWith(color: Theme.of(context).focusColor),
                      ),
                      InkWell(
                        onTap: () async {
                          var date = await showDatePicker(
                            context: context,
                            initialDate: provider.selectedDate,
                            firstDate: DateTime.now()
                                .subtract(const Duration(days: 7300)),
                            lastDate:
                            DateTime.now().add(const Duration(days: 365)),
                          );
                          if (date != null) {
                            provider.changeDate(date);
                          }
                        },
                        child: Text(
                          provider.selectedDate.toString().substring(0, 10),
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall!
                              .copyWith(color: Theme.of(context).focusColor),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  // Update button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        TaskModel updatedModel = TaskModel(
                          id: model.id,
                          title: titleController.text,
                          category: provider.selectedCategoryName,
                          description: descriptionController.text,
                          date: provider.selectedDate.millisecondsSinceEpoch, userId: '',
                        );

                        FirebaseManager.updateTask(updatedModel).then(
                              (value) {
                            Navigator.pop(context);
                          },
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        backgroundColor: Theme.of(context).primaryColor,
                      ),
                      child: Text(
                        "Update Event",
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}