function [param_grad, input_od] = inner_product_backward(output, input, layer, param)

% Replace the following lines with your implementation.


param_grad.b = zeros(size(param.b));
param_grad.w = zeros(size(param.w));
%output.diff stores the D l/D h_i

%h_i=wh_{i-1}+b
%dh_i/dl =w dh_{i-1}/dl
%dl/dh_{i-1}=w dh_i/dl
input_od=  param.w * output.diff;
% sizeod=size(input_od)

%dl/dw
%=dl/dh_i * dh_i/dw
%= dl/dh_i * h_{i-1}
%= dl/dh_i * x
% size(input.data)
% size(output.diff')
param_grad.w = input.data * (output.diff');
% sizegw=size(param_grad.w)

%dl/db
%=dl/dh_i * dh_i/db
%= dl/dh_i * 1
param_grad.b = sum(output.diff'); 
% sizegb=size(param_grad.b)
% assert(false)

end
