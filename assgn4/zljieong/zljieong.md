---
author: Jason Ieong (zljieong)
title: 4901L assignment 4
---
author: Jason Ieong (zljieong)
title: 4901L assignment 4




[toc]

### 1.1 Lambertian albedo

The energy coming in is

$\int_{\Omega}L_{src}(\theta_{in},\phi_{in})\cos{\theta_{in}dA d\Omega }$

and the energy leaving the surface is

$\int_{\Omega}L_{surface}(\theta_{out},\phi_{out})\cos{\theta_{out}dA d\Omega }$

$=\int_{\Omega}\int_{\Omega_{in}}f(\theta_{in},\phi_{in},\theta_{out},\phi_{out})L_{src}(\theta_{out},\phi_{out})\cos{\theta_{in}}dAd\Omega_{in} \cos{\theta_{out}dAd\Omega}$

$=\int_{\Omega}\int_{\Omega_{in}}\frac{\rho}{\pi}L_{src}(\theta_{out},\phi_{out})\cos{\theta_{in}}d\Omega_{in} \cos{\theta_{out}d\Omega dA}$

$=\frac{\rho}{\pi} \int_{\Omega_{in}}L_{src}(\theta_{out},\phi_{out})\cos{\theta_{in}}dA d\Omega_{in}\int_{\Omega} \cos{\theta_{out}dA d\Omega}$

$=\frac{\rho}{\pi} \int_{\Omega_{in}}L_{src}(\theta_{out},\phi_{out})\cos{\theta_{in}}dA d\Omega_{in}\int_{0}^{2\pi}\int_{0}^{\frac{\pi}{2}} \cos{\theta} \sin{\theta}dA d\theta d\phi $

$=\frac{\rho}{\pi} \int_{\Omega_{in}}L_{src}(\theta_{out},\phi_{out})\cos{\theta_{in}}dA d\Omega_{in}\cdot\pi$

$=\rho \int_{\Omega_{in}}L_{src}(\theta_{out},\phi_{out})\cos{\theta_{in}}dA d\Omega_{in}$

By the conversion of energy, clearly the energy leaving is smaller or equal to the energy coming, then:

$\int_{\Omega}L_{src}(\theta_{in},\phi_{in})\cos{\theta_{in}d\Omega dA}\geq \rho \int_{\Omega_{in}}L_{src}(\theta_{out},\phi_{out})\cos{\theta_{in}}dA d\Omega_{in}$

$1\geq\rho$

known that both sides are energy which cannot be negative, we have:

$0\leq \rho\leq 1$

### 1.2 Foreshortening

#### 1.2.1 Calculate the solid angle subtended by dA at points X1 and X2.

$d_{\Omega_{X_1}}=\frac{dA\cos{0}}{D^2}=\frac{dA}{D^2}$

$d_{\Omega_{X_2}}=\frac{dA\cos{\alpha}}{(\frac{D}{\cos{\alpha}})^2}=\frac{dA\cos^3{\alpha}}{D^2}$

#### 1.2.2 Calculate the irradiance E incident on the plane at points X_1 and X_2, and calculate the ratio $E(X_1)/E(X_2)$.

$E(X_1)=L\cos{0}d\Omega_{X_1}=\frac{LdA}{D^2}$

$E(X_2)=L\cos{\alpha}d\Omega_{X_2}=\frac{L\cos^4{(\alpha)}dA}{D^2}$

$\frac{E(X_1)}{E(X_2)}=\frac{1}{\cos^4{\alpha}}$



### 1.3 Simple rendering

#### 1.3.1 Use quiver to display the x-y components of the normal field and print the result. 

![quiver](/home/jasoni111/Desktop/comp4901l/assgn4/zljieong/quiver.png)

#### 1.3.2 • Compute and display the radiance emitted from each point assuming Lambertian reflectance and constant albedo (equal to one), with a distant point light source in direction ˆs = (0, 0, 1), by typing imshow(N(:,:,3)). Explain why this works.

![1_3_2](/home/jasoni111/Desktop/comp4901l/assgn4/zljieong/1_3_2.png)
Why this work:

Under the assumption that all source of incoming flux is from one direction, 

$L(x,\omega)\longrightarrow L(\omega)\longrightarrow s\delta(\omega=\omega_o)$

Assume Lambertian and constant BRDF, the radiance emitted due to reflectance at $\omega_{out}$ 

$=\rho\int_{\Omega}s\delta(\omega=\omega_{out})\hat{\omega}\cdot \hat{n}\hspace{0.4em} d\Omega$ 

$=\rho s\cdot \hat{n}\cdot\hat{w_i} $

$=\rho \hat{n}\cdot\vec{s} $

Where $\rho$ is assumed to be 1, then  $\vec{s}=\hat{w_i}$

$L(\hat{w}_{out})=\hat{n}\cdot(0,0,1)$ gives the result of source from $(0,0,1)$

#### Compute, display and print the emitted radiance for three different light source directions which are rotated i) 45◦ up, ii) 45◦ right, and iii) 75◦ right from the frontal direction ˆs = (0, 0, 1). Can you spot errors in the field of surface normals? What are the illumination effects being ignored in this calculation of scene radiance?

##### $i)45^{\circ }up$

$\hat{w_i}=(0,\sin{45^{\circ}},\cos{45^{\circ}})$

![1_3_3_1](/home/jasoni111/Desktop/comp4901l/assgn4/zljieong/1_3_3_1.png)



##### $ii)45^{\circ }right$

$\hat{w_i}=(\sin{45^{\circ}},0,\cos{45^{\circ}})$



![1_3_3_2](/home/jasoni111/Desktop/comp4901l/assgn4/zljieong/1_3_3_2.png)
##### $ii)75^{\circ }right$

$\hat{w_i}=(\sin{75^{\circ}},0,\cos{75^{\circ}})$



![1_3_3_3](/home/jasoni111/Desktop/comp4901l/assgn4/zljieong/1_3_3_3.png)

Error: above the foot and under the ears. 

Illumination effects being ignored: shadows, the actual albedo, and the actual non Lambertian surface.



### 1.4 Photometric stereo

#### 1.4.1 Estimate the surface normal and gray scale albedo for each pixel. Submit your Matlab code as well as the results (using imshow for the albedo values and quiver for the surface normals.)

using the result from 1.3, we have 

$I=\rho\cdot\hat{n}\cdot\vec{s}=\vec{s}^{T}*(\rho\cdot\hat{n})$

Then let $\vec{g}=\rho\cdot \hat{n}$, with multiple source and output images, we may solve $\rho$ and $\vec{n}$ by lest squares Approximations

$I=(\vec{s_0}\; \vec{s_1}\;...\;\vec{s_n} )*\vec{g}=S\vec{g}$

$\vec{g}=(S^TS)^{-1}S^{T}I$

where since $\rho$ are scaler and $\hat{n}$ are unit vector and can be decomposed after getting $\vec{g}$

Matlab code: in s1_4.m
albedo:
![1_4_1_1](/home/jasoni111/Desktop/comp4901l/assgn4/zljieong/1_4_1_1.png)
normal:
![1_4_1_2](/home/jasoni111/Desktop/comp4901l/assgn4/zljieong/1_4_1_2.png)

#### 1.4.2 Note the poor estimates of the albedo (and surface normal) in the area surrounding the nostrils. What is the source of this error? Describe one method for finding a better estimate of this information from these seven images.

The main problem is the shadow being omitted in the model which leads to poor result of least square method.

One solution may be  masking out part of those images that contain shadow and calculate the albedo of those part with images that does not shadow those part.



#### 1.4.3 Use the recovered surface information to predict what the person would look like (in grayscale) if illuminated from direction ˆs = (0.58, −0.58, −0.58) and from direction ˆs = (−0.58, −0.58, −0.58). Submit your results and your code.

$\vec{s}=(0.58,-0.58,-0.58):$
![1_4_3_1](/home/jasoni111/Desktop/comp4901l/assgn4/zljieong/1_4_3_1.png)

$\vec{s}=(-0.58,-0.58,-0.58):$
![1_4_3_2](/home/jasoni111/Desktop/comp4901l/assgn4/zljieong/1_4_3_2.png)

#### The function integrate frankot.m in the matlab folder can be used to recover a surface z(x, y) from your surface normals nˆ(x, y), and the surface can be displayed in Matlab. Display and submit two views of the recovered shape.
code used in this part comes from the hint part of Harvard cs283 assignment 7
https://www.seas.harvard.edu/courses/cs283/assgn7.pdf

![1_4_4_1](/home/jasoni111/Desktop/comp4901l/assgn4/zljieong/1_4_4_1.png)

![1_4_4_2](/home/jasoni111/Desktop/comp4901l/assgn4/zljieong/1_4_4_2.png)


### 1.5 Dichromatic reflectance

#### 1.5.1 Assuming that the spectral sensitivities of a camera’s three filters are $(c_R(\lambda), c_G(\lambda), c_B(\lambda))$ and that the BRDF at the surface point imaged at pixel $\vec{u}$ is $f(\lambda, \hat{ω}_i(\vec{u}), \hat{ω}_o(\vec{u})) = f_d(\lambda, \vec{u}) + f_s( \hat{ω}_i(\vec{u}), \hat{ω}_o(\vec{u}))$, write expressions for the elements of the diffuse color vectors $\vec{d}(\vec{u})$ and the source color vector $f_s$.

- Diffuse term varies with wavelength, constant with polarization

- Specular term constant with wavelength, varies with polarization

$$
\vec{C}(\vec{u})=<\vec{n}(\vec{u}),\vec{l}>\int_{\lambda}<c_R({\vec{u}}),c_G({\vec{u}}),c_B({\vec{u}})>\circ I(\lambda)(f_d({\lambda})+f_s(\hat{w_i},\hat{w_o}))d\lambda\\
  =<\vec{n}(\vec{u}),\vec{l}>\int_{\lambda}<c_R({\vec{u}}),c_G({\vec{u}}),c_B({\vec{u}})>\circ I(\lambda)f_d({\lambda})d\lambda+\\
  <\vec{n}(\vec{u}),\vec{l}>\int_{\lambda}<c_R({\vec{u}}),c_G({\vec{u}}),c_B({\vec{u}})>\circ I(\lambda)f_s(\hat{w_i},\hat{w_o})d\lambda\\
  =<\vec{n}(\vec{u}),\vec{l}>\int_{\lambda}<c_R({\vec{u}}),c_G({\vec{u}}),c_B({\vec{u}})>\circ I(\lambda)f_d({\lambda})d\lambda+\\
  f_s(\hat{w_i},\hat{w_o})<\vec{n}(\vec{u}),\vec{l}>\int_{\lambda}<c_R({\vec{u}}),c_G({\vec{u}}),c_B({\vec{u}})>\circ I(\lambda)d\lambda\\
$$

where $\circ$ is the Hadamard product (element wise product)

Then $\vec{d}(\vec{u})=\int_{\lambda}<c_R({\vec{u}}),c_G({\vec{u}}),c_B({\vec{u}})>\circ I(\lambda)f_d({\lambda})d\lambda$  and $\vec{s}=\int_{\lambda}<c_R({\vec{u}}),c_G({\vec{u}}),c_B({\vec{u}})>\circ I(\lambda)d\lambda$

#### 1.5.2 Suppose you are given two unit-length three-vectors $\hat{r_1}$ and $\hat{r_2}$ that are orthogonal to $\vec{s}$. Show that the two-channel image1 given by the per-pixel inner products $(<\hat{r}_1, \hat{C}(\hat{u})>,<\hat{r}_2, \hat{C}(\hat{u})>)$:

##### a ) does not depend on the specular components of the BRDFs, $f_s(\hat{w}_i(\vec{u}),\hat{w}_o(\vec{u}))$

##### b) depends linearly on the surface normals, $\hat{n}(\vec{u})$.

$<\hat{r_1},\hat{C}(\vec{u})>$

$=<\hat{r_1},<\vec{n}(\vec{u}),\vec{l}>\vec{d}(\vec{u})+g_s(\vec{u})\vec{s} >$

$=<\hat{r_1},<\vec{n}(\vec{u}),\vec{l}>\vec{d}(\vec{u})>+<\hat{r_1},<\vec{n}(\vec{u}),g_s(\vec{u})>\vec{s}> $

where $\vec{r_1}\perp \vec{s}$  and $\vec{r_2}\perp \vec{s}$ , then the channel is independent to $g_s(\vec{u})$ which depends on the specular component of BRDFs

since$ <\hat{r_1},\hat{C}(\vec{u})>$

=$<\hat{r_1},<\vec{n}(\vec{u}),\vec{l}>\vec{d}(\vec{u})>+0$

=$<\vec{n}(\vec{u}),\vec{l}> <\hat{r_1},\vec{d}(\vec{u})>$

Then since $\vec{d}(\vec{u})$ is independent of $\vec{n}(\vec{u})$, the two channels depends linearly on the inner product of surface normal assumes that $l(\vec{u})$ is fixed, $\hat{n}(\vec{u})$

#### 1.5.3 Show that the two properties from part (b) are also satisfied by the single-channel (gray scale) image $J(\vec{u})$ = $||J(\vec{u})||$.

let $<\vec{n}(\vec{u}),\vec{l}>=k$, then 

$J(\vec{u})=\|\vec{J}(\vec{u})\|$

=$\sqrt{(k<\hat{r_1},\vec{d}(\vec{u})>)^2+(k<\hat{r_1},\vec{d}(\vec{u})>)^2}$

=$\sqrt{k^2((<\hat{r_1},\vec{d}(\vec{u})>)^2+(<\hat{r_1},\vec{d}(\vec{u})>)^2)}$

=$k\sqrt{(<\hat{r_1},\vec{d}(\vec{u})>)^2+(<\hat{r_1},\vec{d}(\vec{u})>)^2}$

is also linear dependent to $<\vec{n}(\vec{u},\vec{l})>$, while since they both are independent of $g_s$, their composition must also be independent of $g_sL_f\vec{l}$



#### 1.5.4 Write a function imout=makeLambertian(im,s) that takes an RGB image im and a source color vector s and computes the grayscale image J(~u) from part (c). Run this function on the image fruitbowl.png from the data folder using s=[0.6257 0.5678 0.5349] and submit the results. Explain in three sentences or less why imout might be more useful than im to a computer vision system. Note that a simple way to numerically obtain a set of N − 1 unit-length vectors that are orthogonal to N-vector is to use the null command in Matlab.

why imout might be more useful than im: Specular depends on light source and view point while diffusion depends mostly on the object itself which make visual recognition and tracking easier. Moreover, there will be less sharp changes in gradient due to light(direct reflect of specular term) which is beneficial for most visual system.

![1_5](/home/jasoni111/Desktop/comp4901l/assgn4/zljieong/1_5.png)

### 1.6  Color metamers (Extra Credit)

#### 1.6.1 Show that the tristimulus vector $\vec{C}_f = (X_f , Y_f , Z_f )$ for a ripe banana $f(\lambda)$ under illuminant spectrum $l(\lambda)$ can be written as $\vec{C}_f = L_f \vec{l}$ where $L_f$ is a 3×N matrix and $\vec{l}$ is the discretization of $l(\lambda)$.

$$
\vec{C}_f=(X_f,Y_f,Z_f)=\int_\lambda\vec{C}(\lambda)f(\lambda)l(\lambda)d\lambda
$$


$$
=R\circ
\begin{bmatrix}
    \vert & & \vert \\
    f(\lambda_1) &...  & f(\lambda_N)   \\
    \vert & &\vert
\end{bmatrix}\vec{l}
=L_f\vec{l}
$$

#### 1.6.2 Given $\vec{f}$ and $\vec{g}$, a good way to choose $\vec{l}$ is to minimize the distance, in a least-squares sense, of the two resulting tristimulus vectors. Write an expression for the Euclidean distance between the two tristimulus vectors in terms of $L_f$ , its counterpart $L_g$ , and $\vec{l}$.

$\|L_f\vec{l}-L_g\vec{l}\|$

#### 1.6.4 The file bananas.mat from the data folder contains two spectral reflectance functions, ripe and overripe, which are sampled in 10nm increments from 400nm to 700nm and correspond roughly to the data from Day 5 and Day 7 of Figure 4. Use your function to find the optimal metamer-inducing blackbody temperature for these materials, and plot the distance as a function of temperature, and the spectral power distribution of the best illuminant. You will need to use the file ciexyz64 1.csv from the data folder, which contains tabulated data for the CIE XYZ color matching functions. In Matlab, you can read data from a CSV file using the csvread command. Remember to normalize the spectral power distributions of blackbody radiators in a way that is meaningful for the minimization criterion of part (b).

best $T=8300K$ with precision $\pm 50K$ 

![1_6_4_a](/home/jasoni111/Desktop/comp4901l/assgn4/zljieong/1_6_4_a.png)


![1_6_4_b](/home/jasoni111/Desktop/comp4901l/assgn4/zljieong/1_6_4_b.png)



















