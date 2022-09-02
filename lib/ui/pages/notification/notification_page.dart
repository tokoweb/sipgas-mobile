part of '../pages.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NotifBloc, NotifState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Scaffold(
          appBar: CustomAppbarDetail(title: "Notifikasi"),
          body: state.status != NotifStatus.loading
              ? state.notif.listNotification != null &&
                      state.notif.listNotification!.length > 0
                  ? SingleChildScrollView(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        children: [
                          ListView.builder(
                            shrinkWrap: true,
                            physics: ClampingScrollPhysics(),
                            itemCount: state.notif.listNotification!.length,
                            itemBuilder: (context, index) {
                              return NotifItem(data: state.notif.listNotification![index]);
                            },
                          )
                        ],
                      ),
                    )
                  : Center(child: Text("Data Kosong"))
              : Center(child: CircularProgressIndicator(color: kPrimaryColor)),
        );
      },
    );
  }
}
