#include "particle.hpp"
#include "Vector2D.hpp"
#include <math.h>
using namespace std;

const float offset = 25.0;
const float maxRange = 8000;
const float resolution = 10;
const float step = resolution/2.0;
const float hitThreshold = 0.9;

enum STATE
{
    X, Y, THETA, DIMENSIONALITY
};

#define nextParticlePtr(x) (x + DIMENSIONALITY);

ParticleSet::ParticleSet(double *p, int number)
{
    particlePtr = p;
    n = number;
}

ParticleSet::~ParticleSet() 
{}

bool
ParticleSet::getIdealLaserMeasurements(const double* map, int width, int height, 
                                       const double* angles, int beams, double *&output)
{
    Vector2D position;
    Vector2D laserPosition, beamEnd, diff, orientation;
    double theta, beamAngle, prob, depth;
    float currStep;
    int x, y;
    double *ptr = particlePtr;

    for (int p=0; p<n; p++)
    {
        position = Vector2D(ptr[X], ptr[Y]);
        theta = ptr[THETA];
        laserPosition = position + Vector2D(cos(theta),sin(theta))*offset;
                
//         mexPrintf("laser = [%f, %f, %f] | map = %e\n", 
//                   laserPosition.x, laserPosition.y, theta,
//                   map[int(round(laserPosition.x/resolution)*height + 
//                         height - round(laserPosition.y/resolution))]);
        
        for (int b=0; b<beams; b++)
        {
            beamAngle = theta + angles[b] - M_PI/2;
            orientation = Vector2D(cos(beamAngle),sin(beamAngle));
//             beamEnd = laserPosition + 
//                         Vector2D(cos(beamAngle),sin(beamAngle))*maxRange;
//             mexPrintf("%d [%f, %f]\n", b, beamEnd.x, beamEnd.y);
            
            currStep = step;
            while (currStep < maxRange)
            {
                beamEnd = laserPosition + orientation*currStep;
                x = floor(beamEnd.x/resolution);
                y = floor(beamEnd.y/resolution);
                
                if (x < 0 || x >= width || y < 0 || y >= height)
                {
                    beamEnd = laserPosition + orientation*maxRange;
                    break;
                }
                    
                prob = map[x*height + y];
                //mexPrintf("%d [%f, %f] prob = %f\n", b, beamEnd.x, beamEnd.y, prob);
                
                if (prob > 1) 
                {
                    beamEnd = laserPosition + orientation*maxRange;
                    break;
                }
                else if (prob > hitThreshold)
                {
                    break;
                }
                
                currStep += step;
            }
            
            diff = beamEnd - laserPosition;
            depth = diff.norm();
            output[n*(beams - 1 - b) + p] = depth;
            
        }
        
        
                
        ptr = nextParticlePtr(ptr);
    }
    
    return true;
}

void
ParticleSet::print() const
{
    double *particle = particlePtr;
    for(int i=0; i < n; i++)
    {  
        mexPrintf("[%f, %f, %f]\n", 
                  particle[X], particle[Y], particle[THETA]);
        particle = nextParticlePtr(particle);
    }
}