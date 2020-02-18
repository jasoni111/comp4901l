function T = metamericLight(f,g)
cieXYZ = csvread('../data/ciexyz64_1.csv');
lambdas = 400:10:700;

R=cieXYZ(ismember(cieXYZ(:,1),400:10:700 ),:)';
R=R(2:end,:);

temperature = 2500e3:50e3:10000e3;
L_T= repelem(temperature,31,1);
L_T=(L_T./lambdas'.^5)./(exp( 1.4388*10^-2 ./(lambdas'.*L_T))-1);
L_T=L_T./sum(L_T);
L_f=R.*[f';f';f'];
L_g=R.*[g';g';g'];
D=vecnorm(L_f*L_T-L_g*L_T);

[~,idx] = min(D);
T=temperature(idx);
figure
plot(temperature,D)
title('distance as a function of temperature')
xlabel('Temperature')
ylabel('distance')
grid on

saveas(gcf,'../1_6_4_a.png')



figure
plot(400:10:700,L_T(:,idx) )
title(sprintf('spectral power distribution of T=%d',T))
grid on
saveas(gcf,'../1_6_4_b.png')
