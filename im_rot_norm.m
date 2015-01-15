% IM_ROT_NORM
% normalize images by rotating them upwards if eccentricity and orientation
% are between bounds
function b = im_rot_norm(varargin)
    argin = shiftargin(varargin,'scalar');
    argin = setdefaults(argin, [], 0.8, 50);
    
    if mapping_task(argin, 'definition')
        b = define_mapping(argin, 'fixed');
        b = setname(b, 'Mapping Example');
        return
    end
    
    [a, min_eccentricity, max_rot] = deal(argin{:});
    
    if isdataset(a)
        error('Command cannot be used for datasets as it may change image size')
    end
    
    if isdatafile(a)
        isobjim(a); % assert that a contains image objects
        b = filtim(a, mfilename, argin{2:end});
        return
    end
    
    % convert dip images to double matrix
    if isa(a, 'dip_image'); a = double(a); end
    
    if ~isa(a, 'double'); error('Unknown data type'); end
    
    props = regionprops(a, {'eccentricity', 'orientation'});
    ecc = props.Eccentricity;
    ori = props.Orientation;
        
    % bring orientation range from [-90, 90] to [0, 180]
    if ori < 0; ori = ori + 180; end
    
    % check if eccentricity is high enough and angle doesn't deviate from the up
    % direction too much. 
    if ecc > min_eccentricity && abs(ori - 90) < max_rot
        b = imrotate(a, 90 - ori, 'bilinear', 'loose');
    else
        b = a;
    end
return