//
//  APIManager.swift
//  Focus Fitness
//
//  Created by Theappfathers on 28/01/20.
//  Copyright © 2020 Theappfathers. All rights reserved.
//

import Foundation


struct APIManager {
    
    //Development
    static let BASEURL                      =   "https://fakestoreapi.com/"
    
    static let LOGIN_URL                    =   "user/login"
    static let SOCIAL_LOGIN_URL             =   "user/social_login"
    static let VERIFY_LOGIN                 =   "user/login_mobile_verify"
    static let FORGOT_PASSWORD              =   "user/password_forgot"
    static let REGISTRATION_URL             =   "user/register" //user
    static let PASSWORD_CHANGE              =   "user/password_change"
    static let GET_ABOUT_US                 =   "menupages/about_us"
    static let GET_TERMS_CONDITION          =   "menupages/term_condition"
    static let GET_CONTACT_US               =   "menupages/contact_us"
    static let GET_NOTIFICATION             =   "notification/get_notification"

    static let GET_HOME_DATA                =   "products"
    static let GET_BANNER                   =   "banner/get_banner"
    static let GET_MALLS                    =   "mall/get"
    static let GET_CATEGORY                 =   "category/get"
    static let GET_STORE                    =   "store/get"
    static let DELETE_STORE                 =   "store/delete"
    static let ADD_STORE                    =   "store/add"

    static let GET_ADDON_DATA               =   "addon/get"
    
    static let ADD_PRODUCT                  =   "product/add"
    static let GET_PRODUCT                  =   "product/get"
    static let DELETE_PRODUCT               =   "product/delete"
    static let SEARCH_PRODUCT               =   "product/search"

    static let GET_MALL_DETAILS             =   "mall/get_details"
    static let GET_ADDRESS                  =   "address/get"
    static let DELETE_ADDRESS               =   "address/delete"
    static let ADD_ADDRESS                  =   "address/add"

    static let GET_FAVOURITE                =   "favourite/favourite_list"
    static let DELETE_FAVOURITE             =   "favourite/favourite_delete"
    static let ADD_FAVOURITE                =   "favourite/add_favourite"

    static let GET_MY_SHOPPER               =   "user/get_shoppers"

    static let GET_MY_ORDER                 =   "order/order_list"
    static let GET_CHAT_USER                =   "chat/get_chat_user"
    static let GET_CHAT_MESSAGES            =   "chat/get_chat"
    static let SEND_CHAT_MESSAGES           =   "chat/add"
    static let WITHDRAW_OFFER               =   "chat/offer_update"

    static let ADD_RATING                   =   "order/order_rating_save"

    static let GET_ORDER_DETAILS            =   "order/order_get"
    static let GET_PRODUCT_DETAILS_BY_ID    =   "product/get_by_type"
    
    static let GET_SETTING_DETAILS          =   "settings/get_by_key"

    static let PLACE_ORDER                  =   "order/order_place"

    static let SELLER_HOME_DATA             =   "home/get_saller_data"

    static let CANCEL_ORDER                 =   "order/order_status_update"

    static let Support                      =   "user/contact_us"
    
}

struct API_Stripe {
    static let BASEURL                      =   "https://api.stripe.com/v1/"
    
    static let SOURCES                      =   "/sources"
    static let GET_CARD_LIST                =   "customers/"
    static let DELETE_CARD                  =   "customers/"
    static let CREATE_CARD_TOKEN            =   "tokens"
    static let POST_SUBSCRIPTIONS           =   "subscriptions"
    static let TEMPLATE_CHARGES             =   "charges"
    
}

let kAuthorization                          =   "Bearer "

struct StripeKey {
    static let kCustomer                    =   "customer"
}

func createUrlForStripeWebservice(url:String) -> String{
    let mainURL:String = API_Stripe.BASEURL+url
    return mainURL
}

func createUrlForWebservice(url:String) -> String{
    let mainURL:String = APIManager.BASEURL+url
    return mainURL
}



struct AlertTitle{
    
    static let App_Name                 = "App"
    static let Information              = "Information"
    static let Confirmation             = "Confirmation"
}

struct AlertMessages{
    static let kmsgNoInternet           =   "No Internet connection.".Localized()
    static let kmsgServerError          =   "Internal Server Error.".Localized()
    
    static let kmsgBlankPassword        =   "Please enter password.".Localized()
    static let kmsgBlankEmail           =   "Please enter email address.".Localized()
    static let kmsgValidEmail           =   "Please enter valid email address.".Localized()
    static let kmsgPasswordNotMatch     =   "Your password and confirmation password do not match.".Localized()
    static let kmsgConfirmPassword      =   "Please enter confirm password.".Localized()
    static let kmsgTermsAndCondition    =   "Please select terms and condition.".Localized()

    static let kmsgBlankProductName     =   "Please enter product name.".Localized()
    static let kmsgBlankProductNameArabic   =   "Please enter product name in arabic".Localized()

    static let kmsgBlankStoreDesc       =   "Please enter store description.".Localized()
    static let kmsgBlankStore           =   "Please select store.".Localized()
    static let kmsgBlankStoreName       =   "Please enter store name".Localized()
    static let kmsgBlankStoreArabic     =   "Please enter store name in arabic".Localized()

    static let kmsgBlankProductPrice    =   "Please enter price.".Localized()
    static let kmsgBlankProductSellPrice    =   "Please enter sale price.".Localized()
    static let kmsgBlankTags            =   "Please enter tags.".Localized()
    static let kmsgBlankImage           =   "Please select image.".Localized()
    static let kmsgBlankCategory        =   "Please select category.".Localized()
    static let kmsgBlankPaymentType     =   "Please select payment method!".Localized()
    static let kmsgBlankSelectAddress   =   "Please select address.".Localized()

    static let kmsgBlankAddress         =   "Please enter address.".Localized()
    static let kmsgBlankCity            =   "Please enter city.".Localized()
    static let kmsgBlankState           =   "Please enter state.".Localized()
    static let kmsgBlankLocationType           =   "Please enter location type.".Localized()
    static let kmsgBlankzipcode         =   "Please enter zipcode.".Localized()
    static let kmsgBlankCountry         =   "Please select country.".Localized()
    
    static let kmsgBlankMobileNumber    =   "Please enter mobile number.".Localized()

    static let kmsgBlankFirstname       =   "Please enter firstname.".Localized()
    static let kmsgBlankUsername        =   "Please enter username.".Localized()
    static let kmsgBlankSurname         =   "Please enter surname.".Localized()
    static let kmsgBlankDate            =   "Please enter birthdate.".Localized()
    static let kmsgBlankGender          =   "Please select gender.".Localized()
    static let kmsgBlankHeight          =   "Please enter height.".Localized()
    static let kmsgBlankweight          =   "Please enter weight.".Localized()
    static let kmsgBlankDiabetic        =   "Please enter diabetic.".Localized()
    static let kmsgBlankDiabeticPre     =   "Please select dietary preference.".Localized()
    static let kmsgBlankOTP             =   "Please enter OTP.".Localized()
    static let kmsgBlankTitle           =   "Please enter Title.".Localized()

    
}

