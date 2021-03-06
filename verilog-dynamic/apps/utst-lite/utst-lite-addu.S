//=========================================================================
// utst-lite-addu.S
//=========================================================================


#include "utst-lite-macros.h"

TEST_PARC_BEGIN

mfc0 $1, $0
mfc0 $2, $0
addu $3, $2, $1
mtc0 $3, $0
mfc0 $1, $0
mfc0 $2, $0
addu $3, $2, $1
mtc0 $3, $0
mfc0 $1, $0
mfc0 $2, $0
addu $3, $2, $1
mtc0 $3, $0

// streaming

mfc0 $1, $0
mfc0 $2, $0
mfc0 $3, $0
mfc0 $4, $0
mfc0 $5, $0
mfc0 $6, $0
mfc0 $7, $0
mfc0 $8, $0

addu $9,  $1, $2
addu $10, $3, $4
addu $11, $5, $6
addu $12, $7, $8

mtc0 $9,  $0
mtc0 $10, $0
mtc0 $11, $0
mtc0 $12, $0

mfc0 $1, $0
mfc0 $2, $0
mfc0 $3, $0
mfc0 $4, $0
mfc0 $5, $0
mfc0 $6, $0
mfc0 $7, $0
mfc0 $8, $0

addu $9,  $1, $2
addu $10, $3, $4
addu $11, $5, $6
addu $12, $7, $8

mtc0 $9,  $0
mtc0 $10, $0
mtc0 $11, $0
mtc0 $12, $0

TEST_PARC_END

