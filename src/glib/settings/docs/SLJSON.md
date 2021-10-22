# SLJSON Schema
This is a basic overview of the SettingsLib JSON Schema

## Introduction
SLJSON is meant to provide essential data about SettingsLib aswell as the actual data provided by the end-user.

This spec is a bit minimal, and might change significantly in future major versions of SettingsLib.

## Internal Keys
SLJSON is JSON with the following mandatory keys:
- `__sl.issljson`:`true` (Ensures that it is actually sljson)
- `__sl.slversion`:int32 (Last Version the file was Read/Written to at. Currently Unused, might be used in future. Usable by 3rd party tools to ensure version compatability)
and the `.sl` file extension.

Accoridng to the current implementation of SettingsLib, it can also have the following keys:
- `__sl.potentialCorruptionDetected`:Boolean (If checks have failed for potential data corruption, such as issljson not being a key. Should warn if set to true.)

## Key Usage
As the End-Application, you should not write to any keys starting with `__sl` unless you are extending SettingsLib.<br/>
SettingsLib will expect these keys to stay in-tact, and could error if these are not as such.

Any non-default SLJSON Library **should** write to `__sl.lastApplication` with an ID unique to that application, uniform to all major versions of that application.<br/>
This is there to allow applications to prevent conflicts when reading SettingsLib JSON Schema Files (for things such as SLJSON Editors)

## Custom Internal Keys
If you need to store data in a SLJSON File, you should store it in the key `__sl.%APP%.%KEY%` where `%APP%` is the application ID, unique to your specific application, and `%KEY%` is whatever the JSON key is.

## Final Notes
This format doesn't need to be strictly followed, but is just a standard to ensure compatability with future versions of SettingsLib.
