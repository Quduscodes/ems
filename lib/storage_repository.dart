import 'package:ems/exports.dart';

final storageLoader = StateProvider<bool>((ref) => false);

final storageProvider = ChangeNotifierProvider<StorageRepository>((ref) {
  return StorageRepository(ref);
});

final spaceIdProvider = StateProvider<String?>((ref) => null);
final indexProvider = StateProvider<int?>((ref) => null);
final spaceListProvider = StateProvider<List<Space>?>((ref) => null);
final applianceDataListProvider =
    StateProvider<List<Appliances>?>((ref) => null);
final spaceProvider = StateProvider<Space?>((ref) => null);
final applianceDataProvider = StateProvider<Appliances?>((ref) => null);

class StorageRepository extends ChangeNotifier {
  final Ref ref;
  StorageRepository(this.ref);
  final UserData? user =
      Hive.box<UserData>(StringConst.userDataBox).get(StringConst.userDataKey);

  addAppliance(BuildContext context, Appliances appliance) {
    dropKeyboard(context);
    var docRefAppliance =
        FirebaseFirestore.instance.collection('appliances').doc("appliances");
    docRefAppliance.get().then((value) {
      if (value.exists) {
        FirebaseFirestore.instance.runTransaction((transaction) async {
          transaction.update(docRefAppliance, {
            "appliance": FieldValue.arrayUnion([appliance.toJson()])
          });
        });
      } else {
        docRefAppliance.set({
          "appliance": FieldValue.arrayUnion([appliance.toJson()])
        });
      }
    }).then((value) => Navigator.pop(context));
  }

  addLocation(BuildContext context, String location) {
    dropKeyboard(context);
    var docRefAppliance =
        FirebaseFirestore.instance.collection('locations').doc("locations");
    docRefAppliance.get().then((value) {
      if (value.exists) {
        FirebaseFirestore.instance.runTransaction((transaction) async {
          transaction.update(docRefAppliance, {
            "location": FieldValue.arrayUnion([location])
          });
        });
      } else {
        docRefAppliance.set({
          "location": FieldValue.arrayUnion([location])
        });
      }
    }).then((value) => Navigator.pop(context));
  }

  editAppliance(BuildContext context, Appliances appliance, int index) {
    ref.watch(applianceDataListProvider)![index] = appliance;
    var docRefAppliance =
        FirebaseFirestore.instance.collection('appliances').doc("appliances");
    FirebaseFirestore.instance.runTransaction((transaction) async {
      transaction.update(docRefAppliance, {
        "appliance": ref
            .watch(applianceDataListProvider)!
            .map((e) => e.toJson())
            .toList()
      });
    }).then((value) => Navigator.pop(context));
  }

  deleteAppliance(BuildContext context, Appliances appliance) {
    var docRefAppliance =
        FirebaseFirestore.instance.collection('appliances').doc("appliances");
    docRefAppliance.update({
      "appliance": FieldValue.arrayRemove([appliance.toJson()])
    });
  }

  deleteLocation(BuildContext context, String location) {
    var docRefAppliance =
        FirebaseFirestore.instance.collection('locations').doc("locations");
    docRefAppliance.update({
      "location": FieldValue.arrayRemove([location])
    });
  }

  addAdminSpace(BuildContext context, Space data) {
    var docRefAdmin =
        FirebaseFirestore.instance.collection('admin').doc(user!.userId);
    var docRefSpace =
        FirebaseFirestore.instance.collection('spaces').doc(data.sId);
    docRefSpace
        .set({
          "space": data.toJson(),
        })
        .then((value) =>
            FirebaseFirestore.instance.runTransaction((transaction) async {
              transaction.update(docRefAdmin, {
                "space": FieldValue.arrayUnion([data.toJson()])
              });
            }))
        .then((value) {
          ScaffoldMessenger.of(context).showSnackBar(showSnackBar(
            context,
            text: 'Successfully added space',
          ));
          Navigator.pop(context);
        });
  }

  addUserSpace(BuildContext context, Space data) {
    var docRefUser =
        FirebaseFirestore.instance.collection('users').doc(user!.userId);
    var docRefSpace = FirebaseFirestore.instance.collection('spaces').doc(data.sId);
    docRefSpace
        .set({
          "space": data.toJson(),
        })
        .then((value) =>
            FirebaseFirestore.instance.runTransaction((transaction) async {
              transaction.update(docRefUser, {"space": data.toJson()});
            }))
        .then((value) {
          ScaffoldMessenger.of(context).showSnackBar(showSnackBar(
            context,
            text: 'Successfully added space',
          ));
          Navigator.pop(context);
        });
  }

  deleteAdminSpace(BuildContext context) {
    ref.watch(spaceListProvider)!.removeAt(ref.watch(indexProvider)!);
    var docRefAdmin =
        FirebaseFirestore.instance.collection('admin').doc(user!.userId);
    var docRefSpace = FirebaseFirestore.instance
        .collection('spaces')
        .doc(ref.watch(spaceProvider)!.sId);
    docRefSpace
        .get()
        .then((value) {
          if (value.exists) {
            docRefSpace.delete();
          }
        })
        .then((value) => docRefAdmin.update({
              "space":
                  FieldValue.arrayRemove([ref.watch(spaceProvider)!.toJson()])
            }))
        .then((value) {
          ScaffoldMessenger.of(context).showSnackBar(showSnackBar(
            context,
            text: 'Successfully deleted space',
          ));
          Navigator.pop(context);
        });
  }

  deleteUserSpace(BuildContext context) {
    var docRefUser =
        FirebaseFirestore.instance.collection('users').doc(user!.userId);
    var docRefSpace = FirebaseFirestore.instance
        .collection('spaces')
        .doc(ref.watch(spaceProvider)!.sId);
    docRefSpace
        .delete()
        .then((value) => docRefUser.update({
              "space": {},
            }))
        .then((value) {
      ScaffoldMessenger.of(context).showSnackBar(showSnackBar(
        context,
        text: 'Successfully deleted space',
      ));
      Navigator.pop(context);
    });
  }

  editUserSpace(BuildContext context, Space data) {
    dropKeyboard(context);
    var docRefUser =
        FirebaseFirestore.instance.collection('users').doc(user!.userId);
    var docRefSpace =
        FirebaseFirestore.instance.collection('spaces').doc(data.sId);
    docRefSpace
        .set({
          "space": data.toJson(),
        })
        .then((value) => docRefUser.update({
              "space": data.toJson(),
            }))
        .then((value) {
          ScaffoldMessenger.of(context).showSnackBar(showSnackBar(
            context,
            text: 'Successfully edited space',
          ));
          Navigator.pop(context);
        });
  }

  editAdminSpace(BuildContext context, Space data) {
    dropKeyboard(context);
    ref.watch(spaceListProvider)![ref.watch(indexProvider)!] = data;
    var docRefAdmin =
        FirebaseFirestore.instance.collection('admin').doc(user!.userId);
    var docRefSpace =
        FirebaseFirestore.instance.collection('spaces').doc(data.sId);
    docRefSpace
        .get()
        .then((value) {
          if (value.exists) {
            docRefSpace.set({
              "space": data.toJson(),
            });
          }
        })
        .then((value) =>
            FirebaseFirestore.instance.runTransaction((transaction) async {
              transaction.update(docRefAdmin, {
                "space": ref
                    .watch(spaceListProvider)!
                    .map((e) => e.toJson())
                    .toList()
              });
            }))
        .then((value) => Navigator.pop(context));
  }
}
