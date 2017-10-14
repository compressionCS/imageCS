function result = obj_fun(a, y, A, AT, x, decoder, q, imsize, type)
 
if strcmp(type, 'Operator')
    updated_x = x + a*AT(y - A(x));
elseif strcmp(type, 'Number')
    updated_x = x + a*AT*(y - A*x);
end
x = EnDecode(decoder, updated_x, q, imsize, 'trash/a_image');
  if strcmp(type, 'Operator')
      result = norm(y - A(x), 2);
  elseif strcmp(type, 'Number')
      result = norm(y - A*x, 2);
  end
end