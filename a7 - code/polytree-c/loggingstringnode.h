#ifndef __LOGGINGSTRINGNODE_H__
#define __LOGGINGSTRINGNODE_H__

struct LoggingStringnode_class {
  struct StringNode_class* super;
  int  (*compareTo) (void*, void*);
  void (*printNode) (void*);
  void (*insert)    (void*, void*);
  void (*print)     (void*);
};
extern struct LoggingStringnode_class LoggingStringnode_class_table;

/**
 * struct definition of object
 */
struct LoggingStringnode;
struct LoggingStringnode {
  struct LoggingStringnode_class* class;

  // instance variables defined in super class(es)
  struct LoggingStringnode* left;
  struct LoggingStringnode* right;

  // instance variables defined in this class
  char* s;
};

// override so it prints what's being inserted
void Node_print_insert(void*, void*);

/**
 * definition of new for class
 */
void* new_LoggingStringnode(char*);

#endif /*__LOGGINGSTRINGNODE_H__*/
