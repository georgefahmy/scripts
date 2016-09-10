classdef quaternion
  % This class contains a quaternion using right hand notation denoted w,
  % x, y, z;
  properties(GetAccess = 'public', SetAccess = 'private')
    % define the properties of the class here, (like fields of a struct)
    w = 1;
    x = 0;
    y = 0;
    z = 0;
  end
  methods
    % methods, including the constructor are defined in this block
    function quat = quaternion(w, x, y, z)
      % class constructor
      if(nargin > 3)
        quat.w = w;
        quat.x = x;
        quat.y = y;
        quat.z = z;
      end
    end
    function v = to_vector(obj)
      v = [obj.w; obj.x; obj.y; obj.z];
    end
    function obj = from_vector(obj, v)
      obj = obj.with_values(v(1), v(2), v(3), v(4));
    end
    function obj = with_values(obj, w, x, y, z)
        obj.w = w; obj.x = x; obj.y = y; obj.z = z;
    end
    function obj = identity(obj)
      obj = obj.with_values(1, 0, 0, 0);
    end
    function obj = eq(obj, q)
      obj = (obj.w == q.w) && (obj.x == q.x) && (obj.y == q.y) && (obj.z == q.z);
    end
    function obj = ne(obj, q)
      obj = ~eq(obj, q);
    end
    function obj = plus(obj, q)
      obj = obj.with_values(obj.w + q.w, obj.x + q.x, obj.y + q.y, obj.z + q.z);
    end
    function obj = minus(obj, q)
      obj = obj.with_values(obj.w - q.w, obj.x - q.x, obj.y - q.y, obj.z - q.z);
    end 
    function obj = inverse(obj)
      temp = norm(obj)^2;
      obj = obj.with_values(obj.w/temp, -obj.x/temp, -obj.y/temp, -obj.z/temp);
    end
    function out = mtimes(obj, q)
      M = [obj.w -obj.x -obj.y -obj.z;
           obj.x  obj.w -obj.z  obj.y;
           obj.y  obj.z  obj.w -obj.x;
           obj.z -obj.y  obj.x  obj.w];
      if(isa(q, 'quaternion'))
        temp = M*q.to_vector();
        temp = temp./norm(temp);
        out = obj.from_vector(temp);
      else
        temp = quaternion(0, q(1), q(2), q(3));
        temp = obj*temp*obj.inverse();
        out = [temp.x; temp.y; temp.z];
      end
    end
    function out = norm(obj)
      out = norm(obj.to_vector());
    end
    function obj = normalize(obj)
      v = obj.to_vector();
      v = v./norm(v);
      obj = obj.from_vector(v);
    end
    function angle = angle_between(obj, q)
      obj = obj.normalize();
      q = q.normalize();
      r = obj.inverse()*q;
      angle = 2*acos(r.w);
    end
    function [axis, angle] = to_axis_angle(obj)
      angle = 2 * acos(obj.w);
      temp = sqrt(1 - obj.w^2);
      if(temp == 0)
        axis = [1; 0; 0];
      else
        x = obj.x / temp;
        y = obj.y / temp;
        z = obj.z / temp;
        axis = [x, y, z];
      end
    end
    function obj = from_axis_angle(obj, axis, angle)
      axis = axis./norm(axis);
      sth = sin(angle/2);
      obj = obj.with_values(cos(angle/2), axis(1)*sth, axis(2)*sth, axis(3)*sth);
    end
    function obj = change_angle_to(obj, new_angle)
      [axis, ~] = obj.to_axis_angle();
      obj = obj.from_axis_angle(axis, new_angle);
    end
    function obj = from_2_vectors(obj, v1, v2)
      axis = cross(v1, v2);
      angle = acos(dot(v1, v2)/(norm(v1)*norm(v2)));
      obj = obj.from_axis_angle(axis, -angle);
    end
    function obj = from_euler(obj, r, p, y)
      if(nargin < 3 && length(r) == 3)
        r = r(1);
        p = r(2);
        y = r(3);
      end
      temp = [cos(r/2)*cos(p/2)*cos(y/2)+sin(r/2)*sin(p/2)*sin(y/2);
             -cos(r/2)*sin(p/2)*sin(y/2)+sin(r/2)*cos(p/2)*cos(y/2);
              cos(r/2)*sin(p/2)*cos(y/2)+sin(r/2)*cos(p/2)*sin(y/2);
              cos(r/2)*cos(p/2)*sin(y/2)-sin(r/2)*sin(p/2)*cos(y/2)];
      obj = obj.from_vector(temp);
    end
    function obj = slerp(obj, q, alpha)
      obj = normalize(obj);
      q = normalize(q);
      qdiff = inverse(obj)*q;
      [axis, angle] = to_axis_angle(qdiff);
      if(angle > pi)
        angle = angle - 2*pi;
      end
      if(angle < pi)
        angle = angle + 2*pi;
      end
      qmove = obj.from_axis_angle(axis, angle*alpha);
      obj = obj * qmove;
    end
    function obj = to_euler(obj)
      q = obj;
      roll = atan2(2*(q.y)*(q.z)+2*(q.w)*(q.x), (q.w)^2-(q.x)^2-(q.y)^2+(q.z)^2);
      pitch = -asin(2*(q.x)*(q.z)-2*(q.w)*(q.y));
      yaw = atan2(2*(q.x)*(q.y)+2*(q.w)*(q.z), (q.w)^2+(q.x)^2-(q.y)^2-(q.z)^2);
      obj = [roll; pitch; yaw];
    end
    function obj = to_rotation_matrix(obj)
      q = obj;
      M = [1-2*q.y^2-2*q.z^2, 2*q.x*q.y-2*q.z*q.w,   2*q.x*q.z+2*q.y*q.w;
           2*q.x*q.y+2*q.z*q.w,   1-2*q.x^2-2*q.z^2, 2*q.y*q.z-2*q.x*q.w;
           2*q.x*q.z-2*q.y*q.w,   2*q.y*q.z+2*q.x*q.w,   1-2*q.x^2-2*q.y^2];
      obj = M;
    end
  end
end