// Generated by the protocol buffer compiler.  DO NOT EDIT!
// source: spacex/api/device/command.proto

// This CPP symbol can be defined to use imports that match up to the framework
// imports needed when using CocoaPods.
#if !defined(GPB_USE_PROTOBUF_FRAMEWORK_IMPORTS)
 #define GPB_USE_PROTOBUF_FRAMEWORK_IMPORTS 0
#endif

#if GPB_USE_PROTOBUF_FRAMEWORK_IMPORTS
 #import <Protobuf/GPBProtocolBuffers_RuntimeSupport.h>
#else
 #import "GPBProtocolBuffers_RuntimeSupport.h"
#endif

#import <stdatomic.h>

#import "spacex/api/device/Command.pbobjc.h"
// @@protoc_insertion_point(imports)

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"

#pragma mark - CommandRoot

@implementation CommandRoot

// No extensions in the file and no imports, so no need to generate
// +extensionRegistry.

@end

#pragma mark - CommandRoot_FileDescriptor

static GPBFileDescriptor *CommandRoot_FileDescriptor(void) {
  // This is called by +initialize so there is no need to worry
  // about thread safety of the singleton.
  static GPBFileDescriptor *descriptor = NULL;
  if (!descriptor) {
    GPB_DEBUG_CHECK_RUNTIME_VERSIONS();
    descriptor = [[GPBFileDescriptor alloc] initWithPackage:@"SpaceX.API.Device"
                                                     syntax:GPBFileSyntaxProto3];
  }
  return descriptor;
}

#pragma mark - Enum Capability

GPBEnumDescriptor *Capability_EnumDescriptor(void) {
  static _Atomic(GPBEnumDescriptor*) descriptor = nil;
  if (!descriptor) {
    static const char *valueNames =
        "Read\000Write\000Debug\000Admin\000Setup\000SetSku\000Refr"
        "esh\000ReadPrivate\000Fuse\000Reset\000";
    static const int32_t values[] = {
        Capability_Read,
        Capability_Write,
        Capability_Debug,
        Capability_Admin,
        Capability_Setup,
        Capability_SetSku,
        Capability_Refresh,
        Capability_ReadPrivate,
        Capability_Fuse,
        Capability_Reset,
    };
    GPBEnumDescriptor *worker =
        [GPBEnumDescriptor allocDescriptorForName:GPBNSStringifySymbol(Capability)
                                       valueNames:valueNames
                                           values:values
                                            count:(uint32_t)(sizeof(values) / sizeof(int32_t))
                                     enumVerifier:Capability_IsValidValue];
    GPBEnumDescriptor *expected = nil;
    if (!atomic_compare_exchange_strong(&descriptor, &expected, worker)) {
      [worker release];
    }
  }
  return descriptor;
}

BOOL Capability_IsValidValue(int32_t value__) {
  switch (value__) {
    case Capability_Read:
    case Capability_Write:
    case Capability_Debug:
    case Capability_Admin:
    case Capability_Setup:
    case Capability_SetSku:
    case Capability_Refresh:
    case Capability_ReadPrivate:
    case Capability_Fuse:
    case Capability_Reset:
      return YES;
    default:
      return NO;
  }
}

#pragma mark - PublicKey

@implementation PublicKey

@dynamic key;
@dynamic capabilitiesArray, capabilitiesArray_Count;

typedef struct PublicKey__storage_ {
  uint32_t _has_storage_[1];
  NSString *key;
  GPBEnumArray *capabilitiesArray;
} PublicKey__storage_;

// This method is threadsafe because it is initially called
// in +initialize for each subclass.
+ (GPBDescriptor *)descriptor {
  static GPBDescriptor *descriptor = nil;
  if (!descriptor) {
    static GPBMessageFieldDescription fields[] = {
      {
        .name = "key",
        .dataTypeSpecific.clazz = Nil,
        .number = PublicKey_FieldNumber_Key,
        .hasIndex = 0,
        .offset = (uint32_t)offsetof(PublicKey__storage_, key),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldClearHasIvarOnZero),
        .dataType = GPBDataTypeString,
      },
      {
        .name = "capabilitiesArray",
        .dataTypeSpecific.enumDescFunc = Capability_EnumDescriptor,
        .number = PublicKey_FieldNumber_CapabilitiesArray,
        .hasIndex = GPBNoHasBit,
        .offset = (uint32_t)offsetof(PublicKey__storage_, capabilitiesArray),
        .flags = (GPBFieldFlags)(GPBFieldRepeated | GPBFieldPacked | GPBFieldHasEnumDescriptor),
        .dataType = GPBDataTypeEnum,
      },
    };
    GPBDescriptor *localDescriptor =
        [GPBDescriptor allocDescriptorForClass:[PublicKey class]
                                     rootClass:[CommandRoot class]
                                          file:CommandRoot_FileDescriptor()
                                        fields:fields
                                    fieldCount:(uint32_t)(sizeof(fields) / sizeof(GPBMessageFieldDescription))
                                   storageSize:sizeof(PublicKey__storage_)
                                         flags:(GPBDescriptorInitializationFlags)(GPBDescriptorInitializationFlag_UsesClassRefs | GPBDescriptorInitializationFlag_Proto3OptionalKnown)];
    #if defined(DEBUG) && DEBUG
      NSAssert(descriptor == nil, @"Startup recursed!");
    #endif  // DEBUG
    descriptor = localDescriptor;
  }
  return descriptor;
}

@end


#pragma clang diagnostic pop

// @@protoc_insertion_point(global_scope)
