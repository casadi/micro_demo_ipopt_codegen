#include "F.h"
#include <stdio.h>

int main() {
    // Given
    double input = 1.0;

    // To be found
    double surface;
    double center[2];

    // Function needs working space
    const double* arg[F_SZ_ARG];
    double*       res[F_SZ_RES];
    casadi_int      iw[F_SZ_IW];
    double            w[F_SZ_W];

    arg[0] = &input;    // First input is a scalar
    res[0] = &surface;  // First output is a scalar
    res[1] = center;    // Second output is a vector

    // Evaluate F with an Ipopt call
    int mem = F_checkout();
    F(arg, res, iw, w, mem);
    F_release(mem);

    printf("surface area: %e\n", surface);
    printf("center: %e %e\n", center[0], center[1]);
}
