//========================================================================
// plab5-mcore-ProcNetCacheMem Unit Tests
//========================================================================

`define PLAB5_MCORE_IMPL			plab5_mcore_ProcNetCacheMemStatic
`define PLAB5_MCORE_IMPL_STR		"plab5-mcore-ProcNetCacheMemStatic-%INST%"
`define PLAB5_MCORE_TEST_CASES_FILE	"plab5-mcore-test-cases-%INST%.v"
`define PLAB5_MCORE_NUM_CORES		2

`include "plab5-mcore-ProcNetCacheMemStatic.v"
`include "plab5-mcore-test-harness.v"
