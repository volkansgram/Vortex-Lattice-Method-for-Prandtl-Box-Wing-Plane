function [DeltaV] = V12_Vor3D(PC,P1,P2)
 
    r1 = PC - P1;
    r2 = PC - P2;
    r0 = P2 - P1;
    r12 = cross(r1, r2);
    if norm(r12)<0.00000001                  % cross(r1, r2) == 0 
        DeltaV = [0;0;0];
    else
        r1r2    = r12 / (norm(r12))^2;
        Term2   = (r1 / norm(r1)) - (r2 / norm(r2));
        r0Term2 = dot(r0, Term2);
        DeltaV  = 1 / (4*pi) * r1r2 * r0Term2;
    end

end