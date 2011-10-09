#include "vector2D.hpp"  
#include <math.h>


Vector2D::Vector2D(double _x, double _y)
{
    x = _x;
    y = _y;
}

Vector2D::~Vector2D(){};
  
Vector2D& 
Vector2D::operator=(const Vector2D& v) 
{
    if (this != &v)
    {
        x = v.x;
        y = v.y;
    }
    return *this;
}

Vector2D 
Vector2D::operator+(const Vector2D& v) const
{
    return Vector2D(v.x + x, v.y + y);
}

Vector2D 
Vector2D::operator+(const double k) const
{
    return Vector2D(x + k, y + k);
}

Vector2D 
Vector2D::operator-(const Vector2D& v) const
{
    return Vector2D(x - v.x, y - v.y);    
}

Vector2D 
Vector2D::operator-(const double k) const
{
    return Vector2D(x - k, y - k);
}

Vector2D 
Vector2D::operator*(const Vector2D& v) const
{
    return Vector2D(v.x * x, v.y * y);
}

Vector2D 
Vector2D::operator*(const double k) const
{
    return Vector2D(x * k, y * k);
}

Vector2D 
Vector2D::operator/(const Vector2D& v) const
{
    return Vector2D(x / v.x, y / v.y);
}

Vector2D 
Vector2D::operator/(const double k) const
{
    return Vector2D(x / k, y / k);
}

bool 
Vector2D::operator==(const Vector2D& v) const
{
    if (this != &v)
    {
        return v.x == x && v.y == y;
    }
    else return true;
}

bool 
Vector2D::operator!=(const Vector2D& v) const
{
    return !(*this == v);
}

double 
Vector2D::norm()
{
    return sqrt(x*x + y*y);
}