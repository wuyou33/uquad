/**
 * control: lib for determing control actions.
 * Copyright (C) 2012  Rodrigo Rosa <rodrigorosa.lg gmail.com>, Matias Tailanian <matias tailanian.com>, Santiago Paternain <spaternain gmail.com>
 *
 *  This program is free software: you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation, either version 3 of the License, or
 *  (at your option) any later version.
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with this program.  If not, see <http://www.gnu.org/licenses/>.
 *
 * @file   control.h
 * @author Rodrigo Rosa <rodrigorosa.lg gmail.com>, Matias Tailanian <matias tailanian.com>, Santiago Paternain <spaternain gmail.com>
 * @date   Sun May 27 11:08:44 2012
 *
 * @brief  lib for determing control actions.
 *
 * Expects to load gain matrices from text files. The number and name of the matrices depends
 * on the mode being used.
 *
 * //TODO:
 * An implementation of the LQR algorithm is complete, this should allow to calculate the gain
 * matrices on-the-go, allowing to change trajectories.
 * The missing element is the linealization function, it is not working yet. LQR requires a
 * linear version of the system as input.
 *
 * Examples:
 *   - src/test/control/control_test.c
 *   - src/main/main.c
 */
#ifndef CONTROL_H
#define CONTROL_H

#include <macros_misc.h>
#include <uquad_error_codes.h>
#include <uquad_aux_math.h>
#include <path_planner.h>
#include <uquad_types.h>
#include <uquad_config.h>

#if FULL_CONTROL
/**
 * These matrices are loaded when full control
 * is used.
 * Matrices were obtained from the simulator,
 * using LQR.
 */
  #if CTRL_INTEGRAL
    #if CTRL_INTEGRAL_ANG
      #define CTRL_MAT_K_NAME   "K_prop_full_ppzt.txt"
    #else // CTRL_INTEGRAL_ANG
      #define CTRL_MAT_K_NAME   "K_prop_full.txt"
    #endif // CTRL_INTEGRAL_ANG
  #else // CTRL_INTEGRAL
    #define CTRL_MAT_K_NAME     "K_full.txt"
  #endif // CTRL_INTEGRAL

  #if CTRL_INTEGRAL_ANG
    #define CTRL_MAT_K_INT_NAME "K_int_full_ppzt.txt"
  #else // CTRL_INTEGRAL_ANG
    #define CTRL_MAT_K_INT_NAME "K_int_full.txt"
  #endif // CTRL_INTEGRAL_ANG
#else // FULL_CONTROL
/**
 * These matrices are loaded when partial control
 * is used.
 */
  #if CTRL_INTEGRAL
    #define CTRL_MAT_K_NAME   "K_prop.txt"
  #else
    #define CTRL_MAT_K_NAME   "K.txt"
  #endif // CTRL_INTEGRAL
  #define CTRL_MAT_K_INT_NAME "K_int.txt"
#endif // FULL_CONTROL

#if CTRL_INTEGRAL
/**
 * Threshold to limit integral control
 *   - Max state variations accepted (*DELTA*)
 *   - Max state diff accumulation (*ACCUM*)
 */
#define CTRL_INT_DELTA_MAX_PSI   1.0e-3// [rad*s] - @Ts=10ms, max 10° expected
#define CTRL_INT_DELTA_MAX_PHI   1.0e-3// [rad*s] - @Ts=10ms, max 10° expected
#define CTRL_INT_DELTA_MAX_THETA 7.0e-3// [rad*s]
#define CTRL_INT_DELTA_MAX_Z     0.5e-2   // [m*s]
#define CTRL_INT_DELTA_MAX_Y     1.0    // [m*s]
#define CTRL_INT_DELTA_MAX_X     1.0    // [m*s]
#define CTRL_INT_ACCUM_MAX_PSI   1.0   // [rad*s]
#define CTRL_INT_ACCUM_MAX_PHI   1.0   // [rad*s]
#define CTRL_INT_ACCUM_MAX_THETA 2.0   // [rad*s]
#define CTRL_INT_ACCUM_MAX_Z     2.0    // [m*s]
#define CTRL_INT_ACCUM_MAX_Y     5.0    // [m*s]
#define CTRL_INT_ACCUM_MAX_X     5.0    // [m*s]
#endif // CTRL_INTEGRAL

typedef struct ctrl{
    uquad_mat_t *K;
#if CTRL_INTEGRAL
    uquad_mat_t *K_int; // Integral gain
    uquad_mat_t *x_int; // Integral term
#endif
}ctrl_t;

/**
 * Allocate mem for ctrl, and loads gain from file.
 * File must have (in order):
 *   - Proportional gain matrix.
 *   - Integral gain matrix.
 *
 * @return structure or NULL if error.
 */
ctrl_t *control_init(void);

/**
 * Calculates action (motor speed) that should be performed on system.
 *
 * @param ctrl 
 * @param w Answer                           [rad/s]
 * @param x Current state estimation
 * @param sp Current setpoint
 * @param T_us Time since las control action [us]
 *
 * @return error code
 */
int control(ctrl_t *ctrl, uquad_mat_t *w, uquad_mat_t *x, set_point_t *sp, double T_us);

void control_deinit(ctrl_t *ctrl);

/**
 * Saves control matrices to file.
 *
 * @param ctrl
 * @param output log file, or NULL for stdout.
 *
 * @return error code
 */
int control_dump(ctrl_t *ctrl, FILE *output);

#endif
