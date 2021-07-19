/**
 * Mandelbulber v2, a 3D fractal generator  _%}}i*<.        ____                _______
 * Copyright (C) 2021 Mandelbulber Team   _>]|=||i=i<,     / __ \___  ___ ___  / ___/ /
 *                                        \><||i|=>>%)    / /_/ / _ \/ -_) _ \/ /__/ /__
 * This file is part of Mandelbulber.     )<=i=]=|=i<>    \____/ .__/\__/_//_/\___/____/
 * The project is licensed under GPLv3,   -<>>=|><|||`        /_/
 * see also COPYING file in this folder.    ~+{i%+++
 *
 * Adds Cpixel constant to z vector

 * This file has been autogenerated by tools/populateUiInformation.php
 * from the file "fractal_transf_add_cpixel_invert.cpp" in the folder formula/definition
 * D O    N O T    E D I T    T H I S    F I L E !
 */

REAL4 TransfAddCpixelInvertIteration(REAL4 z, __constant sFractalCl *fractal, sExtendedAuxCl *aux)
{
	REAL4 cv = aux->const_c;

	if (!fractal->transformCommon.functionEnabledAxFalse) cv.x = 1.0f / cv.x;
	if (!fractal->transformCommon.functionEnabledAyFalse) cv.y = 1.0f / cv.y;
	if (!fractal->transformCommon.functionEnabledAzFalse) cv.z = 1.0f / cv.z;

	if (fractal->transformCommon.functionEnabledAFalse)
	{
		cv.x = min(fabs(cv.x), fractal->transformCommon.scale1);
		cv.y = min(fabs(cv.y), fractal->transformCommon.scale1);
		cv.z = min(fabs(cv.z), fractal->transformCommon.scale1);
	}

	if (fractal->transformCommon.functionEnabledBFalse)
	{
		cv.x *= sign(aux->const_c.x);
		cv.y *= sign(aux->const_c.y);
		cv.z *= sign(aux->const_c.z);
	}

	if (fractal->transformCommon.functionEnabledCFalse)
	{
		cv.x *= sign(z.x);
		cv.y *= sign(z.y);
		cv.z *= sign(z.z);
	}

	z.x += cv.x * fractal->transformCommon.constantMultiplier111.x;
	z.y += cv.y * fractal->transformCommon.constantMultiplier111.y;
	z.z += cv.z * fractal->transformCommon.constantMultiplier111.z;

	// DE tweak
	if (fractal->analyticDE.enabledFalse)
		aux->DE = aux->DE * fractal->analyticDE.scale1 + fractal->analyticDE.offset0;

	// aux->color
	if (fractal->foldColor.auxColorEnabledFalse)
	{
		aux->color += fabs(cv.x * cv.y) * fractal->foldColor.difs0000.x;
		aux->color += (cv.x * cv.x + cv.y * cv.y) * fractal->foldColor.difs0000.y;
		aux->color += fabs(cv.z) * fractal->foldColor.difs0000.z;
	}

	return z;
}
