#include <stdlib.h>
#include <stdio.h>
#include "node.h"
#include "integernode.h"

struct IntegerNode_class IntegerNode_class_table = {
  &Node_class_table,  /* super */
  IntegerNode_compareTo,
  IntegerNode_printNode,
  Node_insert,
  Node_print,
  IntegerNode_sum,
  Node_delete,
};

void IntegerNode_ctor(void* thisv, char* s) {
  struct IntegerNode* this = thisv;
  Node_ctor(this);
  this->i = s;
}

// made my own since I wasn't sure if we're allowed to include <string.h>
int IntegerNode_compareTo(void* thisv, void* nodev) {
  struct IntegerNode* this = thisv;
  struct IntegerNode* node = nodev;
  if (*(this->i) < *(node->i)) {
    return -1;
  }
  else if (*(this->i) > *(node->i)) {
    return 1;
  }
  else {
    return 0;
  }
}

void IntegerNode_printNode(void* thisv) {
  struct IntegerNode* this = thisv;
  printf("%s\n", this->i);
}

int IntegerNode_sum(void* thisv) {
  struct IntegerNode* this = thisv;
  int sum = atoi(this->i);
  if (this->left != NULL) {
    sum += IntegerNode_sum(this->left);
  }
  if (this->right != NULL) {
    sum += IntegerNode_sum(this->right);
  }
  return sum;
}

void* new_IntegerNode(char* s) {
  struct IntegerNode* obj = malloc(sizeof(struct IntegerNode));
  obj->class = &IntegerNode_class_table;
  IntegerNode_ctor(obj, s);
  return obj;
}
