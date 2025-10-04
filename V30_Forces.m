function V30_Forces

    global KW NI NJ Vind AlphaD Swing Voo G Gamma 

    AbsVoo = norm(Voo);
    eD = [ cosd(AlphaD); 0; sind(AlphaD)];
    eL = [-sind(AlphaD); 0; cosd(AlphaD)];

    Ftotal = 0;
    for k = 1:KW
%       -------------------------------------------------------------------
%       Aerodinamik kuvvetler
%       -------------------------------------------------------------------
        Fk = 0;
        for i = 1:NI(k)
        for j = 1:NJ(k)
            Vijk = squeeze(Vind(i,j,k,:));
            ds = squeeze(G(i,j+1,k,:)) - squeeze(G(i,j,k,:));
            VGamma = Gamma(i,j,k) * ds;
            fijk = cross(Vijk, VGamma);
            Fk = Fk + fijk;
        end
        end
        Ftotal = Ftotal + Fk;
%       -------------------------------------------------------------------
%       Aerodinamik katsayýlar
%       -------------------------------------------------------------------
        cFk = 2*Fk/(AbsVoo*Swing(k));
        cD(k) = dot(cFk,eD);
        cL(k) = dot(cFk,eL);

        disp(['cL = ',sprintf('%f ',cL(k))]);
        disp(['cD = ',sprintf('%f ',cD(k))]);
 
    end

end
