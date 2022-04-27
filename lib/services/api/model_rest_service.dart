import 'package:flutter/material.dart';

import '../../models/api_model.dart';
import 'rest_methods.dart';
import 'rest_service.dart';

abstract class GenericRestService<T extends ApiModel> extends RestService {
  final String resource;

  GenericRestService(
    this.resource, {
    List<RestMethods> authenticatedActions = RestMethods.values,
  }) : super(
          authenticatedActions: authenticatedActions,
        );

  T modelFromMap(Map<String, dynamic> m);
}

abstract class ModelRestService<T extends ApiModel> extends GenericRestService<T>
    with
        CreateModelMixin,
        UpdateModelMixin,
        PartialUpdateListModelMixin,
        PatchModelMixin,
        DeleteModelMixin,
        GetModelMixin,
        ListModelMixin {
  /// [resource] The name of the resource, used in URLS (ex `users`)
  /// [modelInstance] An instance of T, needed to create new instances with clone
  ModelRestService(
    BuildContext context,
    String resource,{
    List<RestMethods> authenticatedActions = RestMethods.values,
  }) : super(
          resource,
          authenticatedActions: authenticatedActions,
        );
}
