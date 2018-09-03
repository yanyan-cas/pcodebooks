classdef PersistenceImage < PersistenceRepresentation
  %PERSISTENCEIMAGE

  properties
    resolution
    sigma
    weightingFunction
	parallel
  end
  
  methods
    function obj = PersistenceImage(resolution, sigma, ...
        weightingFunction)
      obj = obj@PersistenceRepresentation();

      obj.resolution = resolution;
      obj.sigma = sigma;
      obj.weightingFunction = weightingFunction;
	  obj.parallel = false;
      obj.feature_size = obj.resolution^2;
    end
    
    function setup(obj)
		PI_path = which('PersistenceImage');
		[filepath, name, ext] = fileparts(PI_path);
		addpath(strcat(filepath,'/../../PersistenceImages/matlab_code'));
		%addpath('../PersistenceImages/matlab_code')
    end
    
    function repr = train(obj, diagrams, diagramLimits)
      repr = obj.test(diagrams, diagramLimits);
    end

    function repr = test(obj, diagrams, diagramLimits)

		useold = true;
        % diagramLimitsPersist = [0, diagramLimits(2) - diagramLimits(1)];
		% weightsLimits = [diagramLimits(1)/2, diagramLimits(2) - diagramLimits(1)];

		if useold
            % Parameters for weight function
            weightsLimits = [0, diagramLimits(2) - diagramLimits(1)];
			repr = newmake_PIs(diagrams, obj.resolution, obj.sigma, ...
				obj.weightingFunction, weightsLimits, 1);
		else
            % Parameters for weight function
            weightsLimits = [0, diagramLimits(2) - diagramLimits(1)];
        	% Lower bound for birth and upper bound for persistence. Other points will be rejected.
    		diagramLimitsPersist = [diagramLimits(1), ...
            	diagramLimits(2) - diagramLimits(1)];
            
            repr = new_make_PIs(diagrams, obj.resolution, obj.sigma, ...
			obj.weightingFunction, weightsLimits, 1, ...
			diagramLimitsPersist, obj.parallel);
		end
    end
  end
end

function cutted = remove_exceeding_points(diagrams, limits)
    % limits = [min_birth, max_pers];
    n = length(diagrams);
    for i=1:n
        points = b_p_data{j,i,d};
        points = points(find(points(:,1) >= type_params(d, 1)),:);
        points = points(find(points(:,2) <= type_params(d, 2)),:);
        b_p_data{j,i,d} = points;
    end
end
