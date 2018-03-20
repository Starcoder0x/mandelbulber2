/**
 * Mandelbulber v2, a 3D fractal generator  _%}}i*<.        ____                _______
 * Copyright (C) 2018 Mandelbulber Team   _>]|=||i=i<,     / __ \___  ___ ___  / ___/ /
 *                                        \><||i|=>>%)    / /_/ / _ \/ -_) _ \/ /__/ /__
 * This file is part of Mandelbulber.     )<=i=]=|=i<>    \____/ .__/\__/_//_/\___/____/
 * The project is licensed under GPLv3,   -<>>=|><|||`        /_/
 * see also COPYING file in this folder.    ~+{i%+++
 *
 * abs add conditional4D

 * This file has been autogenerated by tools/populateUiInformation.php
 * from the function "TransfAbsAddConditional4dIteration" in the file fractal_formulas.cpp
 * D O    N O T    E D I T    T H I S    F I L E !
 */

REAL4 TransfAbsAddConditional4dIteration(
	REAL4 z, __constant sFractalCl *fractal, sExtendedAuxCl *aux)
{
	if (fractal->transformCommon.functionEnabledx)
	{
		z.x = sign(z.x) * (fractal->transformCommon.offset1111.x - fabs(z.x)
												+ fabs(z.x) * fractal->transformCommon.additionConstant0000.x);
	}

	if (fractal->transformCommon.functionEnabledy)
	{
		z.y = sign(z.y) * (fractal->transformCommon.offset1111.y - fabs(z.y)
												+ fabs(z.y) * fractal->transformCommon.additionConstant0000.y);
	}

	if (fractal->transformCommon.functionEnabledz)
	{
		z.z = sign(z.z) * (fractal->transformCommon.offset1111.z - fabs(z.z)
												+ fabs(z.z) * fractal->transformCommon.additionConstant0000.z);
	}

	if (fractal->transformCommon.functionEnabledw)
	{
		z.w = sign(z.w) * (fractal->transformCommon.offset1111.w - fabs(z.w)
												+ fabs(z.w) * fractal->transformCommon.additionConstant0000.w);
	}
	aux->DE *= fractal->analyticDE.scale1; // DE tweak
	return z;
}