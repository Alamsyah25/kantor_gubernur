import 'package:flutter/material.dart';
import 'package:kantor_gubernur/constants/colors.dart';
import 'package:kantor_gubernur/constants/strings.dart';
import 'package:kantor_gubernur/model/kantor_gubernur_response.dart';
import 'package:kantor_gubernur/rest/api_provider.dart';
import 'package:kantor_gubernur/ui/maps_screen.dart';
import 'package:kantor_gubernur/ui/widget/loading_indicator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ApiProvider _apiProvider = ApiProvider();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorPrimary,
        title: const Text(title),
      ),
      body: FutureBuilder<List<KantorGubenurResponse>?>(
        future: _apiProvider.fetchData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<KantorGubenurResponse>? response = snapshot.data;
            if (response != null) {
              List<KantorGubenurResponse> data = response;

              return ListView.separated(
                  padding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                  itemBuilder: (context, index) {
                    var item = data[index];

                    return _buildItem(
                        item: item,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MapsScreen(
                                province: item.province ?? '',
                                address: item.address ?? '',
                              ),
                            ),
                          );
                        });
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(
                      height: 12,
                    );
                  },
                  itemCount: data.length);
            }
          } else {
            return _buildNoData();
          }
          return const LoadingIndicator();
        },
      ),
    );
  }

  Widget _buildNoData() {
    return const Center(
      child: Text(noDataAvailable,
          style: TextStyle(
            leadingDistribution: TextLeadingDistribution.even,
            fontWeight: FontWeight.bold,
            fontSize: 28,
            height: 1.57,
          )),
    );
  }

  Widget _buildItem(
      {required KantorGubenurResponse item, required VoidCallback onTap}) {
    return Material(
      color: colorTransparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          height: 275,
          decoration: BoxDecoration(
            border: Border.all(
              color: colorAccent.withOpacity(0.5),
              width: 1.3,
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: [
              Container(
                height: 150,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                        item.image ?? '',
                      )),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(14),
                    topRight: Radius.circular(14),
                  ),
                  color: colorTransparent,
                ),
              ),
              Flexible(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(item.province ?? '',
                          style: const TextStyle(
                            color: colorAccent,
                            leadingDistribution: TextLeadingDistribution.even,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            height: 1.57,
                          )),
                      Text(item.address ?? '',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: colorAccent,
                            leadingDistribution: TextLeadingDistribution.even,
                            fontWeight: FontWeight.normal,
                            fontSize: 14,
                            height: 1.57,
                          )),
                      const Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(item.website ?? '',
                              style: const TextStyle(
                                color: colorAccent,
                                leadingDistribution:
                                    TextLeadingDistribution.even,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                height: 1.57,
                              )),
                          Text(item.phone ?? '',
                              style: const TextStyle(
                                color: colorAccent,
                                leadingDistribution:
                                    TextLeadingDistribution.even,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                height: 1.57,
                              )),
                        ],
                      ),
                      const SizedBox(
                        width: 100,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
