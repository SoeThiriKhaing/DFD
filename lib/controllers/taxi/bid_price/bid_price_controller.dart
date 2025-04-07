import 'package:dailyfairdeal/services/taxi/bid_price/bid_price_service.dart';
import 'package:flutter/material.dart';

class BidPriceController {
  final BidPriceService bidPriceService;

  BidPriceController({required this.bidPriceService});

  Future<bool> submitBidPrice(int travelId, int driverId, double price) async {
    try {
      await bidPriceService.submitBidPrice(travelId, driverId, price);
      return true;
    } catch (e) {
      debugPrint('Error occurred in submit Bid Price: $e');
      return false;
    }
  }

}