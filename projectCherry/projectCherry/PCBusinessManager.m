//
//  PCLBusinessManager.m
//  projectCherry
//
//  Created by Elijah Cobb on 6/23/16.
//  Copyright © 2016 Apollo Technology. All rights reserved.
//

#import "PCBusinessManager.h"

@implementation PCBusinessManager

+ (instancetype)manager {
    static PCBusinessManager *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[[self class] alloc] init];
    });
    return sharedManager;
}

+(void)setBusinessId:(NSString *)pcId{
    [PCBusinessManager manager].businessId = pcId;
}

+(NSString *)getBusinessId{
    return [[PCBusinessManager manager] businessId];
}

+(void)updatePlace:(PCPlace *)place completion:(void (^)(BOOL succeeded))completionHandler{
    PFQuery *query = [PFQuery queryWithClassName:@"places"];
    [query whereKey:@"id" equalTo:place.pcId];
    [query getFirstObjectInBackgroundWithBlock:^(PFObject * _Nullable object, NSError * _Nullable error) {
        if (object) {
            object[@"id"] = object[@"id"];
            object[@"name"] = place.name;
            object[@"type"] = place.type;
            object[@"rating"] = object[@"rating"];
            object[@"lat"] = place.lat;
            object[@"lng"] = place.lng;
            object[@"phoneNumber"] = place.phoneNumber;
            object[@"address"] = place.address;
            object[@"website"] = place.website;
            object[@"images"] = place.images;
            object[@"files"] = place.files;
            object[@"reviews"] = object[@"reviews"];
            [object saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
                if (error) {
                    completionHandler(NO);
                } else {
                    completionHandler(YES);
                }
            }];
        } else {
            completionHandler(NO);
        }
    }];
}

+(NSArray *)getTypeArray{
    return [@{@"Accounting": @"accounting",
              @"Airpot": @"airport",
              @"Amusement Park": @"amusement_park",
              @"Aquarium": @"aquarium",
              @"Art Gallery": @"art_gallery",
              @"ATM": @"atm",
              @"Bakery": @"bakery",
              @"Bank": @"bank",
              @"Bar": @"bar",
              @"Salon": @"beauty_salon",
              @"Bicycly Shop": @"bicycle_store",
              @"Book Store": @"book_store",
              @"Bowling": @"bowling_alley",
              @"Bus Station": @"bus_station",
              @"Cafe": @"cafe",
              @"Campground": @"campground",
              @"Car Dealer": @"car_dealer",
              @"Car Rental": @"car_rental",
              @"Car Mechanic": @"car_repair",
              @"Car Wash": @"car_wash",
              @"Casino": @"casino",
              @"Cemetery": @"cemetery",
              @"Church": @"church",
              @"City Hall": @"city_hall",
              @"Clothing Store": @"clothing_store",
              @"Convenience Store": @"convenience_store",
              @"Courthouse": @"courthouse",
              @"Dentist": @"dentist",
              @"Department Store": @"department_store",
              @"Doctor": @"doctor",
              @"Electrician": @"electrician",
              @"Electronics Store": @"electronics_store",
              @"Embassy": @"embassy",
              @"Fire Statino": @"fire_station",
              @"Florist": @"florist",
              @"Funeral Home": @"funeral_home",
              @"Furniture Store": @"furniture_store",
              @"Gas Station": @"gas_station",
              @"Groceries": @"grocery_or_supermarket",
              @"Gym": @"gym",
              @"Hair Care": @"hair_care",
              @"Hardware Store": @"hardware_store",
              @"Hindu Temple": @"hindu_temple",
              @"Home Goods Store": @"home_goods_store",
              @"Hospital": @"hospital",
              @"Insurance": @"insurance_agency",
              @"Jeweler": @"jewelry_store",
              @"Laundry Mat": @"laundry",
              @"Lawyer": @"lawyer",
              @"Library": @"library",
              @"Party Store": @"liquor_store",
              @"Government": @"local_government_office",
              @"Locksmith": @"locksmith",
              @"Hotel": @"lodging",
              @"Food Delivery": @"meal_delivery",
              @"Food Take Out": @"meal_takeaway",
              @"Mosuqe": @"mosque",
              @"Movie Rental": @"movie_rental",
              @"Movie Theater": @"movie_theater",
              @"Moving Company": @"moving_company",
              @"Museum": @"museum",
              @"Club": @"night_club",
              @"Painter": @"painter",
              @"Park": @"park",
              @"Parking": @"parking",
              @"Pet Store": @"pet_store",
              @"Pharmacy": @"pharmacy",
              @"Physiotherapist": @"physiotherapist",
              @"Pluber": @"plumber",
              @"Police": @"police",
              @"Post Office": @"post_office",
              @"Real Estate Agency": @"real_estate_agency",
              @"Restaurant": @"restaurant",
              @"RV Park": @"rv_park",
              @"School": @"school",
              @"Shoe Store": @"shoe_store",
              @"Mall": @"shopping_mall",
              @"Spa": @"spa",
              @"Stadium": @"stadium",
              @"Self Storage": @"storage",
              @"Store": @"store",
              @"Sunagogue": @"synagogue",
              @"Taxi": @"taxi_stand",
              @"Transit": @"transit_station",
              @"Travel Agency": @"travel_agency",
              @"University": @"university",
              @"Veterenarian": @"veterinary_care"
              } allKeys];
}

+(NSString *)decodedTypeFromString:(NSString *)string{
    return [@{
              @"accounting": @"Accounting",
              @"airport": @"Airpot",
              @"amusement_park": @"Amusement Park",
              @"aquarium": @"Aquarium",
              @"art_gallery": @"Art Gallery",
              @"atm": @"ATM",
              @"bakery": @"Bakery",
              @"bank": @"Bank",
              @"bar": @"Bar",
              @"beauty_salon": @"Salon",
              @"bicycle_store": @"Bicycly Shop",
              @"book_store": @"Book Store",
              @"bowling_alley": @"Bowling",
              @"bus_station": @"Bus Station",
              @"cafe": @"Cafe",
              @"campground": @"Campground",
              @"car_dealer": @"Car Dealer",
              @"car_rental": @"Car Rental",
              @"car_repair": @"Car Mechanic",
              @"car_wash": @"Car Wash",
              @"casino": @"Casino",
              @"cemetery": @"Cemetery",
              @"church": @"Church",
              @"city_hall": @"City Hall",
              @"clothing_store": @"Clothing Store",
              @"convenience_store": @"Convenience Store",
              @"courthouse": @"Courthouse",
              @"dentist": @"Dentist",
              @"department_store": @"Department Store",
              @"doctor": @"Doctor",
              @"electrician": @"Electrician",
              @"electronics_store": @"Electronics Store",
              @"embassy": @"Embassy",
              @"fire_station": @"Fire Statino",
              @"florist": @"Florist",
              @"funeral_home": @"Funeral Home",
              @"furniture_store": @"Furniture Store",
              @"gas_station": @"Gas Station",
              @"grocery_or_supermarket": @"Groceries",
              @"gym": @"Gym",
              @"hair_care": @"Hair Care",
              @"hardware_store": @"Hardware Store",
              @"hindu_temple": @"Hindu Temple",
              @"home_goods_store": @"Home Goods Store",
              @"hospital": @"Hospital",
              @"insurance_agency": @"Insurance",
              @"jewelry_store": @"Jeweler",
              @"laundry": @"Laundry Mat",
              @"lawyer": @"Lawyer",
              @"library": @"Library",
              @"liquor_store": @"Party Store",
              @"local_government_office": @"Government",
              @"locksmith": @"Locksmith",
              @"lodging": @"Hotel",
              @"meal_delivery": @"Food Delivery",
              @"meal_takeaway": @"Food Take Out",
              @"mosque": @"Mosuqe",
              @"movie_rental": @"Movie Rental",
              @"movie_theater": @"Movie Theater",
              @"moving_company": @"Moving Company",
              @"museum": @"Museum",
              @"night_club": @"Club",
              @"painter": @"Painter",
              @"park": @"Park",
              @"parking": @"Parking",
              @"pet_store": @"Pet Store",
              @"pharmacy": @"Pharmacy",
              @"physiotherapist": @"Physiotherapist",
              @"plumber": @"Pluber",
              @"police": @"Police",
              @"post_office": @"Post Office",
              @"real_estate_agency": @"Real Estate Agency",
              @"restaurant": @"Restaurant",
              @"rv_park": @"RV Park",
              @"school": @"School",
              @"shoe_store": @"Shoe Store",
              @"shopping_mall": @"Mall",
              @"spa": @"Spa",
              @"stadium": @"Stadium",
              @"storage": @"Self Storage",
              @"store": @"Store",
              @"synagogue": @"Sunagogue",
              @"taxi_stand": @"Taxi",
              @"transit_station": @"Transit",
              @"travel_agency": @"Travel Agency",
              @"university": @"University",
              @"veterinary_care": @"Veterenarian"
              } objectForKey:string];
}

+(NSString *)codedTypeFromString:(NSString *)string{
    return [@{@"Accounting": @"accounting",
              @"Airpot": @"airport",
              @"Amusement Park": @"amusement_park",
              @"Aquarium": @"aquarium",
              @"Art Gallery": @"art_gallery",
              @"ATM": @"atm",
              @"Bakery": @"bakery",
              @"Bank": @"bank",
              @"Bar": @"bar",
              @"Salon": @"beauty_salon",
              @"Bicycly Shop": @"bicycle_store",
              @"Book Store": @"book_store",
              @"Bowling": @"bowling_alley",
              @"Bus Station": @"bus_station",
              @"Cafe": @"cafe",
              @"Campground": @"campground",
              @"Car Dealer": @"car_dealer",
              @"Car Rental": @"car_rental",
              @"Car Mechanic": @"car_repair",
              @"Car Wash": @"car_wash",
              @"Casino": @"casino",
              @"Cemetery": @"cemetery",
              @"Church": @"church",
              @"City Hall": @"city_hall",
              @"Clothing Store": @"clothing_store",
              @"Convenience Store": @"convenience_store",
              @"Courthouse": @"courthouse",
              @"Dentist": @"dentist",
              @"Department Store": @"department_store",
              @"Doctor": @"doctor",
              @"Electrician": @"electrician",
              @"Electronics Store": @"electronics_store",
              @"Embassy": @"embassy",
              @"Fire Statino": @"fire_station",
              @"Florist": @"florist",
              @"Funeral Home": @"funeral_home",
              @"Furniture Store": @"furniture_store",
              @"Gas Station": @"gas_station",
              @"Groceries": @"grocery_or_supermarket",
              @"Gym": @"gym",
              @"Hair Care": @"hair_care",
              @"Hardware Store": @"hardware_store",
              @"Hindu Temple": @"hindu_temple",
              @"Home Goods Store": @"home_goods_store",
              @"Hospital": @"hospital",
              @"Insurance": @"insurance_agency",
              @"Jeweler": @"jewelry_store",
              @"Laundry Mat": @"laundry",
              @"Lawyer": @"lawyer",
              @"Library": @"library",
              @"Party Store": @"liquor_store",
              @"Government": @"local_government_office",
              @"Locksmith": @"locksmith",
              @"Hotel": @"lodging",
              @"Food Delivery": @"meal_delivery",
              @"Food Take Out": @"meal_takeaway",
              @"Mosuqe": @"mosque",
              @"Movie Rental": @"movie_rental",
              @"Movie Theater": @"movie_theater",
              @"Moving Company": @"moving_company",
              @"Museum": @"museum",
              @"Club": @"night_club",
              @"Painter": @"painter",
              @"Park": @"park",
              @"Parking": @"parking",
              @"Pet Store": @"pet_store",
              @"Pharmacy": @"pharmacy",
              @"Physiotherapist": @"physiotherapist",
              @"Pluber": @"plumber",
              @"Police": @"police",
              @"Post Office": @"post_office",
              @"Real Estate Agency": @"real_estate_agency",
              @"Restaurant": @"restaurant",
              @"RV Park": @"rv_park",
              @"School": @"school",
              @"Shoe Store": @"shoe_store",
              @"Mall": @"shopping_mall",
              @"Spa": @"spa",
              @"Stadium": @"stadium",
              @"Self Storage": @"storage",
              @"Store": @"store",
              @"Sunagogue": @"synagogue",
              @"Taxi": @"taxi_stand",
              @"Transit": @"transit_station",
              @"Travel Agency": @"travel_agency",
              @"University": @"university",
              @"Veterenarian": @"veterinary_care"
              } objectForKey:string];
}

@end
