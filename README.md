# Diffraction Propagation Simulator
## Overview

A Matlab GUI for simulating five types of diffraction propagation:

* Fourier transform
* Fresnel transfer function
* Fresnel impulse response
* Fraunhofer diffraction
* Angular spectrum

## How to use

1. Run MainScreen.m
2. Choose an object image with the `Open object image` button
3. Check the object image is correct with the left axes.
4. Choose the type of diffraction propagation to simulate from the centre options.
5. If required, change the parameters of the simulation in the bottom section.
6. Click `Run` to start the diffraction propagation simulation to the object image.
7. The diffraction pattern will be displayed in the right axes.
8. Zoom and pan the diffraction image with the controls in the toolbar.
9. Save the diffraction pattern using the `Save diffraction pattern` button.

## The diffraction schemes
### Fourier transform

Performs the standard two dimensional [Fourier Transform](https://en.wikipedia.org/wiki/Fourier_transform#Fourier_transform_on_Euclidean_space) function.

### Fresnel transfer function

Based on the Rayleigh-Sommerfield diffraction solution:

![Alt Text](DiffractionPropagationSimulation/propagation_simulation_assets/propagation_routine.png)

and uses the transfer function *H* given by:


### Fresnel impulse response

Again, based on the Rayleigh-Sommerfield diffraction solution

## 3rd Party licenses

Diffraction pattern image colours by:
[cbrewer](https://www.mathworks.com/matlabcentral/fileexchange/34087-cbrewer---colorbrewer-schemes-for-matlab)

Colour scheme designed by:
[Cynthia Brewer](http://colorbrewer.org/).

