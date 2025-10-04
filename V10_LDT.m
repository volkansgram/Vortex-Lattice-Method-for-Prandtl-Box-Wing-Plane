function V10_LDT

    global C Zeta Vij PC Voo 
    global KW NJ NI maxNI maxNJ
    global A R gamma Gamma

%--------------------------------------------------------------------------      
%   Katsayýlar Matrisi ve Sað Taraf Vektörü
%--------------------------------------------------------------------------
    M=0; for k=1:KW; M=M+NI(k)*NJ(k); end           % Toplam panel sayýsý
    A = zeros(M,M);
    R = zeros(M,1);
%   -----------------------------------------------------------------------    
    i = 0;
    for kC = 1:KW 
    for iC = 1:NI(kC)
    for jC = 1:NJ(kC)
        i= i + 1;
        PC = squeeze(C(iC,jC,kC, :));
        [Vij] = V11_VoRing(PC);
        j=0;
        for kG=1:KW
        for iG = 1:NI(kG)
        for jG = 1:NJ(kG)
            j = j + 1;
            A(i,j) = dot(squeeze(Vij(iG,jG,kG,:)), squeeze(Zeta(iC,jC,kC,:)));
        end
        end
        end
        R(i) = -dot(Voo, squeeze(Zeta(iC,jC,kC,:)));
    end
    end
    end
%--------------------------------------------------------------------------
% 	Çözüm, Girdap þiddetleri
%--------------------------------------------------------------------------
    gm = A \ R;
    disp([A,R,gm]);


%   -----------------------------------------------------------------------
%   Girdap þiddetlerinin kanatlara ve panellere daðýtýlmasý
%   -----------------------------------------------------------------------
    gamma = zeros(maxNI, maxNJ, KW);
    i = 0;
    for k = 1:KW
        for iP = 1:NI(k) 
        for jP = 1:NJ(k)
            i = i+1;
            gamma(iP,jP,k) = gm(i);
        end
        end
    end
%     disp(gamma);
    
%   -----------------------------------------------------------------------
%   Baðlý girdap þiddetleri
%   -----------------------------------------------------------------------
    for k = 1:KW
        for j = 1:NJ(k)
        Gamma(1,j,k) = gamma(1,j,k); 
        for i = 2:NI(k) 
        Gamma(i,j,k) = gamma(i,j,k) - gamma(i-1,j,k);
        end
        end
    end
%     disp(Gamma);

end

