#ifndef __INTEGERNODE_H__
#define __INTEGERNODE_H__

/**
 * struct definition of class and external definition of class table
 */
struct IntegerNode_class {
  struct Node_class* super;
  int  (*compareTo) (void*, void*);
  void (*printNode) (void*);
  void (*insert)    (void*, void*);
  void (*print)     (void*);
  int  (*sum)       (void*);
  void (*delete)    (void*);
};
extern struct IntegerNode_class SIntegerNode_class_table;

/**
 * struct definition of object
 */
struct IntegerNode;
struct IntegerNode {
  struct IntegerNode_class* class;

  // instance variables defined in super class(es)
  struct IntegerNode* left;
  struct IntegerNode* right;

  // instance variables defined in this class
  char* i;
};

/**
 * definition of methods implemented by this class
 */
void IntegerNode_ctor(void*, char*);
int IntegerNode_compareTo(void*, void*);
void IntegerNode_printNode(void*);
int IntegerNode_sum(void*);

/**
 * definition of new for class
 */
void* new_IntegerNode(char*);


#endif /*__INTEGERNODE_H__*/
