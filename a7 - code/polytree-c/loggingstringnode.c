  #include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include "node.h"
#include "stringnode.h"
#include "loggingstringnode.h"


struct LoggingStringNode_class LoggingStringNode_class_table = {
  &StringNode_class_table,  /* super */
  StringNode_compareTo,
  StringNode_printNode,
  Node_print_insert, // override it
  Node_print,
  Node_delete,
};

// print “insert x” each time insert is called
void Node_print_insert(void* thisv, void* nodev) {
  struct LoggingStringNode* this = thisv;
  struct LoggingStringNode* node = nodev;
  printf("insert %s\n", node->s);
  Node_insert(this, node);
}

void* new_LoggingStringNode(char* s) {
  struct LoggingStringNode* obj = malloc(sizeof(struct LoggingStringNode));
  obj->class = &LoggingStringNode_class_table;
  StringNode_ctor(obj, s); // call super?
  return obj;
}
