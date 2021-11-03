// Generated by the protocol buffer compiler.  DO NOT EDIT!
// source: spacex/api/device/dish.proto

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

@class ChallengeResponse;
@class DeviceInfo;
@class DeviceState;
@class DishAlerts;
@class DishObstructionStats;
@class DishOutage;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - Enum DishState

typedef GPB_ENUM(DishState) {
  /**
   * Value used if any message's field encounters a value that is not defined
   * by this enum. The message will also have C functions to get/set the rawValue
   * of the field.
   **/
  DishState_GPBUnrecognizedEnumeratorValue = kGPBUnrecognizedEnumeratorValue,
  DishState_Unknown = 0,
  DishState_Connected = 1,
  DishState_Searching = 2,
  DishState_Booting = 3,
};

GPBEnumDescriptor *DishState_EnumDescriptor(void);

/**
 * Checks to see if the given value is defined by the enum or was not known at
 * the time this source was generated.
 **/
BOOL DishState_IsValidValue(int32_t value);

#pragma mark - Enum DishOutage_Cause

typedef GPB_ENUM(DishOutage_Cause) {
  /**
   * Value used if any message's field encounters a value that is not defined
   * by this enum. The message will also have C functions to get/set the rawValue
   * of the field.
   **/
  DishOutage_Cause_GPBUnrecognizedEnumeratorValue = kGPBUnrecognizedEnumeratorValue,
  DishOutage_Cause_Unknown = 0,
  DishOutage_Cause_Booting = 1,
  DishOutage_Cause_Stowed = 2,
  DishOutage_Cause_ThermalShutdown = 3,
  DishOutage_Cause_NoSchedule = 4,
  DishOutage_Cause_NoSats = 5,
  DishOutage_Cause_Obstructed = 6,
  DishOutage_Cause_NoDownlink = 7,
  DishOutage_Cause_NoPings = 8,
};

GPBEnumDescriptor *DishOutage_Cause_EnumDescriptor(void);

/**
 * Checks to see if the given value is defined by the enum or was not known at
 * the time this source was generated.
 **/
BOOL DishOutage_Cause_IsValidValue(int32_t value);

#pragma mark - DishRoot

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
GPB_FINAL @interface DishRoot : GPBRootObject
@end

#pragma mark - DishStowRequest

typedef GPB_ENUM(DishStowRequest_FieldNumber) {
  DishStowRequest_FieldNumber_Unstow = 1,
};

GPB_FINAL @interface DishStowRequest : GPBMessage


@property(nonatomic, readwrite) BOOL unstow;

@end

#pragma mark - DishStowResponse

GPB_FINAL @interface DishStowResponse : GPBMessage

@end

#pragma mark - DishGetContextRequest

GPB_FINAL @interface DishGetContextRequest : GPBMessage

@end

#pragma mark - DishGetContextResponse

typedef GPB_ENUM(DishGetContextResponse_FieldNumber) {
  DishGetContextResponse_FieldNumber_DeviceInfo = 1,
  DishGetContextResponse_FieldNumber_ObstructionFraction = 2,
  DishGetContextResponse_FieldNumber_ObstructionValidS = 3,
  DishGetContextResponse_FieldNumber_CellId = 4,
  DishGetContextResponse_FieldNumber_PopRackId = 5,
  DishGetContextResponse_FieldNumber_SecondsToSlotEnd = 6,
  DishGetContextResponse_FieldNumber_DeviceState = 7,
  DishGetContextResponse_FieldNumber_InitialSatelliteId = 8,
  DishGetContextResponse_FieldNumber_InitialGatewayId = 9,
  DishGetContextResponse_FieldNumber_OnBackupBeam = 10,
  DishGetContextResponse_FieldNumber_DebugTelemetryEnabled = 11,
};

GPB_FINAL @interface DishGetContextResponse : GPBMessage


@property(nonatomic, readwrite, strong, null_resettable) DeviceInfo *deviceInfo;
/** Test to see if @c deviceInfo has been set. */
@property(nonatomic, readwrite) BOOL hasDeviceInfo;


@property(nonatomic, readwrite, strong, null_resettable) DeviceState *deviceState;
/** Test to see if @c deviceState has been set. */
@property(nonatomic, readwrite) BOOL hasDeviceState;


@property(nonatomic, readwrite) float obstructionFraction;


@property(nonatomic, readwrite) float obstructionValidS;


@property(nonatomic, readwrite) uint32_t cellId;


@property(nonatomic, readwrite) uint32_t popRackId;


@property(nonatomic, readwrite) uint32_t initialSatelliteId;


@property(nonatomic, readwrite) uint32_t initialGatewayId;


@property(nonatomic, readwrite) BOOL onBackupBeam;


@property(nonatomic, readwrite) float secondsToSlotEnd;


@property(nonatomic, readwrite) BOOL debugTelemetryEnabled;

@end

#pragma mark - DishOutage

typedef GPB_ENUM(DishOutage_FieldNumber) {
  DishOutage_FieldNumber_Cause = 1,
  DishOutage_FieldNumber_StartTimestampNs = 2,
  DishOutage_FieldNumber_DurationNs = 3,
  DishOutage_FieldNumber_DidSwitch = 4,
};

GPB_FINAL @interface DishOutage : GPBMessage


@property(nonatomic, readwrite) DishOutage_Cause cause;


@property(nonatomic, readwrite) int64_t startTimestampNs;


@property(nonatomic, readwrite) uint64_t durationNs;


@property(nonatomic, readwrite) BOOL didSwitch;

@end

/**
 * Fetches the raw value of a @c DishOutage's @c cause property, even
 * if the value was not defined by the enum at the time the code was generated.
 **/
int32_t DishOutage_Cause_RawValue(DishOutage *message);
/**
 * Sets the raw value of an @c DishOutage's @c cause property, allowing
 * it to be set to a value that was not defined by the enum at the time the code
 * was generated.
 **/
void SetDishOutage_Cause_RawValue(DishOutage *message, int32_t value);

#pragma mark - DishGetHistoryResponse

typedef GPB_ENUM(DishGetHistoryResponse_FieldNumber) {
  DishGetHistoryResponse_FieldNumber_Current = 1,
  DishGetHistoryResponse_FieldNumber_PopPingDropRateArray = 1001,
  DishGetHistoryResponse_FieldNumber_PopPingLatencyMsArray = 1002,
  DishGetHistoryResponse_FieldNumber_DownlinkThroughputBpsArray = 1003,
  DishGetHistoryResponse_FieldNumber_UplinkThroughputBpsArray = 1004,
  DishGetHistoryResponse_FieldNumber_OutagesArray = 1009,
};

GPB_FINAL @interface DishGetHistoryResponse : GPBMessage


@property(nonatomic, readwrite) uint64_t current;


@property(nonatomic, readwrite, strong, null_resettable) GPBFloatArray *popPingDropRateArray;
/** The number of items in @c popPingDropRateArray without causing the array to be created. */
@property(nonatomic, readonly) NSUInteger popPingDropRateArray_Count;


@property(nonatomic, readwrite, strong, null_resettable) GPBFloatArray *popPingLatencyMsArray;
/** The number of items in @c popPingLatencyMsArray without causing the array to be created. */
@property(nonatomic, readonly) NSUInteger popPingLatencyMsArray_Count;


@property(nonatomic, readwrite, strong, null_resettable) GPBFloatArray *downlinkThroughputBpsArray;
/** The number of items in @c downlinkThroughputBpsArray without causing the array to be created. */
@property(nonatomic, readonly) NSUInteger downlinkThroughputBpsArray_Count;


@property(nonatomic, readwrite, strong, null_resettable) GPBFloatArray *uplinkThroughputBpsArray;
/** The number of items in @c uplinkThroughputBpsArray without causing the array to be created. */
@property(nonatomic, readonly) NSUInteger uplinkThroughputBpsArray_Count;


@property(nonatomic, readwrite, strong, null_resettable) NSMutableArray<DishOutage*> *outagesArray;
/** The number of items in @c outagesArray without causing the array to be created. */
@property(nonatomic, readonly) NSUInteger outagesArray_Count;

@end

#pragma mark - DishGetStatusResponse

typedef GPB_ENUM(DishGetStatusResponse_FieldNumber) {
  DishGetStatusResponse_FieldNumber_DeviceInfo = 1,
  DishGetStatusResponse_FieldNumber_DeviceState = 2,
  DishGetStatusResponse_FieldNumber_SecondsToFirstNonemptySlot = 1002,
  DishGetStatusResponse_FieldNumber_PopPingDropRate = 1003,
  DishGetStatusResponse_FieldNumber_ObstructionStats = 1004,
  DishGetStatusResponse_FieldNumber_Alerts = 1005,
  DishGetStatusResponse_FieldNumber_DownlinkThroughputBps = 1007,
  DishGetStatusResponse_FieldNumber_UplinkThroughputBps = 1008,
  DishGetStatusResponse_FieldNumber_PopPingLatencyMs = 1009,
  DishGetStatusResponse_FieldNumber_StowRequested = 1010,
  DishGetStatusResponse_FieldNumber_BoresightAzimuthDeg = 1011,
  DishGetStatusResponse_FieldNumber_BoresightElevationDeg = 1012,
  DishGetStatusResponse_FieldNumber_Outage = 1014,
};

GPB_FINAL @interface DishGetStatusResponse : GPBMessage


@property(nonatomic, readwrite, strong, null_resettable) DeviceInfo *deviceInfo;
/** Test to see if @c deviceInfo has been set. */
@property(nonatomic, readwrite) BOOL hasDeviceInfo;


@property(nonatomic, readwrite, strong, null_resettable) DeviceState *deviceState;
/** Test to see if @c deviceState has been set. */
@property(nonatomic, readwrite) BOOL hasDeviceState;


@property(nonatomic, readwrite, strong, null_resettable) DishAlerts *alerts;
/** Test to see if @c alerts has been set. */
@property(nonatomic, readwrite) BOOL hasAlerts;


@property(nonatomic, readwrite, strong, null_resettable) DishOutage *outage;
/** Test to see if @c outage has been set. */
@property(nonatomic, readwrite) BOOL hasOutage;


@property(nonatomic, readwrite) float secondsToFirstNonemptySlot;


@property(nonatomic, readwrite) float popPingDropRate;


@property(nonatomic, readwrite) float downlinkThroughputBps;


@property(nonatomic, readwrite) float uplinkThroughputBps;


@property(nonatomic, readwrite) float popPingLatencyMs;


@property(nonatomic, readwrite, strong, null_resettable) DishObstructionStats *obstructionStats;
/** Test to see if @c obstructionStats has been set. */
@property(nonatomic, readwrite) BOOL hasObstructionStats;


@property(nonatomic, readwrite) BOOL stowRequested;


@property(nonatomic, readwrite) float boresightAzimuthDeg;


@property(nonatomic, readwrite) float boresightElevationDeg;

@end

#pragma mark - DishGetObstructionMapRequest

GPB_FINAL @interface DishGetObstructionMapRequest : GPBMessage

@end

#pragma mark - DishGetObstructionMapResponse

typedef GPB_ENUM(DishGetObstructionMapResponse_FieldNumber) {
  DishGetObstructionMapResponse_FieldNumber_NumRows = 1,
  DishGetObstructionMapResponse_FieldNumber_NumCols = 2,
  DishGetObstructionMapResponse_FieldNumber_SnrArray = 3,
};

GPB_FINAL @interface DishGetObstructionMapResponse : GPBMessage


@property(nonatomic, readwrite) uint32_t numRows;


@property(nonatomic, readwrite) uint32_t numCols;


@property(nonatomic, readwrite, strong, null_resettable) GPBFloatArray *snrArray;
/** The number of items in @c snrArray without causing the array to be created. */
@property(nonatomic, readonly) NSUInteger snrArray_Count;

@end

#pragma mark - DishAlerts

typedef GPB_ENUM(DishAlerts_FieldNumber) {
  DishAlerts_FieldNumber_MotorsStuck = 1,
  DishAlerts_FieldNumber_ThermalShutdown = 2,
  DishAlerts_FieldNumber_ThermalThrottle = 3,
  DishAlerts_FieldNumber_UnexpectedLocation = 4,
  DishAlerts_FieldNumber_MastNotNearVertical = 5,
  DishAlerts_FieldNumber_SlowEthernetSpeeds = 6,
};

GPB_FINAL @interface DishAlerts : GPBMessage


@property(nonatomic, readwrite) BOOL motorsStuck;


@property(nonatomic, readwrite) BOOL thermalThrottle;


@property(nonatomic, readwrite) BOOL thermalShutdown;


@property(nonatomic, readwrite) BOOL mastNotNearVertical;


@property(nonatomic, readwrite) BOOL unexpectedLocation;


@property(nonatomic, readwrite) BOOL slowEthernetSpeeds;

@end

#pragma mark - DishObstructionStats

typedef GPB_ENUM(DishObstructionStats_FieldNumber) {
  DishObstructionStats_FieldNumber_FractionObstructed = 1,
  DishObstructionStats_FieldNumber_WedgeFractionObstructedArray = 2,
  DishObstructionStats_FieldNumber_WedgeAbsFractionObstructedArray = 3,
  DishObstructionStats_FieldNumber_ValidS = 4,
  DishObstructionStats_FieldNumber_CurrentlyObstructed = 5,
  DishObstructionStats_FieldNumber_AvgProlongedObstructionDurationS = 6,
  DishObstructionStats_FieldNumber_AvgProlongedObstructionIntervalS = 7,
  DishObstructionStats_FieldNumber_AvgProlongedObstructionValid = 8,
};

GPB_FINAL @interface DishObstructionStats : GPBMessage


@property(nonatomic, readwrite) BOOL currentlyObstructed;


@property(nonatomic, readwrite) float fractionObstructed;


@property(nonatomic, readwrite) float validS;


@property(nonatomic, readwrite, strong, null_resettable) GPBFloatArray *wedgeFractionObstructedArray;
/** The number of items in @c wedgeFractionObstructedArray without causing the array to be created. */
@property(nonatomic, readonly) NSUInteger wedgeFractionObstructedArray_Count;


@property(nonatomic, readwrite, strong, null_resettable) GPBFloatArray *wedgeAbsFractionObstructedArray;
/** The number of items in @c wedgeAbsFractionObstructedArray without causing the array to be created. */
@property(nonatomic, readonly) NSUInteger wedgeAbsFractionObstructedArray_Count;


@property(nonatomic, readwrite) float avgProlongedObstructionDurationS;


@property(nonatomic, readwrite) float avgProlongedObstructionIntervalS;


@property(nonatomic, readwrite) BOOL avgProlongedObstructionValid;

@end

#pragma mark - DishAuthenticateResponse

typedef GPB_ENUM(DishAuthenticateResponse_FieldNumber) {
  DishAuthenticateResponse_FieldNumber_Dish = 2,
};

GPB_FINAL @interface DishAuthenticateResponse : GPBMessage


@property(nonatomic, readwrite, strong, null_resettable) ChallengeResponse *dish;
/** Test to see if @c dish has been set. */
@property(nonatomic, readwrite) BOOL hasDish;

@end

NS_ASSUME_NONNULL_END

CF_EXTERN_C_END

#pragma clang diagnostic pop

// @@protoc_insertion_point(global_scope)
