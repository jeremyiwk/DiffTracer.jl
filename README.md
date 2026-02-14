# DiffTracer

This is an experimental package for differentiable "ray-tracing". Much of the physics contained in this package can be found in `Rose, Harald. (2012). Geometrical Charged-Particle Optics. 10.1007/978-3-642-32119-1.` Currently, only electrostatic fields are implemented.

Typically, charged particles are propagated through electromagnetic fields via the Lorentz force law:

$$
m \frac{d^2 \mathbf{r}}{ dt^2} = q (\mathbf{E} + \frac{d\mathbf{r}}{dt} \mathbf{B})
$$

where $\mathbf{r} = (x, y, z)$. Setting $\mathbf{B} = \mathbf{0}$ and assuming we can parameterize by $z$ we have

$$
\frac{d\mathbf{r_i}}{dt} = \frac{d\mathbf{r_i}}{ dz} \frac{d z}{dt} \\
\implies \frac{d^2\mathbf{r_i}}{dt^2} = \frac{d\mathbf{r_i}}{ dz} \frac{d^2 z}{dt^2} + \frac{d^2\mathbf{r_i}}{dz^2} \left( \frac{d z}{dt} \right)^2 \\
\implies \frac{d^2\mathbf{r_i}}{dt^2} = \frac{q}{m} \frac{d\mathbf{r_i}}{ dz} \mathbf{E}_z + \frac{d^2\mathbf{r_i}}{dz^2} \left( \frac{d z}{dt} \right)^2 \\
$$

We use the fact that the total energy of the particle is

$$
E = q \phi + \frac{1}{2} m \left(\frac{d x}{dt}^2 + \frac{d y}{dt}^2 + \frac{d z}{dt}^2 \right) \\
E = q \phi + \frac{1}{2} m \frac{d z}{dt}^2 \left(1 + \frac{d x}{dz}^2 + \frac{d y}{dz}^2 \right) \\
$$

where $\phi$ is the electrostatic potential. Therefore,

$$
\frac{d z}{dt}^2 = \frac{2}{m} \frac{E - q \phi}{1 + \frac{d x}{dz}^2 + \frac{d y}{dz}^2 }
$$

Thus, we can rewrite the equations of motion as

$$
\frac{d^2 x}{dz^2} = \frac{1}{2( E/q - \phi)} \left( \mathbf{E}_x - \frac{d x}{dz} \mathbf{E}_z \right) \left( 1 + \frac{d x}{dz}^2 + \frac{d y}{dz}^2 \right) \\
\frac{d^2 y}{dz^2} = \frac{1}{2( E/q - \phi)} \left( \mathbf{E}_y - \frac{d y}{dz} \mathbf{E}_z \right) \left( 1 + \frac{d x}{dz}^2 + \frac{d y}{dz}^2 \right) \\
$$
