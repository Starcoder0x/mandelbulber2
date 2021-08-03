/**
 * Mandelbulber v2, a 3D fractal generator       ,=#MKNmMMKmmßMNWy,
 *                                             ,B" ]L,,p%%%,,,§;, "K
 * Copyright (C) 2017 Mandelbulber Team        §R-==%w["'~5]m%=L.=~5N
 *                                        ,=mm=§M ]=4 yJKA"/-Nsaj  "Bw,==,,
 * This file is part of Mandelbulber.    §R.r= jw",M  Km .mM  FW ",§=ß., ,TN
 *                                     ,4R =%["w[N=7]J '"5=],""]]M,w,-; T=]M
 * Mandelbulber is free software:     §R.ß~-Q/M=,=5"v"]=Qf,'§"M= =,M.§ Rz]M"Kw
 * you can redistribute it and/or     §w "xDY.J ' -"m=====WeC=\ ""%""y=%"]"" §
 * modify it under the terms of the    "§M=M =D=4"N #"%==A%p M§ M6  R' #"=~.4M
 * GNU General Public License as        §W =, ][T"]C  §  § '§ e===~ U  !§[Z ]N
 * published by the                    4M",,Jm=,"=e~  §  §  j]]""N  BmM"py=ßM
 * Free Software Foundation,          ]§ T,M=& 'YmMMpM9MMM%=w=,,=MT]M m§;'§,
 * either version 3 of the License,    TWw [.j"5=~N[=§%=%W,T ]R,"=="Y[LFT ]N
 * or (at your option)                   TW=,-#"%=;[  =Q:["V""  ],,M.m == ]N
 * any later version.                      J§"mr"] ,=,," =="""J]= M"M"]==ß"
 *                                          §= "=C=4 §"eM "=B:m|4"]#F,§~
 * Mandelbulber is distributed in            "9w=,,]w em%wJ '"~" ,=,,ß"
 * the hope that it will be useful,                 . "K=  ,=RMMMßM"""
 * but WITHOUT ANY WARRANTY;                            .'''
 * without even the implied warranty
 * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
 *
 * See the GNU General Public License for more details.
 * You should have received a copy of the GNU General Public License
 * along with Mandelbulber. If not, see <http://www.gnu.org/licenses/>.
 *
 * ###########################################################################
 *
 * Authors: Sebastian Jennen (jenzebas@gmail.com), Robert Pancoast (Pancoaster@outlook.com)
 *
 * This header contains the include dependencies for math and opencl specific code
 * see usage in other src/opencl_*, algebra, and random
 */

#ifndef MANDELBULBER2_SRC_HEADER_WRAPPER_HPP_
#define MANDELBULBER2_SRC_HEADER_WRAPPER_HPP_

#if defined(_MSC_VER)
#pragma warning(push)
// MSVC defines math constants elsewhere, do not warn about the
// redefinition in math.h
#pragma warning(disable : 4005) // macro redefinition

// MSVC declares 'clEnqueueTask' deprecated in cl.h/hpp
#pragma warning(disable : 4996) // declared deprecated
#endif													// _MSC_VER

// custom includes
#ifdef USE_OPENCL

#ifndef CL_TARGET_OPENCL_VERSION
#define CL_TARGET_OPENCL_VERSION 120
#endif

#ifndef CL_HPP_TARGET_OPENCL_VERSION
#define CL_HPP_TARGET_OPENCL_VERSION 120
#endif // not CL_HPP_TARGET_OPENCL_VERSION

#ifndef CL_HPP_MINIMUM_OPENCL_VERSION
#define CL_HPP_MINIMUM_OPENCL_VERSION 120
#endif // not CL_HPP_MINIMUM_OPENCL_VERSION

#ifndef CL_HPP_ENABLE_PROGRAM_CONSTRUCTION_FROM_ARRAY_COMPATIBILITY
#define CL_HPP_ENABLE_PROGRAM_CONSTRUCTION_FROM_ARRAY_COMPATIBILITY
#endif // not CL_HPP_ENABLE_PROGRAM_CONSTRUCTION_FROM_ARRAY_COMPATIBILITY

#ifndef CL_HPP_CL_1_2_DEFAULT_BUILD
#define CL_HPP_CL_1_2_DEFAULT_BUILD
#endif // not CL_HPP_CL_1_2_DEFAULT_BUILD

// OpenCL SDK for all others
#if defined(__APPLE__) || defined(__MACOSX)
#if CL_NEW_HEADERS || __has_include("OpenCL/opencl.hpp")
#include <OpenCL/opencl.hpp>
#else
#include <OpenCL/cl.hpp>
#endif // if exists opencl.hpp

#else // if linux of windows

#if defined(CL_NEW_HEADERS) || __has_include("CL/opencl.hpp")
#include <CL/opencl.hpp>

#else

#if __has_include("CL/cl.hpp")
#include <CL/cl.hpp>
#else
#include <CL/cl2.hpp>
#endif

#endif
#endif // if macos or linux or windows

#endif // USE_OPENCL

// include math header here with opencl
#include <cmath>

#if defined(_MSC_VER)
#pragma warning(pop)
#endif // _MSC_VER

#endif /* MANDELBULBER2_SRC_HEADER_WRAPPER_HPP_ */
