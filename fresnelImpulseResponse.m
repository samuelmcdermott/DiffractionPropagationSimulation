function diffraction_image = fresnelImpulseResponse(object_image, plane_side_length,wavelength,propagation_distance)
%%performs fresnel impulse response of 2D image and returns irradiance
%%image
%Inputs:
%   object_image: the image of the object to be diffracted
%   plane_side_length: the length of the object plane (assumed square)
%   wavelength: the wavelength of the simluated monochromatic light
%   propagation distance: the distance between the object plane and the
%   observation plane
%
%Outputs:
%   diffraction_image: the irradiance image of the diffraction pattern

%get the pixel size of the object
[M,~] = size(object_image);
%get the sample size
dx = plane_side_length/M;
%wavenumber
k = 2*pi/wavelength;
%create coordinates in spatial space
x = -plane_side_length/2:dx:plane_side_length/2-dx;
[X,Y] = meshgrid(x,x);
%impulse response function
h = 1/(1i*wavelength*propagation_distance)*exp(1i*k/(2*propagation_distance)*(X.^2+Y.^2));
%create transfer function
H=fft2((h))*dx^2;
%shift, fft object image
U1 = fft2((object_image));
%convolution in fourier space
U2 = H.*U1;
%ifft, shift
diffraction_image = (ifft2(U2));
%get irradiance image of diffraction pattern
diffraction_image = abs(diffraction_image).^2;
end

