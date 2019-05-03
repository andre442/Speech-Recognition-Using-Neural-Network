%%%%%%%%%% Identificador de Locutor André Heidemann Iarozinski
%%%%%%%%%%

prompt = 'bem vindo, aperte "enter" para fazer login ';
input(prompt);

%%%%% gerando som
amp=5; 
fs=11025;  % frequencia de amostragem
duration=0.3;
freq=196;

values=0:1/fs:duration;
a=amp*sin(2*pi* freq*values);
sound(a,11025)

%%%%%%%%%% armazenando amostras para verificação

for i=1:3

prompt = 'para gravar sua voz - aperte "enter"';
input(prompt);

recc = audiorecorder(11025, 16, 1);
disp('inicio da gravacao')
recordblocking(recc, 1);
disp('fim da gravacao');

z = getaudiodata(recc);
z=abs(fft(z));
z=z(1:3000);

[pks,locs] = findpeaks(z,'MinPeakProminence',20,'Threshold',4,'MinPeakDistance',30);
size(locs);

if size(locs)<12
    locs=[locs; zeros(12-length(locs),1)];
else
    locs=locs(1:12);
end

cmd = ['c' num2str(i) '= locs;'];
eval(cmd);
 
end

cf=(c1+c2+c3)/3;

c=ceil(cf);                 %%%ENTRADA NA REDE 

%%%%%%%%% criação da matriz data
d = [a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 a13 a14 a15 a16 a17 a18 a19 a20 a21 a22 a23 a24 a25 a26 a27 a28 a29 a30 b1 b2 b3 b4 b5 b6 b7 b8 b9 b10 u1 u2 u3 u4 u5 u6 u7 u8 u9 u10];  %% b´s bruno,kaio,jake

%%%%%%% criação da matriz resposta
r = [zeros(1,30) ones(1,20)];

d=d';
r=r';
%%%%criacao da rede neural "redezz"(10 neuronios) com as amostras

%%%%%%%%% verificação final
f= rede_x4(c);

if f<=0.4

    disp('login efetuado com sucesso! ');
else
    
    disp('acesso negado!');
end


