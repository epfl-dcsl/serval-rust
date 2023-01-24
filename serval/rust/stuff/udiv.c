#include <stdint.h>

uint32_t udiv(uint32_t x, uint32_t y)
{

    if(y==0) return 0;

    uint32_t idx = x / y;

    return idx;
}


uint32_t max(uint32_t x, uint32_t y)
{

    if(x>y) return x;
    return y;
}



uint32_t sum(uint32_t x, uint32_t y)
{
   return x + y;
}  

#define L 3

void sort(uint32_t v[L]){

	uint32_t i,j;


	for (i = 0; i < L-1; i++)
	{
	    uint32_t jMin = i;

	    for (j = i+1; j < L; j++)
	    {

		if (v[j] < v[jMin])
		{
		    jMin = j;
		}
	    }

	    if (jMin != i) 
	    {
	    	uint32_t t;
	    	
	    	t = v[i];
	    	v[i] = v[jMin];
	    	v[jMin] = t;

	    }
	}
  
}

