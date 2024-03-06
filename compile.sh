export  P=`python -c "import casadi as ca;print(ca.GlobalOptions.getCasadiPath())"`
export IP=`python -c "import casadi as ca;print(ca.GlobalOptions.getCasadiIncludePath())"`
gcc main.c F.c -I${IP} -lipopt -L${P} -Wl,-rpath ${P} -lm -o main
./main
