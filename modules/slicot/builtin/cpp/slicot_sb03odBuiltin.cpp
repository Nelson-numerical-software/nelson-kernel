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
#include "slicot_sb03odBuiltin.hpp"
#include "Error.hpp"
//=============================================================================
using namespace Nelson;
//=============================================================================
#ifdef __cplusplus
extern "C"
{
#endif
    extern int
    sb03od_(const char* DICO, const char* FACT, const char* TRANS, int* N, int* M, const double* A,
        int* LDA, double* Q, int* LDQ, double* B, int* LDB, double* SCALE, double* WR, double* WI,
        double* DWORK, int* LDWORK, int* INFO);
#ifdef __cplusplus
}
#endif
//=============================================================================
// [Q_OUT, B_OUT, SCALE, WR, WI, INFO] = slicot_sb03od(DICO, FACT, TRANS, A, Q_IN, B_IN)
//=============================================================================
ArrayOfVector
Nelson::SlicotGateway::slicot_sb03odBuiltin(Evaluator* eval, int nLhs, const ArrayOfVector& argIn)
{
    ArrayOfVector retval;
    if (nLhs > 6) {
        Error(eval, ERROR_WRONG_NUMBERS_OUTPUT_ARGS);
    }
    if (argIn.size() != 6) {
        Error(eval, ERROR_WRONG_NUMBERS_INPUT_ARGS);
    }
    // INPUT VARIABLES
    ArrayOf DICO = argIn[0];
    Dimensions dimsDICO = DICO.getDimensions();
    std::string DICO_string = DICO.getContentAsCString();
    const char* DICO_ptr = DICO_string.c_str();
    ArrayOf FACT = argIn[1];
    Dimensions dimsFACT = FACT.getDimensions();
    std::string FACT_string = FACT.getContentAsCString();
    const char* FACT_ptr = FACT_string.c_str();
    ArrayOf TRANS = argIn[2];
    Dimensions dimsTRANS = TRANS.getDimensions();
    std::string TRANS_string = TRANS.getContentAsCString();
    const char* TRANS_ptr = TRANS_string.c_str();
    ArrayOf A = argIn[3];
    Dimensions dimsA = A.getDimensions();
    A.promoteType(NLS_DOUBLE);
    double* A_ptr = (double*)A.getDataPointer();
    // IN/OUT VARIABLES
    ArrayOf Q = argIn[4];
    Dimensions dimsQ = Q.getDimensions();
    Q.promoteType(NLS_DOUBLE);
    ArrayOf Q_output = Q;
    Q_output.ensureSingleOwner();
    double* Q_output_ptr = (double*)Q_output.getDataPointer();
    ArrayOf B = argIn[5];
    Dimensions dimsB = B.getDimensions();
    B.promoteType(NLS_DOUBLE);
    ArrayOf B_output = B;
    B_output.ensureSingleOwner();
    double* B_output_ptr = (double*)B_output.getDataPointer();
    // LOCAL VARIABLES
    ArrayOf N = ArrayOf::int32VectorConstructor(1);
    int* N_ptr = (int*)N.getDataPointer();
    N_ptr[0] = (int)A.getDimensions().getRows();
    ArrayOf M = ArrayOf::int32VectorConstructor(1);
    int* M_ptr = (int*)M.getDataPointer();
    M_ptr[0] = (int)B.getDimensions().getRows();
    ArrayOf LDA = ArrayOf::int32VectorConstructor(1);
    int* LDA_ptr = (int*)LDA.getDataPointer();
    LDA_ptr[0] = std::max(1, (int)A.getDimensions().getRows());
    ArrayOf LDQ = ArrayOf::int32VectorConstructor(1);
    int* LDQ_ptr = (int*)LDQ.getDataPointer();
    LDQ_ptr[0] = std::max(1, (int)A.getDimensions().getRows());
    ArrayOf LDB = ArrayOf::int32VectorConstructor(1);
    int* LDB_ptr = (int*)LDB.getDataPointer();
    LDB_ptr[0] = TRANS.getContentAsCString().compare("N") == 0
        ? std::max(1, std::max((int)A.getDimensions().getRows(), (int)B.getDimensions().getRows()))
        : std::max(1, (int)A.getDimensions().getRows());
    ArrayOf DWORK = ArrayOf::doubleMatrix2dConstructor(1,
        std::max(1,
            4 * (int)A.getDimensions().getRows()
                + std::min((int)B.getDimensions().getRows(), (int)A.getDimensions().getRows())));
    double* DWORK_ptr = (double*)DWORK.getDataPointer();
    ArrayOf LDWORK = ArrayOf::int32VectorConstructor(1);
    int* LDWORK_ptr = (int*)LDWORK.getDataPointer();
    LDWORK_ptr[0] = std::max(1,
        4 * (int)A.getDimensions().getRows()
            + std::min((int)B.getDimensions().getRows(), (int)A.getDimensions().getRows()));
    // OUTPUT VARIABLES
    ArrayOf SCALE_output = ArrayOf::doubleVectorConstructor(1);
    double* SCALE_output_ptr = (double*)SCALE_output.getDataPointer();
    ArrayOf WR_output = ArrayOf::doubleMatrix2dConstructor(
        (indexType)1, (indexType)(int)A.getDimensions().getRows());
    double* WR_output_ptr = (double*)WR_output.getDataPointer();
    ArrayOf WI_output = ArrayOf::doubleMatrix2dConstructor(
        (indexType)1, (indexType)(int)A.getDimensions().getRows());
    double* WI_output_ptr = (double*)WI_output.getDataPointer();
    ArrayOf INFO_output = ArrayOf::int32VectorConstructor(1);
    int* INFO_output_ptr = (int*)INFO_output.getDataPointer();
    // CHECK INPUT VARIABLES DIMENSIONS
    if (!dimsDICO.isScalar()) {
        Error(eval, _W("Input argument #1: scalar expected."));
    }
    if (!dimsFACT.isScalar()) {
        Error(eval, _W("Input argument #2: scalar expected."));
    }
    if (!dimsTRANS.isScalar()) {
        Error(eval, _W("Input argument #3: scalar expected."));
    }
    Dimensions dimsQ_expected(
        std::max(1, (int)A.getDimensions().getRows()), (int)A.getDimensions().getRows());
    if (!dimsQ.equals(dimsQ_expected)) {
        Error(eval,
            _("Input argument #5: wrong size.") + " " + dimsQ_expected.toString() + " " + "expected"
                + ".");
    }
    Dimensions dimsB_expected(TRANS.getContentAsCString().compare("N") == 0
            ? std::max(
                  1, std::max((int)A.getDimensions().getRows(), (int)B.getDimensions().getRows()))
            : std::max(1, (int)A.getDimensions().getRows()),
        (int)A.getDimensions().getRows());
    if (!dimsB.equals(dimsB_expected)) {
        Error(eval,
            _("Input argument #6: wrong size.") + " " + dimsB_expected.toString() + " " + "expected"
                + ".");
    }
    // CALL EXTERN FUNCTION
    try {
        sb03od_(DICO_ptr, FACT_ptr, TRANS_ptr, N_ptr, M_ptr, A_ptr, LDA_ptr, Q_output_ptr, LDQ_ptr,
            B_output_ptr, LDB_ptr, SCALE_output_ptr, WR_output_ptr, WI_output_ptr, DWORK_ptr,
            LDWORK_ptr, INFO_output_ptr);
    } catch (std::runtime_error& e) {
        e.what();
        Error(eval, "sb03od function fails.");
    }
    // ASSIGN OUTPUT VARIABLES
    if (nLhs > 0) {
        retval.push_back(Q_output);
    }
    if (nLhs > 1) {
        retval.push_back(B_output);
    }
    if (nLhs > 2) {
        retval.push_back(SCALE_output);
    }
    if (nLhs > 3) {
        retval.push_back(WR_output);
    }
    if (nLhs > 4) {
        retval.push_back(WI_output);
    }
    if (nLhs > 5) {
        retval.push_back(INFO_output);
    }
    return retval;
}
//=============================================================================
