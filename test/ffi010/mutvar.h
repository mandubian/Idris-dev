#ifndef FFI010_H
#define FFI010_H

#include <idris_rts.h>

// Handle Mutable variables
// CData idris_newMutVar(VM* vm, VAL data);
// VAL idris_readMutVar(VM* vm, CData ptr);
// void idris_writeMutVar(VM* vm, CData var, VAL data);

MutVar idris_newMutVar(VM* vm, VAL data);
VAL    idris_readMutVar(VM* vm, MutVar mv);
void   idris_writeMutVar(VM* vm, MutVar mv, VAL newData);

#endif /* FFI010_H */
