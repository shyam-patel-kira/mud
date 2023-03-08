// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

/* Autogenerated file. Do not edit manually. */

import { SchemaType } from "@latticexyz/schema-type/src/solidity/SchemaType.sol";

import { IStore } from "../IStore.sol";
import { StoreSwitch } from "../StoreSwitch.sol";
import { StoreCore } from "../StoreCore.sol";
import { Bytes } from "../Bytes.sol";
import { SliceLib } from "../Slice.sol";
import { EncodeArray } from "../tightcoder/EncodeArray.sol";
import { Schema, SchemaLib } from "../Schema.sol";
import { PackedCounter, PackedCounterLib } from "../PackedCounter.sol";

uint256 constant _tableId = uint256(keccak256("/store_internals/tables/Mixed"));
uint256 constant MixedTableId = _tableId;

struct MixedData {
  uint32 u32;
  uint128 u128;
  uint32[] a32;
  string s;
}

library Mixed {
  /** Get the table's schema */
  function getSchema() internal pure returns (Schema) {
    SchemaType[] memory _schema = new SchemaType[](4);
    _schema[0] = SchemaType.UINT32;
    _schema[1] = SchemaType.UINT128;
    _schema[2] = SchemaType.UINT32_ARRAY;
    _schema[3] = SchemaType.STRING;

    return SchemaLib.encode(_schema);
  }

  /** Get the table's metadata */
  function getMetadata() internal pure returns (string memory, string[] memory) {
    string[] memory _fieldNames = new string[](4);
    _fieldNames[0] = "u32";
    _fieldNames[1] = "u128";
    _fieldNames[2] = "a32";
    _fieldNames[3] = "s";
    return ("Mixed", _fieldNames);
  }

  /** Register the table's schema */
  function registerSchema() internal {
    StoreSwitch.registerSchema(_tableId, getSchema());
  }

  /** Set the table's metadata */
  function setMetadata() internal {
    (string memory _tableName, string[] memory _fieldNames) = getMetadata();
    StoreSwitch.setMetadata(_tableId, _tableName, _fieldNames);
  }

  /** Get u32 */
  function getU32(bytes32 key) internal view returns (uint32 u32) {
    bytes32[] memory _primaryKeys = new bytes32[](1);

    _primaryKeys[0] = bytes32(key);

    bytes memory _blob = StoreSwitch.getField(_tableId, _primaryKeys, 0);
    return uint32(Bytes.slice4(_blob, 0));
  }

  /** Set u32 */
  function setU32(bytes32 key, uint32 u32) internal {
    bytes32[] memory _primaryKeys = new bytes32[](1);

    _primaryKeys[0] = bytes32(key);

    StoreSwitch.setField(_tableId, _primaryKeys, 0, abi.encodePacked(u32));
  }

  /** Get u128 */
  function getU128(bytes32 key) internal view returns (uint128 u128) {
    bytes32[] memory _primaryKeys = new bytes32[](1);

    _primaryKeys[0] = bytes32(key);

    bytes memory _blob = StoreSwitch.getField(_tableId, _primaryKeys, 1);
    return uint128(Bytes.slice16(_blob, 0));
  }

  /** Set u128 */
  function setU128(bytes32 key, uint128 u128) internal {
    bytes32[] memory _primaryKeys = new bytes32[](1);

    _primaryKeys[0] = bytes32(key);

    StoreSwitch.setField(_tableId, _primaryKeys, 1, abi.encodePacked(u128));
  }

  /** Get a32 */
  function getA32(bytes32 key) internal view returns (uint32[] memory a32) {
    bytes32[] memory _primaryKeys = new bytes32[](1);

    _primaryKeys[0] = bytes32(key);

    bytes memory _blob = StoreSwitch.getField(_tableId, _primaryKeys, 2);
    return SliceLib.getSubslice(_blob, 0, _blob.length).decodeArray_uint32();
  }

  /** Set a32 */
  function setA32(bytes32 key, uint32[] memory a32) internal {
    bytes32[] memory _primaryKeys = new bytes32[](1);

    _primaryKeys[0] = bytes32(key);

    StoreSwitch.setField(_tableId, _primaryKeys, 2, EncodeArray.encode(a32));
  }

  /** Push an element to a32 */
  function pushA32(bytes32 key, uint32 _element) internal {
    bytes32[] memory _primaryKeys = new bytes32[](1);

    _primaryKeys[0] = bytes32(key);

    bytes memory _blob = StoreSwitch.getField(_tableId, _primaryKeys, 2);
    bytes memory _newBlob = abi.encodePacked(_blob, abi.encodePacked(_element));
    StoreSwitch.setField(_tableId, _primaryKeys, 2, _newBlob);
  }

  /** Get s */
  function getS(bytes32 key) internal view returns (string memory s) {
    bytes32[] memory _primaryKeys = new bytes32[](1);

    _primaryKeys[0] = bytes32(key);

    bytes memory _blob = StoreSwitch.getField(_tableId, _primaryKeys, 3);
    return string(_blob);
  }

  /** Set s */
  function setS(bytes32 key, string memory s) internal {
    bytes32[] memory _primaryKeys = new bytes32[](1);

    _primaryKeys[0] = bytes32(key);

    StoreSwitch.setField(_tableId, _primaryKeys, 3, bytes(s));
  }

  /** Push a slice to s */
  function pushS(bytes32 key, string memory _slice) internal {
    bytes32[] memory _primaryKeys = new bytes32[](1);

    _primaryKeys[0] = bytes32(key);

    bytes memory _blob = StoreSwitch.getField(_tableId, _primaryKeys, 3);
    bytes memory _newBlob = abi.encodePacked(_blob, bytes(_slice));
    StoreSwitch.setField(_tableId, _primaryKeys, 3, _newBlob);
  }

  /** Get the full data */
  function get(bytes32 key) internal view returns (MixedData memory _table) {
    bytes32[] memory _primaryKeys = new bytes32[](1);

    _primaryKeys[0] = bytes32(key);

    bytes memory _blob = StoreSwitch.getRecord(_tableId, _primaryKeys, getSchema());
    return decode(_blob);
  }

  /** Set the full data using individual values */
  function set(bytes32 key, uint32 u32, uint128 u128, uint32[] memory a32, string memory s) internal {
    uint16[] memory _counters = new uint16[](2);
    _counters[0] = uint16(a32.length * 4);
    _counters[1] = uint16(bytes(s).length);
    PackedCounter _encodedLengths = PackedCounterLib.pack(_counters);

    bytes memory _data = abi.encodePacked(u32, u128, _encodedLengths.unwrap(), EncodeArray.encode(a32), bytes(s));

    bytes32[] memory _primaryKeys = new bytes32[](1);

    _primaryKeys[0] = bytes32(key);

    StoreSwitch.setRecord(_tableId, _primaryKeys, _data);
  }

  /** Set the full data using the data struct */
  function set(bytes32 key, MixedData memory _table) internal {
    set(key, _table.u32, _table.u128, _table.a32, _table.s);
  }

  /** Decode the tightly packed blob using this table's schema */
  function decode(bytes memory _blob) internal view returns (MixedData memory _table) {
    // 20 is the total byte length of static data
    PackedCounter _encodedLengths = PackedCounter.wrap(Bytes.slice32(_blob, 20));

    _table.u32 = uint32(Bytes.slice4(_blob, 0));

    _table.u128 = uint128(Bytes.slice16(_blob, 4));

    uint256 _start;
    uint256 _end = 52;

    _start = _end;
    _end += _encodedLengths.atIndex(0);
    _table.a32 = SliceLib.getSubslice(_blob, _start, _end).decodeArray_uint32();

    _start = _end;
    _end += _encodedLengths.atIndex(1);
    _table.s = string(SliceLib.getSubslice(_blob, _start, _end).toBytes());
  }

  /* Delete all data for given keys */
  function deleteRecord(bytes32 key) internal {
    bytes32[] memory _primaryKeys = new bytes32[](1);

    _primaryKeys[0] = bytes32(key);

    StoreSwitch.deleteRecord(_tableId, _primaryKeys);
  }
}
