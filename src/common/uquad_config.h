#ifndef UQUAD_CONFIG_H
#define UQUAD_CONFIG_H

#define DEBUG             1 // Show debug info

#define GPS_FAKE          1 // Simulate GPS data (use zeros)

#define CTRL_INTEGRAL     0 // Use PI control
#define FULL_CONTROL      1 // Control 12 states

#if FULL_CONTROL
#define STATES_CONTROLLED 12
#else
#define STATES_CONTROLLED 8
#endif


#endif // UQUAD_CONFIG_H