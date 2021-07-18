/**
 * Mandelbulber v2, a 3D fractal generator  _%}}i*<.        ____                _______
 * Copyright (C) 2021 Mandelbulber Team   _>]|=||i=i<,     / __ \___  ___ ___  / ___/ /
 *                                        \><||i|=>>%)    / /_/ / _ \/ -_) _ \/ /__/ /__
 * This file is part of Mandelbulber.     )<=i=]=|=i<>    \____/ .__/\__/_//_/\___/____/
 * The project is licensed under GPLv3,   -<>>=|><|||`        /_/
 * see also COPYING file in this folder.    ~+{i%+++
 *
 * Mandelbar or Tricorn
 * ref: https://en.wikipedia.org/wiki/Tricorn_(mathematics)

 * This file has been autogenerated by tools/populateUiInformation.php
 * from the file "fractal_mandelbar.cpp" in the folder formula/definition
 * D O    N O T    E D I T    T H I S    F I L E !
 */

REAL4 MandelbarIteration(REAL4 z, __constant sFractalCl *fractal, sExtendedAuxCl *aux)
{
	if (fractal->transformCommon.functionEnabledFalse)
	{
		if (fractal->transformCommon.functionEnabledAxFalse) z.x = fabs(z.x);
		if (fractal->transformCommon.functionEnabledAyFalse) z.y = fabs(z.y);
		if (fractal->transformCommon.functionEnabledAzFalse) z.z = fabs(z.z);
	}

	aux->DE = aux->DE * 2.0f * aux->r;
	REAL4 dd = fractal->transformCommon.constantMultiplier122;
	dd.x = z.x * z.x * dd.x - z.y * z.y - z.z * z.z;
	dd.y = -dd.y * z.x * z.y;
	dd.z = dd.z * z.x * z.z;
	z = dd;

	// offset (Julia)
	z += fractal->transformCommon.additionConstant000;

	z = Matrix33MulFloat4(fractal->transformCommon.rotationMatrix, z);

	// DE tweak
	if (fractal->analyticDE.enabledFalse)
		aux->DE = aux->DE * fractal->analyticDE.scale1 + fractal->analyticDE.offset0;
	return z;
}