function [Mef, Cef, Kef, Fef, iddof, indexnodof2, nidof, sdof, ngl] = truss_FEM(nodes, elem, bc, alfa_damp, beta_damp, N, F, nelem, ngl, sdof, nnos, nnel)


% % determinar o tamanho do problema
% [nnos, ~] = size(nodes); % numero de nos
% ngl = 2;                 % numero de graus de liberdade por no
% sdof = nnos*ngl;         % numero total de graus de liberdade   

% %% visualizacao da treliça
% plot_graph(nodes, elem, ngl)


%% alocacao de memoria
K = zeros(sdof,sdof);       % matriz rigidez
M = zeros(sdof,sdof);       % matriz massa

%% montagem do sistema global
[K, M] = global_sys(K, M, nodes, elem, nelem, ngl, nnel);

%% calculo da matriz de amortecimento
C = alfa_damp.*M + beta_damp.*K;


%% sistema efetivo
% aplicacao de condicoes de contorno
[nbc, ~] = size(bc);

k = 0;

for i=1:nbc

    ini = (bc(i,1)-1)*ngl;          % localiza posicao no vetor

    for j=1:ngl
        if bc(i,j+1) == 1

            k = k + 1;             
            indexbc(k) = ini+j;

        end
    end    
end

% selecao dos GL's a serem calculados 
k=0;

for i=1:nnos
    for j=1:ngl
        
        k=k+1;
        
        indexnodof(k,1) = k;
        indexnodof(k,2) = nodes(i,1);
        
    end
end

indexnodof2 = indexnodof';

iddof = setdiff(indexnodof2(1,:),indexbc);
[~, nidof] = size(iddof);


Mef = M(iddof,iddof);
Kef = K(iddof,iddof);
Cef = C(iddof,iddof);
Fef = F(iddof,:);

end