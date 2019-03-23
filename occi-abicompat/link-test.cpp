#include <occi.h>

int main(int, char **)
{
    oracle::occi::Date d;
    std::string s = d.toText();
    return EXIT_SUCCESS;
}
