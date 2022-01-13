/**
 * Mandelbulber v2, a 3D fractal generator  _%}}i*<.        ____                _______
 * Copyright (C) 2020 Mandelbulber Team   _>]|=||i=i<,     / __ \___  ___ ___  / ___/ /
 *                                        \><||i|=>>%)    / /_/ / _ \/ -_) _ \/ /__/ /__
 * This file is part of Mandelbulber.     )<=i=]=|=i<>    \____/ .__/\__/_//_/\___/____/
 * The project is licensed under GPLv3,   -<>>=|><|||`        /_/
 * see also COPYING file in this folder.    ~+{i%+++
 *
 * IQ-Bulb from Mandelbulb 3D and Inigo Quilez
 * @reference http://iquilezles.org/www/articles/mandelbulb/mandelbulb.htm

 * This file has been autogenerated by tools/populateUiInformation.php
 * from the file "fractal_iq_bulb.cpp" in the folder formula/definition
 * D O    N O T    E D I T    T H I S    F I L E !
 */

REAL4 MandelbulbIqPow8Iteration(REAL4 z, __constant sFractalCl *fractal, sExtendedAuxCl *aux)
{
	REAL tp = dot(z, z);
	tp = tp * tp * tp * aux->r;
	aux->DE = tp * aux->DE * 8.0f + 1.0f;

	REAL4 z2 = z * z;
	REAL4 z4 = z2 * z2;
	REAL k3 = z2.x + z2.y;
	tp = k3 * k3;
	tp = tp * tp * tp * k3;
	//REAL k2 = 1.0f / native_sqrt(tp);
	REAL k2 = fractal->transformCommon.scaleA1 / native_sqrt(tp);
	aux->DE *= fractal->transformCommon.scaleA1;
	tp = z2.x * z2.y;
	REAL k1 = z4.x + z4.y + z4.z - 6.0f * z2.z * k3 + 2.0f * tp;
	REAL k4 = k3 - z2.z;
	REAL k12 = k1 * k2;
	//z.x = 64.0f * z.x * z.y * z.z * k4 * (z2.x - z2.y) * (z4.x - 6.0f * tp + z4.y) * k12;

	z.x = fractal->transformCommon.scale1 * 64.0f * z.x * z.y * z.z * k4 * (z2.x - z2.y) * (z4.x - 6.0f * tp + z4.y) * k12;
	z.y = -8.0f * z.z * k4 * (z4.x * z4.x - 28.0f * tp * (z4.x + z4.y) + 70.0f * z4.x * z4.y + z4.y * z4.y) * k12;
	z.z = -16.0f * z2.z * k3 * k4 * k4 + k1 * k1;
	z.z *= fractal->transformCommon.scaleB1;
	z += fractal->transformCommon.offset000;
	return z;
}
