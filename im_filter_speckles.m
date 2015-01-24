% IM_FILTER_SPECKLES
%
%
function b = im_filter_speckles(varargin)
    argin = shiftargin(varargin,'scalar');
    argin = setdefaults(argin, [], 30);
    
    if mapping_task(argin, 'definition')
        b = define_mapping(argin, 'fixed');
        b = setname(b, 'Mapping Example');
        return
    end
    
    [a, speckle_size] = deal(argin{:});
    
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
    
    cc = bwconncomp(a);
    stats = regionprops(cc, 'Area');
    cc_indexes = find([stats.Area] > speckle_size);
    b = a .* ismember(labelmatrix(cc), cc_indexes);
return