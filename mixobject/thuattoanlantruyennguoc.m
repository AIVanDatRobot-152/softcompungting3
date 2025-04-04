x = linspace(0,2,300);
y = exp(-x).*sin(10*x);
figure(1);
plot(x,y,'r');

%% Tap du lieu huan luyen mang NN
K = 300;    %so mau. Khi bi overfit thi tang K len.
X = 2*rand(1,K);    %0<X<2
D = exp(-X).*sin(10*X);
figure(2);
plot(X,D,'o');

%% Huan luyen mang Neuron
N = 12;    %It neuron chua linh dong nhieu overfit. 
mynet = newff(X,D,N,{'tansig' 'purelin'});
mynet = train(mynet,X,D);

%% Danh gia mang sau khi huan luyen
x = linspace(0,2,300);
ynn = sim(mynet,x);
figure(1);
subplot(1, 1 ,1)
hold on
plot(x,y,'r')
% subplot(2, 1 ,2)
plot(x,ynn,'--b');
mse = (y-ynn)*(y-ynn)'/K   %mean square error