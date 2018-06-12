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
#include "slicot_ab04mdBuiltin.hpp"
#include "Error.hpp"
//=============================================================================
using namespace Nelson;
//=============================================================================
#ifdef __cplusplus
extern "C"
{
#endif
    extern int
    ab04md_(const char* TYPE, int* N, int* M, int* P, double* ALPHA, double* BETA, double* A,
        int* LDA, double* B, int* LDB, double* C, int* LDC, double* D, int* LDD, int* IWORK,
        double* DWORK, int* LDWORK, int* INFO);
#ifdef __cplusplus
}
#endif
//=============================================================================
// [A_OUT, B_OUT, C_OUT, D_OUT, INFO] = slicot_ab04md(TYPE, ALPHA, BETA, A_IN, B_IN, C_IN, D_IN)
//=============================================================================
ArrayOfVector
Nelson::SlicotGateway::slicot_ab04mdBuiltin(Evaluator* eval, int nLhs, const ArrayOfVector& argIn)
{
    ArrayOfVector retval;
    if (nLhs > 5) {
        Error(eval, ERROR_WRONG_NUMBERS_OUTPUT_ARGS);
    }
    if (argIn.size() != 7) {
        Error(eval, ERROR_WRONG_NUMBERS_INPUT_ARGS);
    }
    // INPUT VARIABLES
    ArrayOf TYPE = argIn[0];
    Dimensions dimsTYPE = TYPE.getDimensions();
    std::string TYPE_string = TYPE.getContentAsCString();
    const char* TYPE_ptr = TYPE_string.c_str();
    ArrayOf ALPHA = argIn[1];
    Dimensions dimsALPHA = ALPHA.getDimensions();
    ALPHA.promoteType(NLS_DOUBLE);
    double* ALPHA_ptr = (double*)ALPHA.getDataPointer();
    ArrayOf BETA = argIn[2];
    Dimensions dimsBETA = BETA.getDimensions();
    BETA.promoteType(NLS_DOUBLE);
    double* BETA_ptr = (double*)BETA.getDataPointer();
    // IN/OUT VARIABLES
    ArrayOf A = argIn[3];
    Dimensions dimsA = A.getDimensions();
    A.promoteType(NLS_DOUBLE);
    ArrayOf A_output = A;
    A_output.ensureSingleOwner();
    double* A_output_ptr = (double*)A_output.getDataPointer();
    ArrayOf B = argIn[4];
    Dimensions dimsB = B.getDimensions();
    B.promoteType(NLS_DOUBLE);
    ArrayOf B_output = B;
    B_output.ensureSingleOwner();
    double* B_output_ptr = (double*)B_output.getDataPointer();
    ArrayOf C = argIn[5];
    Dimensions dimsC = C.getDimensions();
    C.promoteType(NLS_DOUBLE);
    ArrayOf C_output = C;
    C_output.ensureSingleOwner();
    double* C_output_ptr = (double*)C_output.getDataPointer();
    ArrayOf D = argIn[6];
    Dimensions dimsD = D.getDimensions();
    D.promoteType(NLS_DOUBLE);
    ArrayOf D_output = D;
    D_output.ensureSingleOwner();
    double* D_output_ptr = (double*)D_output.getDataPointer();
    // LOCAL VARIABLES
    ArrayOf N = ArrayOf::int32VectorConstructor(1);
    int* N_ptr = (int*)N.getDataPointer();
    N_ptr[0] = (int)A.getDimensions().getRows();
    ArrayOf M = ArrayOf::int32VectorConstructor(1);
    int* M_ptr = (int*)M.getDataPointer();
    M_ptr[0] = (int)B.getDimensions().getColumns();
    ArrayOf P = ArrayOf::int32VectorConstructor(1);
    int* P_ptr = (int*)P.getDataPointer();
    P_ptr[0] = (int)C.getDimensions().getRows();
    ArrayOf LDA = ArrayOf::int32VectorConstructor(1);
    int* LDA_ptr = (int*)LDA.getDataPointer();
    LDA_ptr[0] = std::max(1, (int)A.getDimensions().getRows());
    ArrayOf LDB = ArrayOf::int32VectorConstructor(1);
    int* LDB_ptr = (int*)LDB.getDataPointer();
    LDB_ptr[0] = std::max(1, (int)A.getDimensions().getRows());
    ArrayOf LDC = ArrayOf::int32VectorConstructor(1);
    int* LDC_ptr = (int*)LDC.getDataPointer();
    LDC_ptr[0] = std::max(1, (int)C.getDimensions().getRows());
    ArrayOf LDD = ArrayOf::int32VectorConstructor(1);
    int* LDD_ptr = (int*)LDD.getDataPointer();
    LDD_ptr[0] = std::max(1, (int)C.getDimensions().getRows());
    ArrayOf IWORK = ArrayOf::int32Matrix2dConstructor(1, (int)A.getDimensions().getRows());
    int* IWORK_ptr = (int*)IWORK.getDataPointer();
    ArrayOf DWORK
        = ArrayOf::doubleMatrix2dConstructor(1, std::max(1, (int)A.getDimensions().getRows()));
    double* DWORK_ptr = (double*)DWORK.getDataPointer();
    ArrayOf LDWORK = ArrayOf::int32VectorConstructor(1);
    int* LDWORK_ptr = (int*)LDWORK.getDataPointer();
    LDWORK_ptr[0] = std::max(1, (int)A.getDimensions().getRows());
    // OUTPUT VARIABLES
    ArrayOf INFO_output = ArrayOf::int32VectorConstructor(1);
    int* INFO_output_ptr = (int*)INFO_output.getDataPointer();
    // CHECK INPUT VARIABLES DIMENSIONS
    if (!dimsTYPE.isScalar()) {
        Error(eval, _W("Input argument #1: scalar expected."));
    }
    if (!dimsALPHA.isScalar()) {
        Error(eval, _W("Input argument #2: scalar expected."));
    }
    if (!dimsBETA.isScalar()) {
        Error(eval, _W("Input argument #3: scalar expected."));
    }
    Dimensions dimsA_expected(
        std::max(1, (int)A.getDimensions().getRows()), (int)A.getDimensions().getRows());
    if (!dimsA.equals(dimsA_expected)) {
        Error(eval,
            _("Input argument #4: wrong size.") + " " + dimsA_expected.toString() + " " + "expected"
                + ".");
    }
    Dimensions dimsB_expected(
        std::max(1, (int)A.getDimensions().getRows()), (int)B.getDimensions().getColumns());
    if (!dimsB.equals(dimsB_expected)) {
        Error(eval,
            _("Input argument #5: wrong size.") + " " + dimsB_expected.toString() + " " + "expected"
                + ".");
    }
    Dimensions dimsC_expected(
        std::max(1, (int)C.getDimensions().getRows()), (int)A.getDimensions().getRows());
    if (!dimsC.equals(dimsC_expected)) {
        Error(eval,
            _("Input argument #6: wrong size.") + " " + dimsC_expected.toString() + " " + "expected"
                + ".");
    }
    Dimensions dimsD_expected(
        std::max(1, (int)C.getDimensions().getRows()), (int)B.getDimensions().getColumns());
    if (!dimsD.equals(dimsD_expected)) {
        Error(eval,
            _("Input argument #7: wrong size.") + " " + dimsD_expected.toString() + " " + "expected"
                + ".");
    }
    // CALL EXTERN FUNCTION
    try {
        ab04md_(TYPE_ptr, N_ptr, M_ptr, P_ptr, ALPHA_ptr, BETA_ptr, A_output_ptr, LDA_ptr,
            B_output_ptr, LDB_ptr, C_output_ptr, LDC_ptr, D_output_ptr, LDD_ptr, IWORK_ptr,
            DWORK_ptr, LDWORK_ptr, INFO_output_ptr);
    } catch (std::runtime_error& e) {
        e.what();
        Error(eval, "ab04md function fails.");
    }
    // ASSIGN OUTPUT VARIABLES
    if (nLhs > 0) {
        retval.push_back(A_output);
    }
    if (nLhs > 1) {
        retval.push_back(B_output);
    }
    if (nLhs > 2) {
        retval.push_back(C_output);
    }
    if (nLhs > 3) {
        retval.push_back(D_output);
    }
    if (nLhs > 4) {
        retval.push_back(INFO_output);
    }
    return retval;
}
//=============================================================================
