//=============================================================================
// Copyright (c) 2016-2018 Allan CORNET (Nelson)
//=============================================================================
// LICENCE_BLOCK_BEGIN
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 2 of the License, or
// (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program.  If not, see <http://www.gnu.org/licenses/>.
// LICENCE_BLOCK_END
//=============================================================================
#include "h5ReadArray.hpp"
#include "Exception.hpp"
//=============================================================================
namespace Nelson {
//=============================================================================
static ArrayOf
h5ReadArrayFloat(hid_t attr_id, hid_t type, Dimensions dimsOutput, bool asAttribute, std::wstring& error)
{
    ArrayOf res;
    Class outputClass;
    void* ptrVoid = nullptr;
    hid_t nativeFloatType = H5Tget_super(type);
    if (H5Tequal(nativeFloatType, H5T_NATIVE_FLOAT)) {
        outputClass = NLS_SINGLE;
    } else if (H5Tequal(nativeFloatType, H5T_NATIVE_DOUBLE)) {
        outputClass = NLS_DOUBLE;
    } else {
        error = _W("Type not managed.");
        return ArrayOf();
    }
    if (dimsOutput.isEmpty(false)) {
        res = ArrayOf::emptyConstructor(dimsOutput);
        res.promoteType(outputClass);
    } else {
        ptrVoid = ArrayOf::allocateArrayOf(
            outputClass, dimsOutput.getElementCount(), stringVector(), false);
    }
    H5Tclose(nativeFloatType);
    herr_t status = H5I_INVALID_HID;
	if (asAttribute) {
        status = H5Aread(attr_id, type, ptrVoid);
    } else {
        status = H5Dread(attr_id, type, H5S_ALL, H5S_ALL, H5P_DEFAULT, ptrVoid);
    }
    if (status < 0) {
        if (asAttribute) {
            error = _W("Cannot read attribute.");
        } else {
            error = _W("Cannot read data set.");
        }
        res = ArrayOf(outputClass, dimsOutput, ptrVoid);
        res = ArrayOf();
    } else {
        res = ArrayOf(outputClass, dimsOutput, ptrVoid);
    }
    return res;
}
//=============================================================================
static ArrayOf
h5ReadArrayInteger(
    hid_t attr_id, hid_t type, Dimensions dimsOutput, bool asAttribute, std::wstring& error)
{
    ArrayOf res;
    Class outputClass;
    void* ptrVoid = nullptr;
    hid_t nativeIntegerType = H5Tget_super(type);
    if (H5Tequal(nativeIntegerType, H5T_NATIVE_INT64)) {
        outputClass = NLS_INT64;
    } else if (H5Tequal(nativeIntegerType, H5T_NATIVE_INT32)) {
        outputClass = NLS_INT32;
    } else if (H5Tequal(nativeIntegerType, H5T_NATIVE_INT16)) {
        outputClass = NLS_INT16;
    } else if (H5Tequal(nativeIntegerType, H5T_NATIVE_INT8)) {
        outputClass = NLS_INT8;
    } else if (H5Tequal(nativeIntegerType, H5T_NATIVE_UINT64)) {
        outputClass = NLS_UINT64;
    } else if (H5Tequal(nativeIntegerType, H5T_NATIVE_UINT32)) {
        outputClass = NLS_UINT32;
    } else if (H5Tequal(nativeIntegerType, H5T_NATIVE_UINT16)) {
        outputClass = NLS_UINT16;
    } else if (H5Tequal(nativeIntegerType, H5T_NATIVE_UINT8)) {
        outputClass = NLS_UINT8;
    } else {
        outputClass = NLS_INT8;
    }
    if (dimsOutput.isEmpty(false)) {
        res = ArrayOf::emptyConstructor(dimsOutput);
        res.promoteType(outputClass);
    } else {
        ptrVoid = ArrayOf::allocateArrayOf(
            outputClass, dimsOutput.getElementCount(), stringVector(), false);
    }
    H5Tclose(nativeIntegerType);
    herr_t status = H5I_INVALID_HID;

	if (asAttribute) {
        status = H5Aread(attr_id, type, ptrVoid);
	} else {
        status = H5Dread(attr_id, type, H5S_ALL, H5S_ALL, H5P_DEFAULT, ptrVoid);
	}

    if (status < 0) {
        if (asAttribute) {
            error = _W("Cannot read attribute.");
        } else {
            error = _W("Cannot read data set.");
		}
        res = ArrayOf(outputClass, dimsOutput, ptrVoid);
        res = ArrayOf();
    } else {
        res = ArrayOf(outputClass, dimsOutput, ptrVoid);
    }
    return res;
}
//=============================================================================
ArrayOf
h5ReadArray(hid_t attr_id, hid_t type, hid_t aspace, bool asAttribute, std::wstring& error)
{
    ArrayOf res;
    hsize_t storageSize = H5I_INVALID_HID;
    if (asAttribute) {
        storageSize = H5Aget_storage_size(attr_id);
    } else {
        storageSize = H5Dget_storage_size(attr_id);
    }
    hsize_t sizeType = H5Tget_size(type);
    size_t numVal = storageSize / sizeType;

    int ndims = H5Tget_array_ndims(type);
    hsize_t* dimsAsHsize;
    try {
        dimsAsHsize = new_with_exception<hsize_t>(ndims, false);
    } catch (Exception& e) {
        error = e.getMessage();
        H5Sclose(aspace);
        return res;
    }
    H5Tget_array_dims(type, dimsAsHsize);
    Dimensions dimsOutput;
    size_t i = ndims - 1;
    hsize_t j = 0;
    while (i > j) {
        hsize_t temp = dimsAsHsize[i];
        dimsAsHsize[i] = dimsAsHsize[j];
        dimsAsHsize[j] = temp;
        i--;
        j++;
    }
    for (indexType k = 0; k < ndims; k++) {
        dimsOutput[k] = (indexType)dimsAsHsize[k];
    }
    delete[] dimsAsHsize;
    dimsOutput[ndims] = numVal;

    if (H5Tequal(type, H5T_INTEGER)) {
        res = h5ReadArrayInteger(attr_id, type, dimsOutput, asAttribute, error);
    } else if (H5Tequal(type, H5T_FLOAT)) {
        res = h5ReadArrayFloat(attr_id, type, dimsOutput, asAttribute, error);
    } else if (H5Tequal(type, H5T_TIME)) {
        error = _W("Type not managed.");
    } else if (H5Tequal(type, H5T_ARRAY)) {
        error = _W("Type not managed.");
    } else {
        error = _W("Type not managed.");
    }
    return res;
}
//=============================================================================
} // namespace Nelson
//=============================================================================
