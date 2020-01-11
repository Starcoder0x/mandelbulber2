/**
 * Mandelbulber v2, a 3D fractal generator       ,=#MKNmMMKmmßMNWy,
 *                                             ,B" ]L,,p%%%,,,§;, "K
 * Copyright (C) 2017-19 Mandelbulber Team     §R-==%w["'~5]m%=L.=~5N
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
 * Authors: Krzysztof Marczak (buddhi1980@gmail.com)
 *
 * data structure common for main parameters and fractal parameters
 *       ____                   ________
 *      / __ \____  ___  ____  / ____/ /
 *     / / / / __ \/ _ \/ __ \/ /   / /
 *    / /_/ / /_/ /  __/ / / / /___/ /___
 *    \____/ .___/\___/_/ /_/\____/_____/
 *        /_/
 *
 * This file has been autogenerated by tools/populateOpenCL.php
 * from the file src/common_params.hpp
 * D O    N O T    E D I T    T H I S    F I L E !
 */

#ifndef MANDELBULBER2_OPENCL_COMMON_PARAMS_CL_HPP_
#define MANDELBULBER2_OPENCL_COMMON_PARAMS_CL_HPP_

#ifndef OPENCL_KERNEL_CODE
#include "fractal_cl.h"
#include "image_adjustments_cl.h"
#include "opencl_algebra.h"

#include "src/common_params.hpp"
#include "src/fractal.h"
#include "src/fractparams.hpp"
#include "src/fractal_enums.h"
#include "src/image_adjustments.h"
#endif /* OPENCL_KERNEL_CODE */

typedef enum
{
	fakeLightsShapePoint = 0,
	fakeLightsShapeLine = 1,
	fakeLightsShapeCircle = 2,
	fakeLightsShapeSquare = 3,
	fakeLightsShapeSphere = 4,
	fakeLightsShapeCube = 5
} enumFakeLightsShapeCl;

typedef struct
{
	cl_float boxLimit; // parameters of TGlad's folding
	cl_float boxValue;
	cl_float sphericalOuter;
	cl_float sphericalInner;
	cl_int boxEnable;
	cl_int sphericalEnable;
} sFractalFoldingsCl;

typedef struct
{
	cl_int iterThreshMode;

	cl_int fakeLightsMaxIter;
	cl_int fakeLightsMinIter;

	cl_int fakeLightsOrbitTrapShape;

	cl_float fakeLightsOrbitTrapSize;
	cl_float fakeLightsThickness;
	cl_float linearDEOffset;

	cl_float3 fakeLightsOrbitTrap;
	cl_float3 fakeLightsRotation;
	cl_float3 fractalPosition;
	cl_float3 fractalRotation;
	cl_float3 repeat;
	matrix33 mRotFractalRotation;
	matrix33 mRotFakeLightsRotation;

	sFractalFoldingsCl foldings;
} sCommonParamsCl;

#ifndef OPENCL_KERNEL_CODE
inline sFractalFoldingsCl clCopySFractalFoldingsCl(const sFractalFoldings &source)
{
	sFractalFoldingsCl target;
	target.boxLimit = source.boxLimit;
	target.boxValue = source.boxValue;
	target.sphericalOuter = source.sphericalOuter;
	target.sphericalInner = source.sphericalInner;
	target.boxEnable = source.boxEnable;
	target.sphericalEnable = source.sphericalEnable;
	return target;
}

inline sCommonParamsCl clCopySCommonParamsCl(const sCommonParams &source)
{
	sCommonParamsCl target;
	target.iterThreshMode = source.iterThreshMode;
	target.fakeLightsMaxIter = source.fakeLightsMaxIter;
	target.fakeLightsMinIter = source.fakeLightsMinIter;
	target.fakeLightsOrbitTrapShape = source.fakeLightsOrbitTrapShape;
	target.fakeLightsOrbitTrapSize = source.fakeLightsOrbitTrapSize;
	target.fakeLightsThickness = source.fakeLightsThickness;
	target.linearDEOffset = source.linearDEOffset;
	target.fakeLightsOrbitTrap = toClFloat3(source.fakeLightsOrbitTrap);
	target.fakeLightsRotation = toClFloat3(source.fakeLightsRotation);
	target.fractalPosition = toClFloat3(source.fractalPosition);
	target.fractalRotation = toClFloat3(source.fractalRotation);
	target.repeat = toClFloat3(source.repeat);
	target.mRotFractalRotation = toClMatrix33(source.mRotFractalRotation);
	target.mRotFakeLightsRotation = toClMatrix33(source.mRotFakeLightsRotation);
	target.foldings = clCopySFractalFoldingsCl(source.foldings);
	return target;
}
#endif /* OPENCL_KERNEL_CODE */

#endif /* MANDELBULBER2_OPENCL_COMMON_PARAMS_CL_HPP_ */
