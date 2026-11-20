#include "stack/stack.h"
#include <assert.h>

Stack *stack_init(void) {
    Stack *stack = malloc(sizeof(Stack));
    stack->pointer = 0;
    return stack;
}

bool stack_push(Stack *stack, int value) {
    if (stack->pointer >= STACK_SIZE) {
        return false;
    }

    stack->data[stack->pointer++] = value;
    return true;
}

bool stack_is_empty(Stack *stack) { return stack->pointer == 0; }

int stack_pop(Stack *stack) {
    assert(!stack_is_empty(stack));

    return stack->data[--stack->pointer];
}

void stack_destroy(Stack **stack) {
    free(*stack);
    *stack = NULL;
}
