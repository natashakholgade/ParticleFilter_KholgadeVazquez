#ifndef MYMEX_VECTOR2D
#define MYMEX_VECTOR2D

class Vector2D
{
public:
  double x;
  double y;
  
  Vector2D(double _x = 0.0, double _y = 0.0);
  ~Vector2D();
  
  Vector2D& operator=(const Vector2D& v);
  Vector2D operator+(const Vector2D& v) const;
  Vector2D operator+(const double k) const;
  Vector2D operator-(const Vector2D& v) const;
  Vector2D operator-(const double k) const;
  Vector2D operator*(const Vector2D& v) const;
  Vector2D operator*(const double k) const;
  Vector2D operator/(const Vector2D& v) const;
  Vector2D operator/(const double k) const;
  bool operator==(const Vector2D& v) const;
  bool operator!=(const Vector2D& v) const;
  double norm();
};

#endif