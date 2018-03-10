#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include "node.h"
#include "stringnode.h"
#include "loggingstringnode.h"


struct LoggingStringnode_class LoggingStringnode_class_table = {
  &StringNode_class_table,  /* super */
  StringNode_compareTo,
  StringNode_printNode,
  Node_print_insert, // override it
  Node_print,
};

// void LoggingStringnode_ctor(void* thisv, char* s) {
//   struct LoggingStringnode* this = thisv;
//   Node_ctor(this);
//   this->s = s;
// }

/**
print “insert x” each time insert is called
(where “x” is value of the node begin inserted without the quotes). Note that this means
that a node may print multiple times in the process of being inserted since insert is
recursive
*/
// could we still call the Node_insert and add a feature of printf?
void Node_print_insert(void* thisv, void* nodev) {
  struct Node* this = thisv;
  struct Node* node = nodev;
  int c = this->class->compareTo(this, node); // where's compareTo coming from
  if (c > 0) {
    if (this->left == NULL)
      // printf("%p\n", node); //is it p for node?
      // "insert " + value in str then print
      // printf(a "\p", b); ? where a is char* "insert "
      this->left = node;
    else
      this->class->insert(this->left, node); // abstract insert from Node?
  } else {
    if (this->right == NULL)
      this->right = node;
    else
      this->class->insert(this->right, node);
  }
}

void* new_LoggingStringnode(char* s) {
  struct LoggingStringnode* obj = malloc(sizeof(struct LoggingStringnode));
  obj->class = &LoggingStringnode_class_table;
  StringNode_ctor(obj, s); // call super?
  return obj;
}
