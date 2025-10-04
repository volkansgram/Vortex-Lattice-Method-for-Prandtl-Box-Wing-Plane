%==========================================================================
%   Panel köþe noktalarý
%==========================================================================
function V02_Geometry

    global KW NI NJ NI1 NJ1 maxNI1 maxNJ1
    global cMean bWing OH P Tpr SwpD DheD IncD

%--------------------------------------------------------------------------
%   Rectangular platform
%--------------------------------------------------------------------------
    P = zeros(maxNI1, maxNJ1, KW, 3);
    for k = 1:KW 
        dx = 1 / NI(k);
        dy = bWing(k) / NJ(k);
        for j = 1:NJ1(k)
        for i = 1:NI1(k)
            P(i,j,k,:) = [(i-1)*dx, (j-1)*dy, 0]; 
        end
        end
    end

%--------------------------------------------------------------------------
%   Taper
%--------------------------------------------------------------------------
    for k = 1:KW
        if Tpr(k)<0; Tpr(k) = 1/abs(Tpr(k)); end
        cR = 2*cMean(k)/(1+Tpr(k));
        cT = Tpr(k)*cR;
        dcdy = (cT-cR)/bWing(k);
        for j = 1:NJ1(k)
            cy = cR + dcdy*squeeze(P(i,j,k,2));
            for i = 1:NI1(k)
                P(i,j,k,1) = cy*squeeze(P(i,j,k,1));
            end
        end
    end
%--------------------------------------------------------------------------
%   Sweep
%--------------------------------------------------------------------------
    for k = 1:KW
        TanSwp = tan(deg2rad(SwpD(k)));
        for j  = 1:NJ1(k)
            delx = P(i,j,k,2)*TanSwp;
            for i  = 1:NI1(k)
                P(i,j,k,1) = P(i,j,k,1) + delx;   
            end
        end
    end
%--------------------------------------------------------------------------
%   Dihedral
%--------------------------------------------------------------------------
    for k = 1:KW 
        DheR = deg2rad(DheD(k));
        rotate  = angle2dcm(-DheR,0,0,'XYZ');
        for j = 1:NJ1(k)
        for i = 1:NI1(k)
            P(i,j,k,:) = rotate*squeeze(P(i,j,k,:));
        end
        end
    end 
%--------------------------------------------------------------------------
%   Incidence
%--------------------------------------------------------------------------
    for k = 1:KW 
        IncR = deg2rad(IncD(k));
        rotate  = angle2dcm(0,-IncR,0,'XYZ');
        for j = 1:NJ1(k)
        for i = 1:NI1(k)
            P(i,j,k,:) = rotate*squeeze(P(i,j,k,:));
        end
        end
    end

%--------------------------------------------------------------------------
%   Wing positioning
%--------------------------------------------------------------------------
    for k = 1:KW 
        for j = 1:NJ1(k)
        for i = 1:NI1(k)
            P(i,j,k,:) = squeeze(P(i,j,k,:)) + OH(:,k); 
        end
        end
    end
%--------------------------------------------------------------------------


end

