% function V04_Graphics
%     global KW NI1 NJ1 P G
% 
%     figure(1); clf;
%     hold on;
% 
%     for k = 1:KW
%         %% -- Mesh (Panel) çizimi
%         xGr = squeeze(P(:,:,k,1));
%         yGr = squeeze(P(:,:,k,2));
%         zGr = squeeze(P(:,:,k,3));
%         mesh(xGr, yGr, zGr, 'edgecolor', 'b');
% 
%         %% -- Statik etiket: Panel köşelerine küçük siyah nokta ve değer yazısı
%         for i = 1:NI1(k)
%             for j = 1:NJ1(k)
%                 xi = P(i,j,k,1);
%                 yi = P(i,j,k,2);
%                 zi = P(i,j,k,3);
%                 plot3(xi, yi, zi, 'k.', 'MarkerSize', 8);
%                 text(xi, yi, zi, sprintf('(%0.1f, %0.1f, %0.1f)', xi, yi, zi), ...
%                     'FontSize', 8, 'HorizontalAlignment','left','VerticalAlignment','bottom');
%             end
%         end
% 
%         %% -- Vortices çizimi
%         NI2 = NI1(k)+1;
%         xGr2 = squeeze(G(:,:,k,1));
%         yGr2 = squeeze(G(:,:,k,2));
%         zGr2 = squeeze(G(:,:,k,3));
%         mesh(xGr2, yGr2, zGr2, 'edgecolor', 'r');
% 
%         %% -- Statik etiket: Vortex köşelerine kırmızı nokta ve değer yazısı
%         for i = 1:NI2
%             for j = 1:NJ1(k)
%                 xi = G(i,j,k,1);
%                 yi = G(i,j,k,2);
%                 zi = G(i,j,k,3);
%                 plot3(xi, yi, zi, 'r.', 'MarkerSize', 8);
%                 text(xi, yi, zi, sprintf('(%0.1f, %0.1f, %0.1f)', xi, yi, zi), ...
%                     'FontSize', 8, 'HorizontalAlignment','left','VerticalAlignment','bottom');
%             end
%         end
%     end
% 
%     axis equal;
%     xlabel('X'); ylabel('Y'); zlabel('Z');
%     title('Panel ve Vortex Mesh + Konum Etiketleri');
% 
%     %% -- İnteraktif datatip modu
%     dcm = datacursormode(gcf);
%     set(dcm, 'Enable', 'on', ...
%              'DisplayStyle', 'window', ...
%              'SnapToDataVertex', 'off', ...
%              'UpdateFcn', @myUpdateFcn);
% end
%==========================================================================
function V04_Graphics
%==========================================================================
    global KW NI1 NJ1 P G

    figure(1);
    for k = 1:KW
%       -------------------------------------------------------------------
%       Panels
%       -------------------------------------------------------------------
        xGr = zeros(NI1(k),NJ1(k));
        yGr = zeros(NI1(k),NJ1(k));
        zGr = zeros(NI1(k),NJ1(k));
        for i=1:NI1(k)
        for j=1:NJ1(k)
            xGr(i,j)=P(i,j,k,1);
            yGr(i,j)=P(i,j,k,2);
            zGr(i,j)=P(i,j,k,3);   
        end 
        end
        mesh(xGr(1:NI1(k),1:NJ1(k)), yGr(1:NI1(k),1:NJ1(k)),zGr(1:NI1(k),1:NJ1(k)),'edgecolor', 'b');
        hold on;
%       -------------------------------------------------------------------
%       Vortices
%       -------------------------------------------------------------------
        NI2(k)=NI1(k)+1;
        xGr = zeros(NI2(k),NJ1(k));
        yGr = zeros(NI2(k),NJ1(k));
        zGr = zeros(NI2(k),NJ1(k));
        for i=1:NI2(k)
        for j=1:NJ1(k)
            xGr(i,j)=G(i,j,k,1);
            yGr(i,j)=G(i,j,k,2);
            zGr(i,j)=G(i,j,k,3);   
        end 
        end
        mesh(xGr(1:NI2(k),1:NJ1(k)), yGr(1:NI2(k),1:NJ1(k)),zGr(1:NI2(k),1:NJ1(k)),'edgecolor', 'r');
        hold on;
%       -------------------------------------------------------------------
    end
    axis equal; 

end
