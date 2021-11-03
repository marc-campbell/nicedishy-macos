// Generated by the protocol buffer compiler.  DO NOT EDIT!
// source: spacex/api/device/common.proto

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

@class EthernetNetworkInterface;
@class NetworkInterface_RxStats;
@class NetworkInterface_TxStats;
@class PingTarget;
@class SignedData;
@class WifiNetworkInterface;
@class WifiNetworkInterface_InvalidPacketCounts;
@class WifiNetworkInterface_ThermalStatus;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - Enum EthernetNetworkInterface_Duplex

typedef GPB_ENUM(EthernetNetworkInterface_Duplex) {
  /**
   * Value used if any message's field encounters a value that is not defined
   * by this enum. The message will also have C functions to get/set the rawValue
   * of the field.
   **/
  EthernetNetworkInterface_Duplex_GPBUnrecognizedEnumeratorValue = kGPBUnrecognizedEnumeratorValue,
  EthernetNetworkInterface_Duplex_Unknown = 0,
  EthernetNetworkInterface_Duplex_Half = 1,
  EthernetNetworkInterface_Duplex_Full = 2,
};

GPBEnumDescriptor *EthernetNetworkInterface_Duplex_EnumDescriptor(void);

/**
 * Checks to see if the given value is defined by the enum or was not known at
 * the time this source was generated.
 **/
BOOL EthernetNetworkInterface_Duplex_IsValidValue(int32_t value);

#pragma mark - CommonRoot

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
GPB_FINAL @interface CommonRoot : GPBRootObject
@end

#pragma mark - DeviceInfo

typedef GPB_ENUM(DeviceInfo_FieldNumber) {
  DeviceInfo_FieldNumber_Id_p = 1,
  DeviceInfo_FieldNumber_HardwareVersion = 2,
  DeviceInfo_FieldNumber_SoftwareVersion = 3,
  DeviceInfo_FieldNumber_CountryCode = 4,
  DeviceInfo_FieldNumber_UtcOffsetS = 5,
  DeviceInfo_FieldNumber_SoftwarePartitionsEqual = 6,
  DeviceInfo_FieldNumber_IsDev = 7,
  DeviceInfo_FieldNumber_Bootcount = 8,
  DeviceInfo_FieldNumber_AntiRollbackVersion = 9,
};

GPB_FINAL @interface DeviceInfo : GPBMessage


@property(nonatomic, readwrite, copy, null_resettable) NSString *id_p;


@property(nonatomic, readwrite, copy, null_resettable) NSString *hardwareVersion;


@property(nonatomic, readwrite, copy, null_resettable) NSString *softwareVersion;


@property(nonatomic, readwrite, copy, null_resettable) NSString *countryCode;


@property(nonatomic, readwrite) int32_t utcOffsetS;


@property(nonatomic, readwrite) BOOL softwarePartitionsEqual;


@property(nonatomic, readwrite) BOOL isDev;


@property(nonatomic, readwrite) int32_t bootcount;


@property(nonatomic, readwrite) int32_t antiRollbackVersion;

@end

#pragma mark - DeviceState

typedef GPB_ENUM(DeviceState_FieldNumber) {
  DeviceState_FieldNumber_UptimeS = 1,
};

GPB_FINAL @interface DeviceState : GPBMessage


@property(nonatomic, readwrite) uint64_t uptimeS;

@end

#pragma mark - SignedData

typedef GPB_ENUM(SignedData_FieldNumber) {
  SignedData_FieldNumber_Data_p = 1,
  SignedData_FieldNumber_Signature = 2,
};

GPB_FINAL @interface SignedData : GPBMessage


@property(nonatomic, readwrite, copy, null_resettable) NSData *data_p;


@property(nonatomic, readwrite, copy, null_resettable) NSData *signature;

@end

#pragma mark - GetNextIdRequest

GPB_FINAL @interface GetNextIdRequest : GPBMessage

@end

#pragma mark - GetNextIdResponse

typedef GPB_ENUM(GetNextIdResponse_FieldNumber) {
  GetNextIdResponse_FieldNumber_Id_p = 1,
  GetNextIdResponse_FieldNumber_EpochId = 2,
};

GPB_FINAL @interface GetNextIdResponse : GPBMessage


@property(nonatomic, readwrite) uint64_t id_p;


@property(nonatomic, readwrite) uint64_t epochId;

@end

#pragma mark - PingTarget

typedef GPB_ENUM(PingTarget_FieldNumber) {
  PingTarget_FieldNumber_Service = 1,
  PingTarget_FieldNumber_Location = 2,
  PingTarget_FieldNumber_Address = 3,
};

GPB_FINAL @interface PingTarget : GPBMessage


@property(nonatomic, readwrite, copy, null_resettable) NSString *service;


@property(nonatomic, readwrite, copy, null_resettable) NSString *location;


@property(nonatomic, readwrite, copy, null_resettable) NSString *address;

@end

#pragma mark - PingResult

typedef GPB_ENUM(PingResult_FieldNumber) {
  PingResult_FieldNumber_DropRate = 1,
  PingResult_FieldNumber_LatencyMs = 2,
  PingResult_FieldNumber_Target = 3,
};

GPB_FINAL @interface PingResult : GPBMessage


@property(nonatomic, readwrite, strong, null_resettable) PingTarget *target;
/** Test to see if @c target has been set. */
@property(nonatomic, readwrite) BOOL hasTarget;


@property(nonatomic, readwrite) float dropRate;


@property(nonatomic, readwrite) float latencyMs;

@end

#pragma mark - BondingChallenge

typedef GPB_ENUM(BondingChallenge_FieldNumber) {
  BondingChallenge_FieldNumber_DishId = 1,
  BondingChallenge_FieldNumber_WifiId = 2,
  BondingChallenge_FieldNumber_Nonce = 3,
};

GPB_FINAL @interface BondingChallenge : GPBMessage


@property(nonatomic, readwrite, copy, null_resettable) NSString *dishId;


@property(nonatomic, readwrite, copy, null_resettable) NSString *wifiId;


@property(nonatomic, readwrite, copy, null_resettable) NSData *nonce;

@end

#pragma mark - AuthenticateRequest

typedef GPB_ENUM(AuthenticateRequest_FieldNumber) {
  AuthenticateRequest_FieldNumber_Challenge = 1,
};

GPB_FINAL @interface AuthenticateRequest : GPBMessage


@property(nonatomic, readwrite, strong, null_resettable) SignedData *challenge;
/** Test to see if @c challenge has been set. */
@property(nonatomic, readwrite) BOOL hasChallenge;

@end

#pragma mark - ChallengeResponse

typedef GPB_ENUM(ChallengeResponse_FieldNumber) {
  ChallengeResponse_FieldNumber_Signature = 1,
  ChallengeResponse_FieldNumber_CertificateChain = 2,
};

GPB_FINAL @interface ChallengeResponse : GPBMessage


@property(nonatomic, readwrite, copy, null_resettable) NSData *signature;


@property(nonatomic, readwrite, copy, null_resettable) NSData *certificateChain;

@end

#pragma mark - NetworkInterface

typedef GPB_ENUM(NetworkInterface_FieldNumber) {
  NetworkInterface_FieldNumber_Name = 1,
  NetworkInterface_FieldNumber_RxStats = 2,
  NetworkInterface_FieldNumber_TxStats = 3,
  NetworkInterface_FieldNumber_Up = 4,
  NetworkInterface_FieldNumber_Ethernet = 1000,
  NetworkInterface_FieldNumber_Wifi = 1001,
};

typedef GPB_ENUM(NetworkInterface_Interface_OneOfCase) {
  NetworkInterface_Interface_OneOfCase_GPBUnsetOneOfCase = 0,
  NetworkInterface_Interface_OneOfCase_Ethernet = 1000,
  NetworkInterface_Interface_OneOfCase_Wifi = 1001,
};

GPB_FINAL @interface NetworkInterface : GPBMessage


@property(nonatomic, readwrite, copy, null_resettable) NSString *name;


@property(nonatomic, readwrite) BOOL up;


@property(nonatomic, readwrite, strong, null_resettable) NetworkInterface_RxStats *rxStats;
/** Test to see if @c rxStats has been set. */
@property(nonatomic, readwrite) BOOL hasRxStats;


@property(nonatomic, readwrite, strong, null_resettable) NetworkInterface_TxStats *txStats;
/** Test to see if @c txStats has been set. */
@property(nonatomic, readwrite) BOOL hasTxStats;

@property(nonatomic, readonly) NetworkInterface_Interface_OneOfCase interfaceOneOfCase;


@property(nonatomic, readwrite, strong, null_resettable) EthernetNetworkInterface *ethernet;


@property(nonatomic, readwrite, strong, null_resettable) WifiNetworkInterface *wifi;

@end

/**
 * Clears whatever value was set for the oneof 'interface'.
 **/
void NetworkInterface_ClearInterfaceOneOfCase(NetworkInterface *message);

#pragma mark - NetworkInterface_RxStats

typedef GPB_ENUM(NetworkInterface_RxStats_FieldNumber) {
  NetworkInterface_RxStats_FieldNumber_Bytes = 1,
  NetworkInterface_RxStats_FieldNumber_Packets = 2,
  NetworkInterface_RxStats_FieldNumber_FrameErrors = 3,
};

GPB_FINAL @interface NetworkInterface_RxStats : GPBMessage


@property(nonatomic, readwrite) uint64_t bytes;


@property(nonatomic, readwrite) uint64_t packets;


@property(nonatomic, readwrite) uint64_t frameErrors;

@end

#pragma mark - NetworkInterface_TxStats

typedef GPB_ENUM(NetworkInterface_TxStats_FieldNumber) {
  NetworkInterface_TxStats_FieldNumber_Bytes = 1,
  NetworkInterface_TxStats_FieldNumber_Packets = 2,
};

GPB_FINAL @interface NetworkInterface_TxStats : GPBMessage


@property(nonatomic, readwrite) uint64_t bytes;


@property(nonatomic, readwrite) uint64_t packets;

@end

#pragma mark - EthernetNetworkInterface

typedef GPB_ENUM(EthernetNetworkInterface_FieldNumber) {
  EthernetNetworkInterface_FieldNumber_LinkDetected = 1,
  EthernetNetworkInterface_FieldNumber_SpeedMbps = 2,
  EthernetNetworkInterface_FieldNumber_AutonegotiationOn = 3,
  EthernetNetworkInterface_FieldNumber_Duplex = 4,
};

GPB_FINAL @interface EthernetNetworkInterface : GPBMessage


@property(nonatomic, readwrite) BOOL linkDetected;


@property(nonatomic, readwrite) uint32_t speedMbps;


@property(nonatomic, readwrite) BOOL autonegotiationOn;


@property(nonatomic, readwrite) EthernetNetworkInterface_Duplex duplex;

@end

/**
 * Fetches the raw value of a @c EthernetNetworkInterface's @c duplex property, even
 * if the value was not defined by the enum at the time the code was generated.
 **/
int32_t EthernetNetworkInterface_Duplex_RawValue(EthernetNetworkInterface *message);
/**
 * Sets the raw value of an @c EthernetNetworkInterface's @c duplex property, allowing
 * it to be set to a value that was not defined by the enum at the time the code
 * was generated.
 **/
void SetEthernetNetworkInterface_Duplex_RawValue(EthernetNetworkInterface *message, int32_t value);

#pragma mark - WifiNetworkInterface

typedef GPB_ENUM(WifiNetworkInterface_FieldNumber) {
  WifiNetworkInterface_FieldNumber_ThermalStatus = 1,
  WifiNetworkInterface_FieldNumber_InvalidPacketCounts = 2,
  WifiNetworkInterface_FieldNumber_Channel = 3,
  WifiNetworkInterface_FieldNumber_LinkQuality = 4,
  WifiNetworkInterface_FieldNumber_SignalLevel = 5,
  WifiNetworkInterface_FieldNumber_NoiseLevel = 6,
  WifiNetworkInterface_FieldNumber_MissedBeacons = 8,
};

GPB_FINAL @interface WifiNetworkInterface : GPBMessage


@property(nonatomic, readwrite, strong, null_resettable) WifiNetworkInterface_ThermalStatus *thermalStatus;
/** Test to see if @c thermalStatus has been set. */
@property(nonatomic, readwrite) BOOL hasThermalStatus;


@property(nonatomic, readwrite, strong, null_resettable) WifiNetworkInterface_InvalidPacketCounts *invalidPacketCounts;
/** Test to see if @c invalidPacketCounts has been set. */
@property(nonatomic, readwrite) BOOL hasInvalidPacketCounts;


@property(nonatomic, readwrite) uint32_t channel;


@property(nonatomic, readwrite) uint32_t missedBeacons;


@property(nonatomic, readwrite) double linkQuality;


@property(nonatomic, readwrite) double signalLevel;


@property(nonatomic, readwrite) double noiseLevel;

@end

#pragma mark - WifiNetworkInterface_ThermalStatus

typedef GPB_ENUM(WifiNetworkInterface_ThermalStatus_FieldNumber) {
  WifiNetworkInterface_ThermalStatus_FieldNumber_Level = 1,
  WifiNetworkInterface_ThermalStatus_FieldNumber_Temp = 2,
  WifiNetworkInterface_ThermalStatus_FieldNumber_Temp2 = 3,
  WifiNetworkInterface_ThermalStatus_FieldNumber_PowerReduction = 4,
  WifiNetworkInterface_ThermalStatus_FieldNumber_DutyCycle = 5,
};

GPB_FINAL @interface WifiNetworkInterface_ThermalStatus : GPBMessage


@property(nonatomic, readwrite) uint32_t level;


@property(nonatomic, readwrite) uint32_t temp GPB_DEPRECATED_MSG("SpaceX.API.Device.WifiNetworkInterface.ThermalStatus.temp is deprecated (see spacex/api/device/common.proto).");


@property(nonatomic, readwrite) double temp2;


@property(nonatomic, readwrite) uint32_t powerReduction;


@property(nonatomic, readwrite) uint32_t dutyCycle;

@end

#pragma mark - WifiNetworkInterface_InvalidPacketCounts

typedef GPB_ENUM(WifiNetworkInterface_InvalidPacketCounts_FieldNumber) {
  WifiNetworkInterface_InvalidPacketCounts_FieldNumber_RxInvalidNwid = 1,
  WifiNetworkInterface_InvalidPacketCounts_FieldNumber_RxInvalidCrypt = 2,
  WifiNetworkInterface_InvalidPacketCounts_FieldNumber_RxInvalidFrag = 3,
  WifiNetworkInterface_InvalidPacketCounts_FieldNumber_TxExcessiveRetries = 4,
  WifiNetworkInterface_InvalidPacketCounts_FieldNumber_InvalidMisc = 5,
};

GPB_FINAL @interface WifiNetworkInterface_InvalidPacketCounts : GPBMessage


@property(nonatomic, readwrite) uint32_t rxInvalidNwid;


@property(nonatomic, readwrite) uint32_t rxInvalidCrypt;


@property(nonatomic, readwrite) uint32_t rxInvalidFrag;


@property(nonatomic, readwrite) uint32_t txExcessiveRetries;


@property(nonatomic, readwrite) uint32_t invalidMisc;

@end

#pragma mark - LLAPosition

typedef GPB_ENUM(LLAPosition_FieldNumber) {
  LLAPosition_FieldNumber_Lat = 1,
  LLAPosition_FieldNumber_Lon = 2,
  LLAPosition_FieldNumber_Alt = 3,
};

GPB_FINAL @interface LLAPosition : GPBMessage


@property(nonatomic, readwrite) double lat;


@property(nonatomic, readwrite) double lon;


@property(nonatomic, readwrite) double alt;

@end

#pragma mark - ECEFPosition

typedef GPB_ENUM(ECEFPosition_FieldNumber) {
  ECEFPosition_FieldNumber_X = 1,
  ECEFPosition_FieldNumber_Y = 2,
  ECEFPosition_FieldNumber_Z = 3,
};

GPB_FINAL @interface ECEFPosition : GPBMessage


@property(nonatomic, readwrite) double x;


@property(nonatomic, readwrite) double y;


@property(nonatomic, readwrite) double z;

@end

NS_ASSUME_NONNULL_END

CF_EXTERN_C_END

#pragma clang diagnostic pop

// @@protoc_insertion_point(global_scope)
