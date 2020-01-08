/**
 * Mandelbulber v2, a 3D fractal generator  _%}}i*<.        ____                _______
 * Copyright (C) 2020 Mandelbulber Team   _>]|=||i=i<,     / __ \___  ___ ___  / ___/ /
 *                                        \><||i|=>>%)    / /_/ / _ \/ -_) _ \/ /__/ /__
 * This file is part of Mandelbulber.     )<=i=]=|=i<>    \____/ .__/\__/_//_/\___/____/
 * The project is licensed under GPLv3,   -<>>=|><|||`        /_/
 * see also COPYING file in this folder.    ~+{i%+++
 *
 * KochV2Iteration
 * Based on Knighty's Kaleidoscopic IFS 3D Fractals, described here:
 * http://www.fractalforums.com/3d-fractal-generation/kaleidoscopic-%28escape-time-ifs%29/

 * This file has been autogenerated by tools/populateUiInformation.php
 * from the function "KochV2Iteration" in the file fractal_formulas.cpp
 * D O    N O T    E D I T    T H I S    F I L E !
 */

REAL4 KochV2Iteration(REAL4 z, __constant sFractalCl *fractal, sExtendedAuxCl *aux)
{
	if (fractal->transformCommon.functionEnabledAx) z.x = fabs(z.x);
	if (fractal->transformCommon.functionEnabledAy) z.y = fabs(z.y);
	if (fractal->transformCommon.functionEnabledAzFalse) z.z = fabs(z.z);
	if (fractal->transformCommon.functionEnabledCx)
		if (z.y > z.x)
		{
			REAL temp = z.x;
			z.x = z.y;
			z.y = temp;
		}

	// folds
	if (fractal->transformCommon.functionEnabledFalse)
	{
		// diagonal2
		if (fractal->transformCommon.functionEnabledCxFalse)
			if (z.x > z.y)
			{
				REAL temp = z.x;
				z.x = z.y;
				z.y = temp;
			}
		// polyfold
		if (fractal->transformCommon.functionEnabledPFalse)
		{
			z.x = fabs(z.x);
			int poly = fractal->transformCommon.int6;
			REAL psi = fabs(fmod(atan(native_divide(z.y, z.x)) + native_divide(M_PI_F, poly),
												native_divide(M_PI_F, (0.5f * poly)))
											- native_divide(M_PI_F, poly));
			REAL len = native_sqrt(mad(z.x, z.x, z.y * z.y));
			z.x = native_cos(psi) * len;
			z.y = native_sin(psi) * len;
		}
		// abs offsets
		if (fractal->transformCommon.functionEnabledCFalse)
		{
			REAL xOffset = fractal->transformCommon.offsetC0;
			if (z.x < xOffset) z.x = fabs(z.x - xOffset) + xOffset;
		}
		if (fractal->transformCommon.functionEnabledDFalse)
		{
			REAL yOffset = fractal->transformCommon.offsetD0;
			if (z.y < yOffset) z.y = fabs(z.y - yOffset) + yOffset;
		}

		if (fractal->transformCommon.functionEnabledGFalse)
		{
			z += fractal->mandelbox.offset;
			REAL rr = dot(z, z);

			if (rr < fractal->transformCommon.minR0)
			{
				REAL tglad_factor1 =
					native_divide(fractal->transformCommon.maxR2d1, fractal->transformCommon.minR0);
				z *= tglad_factor1;
				aux->DE *= tglad_factor1;
			}
			else if (rr < fractal->transformCommon.maxR2d1)
			{
				REAL tglad_factor2 = native_divide(fractal->transformCommon.maxR2d1, rr);
				z *= tglad_factor2;
				aux->DE *= tglad_factor2;
			}
			z -= fractal->mandelbox.offset;
		}
	}

	REAL YOff = FRAC_1_3 * fractal->transformCommon.scale1;
	z.y = YOff - fabs(z.y - YOff);

	z.x += FRAC_1_3;
	if (z.z > z.x)
	{
		REAL temp = z.x;
		z.x = z.z;
		z.z = temp;
	}
	z.x -= FRAC_1_3;

	z.x -= FRAC_1_3;
	if (z.z > z.x)
	{
		REAL temp = z.x;
		z.x = z.z;
		z.z = temp;
	}
	z.x += FRAC_1_3;

	REAL4 Offset = fractal->transformCommon.offset100;
	z = mad(fractal->transformCommon.scale3, (z - Offset), Offset);
	aux->DE = aux->DE * fractal->transformCommon.scale3;

	// rotation
	if (fractal->transformCommon.functionEnabledRFalse
			&& aux->i >= fractal->transformCommon.startIterationsR
			&& aux->i < fractal->transformCommon.stopIterationsR)
	{
		z = Matrix33MulFloat4(fractal->transformCommon.rotationMatrix, z);
	}
	z += fractal->transformCommon.offset000;

	if (!fractal->transformCommon.functionEnabledFFalse)
	{
		aux->dist = fabs(length(z) - length(Offset));
		aux->dist = native_divide(aux->dist, aux->DE);
	}
	else
	{
		REAL e = fractal->transformCommon.offset1;
		if (!fractal->transformCommon.functionEnabledEFalse)
		{
			REAL4 f = fabs(aux->c) - (REAL4){e, e, e, 0.0f};
			e = max(f.x, max(f.y, f.z));
		}
		else
		{
			e = clamp(length(aux->c) - e, 0.0f, 100.0f); // circle
		}
		aux->dist = fabs(z.z - Offset.z);
		aux->dist = native_divide(aux->dist, aux->DE);
		aux->dist = max(aux->dist, e);
	}
	return z;
}