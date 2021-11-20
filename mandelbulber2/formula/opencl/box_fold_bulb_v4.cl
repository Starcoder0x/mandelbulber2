/**
 * Mandelbulber v2, a 3D fractal generator  _%}}i*<.        ____                _______
 * Copyright (C) 2021 Mandelbulber Team   _>]|=||i=i<,     / __ \___  ___ ___  / ___/ /
 *                                        \><||i|=>>%)    / /_/ / _ \/ -_) _ \/ /__/ /__
 * This file is part of Mandelbulber.     )<=i=]=|=i<>    \____/ .__/\__/_//_/\___/____/
 * The project is licensed under GPLv3,   -<>>=|><|||`        /_/
 * see also COPYING file in this folder.    ~+{i%+++
 *
 * Classic Mandelbulb fractal.
 * @reference http://www.fractalforums.com/3d-fractal-generation/true-3d-mandlebrot-type-fractal/

 * This file has been autogenerated by tools/populateUiInformation.php
 * from the file "fractal_box_fold_bulb_v4.cpp" in the folder formula/definition
 * D O    N O T    E D I T    T H I S    F I L E !
 */

REAL4 BoxFoldBulbV4Iteration(REAL4 z, __constant sFractalCl *fractal, sExtendedAuxCl *aux)
{
	REAL4 oldZ = z;
	z.x = fabs(z.x + fractal->transformCommon.offset222.x)
				- fabs(z.x - fractal->transformCommon.offset222.x) - z.x;
	z.y = fabs(z.y + fractal->transformCommon.offset222.y)
				- fabs(z.y - fractal->transformCommon.offset222.y) - z.y;
	if (aux->i >= fractal->transformCommon.startIterationsB
			&& aux->i < fractal->transformCommon.stopIterationsB)
		z.z = fabs(z.z + fractal->transformCommon.offset222.z)
					- fabs(z.z - fractal->transformCommon.offset222.z) - z.z;
	REAL4 zCol = z;
	z *= fractal->transformCommon.scaleA1;
	aux->DE *= fabs(fractal->transformCommon.scaleA1);
	aux->r = length(z);
	// if (aux->r < 1e-21f) aux->r = 1e-21f;
	REAL th0 = asin(z.z / aux->r) + fractal->bulb.betaAngleOffset;
	REAL ph0 = atan2(z.y, z.x) + fractal->bulb.alphaAngleOffset;
	REAL rp = native_powr(aux->r, fractal->transformCommon.scale2 - 1.0f);
	REAL th = th0 * fractal->transformCommon.scale2;
	REAL ph = ph0 * fractal->transformCommon.scale2;
	REAL cth = native_cos(th);
	aux->DE = (rp * aux->DE) * fractal->transformCommon.scale2;
	rp *= aux->r;
	z.x = cth * native_cos(ph) * rp;
	z.y = cth * native_sin(ph) * rp;
	z.z = native_sin(th) * rp;

	z.z *= fractal->transformCommon.scaleNeg1;

	if (fractal->analyticDE.enabledFalse)
		aux->DE = aux->DE * fractal->analyticDE.scale1 + fractal->analyticDE.offset0;

	if (fractal->foldColor.auxColorEnabledFalse)
	{
		REAL colorAdd = 0.0f;
		if (zCol.x != oldZ.x)
			aux->color += fractal->foldColor.difs0000.x
										* (fabs(zCol.x) / fractal->transformCommon.offset222.x - 1.0f);

		if (zCol.y != oldZ.y)
			aux->color += fractal->foldColor.difs0000.y
										* (fabs(zCol.y) / fractal->transformCommon.offset222.y - 1.0f);

		if (zCol.z != oldZ.z)
			aux->color += fractal->foldColor.difs0000.z
										* (fabs(zCol.z) / fractal->transformCommon.offset222.z - 1.0f);

		colorAdd += fractal->foldColor.difs0000.w * rp * 0.001f;
		aux->color += colorAdd;
	}
	return z;
}