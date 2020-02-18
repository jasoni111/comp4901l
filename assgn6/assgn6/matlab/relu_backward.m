function [input_od] = relu_backward(output, input, layer)

% Replace the following line with your implementation.
input_od = zeros(size(input.data));

%h_i=max(h_{i-1},0)
%dh_i/dl =dh_{i-1}/dl if h_{i-1}>0
%dl/dh_i =dl/dh_{i-1} if h_{i-1}>0
input_od= output.diff .* (input.data > 0);

end
