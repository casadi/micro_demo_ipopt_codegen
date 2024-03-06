#!/bin/bash



pip install casadi
# Available on Win/Linux/Mac
# Includes Ipopt




# Generate C code
# Can also be done from Matlab
python generate.py



# Compile C code
export  P=`python -c "import casadi as ca;print(ca.GlobalOptions.getCasadiPath())"`
export IP=`python -c "import casadi as ca;print(ca.GlobalOptions.getCasadiIncludePath())"`
gcc main.c F.c -I${IP} -lipopt -L${P} -Wl,-rpath ${P} -lm -o main




# Run
./main
