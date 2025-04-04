x1 = linspace(-1,1,300);
x2 = linspace(-1,1,300);
% y = exp(-x).*sin(10*x);

y = 5*sin(10*x1) + x2;

figure(1);
plot3(x1,x2,y,'r');

%% Tap du lieu huan luyen mang NN
K = 1000;    %so mau. Khi bi overfit thi tang K len.
X = [2*rand(1,K)-1 ; 2*rand(1,K)-1];    
% D = exp(-X).*sin(10*X);
D = 5*sin(10*X(1,:)) + X(2,:);
figure(2);
plot3(X(1,:),X(2,:),D,'o');

%% Huan luyen mang Neuron
N = 25;    %It neuron chua linh dong nhieu overfit. 
mynet = newff(X,D,N,{'tansig' 'purelin'});
mynet = train(mynet,X,D);

%% Danh gia mang sau khi huan luyen
x1 = linspace(-1,1,300);
x2 = linspace(-1,1,300);
x = [x1;x2];
ynn = sim(mynet,x);
figure(1);
subplot(1, 1 ,1)
hold on
plot3(x1,x2,y,'r')
% subplot(2, 1 ,2)
plot3(x1,x2,ynn,'--b');
mse = (y-ynn)*(y-ynn)'/K   %mean square error