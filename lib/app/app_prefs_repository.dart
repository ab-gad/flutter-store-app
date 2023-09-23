import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_store_app/app/app_constants.dart';
import 'package:flutter_store_app/app/exceptions.dart';
import 'package:flutter_store_app/app/failures.dart';
import 'package:flutter_store_app/data/data_sources/local/local_data_source.dart';

abstract class AppPrefsRepository {
  Future<String> get appLang;
  Future<bool> get isOnboardingViewed;
  Future<bool> get isUserLoggedIn;
  Stream<Locale> get appLangStream;
  Sink<Locale> get appLangStreamSink;

  Future<Either<CashFailure, void>> setIsOnboardingViewed(
      bool isOnboardingViewed);
  Future<Either<CashFailure, void>> setIsUserLoggedIn(bool isLoggedIn);
}

class AppPrefsRepositoryImpl implements AppPrefsRepository {
  final LocalDataSources _localDataSource;
  final StreamController<Locale> _appLangStreamCtrl =
      StreamController.broadcast();

  AppPrefsRepositoryImpl(this._localDataSource);

  @override
  Future<String> get appLang async {
    try {
      var lang = await _localDataSource.appLang;
      return lang;
    } on CashException {
      return AppConstants.defaultLangCode;
    }
  }

  @override
  Future<bool> get isOnboardingViewed async {
    try {
      var isViewed = await _localDataSource.isOnboardingViewed;
      return isViewed;
    } on CashException {
      return false;
    }
  }

  @override
  Future<bool> get isUserLoggedIn async {
    try {
      var isLoggedIn = await _localDataSource.isUserLoggedIn;
      return isLoggedIn;
    } on CashException {
      return false;
    }
  }

  @override
  setIsOnboardingViewed(bool isOnboardingViewed) async {
    try {
      var cachingSuccess =
          await _localDataSource.setIsOnboardingViewed(isOnboardingViewed);
      return Right(cachingSuccess);
    } on CashException {
      return Left(CashFailure(message: 'Can not cash is onboarding viewed'));
    }
  }

  @override
  setIsUserLoggedIn(bool isUserLoggedIn) async {
    try {
      var cachingSuccess =
          await _localDataSource.setIsUserLoggedIn(isUserLoggedIn);
      return Right(cachingSuccess);
    } on CashException {
      return Left(CashFailure(message: 'Can not cash isUserLoggedIn'));
    }
  }

  @override
  Stream<Locale> get appLangStream => _appLangStreamCtrl.stream;

  @override
  Sink<Locale> get appLangStreamSink => _appLangStreamCtrl.sink;
}
