classdef PersistencePds < PersistenceRepresentation
  %PERSISTENCEPDS
  
  properties
    resolution
    sigma
    dim
  end
  
  methods
	function obj = PersistencePds(resolution, sigma, dim)
		obj = obj@PersistenceRepresentation();

		obj.resolution = resolution;
		obj.sigma = sigma;
		obj.dim = dim;
		obj.feature_size = dim;
    end
    
	function setup(obj)
		addpath('../pdsphere/matlab/');
		addpath('../pdsphere/matlab/Sphere tools/');
	end

	function obj = fit(obj, diagrams, diagramLimits)
		disp('PersistencePds does not need fitting.');
	end

	function repr = predict(obj, diagrams, diagramLimits)
		stepVal = (diagramLimits(2) - diagramLimits(1)) / obj.resolution;
		params.x1 = diagramLimits(1):stepVal:diagramLimits(2);
		params.x2 = params.x1;
		params.sig = obj.sigma;

		htMap = newHeatMapfromPD(diagrams, params);
		phi = hmap2sphere(htMap);
		repr = Sphere_PGA(phi, obj.dim);
    end
  end
end
