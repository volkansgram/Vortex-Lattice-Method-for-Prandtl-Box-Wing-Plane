function [Vij] = V11_VoRing(PC)

    global NI NJ NI1 NJ1 G
    global maxNI1 maxNJ1 maxNJ maxNI KW

    vB  = zeros(maxNI1,maxNJ ,KW,3);
    vT  = zeros(maxNI1,maxNJ1,KW,3);
    Vij = zeros(maxNI ,maxNJ ,KW,3);
       
   

%--------------------------------------------------------------------------
%   Baðlý girdap indüklemeleri
%--------------------------------------------------------------------------
    for k = 1:KW 
        for jG = 1:NJ(k)
        for iG = 1:NI1(k)
            P1 = squeeze(G(iG,jG  ,k,:));  
            P2 = squeeze(G(iG,jG+1,k,:));
            vB(iG,jG,k,:) = V12_Vor3D(PC,P1,P2);
        end
        end
    end
%--------------------------------------------------------------------------
%   Kaçma girdaplarýnýn indüklemeleri
%--------------------------------------------------------------------------
    for k = 1:KW 
        for jG = 1:NJ1(k)
        for iG = 1:NI1(k)
            P1 = squeeze(G(iG  ,jG,k,:));
            P2 = squeeze(G(iG+1,jG,k,:));
            vT(iG,jG,k,:) = V12_Vor3D(PC,P1,P2);
        end
        end
    end
%--------------------------------------------------------------------------
%   Halka girdaplarýn indüklemeleri
%--------------------------------------------------------------------------
    for k = 1:KW 
        for jG = 1:NJ(k)
            for iG=1:NI(k)
                Vij(iG,jG,k,:) = - squeeze(vT(iG  ,jG  ,k,:)) ...
                                 + squeeze(vB(iG  ,jG  ,k,:)) ...
                                 + squeeze(vT(iG  ,jG+1,k,:)) ...
                                 - squeeze(vB(iG+1,jG  ,k,:));
            end
%           ---------------------------------------------------------------
%           Serbest at nalý girdaplarýnýn indüklemeleri
%           ---------------------------------------------------------------
            iG = NI(k); 
            Vij(iG,jG,k,:) = squeeze(Vij(iG, jG  ,k,:)) ...
                           - squeeze(vT(iG+1,jG  ,k,:)) ...
                           + squeeze(vB(iG+1,jG  ,k,:)) ...
                           + squeeze(vT(iG+1,jG+1,k,:));
        end
    end

end