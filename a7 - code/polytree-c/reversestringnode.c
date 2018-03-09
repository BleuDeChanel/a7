#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include "node.h"
#include "stringnode.h"
#include "reversestringnode.h"

// TODO

struct ReverseStringNode_class ReverseStringNode_class_table = {
  &StringNode_class_table,  /* super */
  //overriding only the compareTo method to sort strings in reverse.
  ReverseStringNode_compareTo,
  StringNode_printNode,
  Node_insert,
  Node_print,
};

int ReverseStringNode_compareTo(void* thisv, void* nodev) {
  struct ReverseStringNode* this = thisv;
  struct ReverseStringNode* node = nodev;
  return;
  return strcmp (this->s, node->s); // need to reverse the string
}
