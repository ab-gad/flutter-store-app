import 'package:flutter/material.dart';
import 'package:flutter_store_app/app/service_locator.dart';
import 'package:flutter_store_app/domain/models/home_data_model.dart';
import 'package:flutter_store_app/domain/models/state_renderer_data.dart';
import 'package:flutter_store_app/presentation/store_details/view_model/store_details_view_model.dart';
import 'package:flutter_store_app/resources/string_manager.dart';
import 'package:flutter_store_app/resources/values_manager.dart';

import '../../common/widgets/state_renderer_stream.dart';

class StoreDetailsView extends StatefulWidget {
  const StoreDetailsView({super.key});

  @override
  State<StoreDetailsView> createState() => _StoreDetailsViewState();
}

class _StoreDetailsViewState extends State<StoreDetailsView> {
  final _viewModel = sl<StoreDetailsViewModel>();

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final store =
        ModalRoute.of(context)!.settings.arguments as HomeDataModelItem;
    _viewModel.getStoreDetails(store.id);
    return Scaffold(
      appBar: AppBar(
        title: const Text(StringManager.banners),
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 400,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(store.image),
                fit: BoxFit.cover,
              ),
            ),
            child: Center(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppValues.v10),
                  color: Colors.white70,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: AppValues.v30,
                    horizontal: AppValues.v50,
                  ),
                  child: Text(
                    store.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: AppValues.v30,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(AppValues.v20),
            child: StateRendererStream(
              initialState: StateRendererData.loading(),
              stateRendererStream: _viewModel.stateRendererStream,
              content: _contentBuilder(),
            ),
          ),
        ],
      )),
    );
  }

  Widget _contentBuilder() {
    return StreamBuilder<HomeStoreItemDetailsModel>(
        stream: _viewModel.storeDetailsStream,
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return Container();
          }
          return Column(
            children: [
              _getSection(
                StringManager.details,
                snapshot.data!.details,
              ),
              _getSection(
                StringManager.about,
                snapshot.data!.about,
              ),
              _getSection(
                StringManager.services,
                snapshot.data!.services,
              )
            ],
          );
        });
  }

  Widget _getSection(String title, String details) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppValues.v20),
      child: Column(
        children: [
          Align(
            alignment: Alignment.bottomLeft,
            child: Text(
              title,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          const SizedBox(
            height: AppValues.v10,
          ),
          Text(
            details,
            textAlign: TextAlign.justify,
          ),
        ],
      ),
    );
  }
}
