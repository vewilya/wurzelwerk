#pragma once

#include <stdbool.h>
#include <stdlib.h>

#ifndef STACK_H
#define STACK_H

#define STACK_SIZE 16

typedef struct {
    int data[STACK_SIZE];
    size_t pointer;
} Stack;

#ifdef __cplusplus
extern "C" {
#endif

Stack *stack_init(void);
bool stack_push(Stack *stack, int value);
bool stack_is_empty(Stack *stack);
int stack_pop(Stack *stack);
void stack_destroy(Stack **stack);

#ifdef __cplusplus
}
#endif

#endif
