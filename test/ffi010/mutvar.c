#include "mutvar.h"

static void mutVarFinalizer(void * data) {
  // do not free the data, it's not ours, it's a pointer to a structure managed by the heap
}

MutVar idris_newMutVar(VM* vm, VAL data) {
  return (MutVar)c_heap_create_item(data, sizeof(Closure), mutVarFinalizer);
}

VAL idris_readMutVar(VM* vm, MutVar mv) {
  return GETMUTVARDATA(mv);
}

void idris_writeMutVar(VM* vm, MutVar mv, VAL newData) {
  SETMUTVARDATA(mv, newData);
}
