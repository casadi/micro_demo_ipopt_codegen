% addpath('.../casadi-3.6.5-linux64-matlab2018b')
import casadi.*

opti   = Opti();

center = opti.variable(2);
radius = opti.variable();

a      = opti.parameter();

opti.minimize(-radius);

% Sample edge vertices
ts = linspace(0, 2*pi, 1000);
v_x = radius*cos(ts)+center(1);
v_y = radius*sin(ts)+center(2);

opti.subject_to(v_x>=0);
opti.subject_to(v_y>=a*sqrt(v_x));
opti.subject_to(v_x.^2+v_y.^2<=1);

opti.set_initial(center, [0.5, 0.5]);
opti.set_value(a, 1);

opti.solver('ipopt');

% Normal use
sol = opti.solve();
sol.value(radius)

% Codegen via a CasADi Function
F = opti.to_function('F',...
        {a},...
        {pi*radius^2, center});
F.generate('F.c',struct('with_header',true));

