#include <benchmark/benchmark.h>
#include <cstdlib>

#include "stack/stack.h"

// One push + pop on a stack that already exists
static void BM_PushPop(benchmark::State &state) {
    Stack *s = stack_init();
    for (auto _ : state) {
        stack_push(s, 42);
        benchmark::DoNotOptimize(stack_pop(s));
    }
    free(s);
}
BENCHMARK(BM_PushPop);

// Fill to a given depth, then empty it again; the depth comes from Arg/Range
static void BM_FillDrain(benchmark::State &state) {
    const int n = static_cast<int>(state.range(0));
    Stack *s = stack_init();

    for (auto _ : state) {
        for (int i = 0; i < n; ++i) {
            benchmark::DoNotOptimize(stack_push(s, i));
        }
        while (!stack_is_empty(s)) {
            benchmark::DoNotOptimize(stack_pop(s));
        }
    }
    state.SetItemsProcessed(state.iterations() * n);
    free(s);
}
BENCHMARK(BM_FillDrain)->Arg(1)->Arg(8)->Arg(STACK_SIZE);

// stack_init itself (includes malloc)
static void BM_Init(benchmark::State &state) {
    for (auto _ : state) {
        Stack *s = stack_init();
        benchmark::DoNotOptimize(s);
        free(s);
    }
}
BENCHMARK(BM_Init);
