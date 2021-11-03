// Generated by the protocol buffer compiler.  DO NOT EDIT!
// source: spacex/api/device/wifi_config.proto

// This CPP symbol can be defined to use imports that match up to the framework
// imports needed when using CocoaPods.
#if !defined(GPB_USE_PROTOBUF_FRAMEWORK_IMPORTS)
 #define GPB_USE_PROTOBUF_FRAMEWORK_IMPORTS 0
#endif

#if GPB_USE_PROTOBUF_FRAMEWORK_IMPORTS
 #import <Protobuf/GPBProtocolBuffers.h>
#else
 #import "GPBProtocolBuffers.h"
#endif

#if GOOGLE_PROTOBUF_OBJC_VERSION < 30004
#error This file was generated by a newer version of protoc which is incompatible with your Protocol Buffer library sources.
#endif
#if 30004 < GOOGLE_PROTOBUF_OBJC_MIN_SUPPORTED_VERSION
#error This file was generated by an older version of protoc which is incompatible with your Protocol Buffer library sources.
#endif

// @@protoc_insertion_point(imports)

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"

CF_EXTERN_C_BEGIN

@class PublicKey;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - Enum MeshAuth

typedef GPB_ENUM(MeshAuth) {
  /**
   * Value used if any message's field encounters a value that is not defined
   * by this enum. The message will also have C functions to get/set the rawValue
   * of the field.
   **/
  MeshAuth_GPBUnrecognizedEnumeratorValue = kGPBUnrecognizedEnumeratorValue,
  MeshAuth_MeshAuthUnknown = 0,
  MeshAuth_MeshAuthNew = 1,
  MeshAuth_MeshAuthTrusted = 2,
  MeshAuth_MeshAuthUntrusted = 3,
};

GPBEnumDescriptor *MeshAuth_EnumDescriptor(void);

/**
 * Checks to see if the given value is defined by the enum or was not known at
 * the time this source was generated.
 **/
BOOL MeshAuth_IsValidValue(int32_t value);

#pragma mark - Enum WifiConfig_Security

typedef GPB_ENUM(WifiConfig_Security) {
  /**
   * Value used if any message's field encounters a value that is not defined
   * by this enum. The message will also have C functions to get/set the rawValue
   * of the field.
   **/
  WifiConfig_Security_GPBUnrecognizedEnumeratorValue = kGPBUnrecognizedEnumeratorValue,
  WifiConfig_Security_Unknown = 0,
  WifiConfig_Security_Wpa2 = 1,
  WifiConfig_Security_Wpa3 = 2,
  WifiConfig_Security_Wpa2Wpa3 = 3,
};

GPBEnumDescriptor *WifiConfig_Security_EnumDescriptor(void);

/**
 * Checks to see if the given value is defined by the enum or was not known at
 * the time this source was generated.
 **/
BOOL WifiConfig_Security_IsValidValue(int32_t value);

#pragma mark - WifiConfigRoot

/**
 * Exposes the extension registry for this file.
 *
 * The base class provides:
 * @code
 *   + (GPBExtensionRegistry *)extensionRegistry;
 * @endcode
 * which is a @c GPBExtensionRegistry that includes all the extensions defined by
 * this file and all files that it depends on.
 **/
GPB_FINAL @interface WifiConfigRoot : GPBRootObject
@end

#pragma mark - WifiConfig

typedef GPB_ENUM(WifiConfig_FieldNumber) {
  WifiConfig_FieldNumber_NetworkName = 1,
  WifiConfig_FieldNumber_NetworkPassword = 2,
  WifiConfig_FieldNumber_CountryCode = 3,
  WifiConfig_FieldNumber_LanIpv4 = 5,
  WifiConfig_FieldNumber_LanIpv4SubnetMask = 6,
  WifiConfig_FieldNumber_SetupComplete = 7,
  WifiConfig_FieldNumber_FactoryResetTicker = 8,
  WifiConfig_FieldNumber_Version = 9,
  WifiConfig_FieldNumber_WifiSecurity = 10,
  WifiConfig_FieldNumber_NetworkName5Ghz = 11,
  WifiConfig_FieldNumber_MacWan = 12,
  WifiConfig_FieldNumber_MacLan = 13,
  WifiConfig_FieldNumber_MacLan2Ghz = 14,
  WifiConfig_FieldNumber_MacLan5Ghz = 15,
  WifiConfig_FieldNumber_DeviceId = 16,
  WifiConfig_FieldNumber_Disable2Ghz = 17,
  WifiConfig_FieldNumber_Disable5Ghz = 18,
  WifiConfig_FieldNumber_Channel2Ghz = 19,
  WifiConfig_FieldNumber_Channel5Ghz = 20,
  WifiConfig_FieldNumber_MeshAuths = 21,
  WifiConfig_FieldNumber_DynamicKeysArray = 22,
  WifiConfig_FieldNumber_IsRepeater = 23,
  WifiConfig_FieldNumber_ExperimentsEnableMesh = 24,
  WifiConfig_FieldNumber_MeshUpstreamsArray = 25,
  WifiConfig_FieldNumber_BootCount = 26,
  WifiConfig_FieldNumber_TrustedPeersArray = 27,
  WifiConfig_FieldNumber_DistrustedPeersArray = 28,
  WifiConfig_FieldNumber_DisableHidden = 29,
  WifiConfig_FieldNumber_NameserversArray = 30,
  WifiConfig_FieldNumber_ApplyNetworkName = 1001,
  WifiConfig_FieldNumber_ApplyNetworkPassword = 1002,
  WifiConfig_FieldNumber_ApplyWifiSecurity = 1004,
  WifiConfig_FieldNumber_ApplyNetworkName5Ghz = 1005,
  WifiConfig_FieldNumber_ApplyMacWan = 1006,
  WifiConfig_FieldNumber_ApplyMacLan = 1007,
  WifiConfig_FieldNumber_ApplyMacLan2Ghz = 1008,
  WifiConfig_FieldNumber_ApplyMacLan5Ghz = 1009,
  WifiConfig_FieldNumber_ApplySetupComplete = 1010,
  WifiConfig_FieldNumber_ApplyDisable2Ghz = 1011,
  WifiConfig_FieldNumber_ApplyDisable5Ghz = 1012,
  WifiConfig_FieldNumber_ApplyChannel2Ghz = 1013,
  WifiConfig_FieldNumber_ApplyChannel5Ghz = 1014,
  WifiConfig_FieldNumber_ApplyDisableHidden = 1015,
  WifiConfig_FieldNumber_ApplyMeshAuths = 1021,
  WifiConfig_FieldNumber_ApplyIsRepeater = 1031,
  WifiConfig_FieldNumber_ApplyExperimentsEnableMesh = 1041,
  WifiConfig_FieldNumber_ApplyMeshUpstreams = 1051,
  WifiConfig_FieldNumber_ApplyTrustedPeers = 1052,
  WifiConfig_FieldNumber_ApplyDistrustedPeers = 1053,
  WifiConfig_FieldNumber_ApplyNameservers = 1054,
  WifiConfig_FieldNumber_HtBandwidth = 2001,
  WifiConfig_FieldNumber_VhtBandwidth = 2002,
  WifiConfig_FieldNumber_WirelessMode2Ghz = 2003,
  WifiConfig_FieldNumber_WirelessMode5Ghz = 2004,
};

GPB_FINAL @interface WifiConfig : GPBMessage


@property(nonatomic, readwrite, copy, null_resettable) NSString *networkName;


@property(nonatomic, readwrite) BOOL applyNetworkName;


@property(nonatomic, readwrite, copy, null_resettable) NSString *networkPassword;


@property(nonatomic, readwrite) BOOL applyNetworkPassword;


@property(nonatomic, readwrite, copy, null_resettable) NSString *countryCode;


@property(nonatomic, readwrite, copy, null_resettable) NSString *lanIpv4;


@property(nonatomic, readwrite, copy, null_resettable) NSString *lanIpv4SubnetMask;


@property(nonatomic, readwrite) BOOL setupComplete;


@property(nonatomic, readwrite) BOOL applySetupComplete;


@property(nonatomic, readwrite) uint32_t factoryResetTicker GPB_DEPRECATED_MSG("SpaceX.API.Device.WifiConfig.factory_reset_ticker is deprecated (see spacex/api/device/wifi_config.proto).");


@property(nonatomic, readwrite) uint32_t version;


@property(nonatomic, readwrite) WifiConfig_Security wifiSecurity;


@property(nonatomic, readwrite) BOOL applyWifiSecurity;


@property(nonatomic, readwrite, copy, null_resettable) NSString *networkName5Ghz;


@property(nonatomic, readwrite) BOOL applyNetworkName5Ghz;


@property(nonatomic, readwrite, copy, null_resettable) NSString *macWan;


@property(nonatomic, readwrite) BOOL applyMacWan;


@property(nonatomic, readwrite, copy, null_resettable) NSString *macLan;


@property(nonatomic, readwrite) BOOL applyMacLan;


@property(nonatomic, readwrite, copy, null_resettable) NSString *macLan2Ghz;


@property(nonatomic, readwrite) BOOL applyMacLan2Ghz;


@property(nonatomic, readwrite, copy, null_resettable) NSString *macLan5Ghz;


@property(nonatomic, readwrite) BOOL applyMacLan5Ghz;


@property(nonatomic, readwrite, copy, null_resettable) NSString *deviceId;


@property(nonatomic, readwrite) BOOL disable2Ghz;


@property(nonatomic, readwrite) BOOL applyDisable2Ghz;


@property(nonatomic, readwrite) BOOL disable5Ghz;


@property(nonatomic, readwrite) BOOL applyDisable5Ghz;


@property(nonatomic, readwrite) BOOL disableHidden;


@property(nonatomic, readwrite) BOOL applyDisableHidden;


@property(nonatomic, readwrite) uint32_t channel2Ghz;


@property(nonatomic, readwrite) BOOL applyChannel2Ghz;


@property(nonatomic, readwrite) uint32_t channel5Ghz;


@property(nonatomic, readwrite) BOOL applyChannel5Ghz;


// |meshAuths| values are |MeshAuth|
@property(nonatomic, readwrite, strong, null_resettable) GPBStringEnumDictionary *meshAuths;
/** The number of items in @c meshAuths without causing the array to be created. */
@property(nonatomic, readonly) NSUInteger meshAuths_Count;


@property(nonatomic, readwrite) BOOL applyMeshAuths;


@property(nonatomic, readwrite, strong, null_resettable) NSMutableArray<NSString*> *meshUpstreamsArray GPB_DEPRECATED_MSG("SpaceX.API.Device.WifiConfig.mesh_upstreams is deprecated (see spacex/api/device/wifi_config.proto).");
/** The number of items in @c meshUpstreamsArray without causing the array to be created. */
@property(nonatomic, readonly) NSUInteger meshUpstreamsArray_Count GPB_DEPRECATED_MSG("SpaceX.API.Device.WifiConfig.mesh_upstreams is deprecated (see spacex/api/device/wifi_config.proto).");


@property(nonatomic, readwrite) BOOL applyMeshUpstreams GPB_DEPRECATED_MSG("SpaceX.API.Device.WifiConfig.apply_mesh_upstreams is deprecated (see spacex/api/device/wifi_config.proto).");


@property(nonatomic, readwrite, strong, null_resettable) NSMutableArray<NSString*> *trustedPeersArray GPB_DEPRECATED_MSG("SpaceX.API.Device.WifiConfig.trusted_peers is deprecated (see spacex/api/device/wifi_config.proto).");
/** The number of items in @c trustedPeersArray without causing the array to be created. */
@property(nonatomic, readonly) NSUInteger trustedPeersArray_Count GPB_DEPRECATED_MSG("SpaceX.API.Device.WifiConfig.trusted_peers is deprecated (see spacex/api/device/wifi_config.proto).");


@property(nonatomic, readwrite) BOOL applyTrustedPeers GPB_DEPRECATED_MSG("SpaceX.API.Device.WifiConfig.apply_trusted_peers is deprecated (see spacex/api/device/wifi_config.proto).");


@property(nonatomic, readwrite, strong, null_resettable) NSMutableArray<NSString*> *distrustedPeersArray GPB_DEPRECATED_MSG("SpaceX.API.Device.WifiConfig.distrusted_peers is deprecated (see spacex/api/device/wifi_config.proto).");
/** The number of items in @c distrustedPeersArray without causing the array to be created. */
@property(nonatomic, readonly) NSUInteger distrustedPeersArray_Count GPB_DEPRECATED_MSG("SpaceX.API.Device.WifiConfig.distrusted_peers is deprecated (see spacex/api/device/wifi_config.proto).");


@property(nonatomic, readwrite) BOOL applyDistrustedPeers GPB_DEPRECATED_MSG("SpaceX.API.Device.WifiConfig.apply_distrusted_peers is deprecated (see spacex/api/device/wifi_config.proto).");


@property(nonatomic, readwrite, strong, null_resettable) NSMutableArray<PublicKey*> *dynamicKeysArray;
/** The number of items in @c dynamicKeysArray without causing the array to be created. */
@property(nonatomic, readonly) NSUInteger dynamicKeysArray_Count;


@property(nonatomic, readwrite) BOOL isRepeater;


@property(nonatomic, readwrite) BOOL applyIsRepeater;


@property(nonatomic, readwrite) BOOL experimentsEnableMesh;


@property(nonatomic, readwrite) BOOL applyExperimentsEnableMesh;


@property(nonatomic, readwrite) int32_t bootCount;


@property(nonatomic, readwrite, copy, null_resettable) NSString *htBandwidth;


@property(nonatomic, readwrite, copy, null_resettable) NSString *vhtBandwidth;


@property(nonatomic, readwrite, copy, null_resettable) NSString *wirelessMode2Ghz;


@property(nonatomic, readwrite, copy, null_resettable) NSString *wirelessMode5Ghz;


@property(nonatomic, readwrite, strong, null_resettable) NSMutableArray<NSString*> *nameserversArray;
/** The number of items in @c nameserversArray without causing the array to be created. */
@property(nonatomic, readonly) NSUInteger nameserversArray_Count;


@property(nonatomic, readwrite) BOOL applyNameservers;

@end

/**
 * Fetches the raw value of a @c WifiConfig's @c wifiSecurity property, even
 * if the value was not defined by the enum at the time the code was generated.
 **/
int32_t WifiConfig_WifiSecurity_RawValue(WifiConfig *message);
/**
 * Sets the raw value of an @c WifiConfig's @c wifiSecurity property, allowing
 * it to be set to a value that was not defined by the enum at the time the code
 * was generated.
 **/
void SetWifiConfig_WifiSecurity_RawValue(WifiConfig *message, int32_t value);

NS_ASSUME_NONNULL_END

CF_EXTERN_C_END

#pragma clang diagnostic pop

// @@protoc_insertion_point(global_scope)
