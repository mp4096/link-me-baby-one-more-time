#include <stdio.h>
#include "variant_a.h"
#include "variant_b.h"

int main(void) {
    const int a = 0;
    printf("Variant A: %i\n", add_five(a));
    printf("Variant B: %i\n", add_nine(a));
    return 0;
}
