#include <stdint.h>

uint32_t udiv(uint32_t x, uint32_t y)
{

    if(y==0) return 0;

    uint32_t idx = x / y;

    return idx;
}


