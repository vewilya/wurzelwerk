#include <assert.h>
#include <stdio.h>
#include <stdbool.h>
#include <stdlib.h>

#include "stack/stack.h"


int main(void) {
    Stack *stack = stack_init();

    if (!stack_is_empty(stack)) {
        stack_pop(stack);
    }
    stack_push(stack, 2);
    stack_push(stack, 3);
    stack_push(stack, 32);
    printf("%d\n", stack_pop(stack));
    printf("%d\n", stack_pop(stack));
    printf("%d\n", stack_pop(stack));

    stack_destroy(&stack);
    return 0;
}
