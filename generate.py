import casadi as ca
import numpy as np

opti = ca.Opti()

center = opti.variable(2)
radius = opti.variable()

a      = opti.parameter()

opti.minimize(-radius)

# Sample edge vertices
ts = np.linspace(0,2*np.pi,1000)
v_x = radius*np.cos(ts)+center[0]
v_y = radius*np.sin(ts)+center[1]

opti.subject_to(v_x>=0)
opti.subject_to(v_y>=a*np.sqrt(v_x))
opti.subject_to(v_x**2+v_y**2<=1)

opti.set_initial(center,[0.5,0.5])

opti.solver('ipopt')
F = opti.to_function('F',[a],[np.pi*radius**2,center])

print(F(1)) # 0.143661

F.generate('F.c',{"with_header":True})



