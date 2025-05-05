import 'package:ecommerce_app/utils/app_colors.dart';
import 'package:ecommerce_app/view_models/choose_location_cubit/choose_location_cubit.dart';
import 'package:ecommerce_app/views/widgets/location_item_widget.dart';
import 'package:ecommerce_app/views/widgets/main_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChooseLocationPage extends StatefulWidget {
  const ChooseLocationPage({super.key});

  @override
  State<ChooseLocationPage> createState() => _ChooseLocationPageState();
}

class _ChooseLocationPageState extends State<ChooseLocationPage> {
  final TextEditingController locationController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<ChooseLocationCubit>(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Address')),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Choose Your Location',
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 12),
                Text(
                  'Let\'s find your unforgettable event! Choose location below to get started',
                  style: Theme.of(
                    context,
                  ).textTheme.labelLarge!.copyWith(color: AppColors.grey),
                ),
                const SizedBox(height: 36),

                TextField(
                  controller: locationController,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.location_on),
                    suffixIcon:
                        BlocConsumer<ChooseLocationCubit, ChooseLocationState>(
                          listenWhen:
                              (previous, current) =>
                                  current is LocationAdded ||
                                  current is ConfirmAddressLoaded,
                          listener: (context, state) {
                            if (state is LocationAdded) {
                              locationController.clear();
                            } else if (state is ConfirmAddressLoaded) {
                              Navigator.of(context).pop();
                            }
                          },
                          bloc: cubit,
                          buildWhen:
                              (previous, current) =>
                                  current is AddingLocations ||
                                  current is LocationAdded ||
                                  current is LocationAddingFailure,
                          builder: (context, state) {
                            if (state is AddingLocations) {
                              return const Center(
                                child: CircularProgressIndicator.adaptive(
                                  backgroundColor: AppColors.grey,
                                ),
                              );
                            }
                            return IconButton(
                              onPressed: () {
                                if (locationController.text.isNotEmpty) {
                                  cubit.addLocation(locationController.text);
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Please enter a location'),
                                    ),
                                  );
                                }
                              },
                              icon: const Icon(
                                Icons.add,
                                color: AppColors.grey,
                              ),
                            );
                          },
                        ),
                    prefixIconColor: AppColors.grey,
                    hintText: 'Write Location City-Country',
                    fillColor: AppColors.grey1,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide.none,
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(color: AppColors.red),
                    ),
                  ),
                ),
                const SizedBox(height: 36),

                Text(
                  'Select Location',
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 16),
                BlocBuilder<ChooseLocationCubit, ChooseLocationState>(
                  bloc: cubit,
                  buildWhen:
                      (previous, current) =>
                          current is FetchingLocations ||
                          current is FetchedLocations ||
                          current is FetchLocationFailure,
                  builder: (context, state) {
                    if (state is FetchingLocations) {
                      return const Center(
                        child: CircularProgressIndicator.adaptive(),
                      );
                    } else if (state is FetchedLocations) {
                      final locations = state.locations;
                      return ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: locations.length,
                        itemBuilder: (context, index) {
                          final location = locations[index];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: BlocBuilder<
                              ChooseLocationCubit,
                              ChooseLocationState
                            >(
                              bloc: cubit,
                              buildWhen:
                                  (previous, current) =>
                                      current is LocationChosen,
                              builder: (context, state) {
                                if (state is LocationChosen) {
                                  final chosenLocation = state.location;
                                  return LocationItemWidget(
                                    onTap: () {
                                      cubit.selectLocation(location.id);
                                    },
                                    borderColor:
                                        chosenLocation.id == location.id
                                            ? AppColors.primary
                                            : AppColors.grey,
                                    location: location,
                                  );
                                }
                                return LocationItemWidget(
                                  onTap: () {
                                    cubit.selectLocation(location.id);
                                  },
                                  location: location,
                                );
                              },
                            ),
                          );
                        },
                      );
                    } else if (state is FetchLocationFailure) {
                      return Center(
                        child: Text(
                          state.error,
                          style: Theme.of(context).textTheme.titleMedium!
                              .copyWith(color: AppColors.red),
                        ),
                      );
                    } else {
                      return const Center(child: Text('No locations found'));
                    }
                  },
                ),
                const SizedBox(height: 24),
                BlocBuilder<ChooseLocationCubit, ChooseLocationState>(
                  bloc: cubit,
                  buildWhen:
                      (previous, current) =>
                          current is ConfirmAddressLoading ||
                          current is ConfirmAddressLoaded ||
                          current is ConfirmAddressFailure,
                  builder: (context, state) {
                    if (state is ConfirmAddressLoading) {
                      return MainButton(isLoading: true);
                    }
                    return MainButton(
                      name: 'Confirm Address',
                      onTap: () {
                        cubit.confirmAddress();
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
