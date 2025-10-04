function V01_Inputs(Veri)

    global AlphaD Voo
    global KW NI NJ NI1 NJ1 maxNI maxNJ maxNI1 maxNJ1
    global cMean bWing Swing OH Tpr SwpD DheD IncD

%--------------------------------------------------------------------------
%   Parametreler
%--------------------------------------------------------------------------
    [KW,~] = size(Veri);
    for k=1:KW
        cMean(k)= Veri{k,1};
        bWing(k)= Veri{k,2};
        NJ(k)   = Veri{k,3};
        NI(k)   = Veri{k,4};
        xH(k)   = Veri{k,5};
        yH(k)   = Veri{k,6};
        zH(k)   = Veri{k,7};
        Tpr(k)  = Veri{k,8};
        SwpD(k) = Veri{k,9};
        DheD(k) = Veri{k,10};
        IncD(k) = Veri{k,11};
    end
%--------------------------------------------------------------------------
    Voo = [cosd(AlphaD), 0, sind(AlphaD)]';
%--------------------------------------------------------------------------
    NI1 = zeros(1,KW);
    NJ1 = zeros(1,KW);
    OH  = zeros(3,k);
    for k=1:KW
        NI1(k) = NI(k)+1;
        NJ1(k) = NJ(k)+1;
        Swing(k) = bWing(k)*cMean(k);
        OH(:,k)  = [xH(k);yH(k);zH(k)];
    end
    maxNI = max(NI); maxNI1 = maxNI+1;
    maxNJ = max(NJ); maxNJ1 = maxNJ+1;

end