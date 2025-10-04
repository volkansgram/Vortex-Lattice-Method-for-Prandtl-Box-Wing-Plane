function V03_Panels

    global KW NI NJ NJ1 maxNI1 maxNJ1 maxNI maxNJ
    global AlphaD fWake
    global P G C bWing Zeta 

    bMax = max(bWing);
    Lwake = fWake*bMax;
%--------------------------------------------------------------------------
%   Girdap uç noktalarý
%--------------------------------------------------------------------------
    G = zeros(maxNI1+1,maxNJ1,KW,3);
    for k = 1:KW
%         L_vektor = Lwake*bWing(k)*[cosd(AlphaD), 0, sind(AlphaD)];
        L_vektor = Lwake*[cosd(AlphaD), 0, sind(AlphaD)];
        for j = 1:NJ1(k)
        for i = 1:NI(k)
            G(i,j,k,:) = P(i,j,k,:) + 0.25*(P(i+1,j,k,:) - P(i,j,k,:));
        end
            G(NI(k)+1,j,k,:) = P(NI(k)+1, j, k, :);
            G(NI(k)+2,j,k,:) = squeeze(P(NI(k)+1,j,k,:))' + L_vektor;
        end
    end
%     disp([G]);
%----------------------------------------------------------------------
%   Panel kontrol noktalarý
%----------------------------------------------------------------------
    C = zeros(maxNI,maxNJ,KW,3);
    for k = 1:KW
        for j = 1:NJ(k)
        for i = 1:NI(k)
            CL = P(i,j,  k,:) + 0.75*(P(i+1,j  ,k,:)-P(i,j  ,k,:));
            CR = P(i,j+1,k,:) + 0.75*(P(i+1,j+1,k,:)-P(i,j+1,k,:));
            C(i,j,k,:) = (CL + CR) / 2;
        end
        end
    end
%----------------------------------------------------------------------
%   Panel Birim Normal Vektörleri
%----------------------------------------------------------------------
    Zeta = zeros(maxNI,maxNJ,KW,3);
    for k=1:KW
        for j = 1:NJ
        for i = 1:NI 
            R1 = squeeze(P(i+1,j+1,k,:) - P(i  ,j,k,:));
            R2 = squeeze(P(i  ,j+1,k,:) - P(i+1,j,k,:));
            R12 = cross(R1,R2);
            norm_R12 = norm(R12);
            Zeta(i,j,k,:) = R12/norm_R12;
        end
        end        
    end

end

