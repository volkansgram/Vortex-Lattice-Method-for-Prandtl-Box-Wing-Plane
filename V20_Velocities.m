function V20_Velocities

    global KW NI NJ maxNI maxNJ
    global gamma G Voo Vij Vind

    Vij  = zeros(maxNI,maxNJ,KW,3);
    Vind = zeros(maxNI,maxNJ,KW,3);

    for kC=1:KW 
    for iC=1:NI(kC)  
    for jC=1:NJ(kC)
%       -------------------------------------------------------------------
%       H�z�n hesapland��� PC noktas�n�n koordinatlar�
%       -------------------------------------------------------------------
        P1 = squeeze(G(iC,jC  ,kC,:));
        P2 = squeeze(G(iC,jC+1,kC,:));
        PC = (P1+P2)/2;
%       -------------------------------------------------------------------
%       PC noktas�nda birim girdap �iddeti ba��na ind�klemeler 
%       -------------------------------------------------------------------
        [Vij] = V11_VoRing(PC);
%         disp(Vij);
%       -------------------------------------------------------------------
%       PC noktas�nda ind�klenen bile�ke h�z
%       -------------------------------------------------------------------
        Vind(iC,jC,kC,:) = Voo; 
        for kG= 1:KW           
        for iG=1:NI(kG)
        for jG=1:NJ(kG)
            sss = squeeze(Vij(iG,jG,kG,:));
            ggg = gamma(iG,jG,kG);
%             vnd = squeeze(Vind(iC,jC,kC,:)) + sss * ggg;
            Vind(iC,jC,kC,:) = squeeze(Vind(iC,jC,kC,:)) + sss * ggg; 
        end
        end
        end
    end
    end
    end
%     disp(Vind);

 end

