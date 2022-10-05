#include <stdio.h>
#include "hocdec.h"
#define IMPORT extern __declspec(dllimport)
IMPORT int nrnmpi_myid, nrn_nobanner_;

extern void _CaL_reg();
extern void _CaT_reg();
extern void _HCN_reg();
extern void _Ka_reg();
extern void _Kdr_reg();
extern void _NaF_reg();

void modl_reg(){
	//nrn_mswindll_stdio(stdin, stdout, stderr);
    if (!nrn_nobanner_) if (nrnmpi_myid < 1) {
	fprintf(stderr, "Additional mechanisms from files\n");

fprintf(stderr," CaL.mod");
fprintf(stderr," CaT.mod");
fprintf(stderr," HCN.mod");
fprintf(stderr," Ka.mod");
fprintf(stderr," Kdr.mod");
fprintf(stderr," NaF.mod");
fprintf(stderr, "\n");
    }
_CaL_reg();
_CaT_reg();
_HCN_reg();
_Ka_reg();
_Kdr_reg();
_NaF_reg();
}
