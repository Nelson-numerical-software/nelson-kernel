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
// Generated by Nelson Interface Generator 1.0.0
//=============================================================================
#include "slicot_mc01tdBuiltin.hpp"
#include "Error.hpp"
//=============================================================================
using namespace Nelson;
//=============================================================================
#ifdef __cplusplus
extern "C"
{
#endif
    extern int
    mc01td_(const char* DICO, int* DP, const double* P, int* STABLE, int* NZ, double* DWORK,
        int* IWARN, int* INFO);
#ifdef __cplusplus
}
#endif
//=============================================================================
// [DP_OUT, STABLE, NZ, IWARN, INFO] = slicot_mc01td(DICO, DP_IN, P)
//=============================================================================
ArrayOfVector
Nelson::SlicotGateway::slicot_mc01tdBuiltin(Evaluator* eval, int nLhs, const ArrayOfVector& argIn)
{
    ArrayOfVector retval;
    if (nLhs > 5) {
        Error(eval, ERROR_WRONG_NUMBERS_OUTPUT_ARGS);
    }
    if (argIn.size() != 3) {
        Error(eval, ERROR_WRONG_NUMBERS_INPUT_ARGS);
    }
    // INPUT VARIABLES
    ArrayOf DICO = argIn[0];
    Dimensions dimsDICO = DICO.getDimensions();
    std::string DICO_string = DICO.getContentAsCString();
    const char* DICO_ptr = DICO_string.c_str();
    ArrayOf P = argIn[2];
    Dimensions dimsP = P.getDimensions();
    P.promoteType(NLS_DOUBLE);
    double* P_ptr = (double*)P.getDataPointer();
    // IN/OUT VARIABLES
    ArrayOf DP = argIn[1];
    Dimensions dimsDP = DP.getDimensions();
    DP.promoteType(NLS_INT32);
    ArrayOf DP_output = DP;
    DP_output.ensureSingleOwner();
    int* DP_output_ptr = (int*)DP_output.getDataPointer();
    // LOCAL VARIABLES
    ArrayOf DWORK
        = ArrayOf::doubleMatrix2dConstructor(1, 2 * (int)P.getDimensions().getElementCount() + 2);
    double* DWORK_ptr = (double*)DWORK.getDataPointer();
    // OUTPUT VARIABLES
    ArrayOf STABLE_output = ArrayOf::int32VectorConstructor(1);
    int* STABLE_output_ptr = (int*)STABLE_output.getDataPointer();
    ArrayOf NZ_output = ArrayOf::int32VectorConstructor(1);
    int* NZ_output_ptr = (int*)NZ_output.getDataPointer();
    ArrayOf IWARN_output = ArrayOf::int32VectorConstructor(1);
    int* IWARN_output_ptr = (int*)IWARN_output.getDataPointer();
    ArrayOf INFO_output = ArrayOf::int32VectorConstructor(1);
    int* INFO_output_ptr = (int*)INFO_output.getDataPointer();
    // CHECK INPUT VARIABLES DIMENSIONS
    if (!dimsDICO.isScalar()) {
        Error(eval, _W("Input argument #1: scalar expected."));
    }
    if (!dimsDP.isScalar()) {
        Error(eval, _W("Input argument #2: scalar expected."));
    }
    // CALL EXTERN FUNCTION
    try {
        mc01td_(DICO_ptr, DP_output_ptr, P_ptr, STABLE_output_ptr, NZ_output_ptr, DWORK_ptr,
            IWARN_output_ptr, INFO_output_ptr);
    } catch (std::runtime_error& e) {
        e.what();
        Error(eval, "mc01td function fails.");
    }
    // ASSIGN OUTPUT VARIABLES
    if (nLhs > 0) {
        retval.push_back(DP_output);
    }
    if (nLhs > 1) {
        retval.push_back(STABLE_output);
    }
    if (nLhs > 2) {
        retval.push_back(NZ_output);
    }
    if (nLhs > 3) {
        retval.push_back(IWARN_output);
    }
    if (nLhs > 4) {
        retval.push_back(INFO_output);
    }
    return retval;
}
//=============================================================================
