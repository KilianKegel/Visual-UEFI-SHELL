#include <stdio.h>

int main(int argc, char** argv)
{
	return printf("hello world%s\n", sizeof(long long) == sizeof(void*) ? "64" : "32");
}