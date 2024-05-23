function [alphaShapePoints,alphaShapeIdx] = findAlphaShape(points,alpha)
%FINDALPHASHAPE_WARD Summary of this function goes here
%   Detailed explanation goes here
    
    arguments
        points
        alpha
    end

    tol = 10*eps;
    p = 2; %parameter for norm; 2 = euclidian

    n = size(points,2);
    alphaShapeIdx = [];
    alphaShapePoints = [];

    tri = delaunayn(points);

    for i = 1:length(tri)
        simplex = tri(i, :);
        simplex_points = points(simplex, :);

        for j = 1:length(simplex_points)
            hyperface = simplex;
            hyperface_points = simplex_points;
            hyperface(j) = [];
            hyperface_points(j,:) = [];

            [c,r] = circumscribedHypersphere(hyperface_points);

            %alpha test
            if r < alpha
                
                centres = circumscribedAlphasphere(hyperface_points,alpha);

                if min(vecnorm(centres(1,:)-points,p,2)) >= alpha - tol | min(vecnorm(centres(2,:)-points,p,2)) >= alpha - tol
                    alphaShapeIdx{end+1} = hyperface;
                    alphaShapePoints{end+1} = hyperface_points;
                end
            end

        end
        

    end



end
