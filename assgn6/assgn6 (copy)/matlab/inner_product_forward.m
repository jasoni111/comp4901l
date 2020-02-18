function [output] = inner_product_forward(input, layer, param)

%  params{i-1}.w = scale*randn(h*w*c, layers{i}.num);(800*500)
%  params{i-1}.b = zeros(1, layers{i}.num);(1*500)

if nargin == 2
    assert(false)
  %do stuff
end

d = size(input.data, 1);
k = size(input.data, 2); % batch size
n = size(param.w, 2);

% Replace the following line with your implementation.
output.data = zeros([n, k]);

output.data=param.w'*input.data;
output.data=output.data+param.b';

assert(size(output.data,1)==n);
assert(size(output.data,2)==k);

output.height=n;
output.width=1;
output.channel=1;
output.batch_size=k;

end
