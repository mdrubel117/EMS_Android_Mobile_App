import 'package:appwrite/models.dart';
import 'package:ems_pro_max/constants/colors.dart';
import 'package:ems_pro_max/containers/format_datetime.dart';
import 'package:ems_pro_max/database.dart';
import 'package:ems_pro_max/saved_data.dart';
import 'package:flutter/material.dart';

class EventDetails extends StatefulWidget {
  final Document data;
  const EventDetails({super.key, required this.data});

  @override
  State<EventDetails> createState() => _EventDetailsState();
}

class _EventDetailsState extends State<EventDetails> {
  bool isRSVPedEvent = false;
  String id = "";
  bool isUserPresent(List<dynamic> partcipants, String userId) {
    return partcipants.contains(userId);
  }

  void initState() {
    id = SavedData.getUserId();
    isRSVPedEvent = isUserPresent(widget.data.data["participants"], id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(children: [
            Container(
              height: 180,
              width: double.infinity,
              child: ColorFiltered(
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.3), BlendMode.darken),
                child: Image.network(
                  "https://cloud.appwrite.io/v1/storage/buckets/671b0af700187a4fccf0/files/${widget.data.data["image"]}/view?project=670a7b6a003ca6969294&project=670a7b6a003ca6969294",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              top: 20,
              child: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(
                    Icons.arrow_back,
                    size: 28,
                    color: Colors.white,
                  )),
            ),
            Positioned(
              bottom: 40,
              left: 8,
              child: Row(
                children: [
                  Icon(
                    Icons.calendar_month_outlined,
                    size: 18,
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  Text(
                    "${formatDate(widget.data.data["datetime"])}",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w400),
                  ),
                  SizedBox(
                    width: 14,
                  ),
                  Icon(
                    Icons.access_time_outlined,
                    size: 18,
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  Text(
                    "${formatTime(widget.data.data["datetime"])}",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 20,
              left: 8,
              child: Row(
                children: [
                  Icon(
                    Icons.location_on_outlined,
                    size: 18,
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  Text(
                    "${widget.data.data["location"]}",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ),
          ]),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        widget.data.data["name"],
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                    Icon(Icons.share)
                  ],
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  widget.data.data["description"],
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  "${widget.data.data["participants"].length} people are attending.", //"${widget.data.data["participants"]?.length ?? 0} people are attending.",
                  style: TextStyle(
                      color: kLightGreen,
                      fontWeight: FontWeight.w500,
                      fontSize: 16),
                ),
                SizedBox(
                  height: 8,
                ),
                Text("Special Guests",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 20)),
                SizedBox(
                  height: 8,
                ),
                Text(
                  widget.data.data["guests"],
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(
                  height: 8,
                ),
                Text("Sponsers",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 20)),
                SizedBox(
                  height: 8,
                ),
                Text(
                  "${widget.data.data["sponsers"] == "" ? "None" : widget.data.data["sponsers"]}",
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(
                  height: 8,
                ),
                Text("More Info",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 20)),
                SizedBox(
                  height: 8,
                ),
                Text(
                  "Event Type : ${widget.data.data["isInPerson"] == true ? "In Person " : "Virtual"}",
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  "Time : ${formatTime(widget.data.data["datetime"])}",
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  "Location : ${widget.data.data["location"]}",
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(
                  height: 8,
                ),
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.map),
                  label: Text("Open with Google Maps"),
                ),
                SizedBox(
                  height: 8,
                ),
                if (isRSVPedEvent)
                  SizedBox(
                    height: 40,
                    width: double.infinity,
                    child: MaterialButton(
                      color: kLightGreen,
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("You are attending this event.")));
                      },
                      child: Text(
                        "Attending Event",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w900,
                            fontSize: 20),
                      ),
                    ),
                  )
                else
                  SizedBox(
                    height: 40,
                    width: double.infinity,
                    child: MaterialButton(
                      color: kLightGreen,
                      onPressed: () {
                        rsvpEvent(widget.data.data["participants"],
                                widget.data.$id)
                            .then((value) {
                          if (value) {
                            setState(() {
                              isRSVPedEvent = true;
                            });
                            // ignore: use_build_context_synchronously
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("RSVP Successful !!!")));
                          } else {
                            var text = Text("Something went worng. Try Agian.");
                            ScaffoldMessenger.of(context)
                                .showSnackBar(SnackBar(content: text));
                          }
                        });
                      },
                      child: Text(
                        "RSVP Event",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w900,
                            fontSize: 20),
                      ),
                    ),
                  ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
